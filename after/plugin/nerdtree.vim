function! NERDTreeMapping()
	nmap <buffer> n cd :only <CR> :enew <CR>
  nmap <buffer> d V d
  nmap <buffer> r cd 0 /\<\a/><CR>"+y$ :!mv <c-r>+
endfunction

augroup nerdtree_mapping
  autocmd!
  autocmd filetype nerdtree call NERDTreeMapping()
augroup END
