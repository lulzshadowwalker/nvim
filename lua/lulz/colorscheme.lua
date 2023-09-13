local colorscheme = 'gruvbox'

function trans_bg()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

local okey, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not okey then
  vim.notify('colorscheme ' .. colorscheme .. ' not found pepega', 'error')
  return
end
