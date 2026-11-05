import { execFileSync } from "node:child_process"
import { homedir } from "node:os"

// opencode globs cannot tell an option from an argument: `git -C * commit *` also denies
// `git -C repo log --grep commit`. The hook Claude Code runs parses the command instead.
const guard = `${homedir()}/.claude/hooks/command-guard`

type Decision = { permissionDecision: "deny" | "ask"; permissionDecisionReason: string }

function judge(command: string): Decision | undefined {
  try {
    const output = execFileSync(guard, {
      input: JSON.stringify({ tool_input: { command } }),
      encoding: "utf8",
      timeout: 5000,
    })
    return output.trim() ? JSON.parse(output).hookSpecificOutput : undefined
  } catch {
    // A broken guard must not break the session: the plain rules in opencode.json still apply.
    return undefined
  }
}

export default {
  id: "command-guard",
  async setup(context) {
    await context.permission.hook("evaluate", (event) => {
      if (event.action !== "shell") return
      for (const command of event.resources) {
        const decision = judge(command)
        if (decision?.permissionDecision === "deny") {
          event.effect = "deny"
          event.message = decision.permissionDecisionReason
          return
        }
        if (decision) event.effect = "ask"
      }
    })
  },
}
