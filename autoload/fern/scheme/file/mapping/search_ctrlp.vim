
function! fern#scheme#file#mapping#search_ctrlp#init(disable_default_mappings) abort
  nnoremap <buffer><silent> <Plug>(fern-action-search-ctrlp) :<C-u>call <SID>call('search_ctrlp')<CR>
  nnoremap <buffer><silent> <Plug>(fern-action-search-ctrlp:cursor) :<C-u>call <SID>call('search_ctrlp', 0)<CR>
  nnoremap <buffer><silent> <Plug>(fern-action-search-ctrlp:root) :<C-u>call <SID>call('search_ctrlp', 1)<CR>
endfunction

function! s:call(name, ...) abort
  return call(
        \ 'fern#mapping#call',
        \ [funcref(printf('s:map_%s', a:name))] + a:000,
        \)
endfunction

function! s:map_search_ctrlp(helper, ...) abort
    if a:0 == 0
        let is_root = get(g:, 'fern_search_ctrlp_root', 0)
    else
        let is_root = a:1
    endif
    if is_root == 1
        let path = a:helper.sync.get_root_node()._path
    else
        let path = a:helper.sync.get_cursor_node()._path
        if !isdirectory(path)
            let path = fnamemodify(path, ':h')
        endif
    endif
    execute printf('CtrlP %s', fnameescape(path))
endfunction

