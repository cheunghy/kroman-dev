tpl=${1/%.md/.tpl}
basetpl=$2
target=$1

pattern='^\${.*}$'

declare -a tokens=()

while read line; do
    if [[ $line =~ $pattern ]]; then
        _line=${line#\$\{}
        _cur=${_line%\}}
        declare current=${_cur}
        declare $current=""
        tokens+=($current)
    else
        eval "declare \$current=\"\${${current[@]}}\"\\\n\"${line//\`/\\\`}\""
    fi
done < $tpl

result=""

pattern='(.*)\${(.*)}(.*)'

while read line; do
    if [[ $line =~ $pattern ]]; then
        before=${BASH_REMATCH[1]}
        current=${BASH_REMATCH[2]}
        after=${BASH_REMATCH[3]}
        for token in ${tokens[*]}; do
            if [[ $token =~ $current ]]; then
                _content=${!token}
                __content=${_content##\\\n}
                ___content=${__content##\\\n}
                content=${___content%%\\\n}
                declare result="$result\n$before"
                declare result="$result$content"
                declare result="$result$after"
            fi
        done
    else
        declare result="$result\n$line"
    fi
done < $basetpl

echo $result > $target


