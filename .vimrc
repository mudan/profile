"{{{ 杂项配置
"set tags+=$DIR/tags	"tags 动态加载
set viminfo^=%	"记住viminfo信息
set showcmd	"显示未完成的命令
set ruler	"显示当前光标位置
set number	"显示行号
set ai		"智能自动缩进
set si		"设置自动缩进
set wrap	"Wrap lines
"set nocompatible	"不需要保持和 vi 非常兼容
set backspace=2	"设置退格键可用
"set autoindent	"启动新行使用与前一行相同的缩进
set formatoptions+=mM	"正确处理中文字符的折行和拼接
set fileencodings=ucs-bom,utf-8,gbk	"自动识别待 BOM 字符文件
set autoread	"自动读档
set history=50	"保存50个命令及查找历史
set list	"显示 TAB 和 $
set listchars=tab:\|\ ,
set shiftwidth=4		"现在自动缩进将是4个字符
set autowrite	"自动保存
"set backup	"保存后生成备份文件
set backupext=.bak		"备份文件后缀名为.bak
set clipboard+=unnamed		"Vim 的默认寄存器和系统剪贴板共享
set wildmenu	"启用文本模式的菜单
set ignorecase  "查找忽略大小写
"set hlsearch	"高亮匹配
set incsearch	"即时显示匹配
"set ignorecase	"搜索忽略大小写
set smartcase	"智能搜索
set smarttab	"智能标签
set fdm=marker	"设置折叠风格
set incsearch	"实时匹配你输入的内容
set laststatus=2		"显示状态栏
"设置在状态行显示的信息
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %c:%l\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]
set shiftwidth=4		"设定 << 和 >> 命令移动时的宽度为 4
"关闭错误声音
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"syntax enable	"开启语法高亮
filetype on	"检测文件类型
filetype plugin indent on	"启用自动补全
filetype indent on		" 针对不同的文件类型采用不同的缩进格式
filetype plugin on		" 针对不同的文件类型加载对应的插件
autocmd BufEnter * lcd %:p:h	"自动更改到当前文件所在的目录

"判断 Vim 是否包含多字节语言支持，并且版本号大于 6.1
if has('multi_byte') && v:version > 601
"如果 Vim 的语言（受环境变量 LANG 影响）是中文（cn）、日文（ja）或韩文（ko）的话，将模糊宽度的 Unicode 字符的宽度设为双宽度（double）
if v:lang =~? '^\(cn\)\|\(ja\)\|\(ko\)'
  set ambiwidth=double
endif
endif

" 在终端支持和gui界面使用语法高亮和搜索高亮
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

"if has("gui_running")
"        set guioptions-=m       "隐藏菜单栏
"        set guioptions-=T       "隐藏工具栏
"        "set guioptions-=L       "隐藏左侧滚动条
"        "set guioptions-=r       "隐藏右侧滚动条
"        "set guioptions-=b       "隐藏底部滚动条
"        "set showtabline=0       "隐藏Tab栏
"endif
"}}}

"{{{ 函数定义

" {{{2获取可读的文件大小
function Lilydjwg_getfsize(file)
  let size = getfsize(a:file)
  if has('python3')
    try
      py3 from myutils import filesize
      return py3eval('filesize('.size.')')
    catch /.*/
    endtry
  endif
  return size . 'B'
endfunction
"}}}
" {{{2 使用分隔符连接多行
function Lilydjwg_join(sep, bang) range
  if a:sep[0] == '\'
    let sep = strpart(a:sep, 1)
  else
    let sep = a:sep
  endif
  let lines = getline(a:firstline, a:lastline)
  if a:firstline == 1 && a:lastline == line('$')
    let dellast = 1
  else
    let dellast = 0
  endif
  exe a:firstline . ',' . a:lastline . 'd_'
  if a:bang != '!'
    call map(lines, "substitute(v:val, '^\\s\\+\\|\\s\\+$', '', 'g')")
  endif
  call append(a:firstline-1, join(lines, sep))
  if dellast
    $d_
  endif
endfunction
"}}}
" {{{2 退格删除自动缩进
function! Lilydjwg_checklist_bs(pat)
  " 退格可清除自动出来的列表符号
  if getline('.') =~ a:pat
    let ind = indent(line('.')-1)
    if !ind
      let ind = indent(line('.')+1)
    endif
    call setline(line('.'), repeat(' ', ind))
    return ""
  else
    return "\<BS>"
  endif
endfunction
"}}}

" 高亮显示 TODO
highlight RipGroup ctermbg=yellow cterm=none ctermfg=black
match RipGroup /TODO/

" 以第一行的文字为名保存当前文件
command TSave call Lilydjwg_TSave()
command -nargs=? -complete=file RSplit vs <args>|normal <C-W>L<C-W>w
command -range=% -bar SQuote <line1>,<line2>s/“\|”\|″/"/ge|<line1>,<line2>s/‘\|’\|′/'/ge
command -range -bar HTMLEscape <line1>,<line2>s/&/\&amp;/ge|<line1>,<line2>s/</\&lt;/ge|<line1>,<line2>s/>/\&gt;/ge
command -range -bar HTMLUnescape <line1>,<line2>s/&amp;/\&/ge|<line1>,<line2>s/&lt;/</ge|<line1>,<line2>s/&gt;/>/ge
command RJ silent call Lilydjwg_edit_diary()

" 设置成 Linux 下适用的格式
command Lin setl ff=unix fenc=utf8 nobomb eol
" 设置成 Windows 下适用的格式
command Win setl ff=dos fenc=gb18030

"}}}

"{{{ Colors and Fonts
syntax enable
colorscheme desert
set background=dark
"Set extra options when running in GUI mode
if has("gui_running")
set guioptions-=T
set guioptions+=e
set t_Co=256
set guitablabel=%M\ %t
endif
"Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
"Use Unix as the standard file type
set ffs=unix,dos,mac
"}}}

" {{{ 快捷键定义
" 插入模式下上下左右移动光标
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <c-o>gj
inoremap <c-k> <c-o>gk

" 选中模式 Ctrl+c 复制选中的文本
vnoremap <c-c> "+y
" 直接按 j/k 移动多列行
map j gj
map k gk
" 普通模式下 Ctrl+c 复制文件路径
nnoremap <c-c> :let @+ = expand('%:p')<cr>
" 标签快捷键操作
map tn :tabnew<cr>
map tc :tabclose<cr>
"insert模式<F2>加入时间戳
imap &lt;F2> &lt;C-R>=strftime("%c")&lt;CR>
" Shift + Insert 插入系统剪切板中的内容
noremap <S-Insert> "+p
vnoremap <S-Insert> d"+P
inoremap <S-Insert> <esc>"+pa
inoremap <C-S-Insert> <esc>pa
"map Q gq	"定义键盘映射
":cmap ,r  :Nread ftp://209.51.134.122/public_html/index.html	"用 VIM 通过 ftp 编辑文件
" }}}

" {{{ 杂类插件

" linemovement.vim	移动行或块操作
let g:linemovement_up="<c-Up>"
let g:linemovement_down="<c-Down>"

" }}}

" {{{ NERD_tree
" 让Tree把自己给装饰得多姿多彩漂亮点
let NERDChristmasTree=1
" 控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
let NERDTreeAutoCenter=1
" 指定书签文件
let NERDTreeBookmarksFile=$VIMFILES.'\NERDTree_bookmarks'
" 指定鼠标模式(1.双击打开 2.单目录双文件 3.单击打开)
let NERDTreeMouseMode=2
" 是否默认显示书签列表
let NERDTreeShowBookmarks=1
" 是否默认显示文件
let NERDTreeShowFiles=1
" 是否默认显示隐藏文件
let NERDTreeShowHidden=1
" 是否默认显示行号
let NERDTreeShowLineNumbers=1
" 窗口位置（'left' or 'right'）
let NERDTreeWinPos='left'
" 窗口宽度
let NERDTreeWinSize=31
nnoremap <Leader>tt :NERDTree<CR>

" 打开 NERDTree，使用当前文件目录或者当前目录
function Lilydjwg_NERDTreeOpen()
  if exists("t:NERDTreeBufName")
    NERDTreeToggle
  else
    try
      NERDTree `=expand('%:h')`
    catch /E121/
      NERDTree `=getcwd()`
    endtry
  endif
endfunction
"}}}

" {{{ bufferExplorer
"let g:bufExplorerSortBy='mru'
"let g:bufExplorerSplitRight=0     
"let g:bufExplorerSplitVertical=1    .
"let g:bufExplorerSplitVertSize = 30 
"let g:bufExplorerUseCurrentWindow=1 
"autocmd BufWinEnter \[Buf\ List\] setl nonumber
" }}}

"{{{ powerline
"let g:Powerline_symbols = 'fancy'
"set fillchars+=stl:\ ,stlnc:\
"set -g default-terminal "screen-256color"
"}}}

"{{{ vimwiki

let g:vimwiki_w32_dir_enc = 'utf-8'
let g:vimwiki_list = [{'path': '~/Yunio/vimwiki/'}]
let g:vimwiki_camel_case = 0
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_folding = 0
let g:vimwiki_browsers = ['chromium']
let g:vimwiki_use_calendar = 1
let g:vimwiki_CJK_length = 1
let g:vimwiki_dir_link = 'index'
let g:vimwiki_html_header_numbering = 2
let g:vimwiki_conceallevel = 2
" 使用的HTML标签
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,br,hr,div,del,code,red,center,left,right,h2,h4,h5,h6,pre,script,style'

"{{{2 tagbar 增加对 markdown 和 vimwiki 的支持
" vimwiki
let g:tagbar_type_vimwiki = {
            \ 'ctagstype' : 'vimwiki',
            \ 'kinds'     : [
            \ 'h:header',
            \ ],
            \ 'sort'    : 0
            \ }
" markdown
let g:tagbar_type_markdown = {
            \ 'ctagstype' : 'markdown',
            \ 'kinds' : [
            \ 'h:Heading_L1',
            \ 'i:Heading_L2',
            \ 'k:Heading_L3'
            \ ]
            \ }
"}}}
