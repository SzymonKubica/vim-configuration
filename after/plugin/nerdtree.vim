function! NERDTreeMapping()
	nmap <buffer> n ma
  nmap <buffer> rm Vd
  nmap <buffer> L <CR>
  nmap <buffer> h u
  nmap <buffer> l C
  nmap <buffer> rm Vd
  nmap <buffer> rn cd 0 /\<\a/><CR>"+y$ :!mv <c-r>+
  nmap <buffer> rnd 0 /\<\a/><CR>"+y$ :!mv <c-r>+
  nmap <buffer> D cd :!mkdir
endfunction

augroup nerdtree_mapping
  autocmd!
  autocmd filetype nerdtree call NERDTreeMapping()
augroup END
