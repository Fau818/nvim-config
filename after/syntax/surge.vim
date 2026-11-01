" The Surge language server only reports diagnostics, so highlight here: dosini covers sections, keys and comments.
if exists('b:current_syntax') | finish | endif
runtime! syntax/dosini.vim
syn case match

" Rules: `TYPE,value,policy,options`, which have no `key = value` for dosini to see
syn match surgeRule     '^\u[[:upper:][:digit:]-]*,.*' containedin=dosiniSection
      \ contains=surgeRuleType,surgePolicy,surgeOption,surgeKey,surgeString,surgeUrl,surgeMarker,surgeComment
syn match surgeRuleType '^\u[[:upper:][:digit:]-]*' contained
syn match surgeString   '"[^"]*"' contained
syn match surgeComment  '\s\zs#[^!].*' contained

" Proxies and groups: `Name = type, …, key=value`
syn match surgeType   '\%(=\s*\)\@<=\%(direct\|reject\%(-drop\|-tinygif\|-no-drop\)\=\|https\=\|socks5\%(-tls\)\=\|ss\|vmess\|trojan\|snell\|tuic\%(-v5\)\=\|hysteria2\|wireguard\|tailscale\|ssh\|select\|url-test\|fallback\|load-balance\|smart\|subnet\|external\)\ze\s*\%(,\|$\)'
      \ contained containedin=dosiniValue
syn match surgePolicy ',\s*\zs\%(DIRECT\|REJECT\%(-DROP\|-TINYGIF\|-NO-DROP\)\=\)\>' contained containedin=dosiniValue
syn match surgeOption ',\s*\zs\%(no-resolve\|extended-matching\|pre-matching\|dns-failed\|hidden\)\>' contained containedin=dosiniValue
syn match surgeKey    '\<\l[[:lower:][:digit:]-]*\ze=' contained containedin=dosiniValue
syn match surgeUrl    '\a[[:alnum:]+.-]*://[^,[:space:]"]\+' contained containedin=dosiniValue
syn match surgeMarker '\s\zs#!\u[[:upper:]-]*\s*$' contained containedin=dosiniValue

" `#!include`, and a module's `#!name=` header
syn match surgeDirective '^#!\a.*' containedin=dosiniSection

hi def link surgeRuleType  Keyword
hi def link surgeType      Keyword
hi def link surgePolicy    Constant
hi def link surgeOption    Special
hi def link surgeKey       Identifier
hi def link surgeString    String
hi def link surgeUrl       Underlined
hi def link surgeMarker    PreProc
hi def link surgeDirective PreProc
hi def link surgeComment   Comment

let b:current_syntax = 'surge'
