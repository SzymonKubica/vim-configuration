function! NetrwMapping()
	nmap <buffer> l <CR>
	nmap <buffer> h -^
	nmap <buffer> n %
  nmap <buffer> . gh
  nmap <buffer> P <C-w>z
  nmap <buffer> L <CR>:Lexplore<CR>
  nmap <buffer> <Leader>dd :Lexplore<CR>
	nmap <buffer> <TAB> mf
	nmap <buffer> <S-TAB> mF
	nmap <buffer> <Leader><TAB> mu
	nmap <buffer> fc mc
	nmap <buffer> fC mtmc
	nmap <buffer> fm mm
	nmap <buffer> fM mtmm
	nmap <buffer> fq :echo 'Target:' . netrw#Expose("netrwmftgt")<CR>
	nmap <buffer> ft mtfq
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END
