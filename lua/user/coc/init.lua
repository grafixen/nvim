-- Prettier
vim.cmd([[ command! CocPrInit execute 'CocCommand prettier.createConfigFile' ]])
vim.cmd([[ command! CocPrOutput execute 'CocCommand prettier.openOutput' ]])
vim.cmd([[ command! CocPrForce execute 'CocCommand prettier.forceFormatDocument' ]])
vim.cmd([[ command! CocPrettier execute 'CocCommand prettier.formatFile' ]])
