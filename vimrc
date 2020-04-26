"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This vimrc is based on the vimrc by Easwy Yang:
"       http://github.com/easwy/share/tree/master/vim/vimrc/
"
" Maintainer:  Shenghua Gu
" Last Change: 2018/04/10
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Paltform
function! MySys()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

function! Open_or_Close_Menu()
  if &g:guioptions == "0"
    let &g:guioptions=&g:guioptions . 'mg'
  else
    let &g:guioptions=0
  endif
endfunction

if MySys() == "windows"
  let $PATH=$VIM . '\vimfiles\bin;' . $PATH
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
if MySys() == "linux"
  set nu			" show line number
endif

"设定文件浏览器目录为当前目录
"set bsdir=buffer
"if exists('+autochdir')
"  set autochdir
"endif

"backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

"查找设置 (若模式里含有大写字母则大小写敏感,否则忽略大小写)
set ignorecase smartcase

"编码----------------------------------------------
" encoding[enc]|Vim内部使用的编码方式（如果工作用的编码中含有无法转换为内部编码的字符，则这些字符就会丢失）
" termencoding|Vim用于屏幕显示的编码（Windows下GVim忽略termencoding的存在）
" fileencoding[fenc]|由Vim探测后自动设置（通过打开文件后设置fileencoding，可将文件由一种编码转换为另一种编码）
" fileencodings[fencs]|编码自动识别（用逗号分隔得列表）
" 如果编码被误判了，可在打开文件的时候使用++enc=encoding的方式来打开文件（:tabnew ++enc=euc-jp myfile.txt）
set encoding=utf-8
"set termencoding=ja_JP.UTF-8
" 设定菜单语言(必须写在其它会载入菜单的命令之前才能生效。例":syntax on"或":filetype on")
"set langmenu=zh_cn.utf-8	"可选值:$VIMRUNTIME/lang/menu_*(无视大小写)	英文=none
set langmenu=none
"language chinese_china
"language ctype chinese_china
"language Japanese_Japan
"language ctype Japanese_Japan
"language message zh_CN.UTF-8	"可选值:$VIMRUNTIME/lang/{dirname} 英文=en

"编码自动识别优先级
set fileencodings=utf-8,euc-jp,ucs-bom,sjis,cp936,b18030,big5,euc-kr,latin1

"Gui OR noGui
if has("gui_running")
  "不显示菜单栏,工具栏,滚动条
  set go=0
  nmap <F9> :call Open_or_Close_Menu()<cr>
  "窗体大小
  set lines=56 columns=206
  "配色方案
  "set background=dark
  "colorscheme solarized
  colorscheme lucius
else
  "配色方案
  set t_Co=256
  "let g:solarized_termcolors=256
  "set background=dark
  "set background=light
  "colorscheme solarized
  colorscheme lucius
endif

"Windows OR Linux
if MySys() == "windows"
  "字体及字号
  "set guifont=Bitstream_Vera_Sans_Mono:h12:cANSI
  "set guifont=DejaVu_Sans_Mono:h10:cANSI
  set guifont=DejaVu_Sans_Mono_for_Powerline:h10:cANSI
  "set guifontwide=HGGothicM:h12:cSHIFTJIS
  set guifontwide=YouYuan:h10
  "set guifontwide=VL-Gothic-Regular:h10
  set ambiwidth=double
  "设定帮助文档为中文(注:doc/下安装文档后需跟新帮助文件的tags":helptags $VIM/vimfiles/doc/")
  set helplang=cn
  "set helplang=en
  "将部分快捷键更改为与Windows类似
  "source $VIMRUNTIME/mswin.vim
  "关闭Vim的自动切换IME输入法(检索模式参照插入模式)
  set iminsert=0 imsearch=-1
  "与Windows共享剪贴板 [*]
  set clipboard+=unnamed

" set diffexpr=MyDiff()
  function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        let cmd = '""' . $VIMRUNTIME . '\diff"'
        let eq = '"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
  endfunction
  if has('mouse')
    set mouse=a
    behave mswin	"使鼠标服从微软的标准
      "左键单击		定位光标
      "左键拖动		在Visual模式下选取文本
      "左键单击+Shift	扩展被选择的文本到单击的位置
      "中键单击		粘贴剪贴板的内容
      "右键单击		显示弹出菜单
  endif
elseif MySys() == "linux"
  "字体及字号
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
  "set guifontwide=HGGothicM:h12:cSHIFTJIS
  "set guifontwide=YouYuan:h10:cGB2312
  set guifontwide=VL-Gothic-Regular\ 10
  "set guifontwide=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
  set ambiwidth=double
  "设定帮助文档为中文(注:doc/下安装文档后需跟新帮助文件的tags":helptags $VIM/vimfiles/doc/")
  set helplang=cn
  "set helplang=en
  "if has('mouse')
  "  set mouse=a
  "  behave xterm	"使鼠标服从XTERM标准
  "    "左键单击		定位光标
  "    "左键拖动		在Visual模式下选取文本
  "    "中键单击		粘贴剪贴板的内容
  "    "右键单击		扩展被选择的文本到单击的位置
  "endif
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

"Enable filetype plugin
filetype plugin on

"Set to auto read when a file is changed from the outside
set autoread

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Include search
set incsearch

"Set magic on
set magic

"Vim ALT key enable
" http://www.skywind.me/blog/archives/2021
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc
call Terminal_MetaMode(0)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch to buffer according to file name
function! SwitchToBuf(filename)
  "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
  " find in current tab
  let bufwinnr = bufwinnr(a:filename)
  if bufwinnr != -1
    exec bufwinnr . "wincmd w"
    return
  else
    " find in each tab
    tabfirst
    let tab = 1
    while tab <= tabpagenr("$")
      let bufwinnr = bufwinnr(a:filename)
      if bufwinnr != -1
        exec "normal " . tab . "gt"
        exec bufwinnr . "wincmd w"
        return
      endif
      tabnext
      let tab = tab + 1
    endwhile
    " not exist, new tab
    exec "tabnew " . a:filename
  endif
endfunction

"Fast edit vimrc
if MySys() == 'linux'
  "Fast reloading of the .vimrc
  nmap <silent> <leader>ss :source ~/.vim/vimrc<cr>
  "Fast editing of .vimrc
  nmap <silent> <leader>ee :call SwitchToBuf("~/.vim/vimrc")<cr>
  "When .vimrc is edited, reload it
  autocmd! bufwritepost vimrc source ~/.vim/vimrc
elseif MySys() == 'windows'
  "Fast reloading of the _vimrc
  nmap <silent> <leader>ss :source $VIM/_vimrc<cr>
  "Fast editing of _vimrc
  nmap <silent> <leader>ee :call SwitchToBuf("$VIM/_vimrc")<cr>
  "When _vimrc is edited, reload it
  autocmd! bufwritepost _vimrc source $VIM/_vimrc
endif

"Fast remove highlight search
nmap <silent> <leader><cr> :noh<cr>

"Fast redraw
nmap <silent> <leader>rr :redraw!<cr>

"Fast diff
set diffopt+=vertical

"Fast type time
imap <F6> <c-r>=strftime("%Y/%m/%d")<cr>
vmap <F6> c<c-r>=strftime("%Y/%m/%d")<cr><esc>
nmap <F6> C<c-r>=strftime("%Y/%m/%d")<cr><esc>
imap <F6><F6> <c-r>=strftime("%c")<cr>
vmap <F6><F6> c<c-r>=strftime("%c")<cr><esc>
nmap <F6><F6> C<c-r>=strftime("%c")<cr><esc>

"Fast table
nmap <leader>tn :tabnew<space>
nmap <leader>tc :tabclose<cr>
nmap <leader>tm :tabmove<space>
nmap <leader>to :tabonly<cr>
try
  set switchbuf=usetab
  set showtabline=1
catch
endtry

"Fast font size
  "<Ctrl--> isn't 'Ctrl+printable key'
nmap <M-=> :let &guifont=substitute(&guifont, ':h\zs\d\+\ze', '\=submatch(0)+1', '')<cr>
      \:let &guifontwide=substitute(&guifontwide, ':h\zs\d\+\ze', '\=submatch(0)+1', '')<cr>
nmap <M--> :let &guifont=substitute(&guifont, ':h\zs\d\+\ze', '\=submatch(0)-1', '')<cr>
      \:let &guifontwide=substitute(&guifontwide, ':h\zs\d\+\ze', '\=submatch(0)-1', '')<cr>

"Fast IME (使Vim自动切换IME输入法)
nmap <leader>im :set iminsert=2<cr>

"Fast split window
nmap <leader>% :vertical split<cr>
nmap <leader>" :split<cr>

"Fast move between windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

"Fast move between buffers
nmap <C-p> :bp<cr>
nmap <C-n> :bn<cr>

"Fast Ex command
nmap ; :
vmap ; :

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set expandtab	"将制表符用相应宽度的空格代替
"set shiftwidth=8
"set softtabstop=4
"set tabstop=8
"map <leader>t2 :set shiftwidth=2<cr>
"map <leader>t4 :set shiftwidth=4<cr>
"map <leader>t8 :set shiftwidth=8<cr>
au FileType html,python,vim,javascript,xml setl shiftwidth=2
"au FileType html,python,vim,javascript setl tabstop=2
"au FileType java,c,cpp setl shiftwidth=4
au FileType java,c,cpp,vb,dosbatch,csh,sh,perl,sql,wsh setl tabstop=4 shiftwidth=4
au FileType c setl expandtab

"set smarttab
"set linebreak
"set textwidth=80
set formatoptions+=mM

""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""
"检查文件类型并搜索一个对应的定义其缩进风格的文件 {dir}/indent/{filetype}.vim
filetype indent on

"Wrap lines
set wrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set fileformats=unix,dos

nmap <leader>fd :set ff=dos<cr>
nmap <leader>fu :set ff=unix<cr>

nmap <leader>fdd :set ff=dos<cr>:%s/\r\+$//e<cr>
nmap <leader>fuu :set ff=unix<cr>:%s/\r\+$//e<cr>

"Del trailing whitespace
nmap <leader>dt :%s/\s\+$//e<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions-=curdir
set sessionoptions+=unix,slash,sesdir,winpos

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowritebackup
"set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """"""""""""""""""""""""""""""
   "fencview 4.8
   "<F2>
   "检测编码格式
   """"""""""""""""""""""""""""""
   set nocompatible              " be iMproved, required

   """"""""""""""""""""""""""""""
   "vim-plug
   "Install:
   "  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
   "    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   "Usage:
   "  :PluginInstall
   """"""""""""""""""""""""""""""
   if MySys() == "linux"
     " Specify a directory for plugins
     " - For Neovim: ~/.local/share/nvim/plugged
     " - Avoid using standard Vim directory names like 'plugin'
     call plug#begin('~/.vim/plugged')

     " Make sure you use single quotes

     " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
     Plug 'junegunn/vim-easy-align'

     function! BuildYCM(info)
     " info is a dictionary with 3 fields
     " - name:   name of the plugin
     " - status: 'installed', 'updated', or 'unchanged'
     " - force:  set on PlugInstall! or PlugUpdate!
     if a:info.status == 'installed' || a:info.force
       !./install.py --clang-completer		" libclang
       "!./install.py --clangd-completer		" clangd lsp server
     endif
     endfunction
     Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
     Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

     " Multiple Plug commands can be written in a single line using | separators
     Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

     "Plug 'jiangmiao/auto-pairs'

     Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

     Plug 'mileszs/ack.vim'
     Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
     Plug 'junegunn/fzf.vim'

     Plug 'vim-scripts/VisIncr'

     Plug 'mbbill/fencview'
     Plug 'vim-scripts/taglist.vim'
     Plug 'vim-scripts/CmdlineComplete'
     Plug 'vim-scripts/a.vim'

     Plug 'drmad/tmux-git', { 'dir': '~/.tmux-git' }

     Plug 'inkarkat/vim-mark' | Plug 'inkarkat/vim-ingo-library'

     Plug 'dense-analysis/ale'

     Plug 'ludovicchabant/vim-gutentags'

     Plug 'skywind3000/vim-preview'

     Plug 'Shougo/echodoc.vim'

     Plug 'tpope/vim-unimpaired'

     Plug 'octol/vim-cpp-enhanced-highlight'

     " Initialize plugin system
     call plug#end()
   endif

   """"""""""""""""""""""""""""""
   " fencview 4.8
   " <F2>
   " 检测编码格式
   """"""""""""""""""""""""""""""
   let g:fencview_autodetect=0	"[=0]不自动检测 [=1]自动检测
   map <F2> :FencView<cr>

   """"""""""""""""""""""""""""""
   " a.vim
   " :A
   """"""""""""""""""""""""""""""
   let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:..,sfr:../include,sfr:../inc,sfr:inc'

   """"""""""""""""""""""""""""""
   " taglist_45
   " <F3>
   """"""""""""""""""""""""""""""
   let Tlist_Ctags_Cmd = 'ctags'
   let Tlist_Show_One_File = 1
   let Tlist_Exit_OnlyWindow = 1
   let Tlist_Use_Right_Window = 1
   nmap <silent> <F3> :Tlist<cr>

   """"""""""""""""""""""""""""""
   " vim-gutentags
   " gutentags_plus
   """"""""""""""""""""""""""""""
   " GLOBAL (gtags)
   " $ sudo apt-get install global
   """"""""""""""""""""""""""""""
   " Universal-ctags
   " https://github.com/universal-ctags/ctags
   " Build and Install:
   "  % ./autogen.sh
   "  % ./configure --prefix=/home/gsh/opt
   """"""""""""""""""""""""""""""
   let g:gutentags_file_list_command = 'find . -type f -name *.c -o -name *.cpp -o -name *.h '
   "允许 gutentags 打开一些高级命令和选项(调试时用)
"  let g:gutentags_define_advanced_commands = 1
"  " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
"  " gutentags 需要确定当前文件所属的项目目录，会从当前文件所在目录开始向父目录递归，直到找到这些标志文件。
"  " 如果没有，则 gutentags 认为该文件是个野文件，不会帮它生成 ctags/gtags 数据，这也很合理，
"  " 所以如果你的项目不在 svn/git/hg 仓库中的话，可以在项目根目录 touch 一个空的名为 .root 的文件即可。
   "let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project', '.ycm_extra_conf.py']
   let g:gutentags_add_default_project_roots = 0
   let g:gutentags_project_root = ['.root', '.ycm_extra_conf.py']
   " 所生成的数据文件的名称
   let g:gutentags_ctags_tagfile = 'tags'
   " 同时开启 ctags 和 gtags 支持：
   let g:gutentags_modules = []
   if executable('ctags')
   	let g:gutentags_modules += ['ctags']
   endif
   if executable('cscope')
   	let g:gutentags_modules += ['cscope']
   endif
   " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
   let s:vim_tags = expand('~/.cache/tags')
   let g:gutentags_cache_dir = s:vim_tags
   " 检测 ~/.cache/tags 不存在就新建
   if !isdirectory(s:vim_tags)
        silent! call mkdir(s:vim_tags, 'p')
   endif
   " 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
   let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
   let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
   let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
   " 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
   let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

   if executable("cscope")
     "同时搜索ctags和cscope的标签,并且cscope优先扫描
     set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
     set csto=0
     set cst
   endif

   """"""""""""""""""""""""""""""
   " cscope 15.7
   """"""""""""""""""""""""""""""
"  set tags=./tags;,tags
"  "前半部分"./tags;" 代表在文件的所在目录下(不是":pwd"返回的 Vim当前目录)查找名字为"tags"的符号文件，
"  "后面一个分号代表查找不到的话向上递归到父目录，直到找到tags文件或者递归到了根目录还没找到。
"  "逗号分隔的后半部分tags是指同时在Vim的当前目录(":pwd"命令返回的目录,可以用:cd .. 命令改变)下面查找tags文件。
"  if has("cscope")
"    "同时搜索ctags和cscope的标签,并且cscope优先扫描
"    set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
"    set csto=0
"    set cst
"    set csverb
"  endif
"  function! Mk_tag()
"    if executable('ctags')
"      " 注意最新版 universal ctags 调用时需要加一个 --output-format=e-ctags，输出格式才和老的 exuberant ctags 兼容否则会有 windows 下路径名等小问题
"      silent! execute '!ctags -R --c++-kinds=+px --fields=+aiKSz --extras=+q --output-format=e-ctags'
"    endif
"    if(executable('cscope') && has("cscope"))
"      if MySys() == "windows"
"        silent! execute '!dir /a:-d-s-h/b/s *.c,*.cpp,*.h,*.java,*.cs > cscope.files'
"      elseif MySys() == "linux"
"        silent! execute "!find `pwd` -type f -name '*.c' -o -name '*.cpp' -o -name '*.h' > cscope.files"
"      endif
"      execute 'cs kill -1'
"      silent! execute '!cscope -bkq'
"      execute 'cs add cscope.out'
"    endif
"  endfunction
"  nmap <silent> <leader>mt :call Mk_tag()<cr>
   """"""""""""""""""""""""""""""
   " cscope maps
   """"""""""""""""""""""""""""""
   nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>	"查找本 C 符号(可以跳过注释)
   nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>		"查找本定义
   nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>	"查找本函数调用的函数
   nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>	"查找调用本函数的函数
   nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>	"查找本字符串
   nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>	"查找本 egrep 模式
   nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>	"查找本文件
   nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>	"查找包含本文件的文件
   nmap <C-@>a :cs find a <C-R>=expand("<cword>")<CR><CR>:copen<CR>	"查找本 C 符号(可以跳过注释)

   """"""""""""""""""""""""""""""
   " vim-preview
   """"""""""""""""""""""""""""""
   noremap <F7> :PreviewSignature!<cr>
   inoremap <F7> <c-\><c-o>:PreviewSignature!<cr>
   autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
   autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
   noremap <m-u> :PreviewScroll -1<cr>
   noremap <m-d> :PreviewScroll +1<cr>
   inoremap <m-u> <c-\><c-o>:PreviewScroll -1<cr>
   inoremap <m-d> <c-\><c-o>:PreviewScroll +1<cr>

   """"""""""""""""""""""""""""""
   " YouCompleteMe
   """"""""""""""""""""""""""""""
if MySys() == "linux"
   " 全局配置文件使用默认自带(在具体的项目中，可在项目的根目录中放一个.ycm_extra_conf.py，并且加上头文件目录的配置)
   "let g:ycm_global_ycm_extra_conf='/home/gsh/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
   " 自动补全配置
   "set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
   set completeopt-=preview
   autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
   "上下左右键的行为 会显示其他信息
"  inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
"  inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
"  inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
"  inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
   "youcompleteme  默认tab  s-tab 和自动补全冲突
   "let g:ycm_key_list_select_completion=['<c-n>']
   "let g:ycm_key_list_select_completion = ['<Down>']
   "let g:ycm_key_list_previous_completion=['<c-p>']
   "let g:ycm_key_list_previous_completion = ['<Up>']
   let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
   let g:ycm_collect_identifiers_from_tags_files=1	"开启 YCM 基于标签引擎
   let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
   "let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
   let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
   let g:ycm_max_diagnostics_to_display = 100 " 显示ERROR和WARNING的上限数量
   "force recomile with syntastic
   nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
   nnoremap <leader>lo :lopen<CR>	"open locationlist
   nnoremap <leader>lc :lclose<CR>	"close locationlist
   inoremap <leader><leader> <C-x><C-o>
   "在注释输入中也能补全
   let g:ycm_complete_in_comments = 1
   "在字符串输入中也能补全
   let g:ycm_complete_in_strings = 1
   "注释和字符串中的文字也会被收入补全
   let g:ycm_collect_identifiers_from_comments_and_strings = 0
   "Warning and Error's symbols
   let g:ycm_error_symbol = '>>'
   let g:ycm_warning_symbol = '>*'
   "跳转到声明
   nnoremap <leader>jl :YcmCompleter GoToDeclaration<CR>
   "跳转到定义
   nnoremap <leader>jf :YcmCompleter GoToDefinition<CR>
   "跳转到定义或声明(不重新编译,速度快)
   nnoremap <leader>jd :YcmCompleter GoToImprecise<CR>
   "提示变量类型
   nnoremap <leader>gt :YcmCompleter GetType<CR>
   "提示Doc
   nnoremap <leader>gd :YcmCompleter GetDoc<CR>
   "自动修正
   nnoremap <leader>fi :YcmCompleter FixIt<CR>
   "打开location-list来显示警告和错误的信息
   nmap <F4> :YcmDiags<CR>
   "YCM启用白名单
   let g:ycm_filetype_whitelist = { "c":1, "cpp":1, "sh":1, }
   let g:ycm_add_preview_to_completeopt = 1
   let g:ycm_autoclose_preview_window_after_completion = 1
endif

   """"""""""""""""""""""""""""""
   " UltiSnips
   """"""""""""""""""""""""""""""
   " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
   let g:UltiSnipsExpandTrigger="<c-j>"
   let g:UltiSnipsJumpForwardTrigger="<tab>"
   let g:UltiSnipsJumpBackwardTrigger="<c-z>"

   " If you want :UltiSnipsEdit to split your window.
   let g:UltiSnipsEditSplit="vertical"

   """"""""""""""""""""""""""""""
   " vim-mark
   """"""""""""""""""""""""""""""
   "let g:mwDefaultHighlightingPalette = 'extended'
   "let g:mwDefaultHighlightingNum = 9
   let g:mwPalettes = {
        \   'mypalette': [
        \       { 'ctermbg':'187', 'ctermfg':'Black', 'guibg':'#d7d7af', 'guifg':'Black' },
        \       { 'ctermbg':'150', 'ctermfg':'Black', 'guibg':'#afd787', 'guifg':'Black' },
        \       { 'ctermbg':'117', 'ctermfg':'Black', 'guibg':'#87d7ff', 'guifg':'Black' },
        \       { 'ctermbg':'108', 'ctermfg':'Black', 'guibg':'#90a99d', 'guifg':'Black' },
        \       { 'ctermbg':'176', 'ctermfg':'Black', 'guibg':'#ae81c5', 'guifg':'Black' },
        \       { 'ctermbg':'203', 'ctermfg':'Black', 'guibg':'#e97877', 'guifg':'Black' },
        \       { 'ctermbg':'147', 'ctermfg':'Black', 'guibg':'#afafff', 'guifg':'Black' },
        \       { 'ctermbg':'077', 'ctermfg':'Black', 'guibg':'#86c6b5', 'guifg':'Black' },
        \       { 'ctermbg':'068', 'ctermfg':'Black', 'guibg':'#5f87d7', 'guifg':'Black' },
        \   ]
        \}

   " Make it the default
   let g:mwDefaultHighlightingPalette = 'mypalette'

   " Disable all marks, similar to :nohlsearch.
   nmap <Leader>M <Plug>MarkToggle
   " Clear all marks.
   nmap <Leader>N <Plug>MarkAllClear
   " List all mark highlight groups and the search patterns defined for them.
   nmap <Leader>L :Marks<CR>
   " You can remap the direct group searches (by default via the keypad 1-9 keys):
   nmap <Leader>1 <Plug>MarkSearchGroup1Next
   nmap <Leader>2 <Plug>MarkSearchGroup2Next
   nmap <Leader>3 <Plug>MarkSearchGroup3Next
   nmap <Leader>4 <Plug>MarkSearchGroup4Next
   nmap <Leader>5 <Plug>MarkSearchGroup5Next
   nmap <Leader>6 <Plug>MarkSearchGroup6Next
   nmap <Leader>7 <Plug>MarkSearchGroup7Next
   nmap <Leader>8 <Plug>MarkSearchGroup8Next
   nmap <Leader>9 <Plug>MarkSearchGroup9Next

   """"""""""""""""""""""""""""""
   " Airline
   """"""""""""""""""""""""""""""
   "By default, airline will use unicode symbols if your encoding matches
   "utf-8. If you want the powerline symbols set this variable:
   let g:airline_powerline_fonts = 0

   "If you want to use plain ascii symbols, set this variable:
   let g:airline_symbols_ascii = 1

   "spaces are allowed after tabs, but not in between
   "this algorithm works well with programming styles that use tabs for
   "indentation and spaces for alignment
   let g:airline#extensions#whitespace#mixed_indent_algo = 2

   """"""""""""""""""""""""""""""
   " Ack.vim
   """"""""""""""""""""""""""""""
   " ack 2.22
   " Check https://beyondgrep.com/ for updates
   " OR
   " ag (the_silver_searcher)
   " Check https://github.com/ggreer/the_silver_searcher for updates
   """"""""""""""""""""""""""""""
   let g:ackhighlight=0
   nmap <Leader>sa :Ack!<space>
   if executable('ag')
     let g:ackprg = 'ag --vimgrep'
   endif
   " ~/.agignore -> ~/.vim/home_conf/agignore

   """"""""""""""""""""""""""""""
   "fzf
   "Install
   " git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   " ~/.fzf/install
   "Update
   " cd ~/.fzf && git pull && ./install
   """"""""""""""""""""""""""""""
   "nmap <Leader>sf :Files<space>
   nmap <Leader>sf :Files<CR>
   "Use ag if exist -> Append the following to file ~/.bashrc or ~/.fzf.bash
   " --------------------
   "if command -v ag >/dev/null 2>&1; then
   "  export FZF_DEFAULT_COMMAND='ag -l -g ""'
   "fi
   " --------------------

   """"""""""""""""""""""""""""""
   " tmuxline.vim
   """"""""""""""""""""""""""""""
   " Need to install the powerline fonts
   " https://github.com/powerline/fonts.git
   """"""""""""""""""""""""""""""
   " Export the current theme file
   ":TmuxlineSnapshot tmuxline.conf
   "
   "Add the setting to read the tmuxline.conf file from the .tmux.conf file
   " --------------------
   "# tmuxline.vim
   "source-file ~/.tmux/tmuxline.conf
   " --------------------

   """"""""""""""""""""""""""""""
   " vim-easy-align
   """"""""""""""""""""""""""""""
   " Start interactive EasyAlign in visual mode (e.g. vip,a)
   xmap <Leader>a <Plug>(EasyAlign)

   """"""""""""""""""""""""""""""
   " Ale
   """"""""""""""""""""""""""""""
   " Need to install the check tool in PATH (exp:cppcheck, clang)
   "  % sudo apt-get install clang cppcheck
   """"""""""""""""""""""""""""""
   let g:ale_linters_explicit = 1
   let g:ale_completion_delay = 500
   let g:ale_echo_delay = 20
   let g:ale_lint_delay = 500
   let g:ale_echo_msg_format = '[%linter%] %code: %%s'
   let g:ale_lint_on_text_changed = 'normal'
   let g:ale_lint_on_insert_leave = 1
   let g:airline#extensions#ale#enabled = 1

   let g:ale_linters = {
         \ 'cpp': ['cppcheck'],
   	 \ 'c': ['cppcheck'],
   	 \ 'csh': ['shell'],
   	 \ 'bash': ['shell'],
   	 \ }
"  let g:ale_linters = {
"        \ 'cpp': ['clang', 'cppcheck'],
"  	 \ 'c': ['clang', 'cppcheck'],
"  	 \ 'csh': ['shell'],
"  	 \ 'bash': ['shell'],
"  	 \ }
   "let g:ale_c_gcc_options = '-Wall -std=c99'
   "let g:ale_cpp_gcc_options = '-Wall -std=c++98'
   "let g:ale_c_clang_options = '-Wall -std=c99'
   "let g:ale_cpp_clang_options = '-Wall -std=c++98'
   let g:ale_c_cppcheck_options = ''
   let g:ale_cpp_cppcheck_options = ''

   """"""""""""""""""""""""""""""
   " echodoc.vim
   """"""""""""""""""""""""""""""
   " To use echodoc, you must increase 'cmdheight' value.
   "set cmdheight=2
   set noshowmode
   let g:echodoc_enable_at_startup = 1
   " Or, you could disable showmode alltogether.
   "let g:echodoc_enable_at_startup = 1
