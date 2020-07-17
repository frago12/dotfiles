for possiblekey in ${HOME}/.ssh/id_*; do
    if grep -q PRIVATE "$possiblekey"; then
        ssh-add -K "$possiblekey" &> /dev/null
    fi
done

