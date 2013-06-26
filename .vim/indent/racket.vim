" Vim indent file 
" Language:     Scheme
" Maintainer:   Dorai Sitaram <ds26@gte.com>
" URL:          http://www.ccs.neu.edu/~dorai/scmindent/scmindent.html
" Last Change:  2002 Dec 07 

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetSchemeIndent()
setlocal indentkeys=o,O

if exists("*GetSchemeIndent")
  finish
endif

func! s:Scheme_word_p(s)
  let x = "," . a:s . ","
  let y = match("," . &lispwords . ",", x)
  return (y != -1)
endfunc

"Some scheme-y stuff

func! s:Cons(a, d)
  return a:a . ',' . a:d
endfunc

func! s:Null(s)
  if a:s =~ '^ *$'
    return 1
  else
    return 0
  endif
endfunc

func! s:Car(s)
  return matchstr(a:s, '^[^,]\+')
endfunc

func! s:Cdr(s)
  return substitute(a:s, '^[^,]\+,', '', '')
endfunc

func! s:Cadr(s)
  return s:Car(s:Cdr(a:s))
endfunc

func! s:Cddr(s)
  return s:Cdr(s:Cdr(a:s))
endfunc

"String procs

func! s:String_ref(s, i)
  return strpart(a:s, a:i, 1)
endfunc

func! s:String_trim_blanks(s)
  return substitute(a:s, '\(^\s\+\|\s\+$\)', '', 'g')
endfunc

func! Num_leading_spaces(s)
  if a:s =~ '^\s*$'
    return -1
  else
    return strlen(matchstr(a:s, '^\s*'))
  endif
endfunc

"Aux fns used by indenter

func! s:Calc_subindent(s, i, n)
  let j = s:Past_next_token(a:s, a:i, a:n)
  if j == a:i
    return 1
  elseif s:Scheme_word_p(strpart(a:s, a:i, j-a:i))
    return 2
  elseif j == a:n
    return 1
  else
    return j - a:i + 2
  endif
endfunc

func! s:Past_next_token(s, i, n)
  let j = a:i
  while 1
    if j >= a:n
      return j
    else
      let c = s:String_ref(a:s, j)
      if c =~ "[ ()'`,;]"
        return j
      endif
    endif
    let j = j + 1
  endwhile
endfunc

"return number of indents for current line

func! GetSchemeIndent()
  normal mx
  let last_line = v:lnum

  "look for line above with flush left paren,
  "and either beginning of file, a blank line,
  "or a comment line directly above
  let first_line = search("^(", 'bW')
  while 1
    if first_line <= 1
      break
    else
      let str = getline(first_line - 1)
      if str =~ '^\s*\($\|;\)'
        break
      else
        let first_line = first_line - 1
      endif
    endif
  endwhile
  normal `x

  "get the nonblank line before the 
  "*second* blank line above
  let blank_based_first_line = search("^\\s*$", 'bW') 
  if blank_based_first_line
    let blank_based_first_line = search("^\\s*$", 'bW')
    if blank_based_first_line 
      let blank_based_first_line = search("^\\s*\\S", 'bW')
    endif
  endif
  normal `x

  "first line is the closer of the two
  if blank_based_first_line > first_line
    let first_line = blank_based_first_line 
  endif

  "if no first line found, pick start of file
  if ! first_line
    let first_line = 1
  endif

  let left_i = 0
  let paren_stack = ''
  let verbp = 'nil'

  if first_line == last_line
    return -1
  endif

  let curr_line = first_line

  while curr_line <= last_line
    let str = getline(curr_line)
    let leading_spaces = Num_leading_spaces(str)

    if verbp != 'nil'
      let curr_left_i = leading_spaces
    elseif s:Null(paren_stack)
      if left_i == 0 && leading_spaces >= 0
        let left_i = leading_spaces
      endif
      let curr_left_i = left_i
    else
      let curr_left_i = s:Car(paren_stack) + s:Cadr(paren_stack)
    endif

    if curr_line == last_line
      return curr_left_i
    endif

    let s = s:String_trim_blanks(str)
    let n = strlen(s)

    let i = 0
    let j = curr_left_i
    let escp = 0

    while i < n
      let c = s:String_ref(s, i)
      if verbp == 'comment'
      elseif escp
        let escp = 0
      elseif c == '\'
        let escp = 1
      elseif verbp == 'string'
        if c == '"'
          let verbp = 'nil'
        endif
      elseif c == ';'
        let verbp = 'comment'
      elseif c == '"'
        let verbp = 'string'
      elseif c == '('
        let paren_stack = s:Cons(s:Calc_subindent(s, i+1, n), s:Cons(j, paren_stack))
      elseif c == ')'
        if ! s:Null(paren_stack)
          let paren_stack = s:Cddr(paren_stack)
        else
          let left_i = 0
        endif
      endif
      let i = i + 1
      let j = j + 1
    endwhile
    let curr_line = curr_line + 1
    if verbp == 'comment'
      let verbp = 'nil'
    endif
  endwhile
endfunc
