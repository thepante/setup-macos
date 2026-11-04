-- Rex ends this script's connection when the server goes away, so the
-- process dies with the server instead of lingering as an orphan.
local DIR = os.getenv("HOME") .. "/.local/state/rex-tab-history"
local STATE_PATH = DIR .. "/state"

local state = {}

local function save()
  local lines = {}
  for session_id, entry in pairs(state) do
    lines[#lines + 1] = table.concat({ session_id, entry.prev or "", entry.cur or "" }, "\t")
  end
  local file = io.open(STATE_PATH .. ".tmp", "w")
  if not file then return end
  file:write(table.concat(lines, "\n"))
  file:close()
  os.rename(STATE_PATH .. ".tmp", STATE_PATH)
end

local function record(session_id, window_id)
  local entry = state[session_id]
  if not entry then
    entry = {}
    state[session_id] = entry
  end
  if entry.cur == window_id then return end
  entry.prev = entry.cur
  entry.cur = window_id
  save()
end

local function seed(session_id)
  rex.session.attach({ session_id = session_id })
  local view = rex.call("session.view", { session_id = session_id })
  if view and view.active_window_id then
    state[session_id] = { cur = view.active_window_id }
    save()
  end
end

rex.on("active_window_changed", function(ctx, ev)
  record(ctx.session_id, ev.window_id)
end)

rex.on("window_closed", function(ctx, ev)
  local entry = state[ctx.session_id]
  if not entry then return end
  if entry.prev == ev.window_id then entry.prev = nil end
  if entry.cur == ev.window_id then entry.cur = nil end
  save()
end)

rex.on("session_destroyed", function(ctx, ev)
  if state[ev.session_id] == nil then return end
  state[ev.session_id] = nil
  save()
end)

rex.on("session_created", function(ctx, ev)
  seed(ev.session.session_id)
end)

for _, session in ipairs((rex.call("session.list") or {}).sessions or {}) do
  seed(session.session_id)
end
