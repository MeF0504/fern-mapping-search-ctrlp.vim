
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

function! fern#scheme#file#mapping#search_ctrlp#reveal(action, line)
    " let find_file = fnamemodify(a:line, ':p')
    " to support symbolic link.
    let find_file = fnameescape(s:path..'/'..a:line)
    call ctrlp#exit()
    execute printf("FernReveal %s", find_file)
endfunction

function! s:map_search_ctrlp(helper, ...) abort
    if exists('g:ctrlp_open_func')
        let old_ctrlp_open_func = g:ctrlp_open_func
        let open_func_exists = 1
    else
        let open_func_exists = 0
    endif
    let g:ctrlp_open_func = {'files': 'fern#scheme#file#mapping#search_ctrlp#reveal'}

    if exists('g:ctrlp_show_hidden')
        let old_ctrlp_show_hidden = g:ctrlp_show_hidden
        let hidden_exists = 1
    else
        let hidden_exists = 0
    endif
    let g:ctrlp_show_hidden = b:fern.hidden
    if exists("b:fern_search_ctrlp_hidden") &&
       \ (b:fern_search_ctrlp_hidden != b:fern.hidden)
        CtrlPClearCache
    endif
    let b:fern_search_ctrlp_hidden = g:ctrlp_show_hidden

    if a:0 == 0
        let is_root = get(g:, 'fern_search_ctrlp_root', 0)
    else
        let is_root = a:1
    endif
    if is_root == 1
        let s:path = a:helper.sync.get_root_node()._path
    else
        let s:path = a:helper.sync.get_cursor_node()._path
        if !isdirectory(s:path)
            let s:path = fnamemodify(s:path, ':h')
        endif
    endif
    execute printf('CtrlP %s', fnameescape(s:path))

    if open_func_exists
        let g:ctrlp_open_func = old_ctrlp_open_func
    else
        unlet g:ctrlp_open_func
    endif
    if hidden_exists
        let g:ctrlp_show_hidden = old_ctrlp_show_hidden
    else
        unlet g:ctrlp_show_hidden
    endif
endfunction

