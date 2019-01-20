" Author: miyabi-sun <miyabi.ooh@gmail.com>
" Description: Functions for working with lslint, for checking files.

call ale#Set('livescript_lslint_executable', 'lslint')
call ale#Set('livescript_lslint_use_global', get(g:, 'ale_use_global_executables', 0))

function! ale#handlers#lslint#GetExecutable(buffer) abort
    return ale#node#FindExecutable(a:buffer, 'livescript_lslint', [
    \   'node_modules/.bin/ls-lint',
    \])
endfunction

function! ale#handlers#lslint#GetCommand(buffer) abort
    let l:executable = ale#handlers#lslint#GetExecutable(a:buffer)

    return ale#node#Executable(a:buffer, l:executable)
    \   . ' %s'
endfunction

function! ale#handlers#lslint#Handle(buffer, lines) abort
    " Matches patterns line the following:
    "
    "      ✗ Variable 'File' should be chain-case. (6:1)
    let l:pattern = '^ *[^ ]* \(.\+\)(\(\d\+\):\(\d\+\)).*$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': l:match[2] + 0,
        \   'col': l:match[3] + 0,
        \   'text': l:match[1],
        \   'type': 'E',
        \})
    endfor

    return l:output
endfunction
