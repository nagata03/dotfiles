" 挙動を vi 互換ではなく、Vim のデフォルト設定にする => .vimrcが存在すれば自動的に有効化されるので設定不要
" set nocompatible
" 一旦ファイルタイプ関連を無効化する => vim-plugでは不要
" filetype off

""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" ファイルオープンを便利に
Plug 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
Plug 'Shougo/neomru.vim'
" ファイルをtree表示してくれる
Plug 'scrooloose/nerdtree'
" Gitを便利に使う
Plug 'tpope/vim-fugitive'

" Rails向けのコマンドを提供する
" Plug 'tpope/vim-rails'
" Ruby向けにendを自動挿入してくれる
Plug 'tpope/vim-endwise'

" コメントON/OFFを手軽に実行
Plug 'tomtom/tcomment_vim'
" シングルクオートとダブルクオートの入れ替え等
Plug 'tpope/vim-surround'

" インデントに色を付けて見やすくする
" Plug 'nathanaelkane/vim-indent-guides'
" let g:indent_guides_enable_on_vim_startup = 1
" ログファイルを色づけしてくれる
Plug 'vim-scripts/AnsiEsc.vim'
" 行末の半角スペースを可視化
Plug 'bronson/vim-trailing-whitespace'
" less用のsyntaxハイライト
" Plug 'KohPoll/vim-less'

" RubyMineのように自動保存する
Plug '907th/vim-auto-save'
let g:auto_save = 1

" CSVをカラム単位に色分けする
Plug 'mechatroner/rainbow_csv'

" 余談: neocompleteは合わなかった。ctrl+pで補完するのが便利



call plug#end()

" filetypeの検出を有効化する => vim-plugでは不要
" filetype plugin indent on
""""""""""""""""""""""""""""""

"文字コードをUFT-8に設定
set fenc=utf-8

"行番号を表示
set number

"シンタックスハイライトon
syntax on

"括弧入力時の対応する括弧を表示
set showmatch

"オートインデント
set smartindent

"矩形選択で文字が無くても右へ進める
set virtualedit=block

"編集中のファイルが変更されたら自動で読み直す
set autoread

"バッファが編集中でもその他のファイルを開けるように
set hidden

"現在の行を強調表示
set cursorline

"ステータスラインを常に表示
set laststatus=2

"入力中のコマンドをステータスに表示する
set showcmd

"不可視文字を可視化(タブが「▸-」と表示される)
"set list listchars=tab:\▸\-

"行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4

"行頭でのTab文字の表示幅
set shiftwidth=4

"検索語をハイライト表示
set hlsearch

"ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"ステータス行にファイル名を表示する
set statusline=%F

"ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}

"ウインドウのタイトルバーにファイルのパス情報等を表示する
set title

"コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu

"入力中のコマンドを表示する
set showcmd
""""""""""""""""""""""""""""""

"grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow


" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
augroup filetypeIndent
    autocmd!
    autocmd BufRead,BufNewFile *.go         setlocal tabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile *.rb,*.erb   setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd BufRead,BufNewFile *.py         setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd BufRead,BufNewFile *.yml,*.yaml setlocal tabstop=2 shiftwidth=2 expandtab
augroup END
""""""""""""""""""""""""""""""
