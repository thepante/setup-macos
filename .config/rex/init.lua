rex.bind("alt+h", "pane.focus.left")
rex.bind("alt+j", "pane.focus.down")
rex.bind("alt+k", "pane.focus.up")
rex.bind("alt+l", "pane.focus.right")

rex.bind("shift+left", "pane.resize", { direction = "left", amount = 5 })
rex.bind("shift+down", "pane.resize", { direction = "down", amount = 5 })
rex.bind("shift+up", "pane.resize", { direction = "up", amount = 5 })
rex.bind("shift+right", "pane.resize", { direction = "right", amount = 5 })

local terminal = "com.superlogical.terminal"

-- rex.client.queue only works from an action bound to the key, not from a
-- bound function, so this action writes the key itself when it doesn't scroll.
rex.action({
  name = "scroll_app",
  title = "Scroll App",
  args = { page = "string", key = "string", opencode = "string?" },
  run = function(ctx, args)
    local p = rex.block.call(terminal, "process", { block_id = ctx.block_id })
    local app = p and p.foreground and p.foreground.name
    if app == "claude" then
      rex.client.queue(args.page)
      return true
    end
    local data = app == "opencode" and args.opencode or args.key
    rex.block.call(terminal, "write", { block_id = ctx.block_id, data = data })
    return true
  end,
})

rex.bind("ctrl+u", "scroll_app", { page = "client.scroll.page_up", key = "\21", opencode = string.rep("\21", 3) })
rex.bind("ctrl+d", "scroll_app", { page = "client.scroll.page_down", key = "\4", opencode = string.rep("\4", 3) })
rex.bind("ctrl+b", "scroll_app", { page = "client.scroll.page_up", key = "\2" })
rex.bind("ctrl+f", "scroll_app", { page = "client.scroll.page_down", key = "\6" })

local function write_key(data)
  return function(ctx)
    rex.block.call("com.superlogical.terminal", "write", { block_id = ctx.block_id, data = data })
    return true
  end
end

rex.bind("cmd+backspace", write_key("\21"))
rex.bind("cmd+left", write_key("\1"))
rex.bind("cmd+right", write_key("\5"))
rex.bind("cmd+h", write_key("\1"))
rex.bind("cmd+l", write_key("\5"))

rex.bind("alt+shift+down", "client.tab.next")
rex.bind("alt+shift+up", "client.tab.previous")
rex.bind("cmd+a", "client.tab.previous")
rex.bind("cmd+d", "client.tab.next")
rex.bind("alt+a", "client.tab.move.backward")
rex.bind("alt+d", "client.tab.move.forward")
rex.bind("ctrl+t", "client.tab.new")

rex.bind("cmd+down", "session.next")
rex.bind("cmd+up", "session.previous")
rex.bind("cmd+k", "session.switch")

rex.mode("prefix", { exclusive = true })
rex.bind("ctrl+a", "client.mode.enter", { name = "prefix", once = true })

rex.action({
  name = "send_prefix",
  title = "Send Prefix",
  run = function(ctx)
    rex.block.call("com.superlogical.terminal", "write", { block_id = ctx.block_id, data = "\1" })
    return true
  end,
})

rex.bind("prefix/ctrl+a", "send_prefix")
rex.bind("prefix/=", "pane.split.right")
rex.bind("prefix/-", "pane.split.down")
rex.bind("prefix/ctrl+x", "pane.close")
rex.bind("prefix/r", "client.tab.rename")
rex.bind("prefix/shift+r", "session.rename")

require("agent_fork").setup()

rex.bind("prefix/f", "fork_agent")
rex.bind("prefix/i", "copy_agent_session_id")

local SCRATCH_LABEL = "scratch"

local function scratch_layer(view)
  for _, window in ipairs(view.windows or {}) do
    if window.window_id == view.active_window_id then
      for _, layer in ipairs(window.layers or {}) do
        if layer.kind == "floating" then
          for _, block in ipairs(layer.blocks or {}) do
            if block.label == SCRATCH_LABEL then
              return layer
            end
          end
        end
      end
    end
  end
end

rex.action({
  name = "toggle_scratch",
  title = "Toggle Scratch Terminal",
  description = "Opens a floating terminal, or hides and shows it.",
  keywords = "scratch floating terminal popup",
  run = function(ctx)
    local view, view_err = rex.session.view({})
    if not view then
      rex.log("warn", "toggle_scratch: " .. tostring(view_err))
      return
    end
    local layer = scratch_layer(view)
    if layer then
      local show = layer.state == "minimized"
      local _, err = rex.call("session.set_layer_state", {
        session_id = ctx.session_id,
        layer_id = layer.layer_id,
        state = show and "normal" or "minimized",
        focus = show,
      })
      if err then
        rex.log("warn", "toggle_scratch: " .. tostring(err))
      end
      return
    end
    local _, err = rex.session.new_layer({
      bounds = { 0.08, 0.08, 0.84, 0.84 },
      focus = true,
      layout = rex.layout.block({
        flavor = "com.superlogical.terminal.shell",
        label = SCRATCH_LABEL,
      }),
    })
    if err then
      rex.log("warn", "toggle_scratch: " .. tostring(err))
    end
  end,
})

rex.bind("alt+f", "toggle_scratch")

local TAB_HISTORY = os.getenv("HOME") .. "/.local/state/rex-tab-history/state"

local function previous_active_tab(session_id)
  local file = io.open(TAB_HISTORY, "r")
  if not file then return nil end
  local window_id
  for line in file:lines() do
    local sid, prev = line:match("^(%S+)\t([^\t]*)\t")
    if sid == session_id then window_id = prev end
  end
  file:close()
  if window_id == "" then return nil end
  return window_id
end

rex.action({
  name = "last_active_tab",
  title = "Back to Last Active Tab",
  description = "Switch to the tab you were on before this one, not the adjacent one.",
  keywords = "tab last previous active back history mru",
  run = function(ctx)
    local window_id = previous_active_tab(ctx.session_id)
    if not window_id then return false end
    local _, err = rex.session.focus_window({ window_id = window_id })
    if err then rex.log("warn", "last_active_tab: " .. tostring(err)) end
    return true
  end,
})

rex.bind("prefix/n", "last_active_tab")

do
  local dir = os.getenv("HOME") .. "/.local/state/rex-tab-history"
  local script = os.getenv("HOME") .. "/.config/rex/last_active_tab.lua"
  local pid_file = dir .. "/pid"

  local function rex_cli()
    local candidates = {
      os.getenv("HOME") .. "/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS/rex",
      "/Applications/Rex.app/Contents/MacOS/rex",
      "/usr/local/bin/rex",
      "/opt/homebrew/bin/rex",
    }
    for _, path in ipairs(candidates) do
      local file = io.open(path, "r")
      if file then
        file:close()
        return path
      end
    end
    return "rex"
  end

  local function tracker_pid()
    local file = io.open(pid_file, "r")
    if not file then return nil end
    local pid = tonumber(file:read("*l"))
    file:close()
    return pid
  end

  local function tracker_running(pid)
    local r = rex.exec({ "ps", "-p", tostring(pid), "-ww", "-o", "command=" })
    return r ~= nil and r.stdout ~= nil and r.stdout:find("last_active_tab.lua", 1, true) ~= nil
  end

  rex.exec({ "mkdir", "-p", dir })
  local pid = tracker_pid()
  if not (pid and tracker_running(pid)) then
    local handle, err = rex.exec.start({ rex_cli(), "do", script, "--all" }, { detach = true })
    if not handle then
      rex.log("warn", "last_active_tab tracker: " .. tostring(err))
    else
      local file = io.open(pid_file, "w")
      if file then
        file:write(tostring(handle.pid))
        file:close()
      end
    end
  end
end

do
  local r = rex.exec(
    { [[/opt/homebrew/bin/rexurrect]], "auto-restore" },
    {
      env = {
        REXURRECT_STATE_DIR = [[/Users/fabian/.local/state/rexurrect]],
        REXURRECT_CONFIG = [[/Users/fabian/.config/rexurrect/config.toml]],
      },
    }
  )
  if r then io.stderr:write(r.stderr) end
end

