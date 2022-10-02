function! NERDTreeMapping()
	nmap <buffer> n cd :only <CR> :enew <CR>
  nmap <buffer> d V d
endfunction

augroup nerdtree_mapping
  autocmd!
  autocmd filetype nerdtree call NERDTreeMapping()
augroup END
