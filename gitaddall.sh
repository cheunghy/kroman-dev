for proj in $@; do
    cd "$proj"
    git add -A
done
