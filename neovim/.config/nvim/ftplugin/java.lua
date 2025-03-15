local config = {
	cmd = { vim.env.MASON .. "/bin/jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
	on_attach = Utils.on_attach,
	capabilities = Utils.capabilities(),
	settings = {
		java = {
			-- configuration = {
			-- 	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
			-- 	-- And search for `interface RuntimeOption`
			-- 	-- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
			-- runtimes = {
			-- 	-- {
			-- 	-- 	name = "JavaSE-11",
			-- 	-- 	path = "/usr/lib/jvm/java-11-openjdk-amd64",
			-- 	-- },
			-- 	{
			-- 		name = "JavaSE-17",
			-- 		path = "/usr/lib/jvm/java-17-openjdk-amd64",
			-- 	},
			-- }
			home = "/usr/lib/jvm/java-17-openjdk-amd64",
			import = {
				gradle = {
					java = {
						home = "/usr/lib/jvm/java-17-openjdk-amd64",
					},
				},
			},
		},
	},
}
require("jdtls").start_or_attach(config)
