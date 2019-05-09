"-----------------------------------------
"基本设置
"-----------------------------------------
"设置字体
"set gfn=X:hX
"设置自动缩进


set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
winpos 500 100                                          "窗口位置
set lines=40 columns=130                                "窗口大小
set noundofile                                           "取消生成备份文件
set noswapfile                                           "
set nu
set number                                               "显示行号
set encoding=utf-8										 "设置utf-8格式
set guifont=Consolas:h12								 "设置字体
set cursorline                                           "突出显示当前行
set tabstop=4                                            "设置tab键的宽度
set backspace=2                                          "设置退格键可用
set nobackup                                             " 不保留备份文件
syn on                                                   "打开语法高亮
set showmatch                                            "设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号
set smartindent                                          "智能对齐方式
set shiftwidth=4                                         "换行时行间交错使用4个空格
set autoindent                                           "自动对齐
set ai!                                                  "设置自动缩进
filetype plugin indent on                                "开启插件
set completeopt=longest,menu
syntax enable                                            "语法高亮
syntax on                                          
colorscheme candy                                      
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else                                                                                                                                              
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"定义CompileRun函数，用来调用编译和运行
func CompileRun()
exec "w"

if &filetype == 'c'
exec "!gcc % -o %<.exe"

elseif &filetype == 'cpp'
exec "!g++ -Wall -enable-auto-import % -g -o %<.exe"

elseif &filetype == 'java'
exec "!javac %"
endif
endfunc
"结束定义ComplieRun

"定义Run函数
func Run()
if &filetype == 'c' || &filetype == 'cpp'
exec "!%<.exe"
elseif &filetype == 'java'
exec "!java %<"
endif
endfunc

"定义Debug函数，用来调试程序
func Debug()
exec "w"

if &filetype == 'c'
exec "!gcc % -o %<.exe"
exec "!%<.exe"
elseif &filetype == 'cpp'
exec "!g++ % -g -o %<.exe"
exec "!gdb %<.exe"
elseif &filetype == 'java'
exec "!javac %"
exec "!java %<"
endif
endfunc

"设置程序的运行和调试的快捷键F5和Ctrl-F5
map <F5> :call CompileRun()<CR>
map <F6> :call Run()<CR>
map <C-F5> :call Debug()<CR>

"设置cscopequcikfix
""cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-    "设定使用quickfix窗口来显示cscope的结果
