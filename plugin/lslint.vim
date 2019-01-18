scriptencoding utf-8

if !exists('g:loaded_ale_dont_use_this_in_other_plugins_please')
    finish
endif

if exists('g:loaded_lslint')
    finish
endif
let g:loaded_lslint = 1

call ale#linter#Define('ls', {
\   'name': 'lslint',
\   'output_stream': 'both',
\   'executable_callback': 'ale#handlers#lslint#GetExecutable',
\   'command_callback': 'ale#handlers#lslint#GetCommand',
\   'callback': 'ale#handlers#lslint#Handle',
\})
