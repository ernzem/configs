return {
    "andrewferrier/debugprint.nvim",
    opts = {
        keymaps = {
            normal = {
                plain_below = "g?p",
                plain_above = "g?P",
                variable_below = "<F2>",
                variable_above = "g?V",
                variable_below_alwaysprompt = nil,
                variable_above_alwaysprompt = nil,
                textobj_below = "g?o",
                textobj_above = "g?O",
                toggle_comment_debug_prints = nil,
                delete_debug_prints = "g?d",
            },
            visual = {
                variable_below = "g?v",
                variable_above = "g?V",
            },
        },
        commands = {
            toggle_comment_debug_prints = "ToggleCommentDebugPrints",
            delete_debug_prints = "DeleteDebugPrints",
        },
    },
    keys = {
        { "g?p",  mode = 'n' },
        { "g?P",  mode = 'n' },
        { "<F2>", mode = 'n' },
        { "g?V",  mode = 'n' },
        { "g?o",  mode = 'n' },
        { "g?O",  mode = 'n' },
        { "g?v",  mode = 'x' },
        { "g?V",  mode = 'x' },
    },
    cmd = {
        "ToggleCommentDebugPrints",
        "DeleteDebugPrints",
    },
    version = "*"
}
