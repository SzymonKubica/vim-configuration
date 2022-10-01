function! NERDTreeMapping()
	nmap <buffer> n cd :new <CR>
  nmap <buffer> d V d
endfunction

augroup nerdtree_mapping
  autocmd!
  autocmd filetype nerdtree call NERDTreeMapping()
augroup END
