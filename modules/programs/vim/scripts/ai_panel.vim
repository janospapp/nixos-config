vim9script

if !exists('g:terminal_bufnr')
  g:terminal_bufnr = -1
endif

def g:ToggleAIPanel()
  var term_buf = g:terminal_bufnr

  # Start the terminal if it's not yet running
  if !bufexists(term_buf)
    # Open the right-side split *before* starting the terminal
    botright vsplit

    # Start terminal in the current window, hidden from other windows
    term_buf = term_start(['zsh', '-c', 'claude; exec zsh'], {
      'term_name': 'RightTerm',
      'exit_cb': (_, _) => {
        if bufexists(term_buf)
          execute('bwipeout! ' .. term_buf)
        endif
      },
      'hidden': v:true,
    })

    g:terminal_bufnr = term_buf

    setbufvar(term_buf, '&bufhidden', 'hide')
    setbufvar(term_buf, '&buftype', 'terminal')
    execute('buffer ' .. term_buf)
    return
  endif

  # Toggle visibility
  var win_ids = win_findbuf(term_buf)
  if len(win_ids) > 0
    for winid in win_ids
      win_execute(winid, 'close')
    endfor
  else
    botright vsplit
    execute('buffer ' .. term_buf)
  endif
enddef
