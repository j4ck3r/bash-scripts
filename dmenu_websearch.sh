#!/bin/bash
# Dmenu prompt to search the web
# Dependencies: dmenu

############## Options
# Searchengines
declare -A searchengines=(
    [DuckDuckGo]="https://duckduckgo.com/?q=" 
    [ArchWiki]="https://wiki.archlinux.org/index.php?search=" 
    [YouTube]="https://www.youtube.com/results?search_query=" 
    [Pexels]="https://www.pexels.com/search/" 
    [Wikipedia]="https://de.wikipedia.org/wiki/" 
    [Ebay]="https://www.ebay.de/sch/i.html?_nkw=" 
    [GitHub]="https://github.com/search?q="
)
# Default browser
if [[ -z $BROWSER ]]
then
    browser=$BROWSER
else
    browser=firefox
fi
############## End options

# Getting the names from the list above
names=()
for ((i = 0; i < ${#searchengines[@]}; i++))
do
    names+=($(echo ${searchengines[i]} | cut -d' ' -f1)) 
done

# User can choose whiche engine to take
engine=$(for name in ${names[@]}; do echo $name; done | dmenu -l ${#names[@]} -i)

# When no searchengine is selected, exit:
if [ -z $engine ]
then
    exit 0
fi

# Searching for the right url
url=""
for ((i = 0; i < ${#searchengines[@]}; i++))
do
    current=($(echo ${searchengines[i]} | tr " " "\n")) 
    if [[ ${current[0]} = $engine ]]
    then
        url=${current[1]}
        break
    fi
done

# Propting for the search term
prompt="${engine}: Enter search query"
query=$(echo $prompt | dmenu -l 1 | tr " " "+")
if [[ ! $query == $prompt ]] && [ ! -z $query ]
then
    $browser "${url}${query}"
fi
