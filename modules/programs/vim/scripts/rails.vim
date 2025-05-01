function! rails#ToggleSpecFile()
  let l:current_path = expand('%')
  if l:current_path =~ 'app/'
    call s:SwitchToSpec(l:current_path)
  elseif l:current_path =~ 'spec/'
    call s:SwitchToSource(l:current_path)
  endif
endfunction

function! s:SwitchToSpec(current_path)
  let l:app_path = substitute(a:current_path, 'app', 'spec', '')
  let l:app_path = substitute(l:app_path, '.rb', '_spec.rb', '')
  echo l:app_path
  call s:SwitchToBufferOrOpen(l:app_path)
endfunction

function! s:SwitchToSource(current_path)
  let l:app_path = substitute(a:current_path, 'spec', 'app', '')
  let l:app_path = substitute(l:app_path, '_spec', '', '')
  echo l:app_path
  call s:SwitchToBufferOrOpen(l:app_path)
endfunction

function! s:SwitchToBufferOrOpen(path)
  " Expand the path to ensure full path is used
  let l:full_path = fnamemodify(a:path, ':p')
  execute 'edit' l:full_path
endfunction
