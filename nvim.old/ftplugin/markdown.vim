call ale#linter#Define('markdown', {
\   'name': 'vale',
\   'executable': 'vale',
\   'command': 'vale --output=line %t',
\   'callback': 'ale#handlers#unix#HandleAsWarning',
\})
