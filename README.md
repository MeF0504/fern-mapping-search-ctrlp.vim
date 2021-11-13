# fern-mapping-search-ctrlp.vim

[![fern plugin](https://img.shields.io/badge/🌿%20fern-plugin-yellowgreen)](https://github.com/lambdalisue/fern.vim)


[fern.vim](https://github.com/lambdalisue/fern.vim) plugin which add `search-ctrlp` mapping to search files using [ctrlp](https://github.com/kien/ctrlp.vim) plugin.

## Usage

This plugin automatically add the following actions to `file` scheme.

| Mapping | Action | Description |
| ------- | ------ | ----------- |
|         | `search-ctrlp`         | Search files under the directory of cursor/root node using `:CtrlP` command. |
|         | `search-ctrlp:cursor` | Search files under the directory of cursor node using `:CtrlP` command.      |
|         | `search-ctrlp:root`    | Search files under the directory of root node using `:CtrlP` command.        |

## Options

- `g:fern_search_ctrlp_root` set the default search path. If it is set 1, search files at root directory.
