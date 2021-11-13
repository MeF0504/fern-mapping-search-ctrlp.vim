if exists('g:fern_mapping_search_ctrlp_loaded')
  finish
endif
let g:fern_mapping_search_ctrlp_loaded = 1

call add(g:fern#scheme#file#mapping#mappings, 'search_ctrlp')
