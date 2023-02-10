local config = {
	cmd = { '~/.local/share/nvim/mason/bin/jdtls' },
	root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require("tools").on_attach("jdtls", 0)
require("jdtls").start_or_attach(config)