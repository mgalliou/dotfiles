if tools#PluginIsLoaded("ale")
	let g:ale_completion_enabled = 1
	let g:ale_linters =  {
				\'c': ['clang', 'gcc']
				\}
	let g:ale_fixers = {
				\'*': ['remove_trailing_lines', 'trim_whitespace']
				\}
	let g:ale_c_cc_options = '-Wall -Wextra -Werror -Iinclude -Ilibft/include -Ilibftest/include'
	" TODO: add OS check
	let g:ale_nasm_nasm_options = '-f macho64'
endif
