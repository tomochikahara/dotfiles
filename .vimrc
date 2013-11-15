"-------------------------------------------------------------------------------
" Plugin Bundles
"-------------------------------------------------------------------------------
filetype off

if has('vim_starting')
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
endif
call neobundle#rc(expand('~/.vim/bundle'))

" NeoBundle
NeoBundle 'Shougo/neobundle.vim'
" 構文チェック
NeoBundle 'scrooloose/syntastic'

NeoBundle 'thinca/vim-quickrun.git'
NeoBundle 'plasticboy/vim-markdown.git'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'groenewege/vim-less'
NeoBundle 'tomochikahara/vim-insert-linenr'
NeoBundle 'rizzatti/funcoo.vim'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'kana/vim-textobj-user'
" 全体をテキストオブジェクト化
NeoBundle 'kana/vim-textobj-entire'

" コメント化
NeoBundle 'tpope/vim-commentary'

NeoBundle 'itchyny/lightline.vim'

" 独自モードを作成
NeoBundle 'thinca/vim-submode'

" for Dart
NeoBundle 'dart-lang/dart-vim-plugin.git'
" for JavaScript
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}

filetype plugin indent on
NeoBundleCheck

let g:quickrun_config = {}
let g:quickrun_config.mkd = {'outputter' : 'null', 'command' : 'open', 'cmdopt' : '-a', 'args' : 'Marked', 'exec' : '%c %o %a %s',}

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" submode.vim {{{
"   ウィンドウリサイズモード
let g:submode_keep_leaving_key = 1
let g:submode_timeout = 0
call submode#enter_with('winsize', 'n', '', '<C-W>>', '<C-W>>')
call submode#enter_with('winsize', 'n', '', '<C-W><', '<C-W><')
call submode#enter_with('winsize', 'n', '', '<C-W>+', '<C-W>+')
call submode#enter_with('winsize', 'n', '', '<C-W>-', '<C-W>-')
call submode#map('winsize', 'n', '', '>', '<C-W>>')
call submode#map('winsize', 'n', '', '<', '<C-W><')
call submode#map('winsize', 'n', '', '+', '<C-W>+')
call submode#map('winsize', 'n', '', '-', '<C-W>-')
" }}}

" CD  : カレントディレクトリを変更する
" CD! : 移動先のディレクトリを表示する
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

""Set augroup.
augroup VimrcReloadAutoCmd
    autocmd!
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd VimrcReloadAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " .vimrcの再読込時にも色が変化するようにする
    autocmd VimrcReloadAutoCmd BufWritePost $MYVIMRC source $MYVIMRC | if has('gui_running') | source $MYGVIMRC
    autocmd VimrcReloadAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif

"-------------------------------------------------------------------------------
" 基本設定 Basics
"-------------------------------------------------------------------------------
set scrolloff=5                  " スクロール時の余白確保
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効

"set iminsert=0
"set imsearch=0
set imdisable
set iminsert=1
set imsearch=1

" OSのクリップボードを使用する
set clipboard+=unnamed

colorscheme desert
syntax on

set tabstop=4
set shiftwidth=2
set expandtab
set helplang=ja

"-------------------------------------------------------------------------------
" 表示 Apperance
"-------------------------------------------------------------------------------
set showmatch         " 括弧の対応をハイライト
set number relativenumber " 行番号表示
set list              " 不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=uhex      " 印字不可能文字を16進数で表示

set ruler " ルーラー
set title " タイトル
set showmatch "閉じ括弧入力時に対応する開き括弧にジャンプ
set showcmd "コマンド表示
set cmdheight=2
set laststatus=2 "ステータス行を常時表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}

" 行を折り返さない
set nowrap
set scrolloff=5

hi Search term=reverse ctermbg=DarkBlue ctermfg=NONE

augroup AutoLoadSyntaxComplete
    autocmd!
augroup END
autocmd AutoLoadSyntaxComplete FileType ruby setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd AutoLoadSyntaxComplete FileType eruby setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd AutoLoadSyntaxComplete BufNewFile,BufRead app/*/*.rhtml setlocal ft=mason fenc=utf-8
autocmd AutoLoadSyntaxComplete BufNewFile,BufRead app/**/*.rb setlocal ft=ruby fenc=utf-8
autocmd AutoLoadSyntaxComplete BufNewFile,BufRead app/**/*.yml setlocal ft=ruby fenc=utf-8
autocmd AutoLoadSyntaxComplete FileType c hi Comment ctermfg=darkcyan
autocmd AutoLoadSyntaxComplete FileType cpp hi Comment ctermfg=darkcyan
autocmd AutoLoadSyntaxComplete FileType haskell setlocal tabstop=2 tw=0 sw=2 expandtab
autocmd AutoLoadSyntaxComplete FileType php setlocal tabstop=4 tw=0 sw=4 expandtab
autocmd AutoLoadSyntaxComplete FileType html setlocal tabstop=2 tw=0 sw=2 expandtab

"-------------------------------------------------------------------------------
" エンコーディング関連 Encoding
"-------------------------------------------------------------------------------
set ffs=unix,dos,mac  " 改行文字
set encoding=utf-8    " デフォルトエンコーディング

"------------------------------------------------------------------------------
" キーマップ Key mappings
"-------------------------------------------------------------------------------
"Escの2回押しでハイライト消去
noremap <Esc><Esc> :nohlsearch<CR><Esc>
noremap ; :
noremap : ;
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
map ¥ <leader>

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>
" Load .gvimrc after .vimrc edited at GVim.
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

" Insert mode中で単語単位/行単位の削除をアンドゥ可能に
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" ページ送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

" 行末までヤンクする
nnoremap Y y$

" インサートモードでも誤爆を防ぐ
inoremap <C-@> <C-[>

" ウィンドウ移動
nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W

" タブ移動
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>

" バッファ移動
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" 相対行番号表示をトグル
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>

" NERD Tree 設定
nnoremap <silent> <C-e> :NERDTreeToggle<CR>

let g:NERDTreeMapJumpNextSibling = '¥<C-J¥>'
let g:NERDTreeMapJumpPrevSibling = '¥<C-K¥>'

"-------------------------------------------------------------------------------
" コマンドライン CommandLine
"-------------------------------------------------------------------------------
" コマンドライン補完
set wildmenu
" コマンドライン補完方法
set wildmode=longest:full,full
" コマンドライン履歴の保存数
set history=2000

" コマンド履歴のフィルタリングにカーソルキーを使わない
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" アクティブなファイルが含まれているディレクトリを展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"-------------------------------------------------------------------------------
" 検索設定 Search
"-------------------------------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

if has ("migemo")
  set migemo
endif

set formatoptions+=mM
let format_join_spaces = 2
let format_allow_over_tw = 1

" changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "Tomochika Hara"

" Kobitoを開く
function! s:open_kobito(...)
    if a:0 == 0
        call system('open -a Kobito '.expand('%:p'))
    else
        call system('open -a Kobito '.join(a:000, ' '))
    endif
endfunction

" 引数のファイル(複数指定可)を Kobitoで開く
" （引数無しのときはカレントバッファを開く
command! -nargs=* Kobito call s:open_kobito(<f-args>)
" Kobito を閉じる
command! -nargs=0 KobitoClose call system("osascript -e 'tell application \"Kobito\" to quit'")
" Kobito にフォーカスを移す
command! -nargs=0 KobitoFocus call system("osascript -e 'tell application \"Kobito\" to activate'")

" Netrw
let g:netrw_altv = 1
let g:netrw_winsize=70

" 隠しファイルを表示する
let NERDTreeShowHidden = 1
