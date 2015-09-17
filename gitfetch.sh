for proj in $@; do
    cd "$proj"
    git fetch origin master
done
