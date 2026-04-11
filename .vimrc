inoremap jk <ESC>

set rnu
set nu

set nowrap
set noeb
set nobackup
set noswapfile
set noundofile

set ic

inoremap <S-TAB> <TAB>

inoremap <C-V> <ESC>"+pa

noremap <leader>z z
map z %
set foldenable
set foldmethod=manual
onoremap v V%
nnoremap Z za
vnoremap Z zf
nnoremap + zR
nnoremap - zM
noremap <DEL> zD

nnoremap <C-C> gg"+yG
vnoremap <C-C> "+y
noremap <space> $
noremap <BS> zz
nnoremap <PageUp> <C-U>
nnoremap <PageDown> <C-D>
nnoremap <HOME> <C-B>
nnoremap <END> <C-F>
nnoremap <UP> <C-Y>
nnoremap <DOWN> <C-E>
nnoremap <LEFT> zH
nnoremap <RIGHT> zL
nnoremap Q :q<CR>
nnoremap <leader>q q
nmap q <C-L>
vnoremap q <ESC>

" Ctrl-Backspace to delete a word
noremap! <C-H> <C-W>
noremap! <C-BS> <C-W>

set tabstop=4
set shiftwidth=4
set softtabstop=4
set mouse=a
set mousemodel=extend
set noexpandtab
autocmd FileType html,typescript,typescriptreact setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

syntax on
filetype plugin indent on
set autoindent
set smartindent

set viewoptions=cursor,folds,slash,unix
if has('termguicolors')
	set termguicolors
endif

au FileType * set formatoptions-=o


autocmd FileType c nnoremap <buffer><F9> :w<CR>:!clear; gcc % -o %<<CR>
autocmd FileType c nnoremap <buffer><F12> :!clear; ./%<<CR>
autocmd FileType cpp nnoremap <buffer><F9> :w<CR>:!clear; g++ % -o %< -std=c++14<CR>
autocmd FileType cpp nnoremap <buffer><A-F9> :w<CR>:!clear; g++ % -o %< -std=c++17 -O2<CR>
autocmd FileType cpp nnoremap <buffer><C-F9> :w<CR>:!clear; g++ % -o %< -g -Wall -std=c++17 -fsanitize=address,leak,undefined<CR>
autocmd FileType cpp nnoremap <buffer><F12> :!clear; ./%<<CR>
autocmd FileType python nnoremap <buffer><F9> :w<CR>:!clear; python %<CR>
autocmd FileType python nnoremap <buffer><C-F9> :w<CR>:!clear; python -i %<CR>
autocmd FileType python nnoremap <buffer><A-F9> :w<CR>:!clear; python -m pdb %<CR>
autocmd FileType python nnoremap <buffer><F12> :w<CR>:!clear; bash run.sh<CR>
autocmd FileType sh nnoremap <buffer><F9> :w<CR>:!clear; bash %<CR>
autocmd FileType php nnoremap <buffer><F9> :w<CR>:!clear; php %<CR>

function WriteFor(str)
	let a=""
	let b=""
	let c=""
	if strlen(a:str)==3
		let a=a:str[0]
		let b=a:str[1]
		let c=a:str[2]
	else
		" a=b; a<=c; a++
		let w=1
		let s1=0
		let s2=0
		for i in range(0,strlen(a:str)-1)
			if a:str[i]==',' && s1==0 && s2==0
				let w=w+1
			else
				if w==1
					let a = a . a:str[i]
					" echo a:str[i] . ' ' . a
				elseif w==2
					let b = b . a:str[i]
				else
					let c = c . a:str[i]
				endif
				if a:str[i]=='('
					let s1=s1+1
				elseif a:str[i]==')'
					let s1=s1-1
				elseif a:str[i]=='['
					let s2=s2+1
				elseif a:str[i]==']'
					let s2=s2-1
				endif
			endif
		endfor
	endif
	if b=="-"
		let outputstr = "for(int " . a . "=" . "0; ". a . "<"
	else
		let outputstr = "for(int " . a . "=" . b . "; " . a  . "<"
	endif
	if b!="0"
		let outputstr = outputstr . "="
	endif
	let outputstr = outputstr . c . "; " . a . "++)"
	execute "normal! cc" . outputstr
endfunction

function WriteEdge(str)
	"iu
	let outputstr = "for(int " . a:str[0] . "=h[" . a:str[1] . "]; " . a:str[0] . "; " . a:str[0] . "=nx[" . a:str[0] . "])"
	execute "normal! cc" . outputstr
endfunction

function WriteScanf(str)
	"n,m
	let s1 = "scanf(\"%d"
	let s2 = " &"
	for i in range(0, strlen(a:str)-1)
		let s2 = s2 . a:str[i]
		if a:str[i]==','
			let s1 = s1 . "%d"
			let s2 = s2 . " &"
		endif
	endfor
	let ans = s1 . "\"," . s2 . ");"
	execute "normal! cc" . ans
endfunction

autocmd FileType cpp inoremap <buffer><C-F> <esc>:call WriteFor("")<left><left>
autocmd FileType cpp inoremap <buffer><C-U> <esc>:call WriteEdge("")<left><left>
autocmd FileType cpp inoremap <buffer><C-C> <esc>:call WriteScanf("")<left><left>
autocmd FileType cpp nnoremap <buffer><F8> :r ~/OI/tem/

" Move selection up or down, learnt from j-morano/buffer_manager.nvim config
vnoremap <silent><C-J> :m '>+1<CR>gv
vnoremap <silent><C-K> :m '<-2<CR>gv

" Pick one colorscheme
colorscheme palenight
"colorscheme onedark
"colorscheme catppuccin_*
