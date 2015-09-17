for proj in $@; do
    cd "$proj"
    git status
done
