import { Plugin } from "@opencode/plugin/tui"
import { execFileSync } from "node:child_process"

type Block = {
  title: string
  description?: string
  value: string
}

function codeBlocks(text: string): Block[] {
  const blocks: Block[] = []
  const pattern = /```([^\n]*)\n([\s\S]*?)```/g
  let match: RegExpExecArray | null

  while ((match = pattern.exec(text))) {
    const language = match[1].trim()
    const body = match[2].replace(/\n$/, "")
    blocks.push({
      title: language ? `${language} block` : "code block",
      description: body.split("\n")[0]?.slice(0, 80) ?? "",
      value: body,
    })
  }

  return blocks
}

function copy(text: string) {
  execFileSync("/usr/bin/pbcopy", { input: text })
}

export default Plugin.define({
  id: "rex.copy-block",
  setup(context) {
    context.keymap.layer(() => ({
      mode: "global",
      commands: [
        {
          id: "rex.copy-block",
          title: "Copy message block",
          bind: "¥",
          slash: { name: "copy-block" },
          run: async () => {
            const route = context.ui.router.current()
            if (route.type !== "session") return

            await context.data.session.message.sync(route.sessionID)
            const messages = context.data.session.message.list(route.sessionID)
            const last = [...messages].reverse().find((message) => {
              if (message.type !== "assistant") return false
              return message.content.some((part) => part.type === "text" && part.text.trim())
            })
            if (!last || last.type !== "assistant") {
              context.ui.toast.show({ message: "No assistant message to copy", variant: "error" })
              return
            }

            const text = last.content
              .filter((part) => part.type === "text")
              .map((part) => part.text)
              .join("\n")
              .trim()
            if (!text) {
              context.ui.toast.show({ message: "The last message has no text", variant: "error" })
              return
            }

            const blocks = codeBlocks(text)
            if (blocks.length === 0) {
              copy(text)
              context.ui.toast.show({ message: "Copied the last message", variant: "success" })
              return
            }

            const selected = await context.ui.dialog.select({
              title: "Copy block",
              options: [{ title: "Full response", value: text }, ...blocks],
            })
            if (!selected) return

            copy(selected)
            context.ui.toast.show({ message: "Copied", variant: "success" })
          },
        },
      ],
    }))
  },
})
