std = "lua51"

max_code_line_length = 120
max_string_line_length = false
max_comment_line_length = false

max_cyclomatic_complexity = 32

self = false

ignore = {
    "211/ADDONNAME",
    "211/ns",
    -- "212/event",
    -- "212/...",
}

new_globals = {

}

read_globals = {
    -- WoW Objects
    "DEFAULT_CHAT_FRAME",

    -- WoW API
    "CreateFrame",

    -- WoW C_API
    "C_EventUtils",

    -- WoW Lua API
    "securecallfunction",
}
