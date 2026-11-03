-- Fork Agent Session and Copy Agent Session ID, for Claude Code, Codex and pi.
--
--   require("agent_fork").setup{ copy = function(text, title) ... end }  -- copy is optional
--   rex.bind("f20>f", "fork_agent")
--   rex.bind("f20>i", "copy_agent_session_id")
--
-- Each agent records its session for the Rex pane it runs in with ~/.config/rex/agent-session:
--   Claude Code: a SessionStart hook in ~/.claude/settings.json running
--     agent-session record claude-code
--   Codex: a SessionStart hook in ~/.codex/hooks.json running agent-session record codex, trusted
--     once in Codex, and ~/.config/fish/functions/codex.fish, which runs Codex without its shared
--     daemon so the hook sees the pane. The hook fires at the first prompt, so a new session can
--     be forked once it has one; after /new, until then, Fork still picks the previous session
--   pi: the extension ~/.pi/agent/extensions/rex-agent-session.ts
-- A remote host's server answers for its own panes, so it needs this file and those records too.

local M = {}

local terminal = "com.superlogical.terminal"
local script = os.getenv("HOME") .. "/.config/rex/agent-session"
local opencode_fork = os.getenv("HOME") .. "/.config/rex/opencode-fork"

-- Keyed by the app name in the pane's program status
local agents = {
  ["claude-code"] = { name = "Claude Code", fork = function(id) return "claude --resume " .. id .. " --fork-session" end },
  codex           = { name = "Codex",       fork = function(id) return "codex fork " .. id end },
  pi              = { name = "pi",          fork = function(id) return "pi --fork " .. id end },
  opencode        = { name = "OpenCode",    status_id = true, fork = function(id) return opencode_fork .. " " .. id end },
}

local function opencode_tab_id(cwd)
  local state = os.getenv("XDG_STATE_HOME") or (os.getenv("HOME") .. "/.local/state")
  local f = io.open(state .. "/opencode/latest/tui/tabs.json", "r")
  if not f then return nil end
  local text = f:read("*a")
  f:close()
  local data = rex.json.decode(text)
  local tabs = data and data.cwd and data.cwd[cwd] and data.cwd[cwd].tabs
  return tabs and tabs[#tabs] and tabs[#tabs].sessionID
end

-- The pane's agent and recorded session, from agent-session on this server's host
local function lookup(ctx)
  local status = rex.block.call(terminal, "program_status", { block_id = ctx.block_id }) or {}
  for _, record in ipairs(status.records or {}) do
    local agent = agents[record.app]
    if agent then
      if agent.status_id then
        if record.id then
          return { app = record.app, id = record.id }
        end
      else
        local found, err = rex.exec({ script, "id", record.app, ctx.block_id })
        if not found then return { error = tostring(err) } end
        if not found.ok then return { error = agent.name .. ": " .. (found.stderr:gsub("%s+$", "")) } end
        return { app = record.app, id = (found.stdout:gsub("%s+$", "")) }
      end
    end
  end
  local proc = rex.block.call(terminal, "process", { block_id = ctx.block_id }) or {}
  local foreground = proc.foreground or {}
  if foreground.name == "opencode" and foreground.cwd then
    local id = opencode_tab_id(foreground.cwd)
    if id then return { app = "opencode", id = id } end
    return { error = "OpenCode is running in this pane but hasn't reported its session yet. Send it a prompt and try again." }
  end
  return { error = "No agent session in this pane (" .. (foreground.name or "an empty pane") .. "). Focus the pane running Claude Code, Codex, pi or OpenCode." }
end

-- For a remote host's session, the Mac app runs these actions on the Mac's server with ctx.server
-- set: rex.call then goes to the pane's server, but rex.exec would still run on the Mac, which has
-- no record of the pane, so ask the pane's server through its agent_session action
local function session_id(ctx)
  local found
  if ctx.server then
    local answer, err = rex.call("client.action", {
      action     = "agent_session",
      session_id = ctx.session_id,
      block_id   = ctx.block_id,
    })
    if not answer then error(err, 0) end
    found = answer.result or {}
  else
    found = lookup(ctx)
  end
  if found.error then error(found.error, 0) end
  return found.id, agents[found.app]
end

function M.setup(opts)
  opts = opts or {}

  rex.action{
    name     = "agent_session",
    title    = "Show Agent Session",
    keywords = "agent session id claude codex pi opencode",
    run      = lookup,
  }

  rex.action{
    name  = "fork_agent",
    title = "Fork Agent Session",
    run   = function(ctx)
      local id, agent = session_id(ctx)
      local proc = rex.block.call(terminal, "process", { block_id = ctx.block_id }) or {}
      local parent = (proc.ancestors or {})[1] or {}
      local _, err = rex.session.new_split{
        anchor_id = ctx.block_id,
        direction = "horizontal",
        side      = "after",
        focus     = true,
        layout    = rex.layout.block{
          flavor  = "com.superlogical.terminal.shell",
          options = {
            shell         = parent.invoked_path or parent.path,
            cwd           = proc.foreground and proc.foreground.cwd,
            initial_input = agent.fork(id) .. "\n",
          },
        },
      }
      if err then error(err, 0) end
      rex.client.queue("pane.balance")
    end,
  }

  rex.action{
    name  = "copy_agent_session_id",
    title = "Copy Agent Session ID",
    run   = function(ctx)
      local id = session_id(ctx)
      if opts.copy then return opts.copy(id, "Copied agent session ID") end
      rex.exec({ "pbcopy" }, { stdin = id })
      return id
    end,
  }
end

return M
