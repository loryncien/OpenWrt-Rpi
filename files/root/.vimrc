" Install plug manager
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" call plug#begin()
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'preservim/nerdcommenter'
" Plug 'yianwillis/vimcdoc'
" Plug 'mhinz/vim-startify'
" Plug 'easymotion/vim-easymotion'
" " markdown support
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
" let g:vim_markdown_folding_disabled = 1
" " markdown preview
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" " Theme
" Plug 'morhetz/gruvbox'
" call plug#end()

" === 常用自定义快捷键 === {{{2
" [count]//   -- 注释循环切换,插件
" <CR>        -- 折叠循环开关

"}}}2 === END ===

" === 通用配置 === {{{2
set nocompatible      " 不使用兼容模式vi
filetype on           " 开启文件类型检测
filetype plugin on    " 开启插件的支持
filetype indent on    " 开启文件类型相应的缩进规则
" 打开语法高亮
if filereadable(expand("$VIMRUNTIME/syntax/synload.vim"))
    syntax on
endif
if has("syntax") && &term =~ "xterm"
    set t_Co=8
    if has("terminfo")
      set t_Sf=<Esc>[3%p1%dm
      set t_Sb=<Esc>[4%p1%dm
    else
      set t_Sf=<Esc>[3%dm
      set t_Sb=<Esc>[4%dm
    endif
endif
set t_Co=256          " 开启vim的256颜色支持
if filereadable(expand("$VIMRUNTIME/colors/desert.vim"))
    colorscheme desert
endif
set background=dark   " 配色主题的色系

" 显示
set nu                " 显示行号 :set nonu
"set rnu              " 显示相对行号
set ruler             " 显示光标位置
set cursorline        " 光标所在的当前高亮
set showcmd           " 显示输入命令(右下角)
set showmatch         " 显示匹配的括号
set matchtime=1       " 匹配括号高亮的时间,默认500ms，现在是100ms
set list              " 显示不可视字符
set listchars=tab:▸\ ,trail:■ " Tab使用~代替，尾部空白使用高亮点号
set laststatus=2      " 底部显示两行状态栏
set sidescroll=1      " 默认设置set sidescroll=0之下，当光标到达屏幕边缘时，将自动扩展显示1/2屏幕的文本。通过使用set sidescroll=1设置，可以实现更加平滑的逐个字符扩展显示。

" 搜索
set smartcase         " 搜索时输入大写，则严格大小写搜索，如果小写并设置了ignorecase，则忽略
set ic                " 查找时忽略大小写 :set noic
set hlsearch          " 高亮显示查找匹配结果
set incsearch         " 搜索时及时匹配搜索内容，需要回车确认

" Tab
set expandtab         " tab自动转化成空格 (输入真正Tab键时，Ctrl+V + Tab)
set smarttab          " 配合shiftwidth使用，如果设置该值，在行首键入<tab>会填充shiftwidth的数值,其他地方使用tabstop的数值，不设置的话，所有地方都是用shiftwidth数值
" 缩进
set tabstop=2         " tab宽度
set shiftwidth=2      " 自动缩进空格数，在文本上按下>>（增加一级缩进）、<<（取消一级缩进）或者==（取消全部缩进）时，每一级的字符数
set softtabstop=2     " 退格键一次清除4个空格
set backspace=indent,eol,start  " 退格可删除缩进,原有字符以及换行
set autoindent        " 换行自动缩进
set smartindent       " 换行自动缩进, C语言风格

" 编码
set encoding=utf8        " 打开文件时编码格式
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030
set termencoding=utf-8   " 终端环境告诉vim使用编码

" 选择
set selectmode=key        " 通过鼠标选择为可视模式,而不是选择模式
set selection=inclusive   " inclousive 包括光标下字符，exclusive则不包括
set mouse=a               " 启用鼠标"

set nobackup          " 不生成备份
set noswapfile        " 不生成swap交换文件
set autoread          " 文件在vim外修改过自动重新载入
au CursorHold,CursorHoldI * checktime
set confirm           " if quit without save,make confirm
set bufhidden=hide    " 当buffer被丢弃的时候隐藏它
set wildmenu          " 增强模式中的命令行自动完成操作

set novisualbell          "关掉可视化响铃警报
set noerrorbells          "关掉错误警报
set visualbell t_vb=      "关掉警报

set ttimeoutlen=0     " set <ESC> response time
set history=64
" set scrolloff=2        " 光标移动到buffer的顶部和底部时保持3行距离

" set ttimeoutlen=1000     " 键码延迟(默认-1)
" set timeoutlen=2000      " 映射延迟(默认1000)

" === 主题 gruvbox === {{{3
" colorscheme gruvbox
set background=dark

nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
" === END ===

" gvim/macvimi config {{{3
if has("gui_running")
    set guifont=DroidSansMono\ Nerd\ Font\ Regular\ 14      " set fonts in gvim
    set guioptions-=m           " hide the menu bar
    set guioptions-=T           " hide tool bar
    set guioptions-=L           " hide left scroll bar
    set guioptions-=r           " hide right scroll bar
    set guioptions-=b           " hide bottom scroll bar
    set showtabline=0           " hide tab bar
    set guicursor=n-v-c:ver5    " set cursor to a vertical line
    " set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete:h14 " set fonts in macvim
endif

" === 光标样式和颜色 === {{{3
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"    " INSERT mode
    let &t_EI = "\e[2 q"    " NORMAL mode
endif
" 1 -> blinking block  闪烁的方块
" 2 -> solid block  不闪烁的方块
" 3 -> blinking underscore  闪烁的下划线
" 4 -> solid underscore  不闪烁的下划线
" 5 -> blinking vertical bar  闪烁的竖线
" 6 -> solid vertical bar  不闪烁的竖线

" === 代码折叠 === {{{3
" set foldlevelstart=99      " 默认不折叠代码
set foldlevel=1             " 关闭高于此折叠层级，默认0全折叠
set foldcolumn=0            " 设置折叠区域的宽度,默认为0
"set foldclose=all           " 设置为自动关闭折叠
"nnoremap zz @=((foldclosed(line('.')) < 0) ? 'zc' :'zo')<CR>
nnoremap <silent> z<space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>
set fdm=marker             " marker方式折叠
"set foldmethod=indent     " 缩进方式折叠
" 自动记忆/载入手动折叠信息
" autocmd BufWrite * mkview
" autocmd BufWinLeave * mkview
" autocmd BufRead * silent loadview

" === 剪贴板 === {{{3
if has("clipboard")
    set clipboard=unnamed  " 复制到系统剪贴板
    if has("unnamedplus")  " X11 support
        set clipboard+=unnamedplus
    endif
endif

if version >=603
    set helplang=cn
endif

" === 自定义文件类型代码高亮 === {{{3
" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile * setfiletype txt
au BufRead,BufNewFile _pentadactylrc set filetype=pentadactyl
au BufRead,BufNewFile .zimrc set filetype=zsh

" === 打开文件默认回到上次编辑 === {{{3
" sudo chmod 777 .viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" === 自动移除末尾空白 === {{{3
autocmd BufWritePre * :%s/\s\+$//e

"}}}2 === 通用配置 END ===

let mapleader = ";"
nnoremap <space> :

" === map 映射 === {{{2
" === Fn功能键 ===
" 显示行号切换
map <silent><F4> :set relativenumber!<CR>

" 将ESC键映射为两次j键
inoremap jj <Esc>

" 光标移动
nnoremap H ^
nnoremap L $
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 复制到末尾
nnoremap Y y$
nnoremap vv ^vg_

" 取消撤销
nnoremap U <C-r>

" 使用回车打开关闭折叠
nnoremap <CR> za

" set split window
nnoremap <silent><nowait>_ :vsp<cr>
nnoremap <silent><nowait>+ :sp<cr>

" 搜索时把当前结果置于屏幕中央并打开折叠
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 缩进，gv命令可以用于重新选取上一次由可视模式所选择的文本范围
vnoremap < <gv
vnoremap > >gv

" 选择替换
vnoremap s :<c-u>execute "normal! gv\"sy"<cr>:%s/<c-r>=@s<cr>/
nnoremap <leader>s :%s/<c-r><c-w>/

" 在正常模式和插入模式快速跳到行首行尾
nnoremap <C-a> I
nnoremap <C-e> A
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A

" 插入模式下的一些快捷键
inoremap <M-o> <esc>o
inoremap <M-O> <esc>O
" inoremap <M-h> <HOME>
inoremap <M-h> <esc>^i
inoremap <M-l> <END>

" https://blog.twofei.com/610/
" https://vim.fandom.com/wiki/Search_for_visually_selected_text
" 选择要搜索的内容
vnoremap // y/<c-r>"<cr>

" 当忘记使用sudo启动vim时，允许sudo保存文件
cmap <silent> w!! %!sudo tee > /dev/null %

" === 命令行按键映射 === {{{3
" 全局查找替换:ss
cnoremap ss <ESC>:%s///<left><left>
" 全局查找排除:vv
cnoremap vv <ESC>:v//<left>

" 命令行移动
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-h> <Home>
cnoremap <C-l> <End>
" cnoremap <C-l> <Right>
" cnoremap <C-j> <Left>

" === END === }}}2 

" === leader map === {{{2
"
" \sa Vim全选按键映射
map <leader>sa ggVG

" \z<space> 代码注释切换重映射
nmap <leader>z<space> <leader>c<space>

" \hh 切换显示行号,相对行号
nmap <leader>nu :set nu! nu?<CR>
nmap <leader>hh :set rnu! rnu?<CR>

" \noh 取消高亮
nmap <leader>/ :nohlsearch<CR>
nmap <leader>nh :nohlsearch<CR>

" \qk \qh \qt 去除空白行,Tab转空格 {{{3
inoremap <leader>qk <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <leader>qk <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
vnoremap <leader>qk <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" \qh  一键删除不包含任何空格的空行,g/^\s*$/d删除包含空格的空行
nmap <leader>qh :g/^$/d<CR>
" \qt   一键替换全部Tab为空格
func! RemoveTabs()
    if &shiftwidth == 2
        exec "%s/	/  /g"
    elseif &shiftwidth == 4
        exec "%s/	/    /g"
    elseif &shiftwidth == 6
        exec "%s/	/      /g"
    elseif &shiftwidth == 8
        exec "%s/	/        /g"
    else
        exec "%s/	<left>/ /g"
    end
endfunc
"}}}2 === Leader END ===

" === 插件配置 === {{{2
" ---- NerdCommenter ----
" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1
" 注释向左对其，而不是跟随代码缩进
let g:NERDDefaultAlign = 'left'
" 取消注释时启用尾随空格的修剪
let g:NERDTrimTrailingWhitespace = 1
" 注释循环切换按键映射
nmap // <leader>c<space>
vmap // <leader>c<space>gv

" ---- airline ----
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['tabline' , 'coc']
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

" ---- easymotion ----
" 跳到任意单词
omap <Leader>fw <Plug>(easymotion-bd-w)
nmap <Leader>fw <Plug>(easymotion-overwin-w)
" 查找一个字符
map  <Leader>ff <Plug>(easymotion-bd-f)
nmap <Leader>ff <Plug>(easymotion-overwin-f)
" 跳到任意行
omap <Leader>fh <Plug>(easymotion-bd-jk)
nmap <Leader>fh <Plug>(easymotion-overwin-line)
" 查找任意长度字符串
nmap <leader>fs <Plug>(easymotion-sn)
" 以当前光标所在列为标记基准
let g:EasyMotion_startofline = 0
let g:EasyMotion_smartcase = 1

"}}}2 === 插件配置 END ===
