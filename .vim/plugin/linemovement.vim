" linemovement.vim  Simplify the line movement
" Author            Wang Chao <yueyoum@gmail.com>
" Started           2013-03-23
" Updated           2013-03-23
" Version           0.2.0


if exists("g:loaded_linemovement") || &cp
    finish
endif
let g:load_linemovement = 1


function! linemovement#MoveBlockUp() range
    call linemovement#MoveBlock(a:firstline, a:lastline, a:firstline-2)
endfunction


function! linemovement#MoveBlockDown() range
    call linemovement#MoveBlock(a:firstline, a:lastline, a:lastline+1)
endfunction


function! linemovement#MoveBlock(startline, endline, new_line_pos)
    let s:cmd = a:startline . ',' . a:endline . ' move ' . a:new_line_pos
    execute s:cmd
    execute "normal! gv"
endfunction


if !exists("g:linemovement_up")
    let g:linemovement_up="<c-Up>"
endif

if !exists("g:linemovement_down")
    let g:linemovement_down="<c-Down>"
endif


if !exists("g:linemovent_mapped_keys")
    " Moving one line
    execute "nnoremap <silent> " . g:linemovement_up . " :m-2<CR>"
    execute "nnoremap <silent> " . g:linemovement_down . " :m+1<CR>"
    execute "inoremap <silent> " . g:linemovement_up . " <ESC>:m-2<CR>gi"
    execute "inoremap <silent> " . g:linemovement_down . " <ESC>:m+1<CR>gi"

    " Moving block
    execute "vnoremap <silent> " . g:linemovement_up . " :call linemovement#MoveBlockUp()<CR>"
    execute "vnoremap <silent> " . g:linemovement_down . " :call linemovement#MoveBlockDown()<CR>"

    let g:linemovent_mapped_keys = 1
endif


" Add empty line of above and bellow of one line
noremap <silent> <c-o> O<ESC>jo<ESC>k
