#!/bin/bash

# A script for handling the cne-lib subtree

pull()
{
    echo ""
    echo "   ****************************"
    echo "   Pulling the cne-lib subtree!"
    echo "   ****************************"
    echo ""
    git subtree pull --squash -P lib/cne cne-lib master
}

push()
{
    echo ""
    echo "   ****************************"
    echo "   Pushing the cne-lib subtree!"
    echo "   ****************************"
    echo ""
    git subtree push -P lib/cne cne-lib master
}

add()
{
    subtrees=$(git log | grep git-subtree-dir | tr -d ' ' | cut -d ":" -f2 | sort | uniq)
    if [ -n "$subtrees" ] 
    then
        echo "You've already got subtrees ya dingus!"
        exit
    fi
    echo ""
    echo "   ****************************"
    echo "   Adding the cne-lib subtree!"
    echo "   ****************************"
    echo ""
    git subtree add -P lib/cne cne-lib master
}

### main
unstaged_commits=$(git status --porcelain)
remotes=$(git remote)
if [ -n "$unstaged_commits" ] 
then
    echo ""
    echo "   ****************************"
    echo "    You have unstaged changes! "
    echo "   ****************************"
    echo ""
    exit
fi

if [[ ! $remotes =~ "cne-lib" ]] 
then
    git remote add cne-lib git@github.com:cnerepo/cne-lib.git
fi

if [[ $1 = "pull" ]] 
then
    pull
elif [[ $1 = "push" ]] 
then
    push
elif [[ $1 = "add" ]] 
then
    add
else 
    base64 -D <<<"H4sIALW3VV0AA1WQQQ7EIAhF957i75xmJO7beBNTjtALcPj5oLEOKOr7hFIA4KBPqz0xNrcJAEdqqrFVK1TRdbMEO5dVGLj6S07bE+oojz1jT6hv3f6XsDDr+4ENKRP40XHnhU2whUWIXI/G4mzjDy2egUIX+YoIqTMGJxOFPkYw9ceCTOR6m2ajM3tJo/65b7ndZPVtDsTDQb0U0LnWCHopZaAj5ZKzPzP2CTmgX1f6ASOITrvJAQAA" | gunzip 
    echo "GET OUT OF MY HOUSE"
fi
