" Custom Markdown rules modified by JaredKat
" copied from /usr/share/vim/vim81/ftplugin/markdown on Arch Linux as maintained by Tim Pope <vimNOSPAM@tpope.org.

" Vim filetype plugin
" Language:		Markdown
" Maintainer:		Tim Pope <vimNOSPAM@tpope.org>
" Last Change:		2016 Aug 29

if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim

setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=>\ %s
setlocal formatoptions+=tcqln formatoptions-=r formatoptions-=o
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+\\\|^\\[^\\ze[^\\]]\\+\\]:

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "|setl cms< com< fo< flp<"
else
  let b:undo_ftplugin = "setl cms< com< fo< flp<"
endif

function! MarkdownFold()
  let line = getline(v:lnum)

  " Regular headers
  let depth = match(line, '\(^#\+\)\@<=\( .*$\)\@=')
  if depth > 0
    return ">" . depth
  endif

  return "="
endfunction

if has("folding") && exists("g:markdown_folding")
  setlocal foldexpr=MarkdownFold()
  setlocal foldmethod=expr
  let b:undo_ftplugin .= " foldexpr< foldmethod<"
endif

" vim:set sw=2:

" Custom Rules
:set syntax=markdown
:set wrap linebreak nolist
:set spell spelllang=en_us
:set showbreak=↪
:set nonumber
:highlight NonText ctermfg=black

