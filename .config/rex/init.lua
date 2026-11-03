rex.bind("alt+h", "pane.focus.left")
rex.bind("alt+j", "pane.focus.down")
rex.bind("alt+k", "pane.focus.up")
rex.bind("alt+l", "pane.focus.right")

rex.bind("shift+left", "pane.resize", { direction = "left", amount = 5 })
rex.bind("shift+down", "pane.resize", { direction = "down", amount = 5 })
rex.bind("shift+up", "pane.resize", { direction = "up", amount = 5 })
rex.bind("shift+right", "pane.resize", { direction = "right", amount = 5 })

local function scroll_app(seqs)
  return function(ctx)
    local terminal = "com.superlogical.terminal"
    local p = rex.block.call(terminal, "process", { block_id = ctx.block_id })
    local seq = seqs[p and p.foreground and p.foreground.name]
    if not seq then
      return false
    end
    rex.block.call(terminal, "write", { block_id = ctx.block_id, data = seq })
    return true
  end
end

local line_up = string.rep("\27[<64;1;1M", 3)
local line_down = string.rep("\27[<65;1;1M", 3)

rex.bind("ctrl+u", scroll_app({ claude = line_up, opencode = string.rep("\21", 3) }))
rex.bind("ctrl+d", scroll_app({ claude = line_down, opencode = string.rep("\4", 3) }))
rex.bind("ctrl+b", scroll_app({ claude = "\27[5~" }))
rex.bind("ctrl+f", scroll_app({ claude = "\27[6~" }))

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

