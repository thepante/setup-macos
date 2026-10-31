rex.bind("alt+h", "pane.focus.left")
rex.bind("alt+j", "pane.focus.down")
rex.bind("alt+k", "pane.focus.up")
rex.bind("alt+l", "pane.focus.right")

rex.bind("ctrl+alt+j", "pane.resize", { direction = "down", amount = 5 })
rex.bind("ctrl+alt+k", "pane.resize", { direction = "up", amount = 5 })
rex.bind("alt+f11", "pane.resize", { direction = "left", amount = 5 })
rex.bind("alt+f12", "pane.resize", { direction = "right", amount = 5 })
rex.bind("alt+down", "pane.resize", { direction = "down", amount = 5 })
rex.bind("alt+up", "pane.resize", { direction = "up", amount = 5 })

local function scroll_claude(seq)
  return function(ctx)
    local terminal = "com.superlogical.terminal"
    local p = rex.block.call(terminal, "process", { block_id = ctx.block_id })
    if not (p and p.foreground and p.foreground.name == "claude") then
      return false
    end
    rex.block.call(terminal, "write", { block_id = ctx.block_id, data = seq })
    return true
  end
end

rex.bind("ctrl+u", scroll_claude("\27[5~"))
rex.bind("ctrl+d", scroll_claude("\27[6~"))
rex.bind("ctrl+y", scroll_claude("\27[<64;1;1M"))
rex.bind("ctrl+e", scroll_claude("\27[<65;1;1M"))

rex.bind("alt+shift+down", "client.tab.next")
rex.bind("alt+shift+up", "client.tab.previous")
rex.bind("ctrl+t", "client.tab.new")

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
rex.bind("prefix/e", "client.tab.rename")
rex.bind("prefix/ctrl+e", "client.tab.rename")
