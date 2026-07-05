-- Neovim bootstrap for this dotfiles repo.
-- Keep the existing Vim configuration as the single source of truth.
local dotvim = vim.fn.expand("~/.vim")

if vim.fn.isdirectory(dotvim) == 1 then
  local rtp = vim.split(vim.o.runtimepath, ",", { plain = true })
  local found = false

  for _, path in ipairs(rtp) do
    if path == dotvim then
      found = true
      break
    end
  end

  if not found then
    vim.o.runtimepath = dotvim .. "," .. vim.o.runtimepath
  end

  vim.o.packpath = vim.o.runtimepath
end

vim.cmd("source " .. vim.fn.fnameescape(vim.fn.expand("~/.vimrc")))
