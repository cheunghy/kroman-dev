for proj in $@; do
    cd "$proj"
    git commit -m "Update README"
done
