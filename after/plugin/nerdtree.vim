function! NERDTreeMapping()
	nmap <buffer> n cd :only <CR> :enew <CR>
  nmap <buffer> d Vd
  nmap <buffer> r cd 0 /\<\a/><CR>"+y$ :!mv <c-r>+
  nmap <buffer> md 0 /\<\a/><CR>"+y$ :!mv <c-r>+
  nmap <buffer> D cd :!mkdir
endfunction

augroup nerdtree_mapping
  autocmd!
  autocmd filetype nerdtree call NERDTreeMapping()
augroup END
