syntax on
colorscheme jon

set nocompatible
set encoding=utf-8
set noswapfile
set nu
set path+=**
set runtimepath+=~/.vim/autoload
set wildmenu
set tabstop=4
set shiftwidth=4
set expandtab
set binary
set noeol
set cursorline
set hlsearch
set ignorecase
set incsearch
set noerrorbells
set nostartofline
set ruler
set shortmess=atI
set showmode
set title
set scrolloff=3

filetype plugin indent on

set backspace=indent,eol,start
let mapleader = ","

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

function Ai() range
    let question = getline(line("."))
    let res = json_decode(system("curl -s http://localhost:5000/"))
    if has_key(res, question)
        call setline(line('.'), "")
        let information = get(res, question)
        let curpos = getpos(".")
        for line in information
            let insert_command = strpart(line, 0, 1)
            let code = split(strpart(line, 1, len(line)), "\n")
            if insert_command == "."
                call append(line("."), '')
                call append(line(insert_command) - 1, code)
            else
                call append(line(insert_command), code)
            endif
        endfor
        "call setpos(".", [0, line("$"), len(getline(line("$"))), 0])
   else
        echom "I'm not sure. Hrmm.."
    endif
endfunction
noremap <leader>H :call Ai()<cr>


function AiUpload() range
"    let answer = getline(line("."))
    let answer = join(getline(a:firstline, a:lastline), "\n")
    let payload = {}
    let payload.answer = answer
    let question = input('What is this?: ')
    let payload.question = question

    let syscall = "curl -s -H \"Content-Type: application/json\" -d '" . json_encode(payload) . "' http://localhost:5000/answer"
    let res = json_encode(system(syscall))
    echom res

endfunction

noremap <leader>J :call AiUpload()<cr>
noremap <leader>s :w<CR>
