local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  toggler = {
      -- 切换行注释
      line = "gcc",
      --- 切换块注释
      block = "gCC"
    },
    opleader = {
      -- 可视模式下的行注释
      line = "gc",
      -- 可视模式下的块注释
      block = "gC"
    },
    extra = {
      -- 在当前行上方新增行注释
      above = "gcO",
      -- 在当前行下方新增行注释
      below = "gco",
      -- 在当前行行尾新增行注释
      eol = "gcA"
    },
  pre_hook = function(ctx)
    local U = require "Comment.utils"

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,
}
