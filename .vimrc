set fenc=utf-8 "文字コードをUFT-8に設定
set number "行番号を表示する
syntax on "色付け
set showmatch "括弧入力時の対応する括弧を表示
set smartindent "オートインデント
set virtualedit=block "矩形選択で文字が無くても右へ進める
set autoread " 編集中のファイルが変更されたら自動で読み直す
set hidden " バッファが編集中でもその他のファイルを開けるように
set cursorline " 現在の行を強調表示
set laststatus=2 " ステータスラインを常に表示
set showcmd " 入力中のコマンドをステータスに表示する
"set list listchars=tab:\▸\- " 不可視文字を可視化(タブが「▸-」と表示される)
set tabstop=4 " 行頭以外のTab文字の表示幅（スペースいくつ分）
set shiftwidth=4 " 行頭でのTab文字の表示幅
set hlsearch " 検索語をハイライト表示
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

augroup filetypeIndent
    autocmd!
    autocmd BufRead,BufNewFile *.go       setlocal tabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile *.rb,*.erb setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd BufRead,BufNewFile *.py       setlocal tabstop=4 shiftwidth=4 expandtab
augroup END

