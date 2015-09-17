for proj in $@; do
    cd "$proj"
    git rebase origin master
    git push
done
