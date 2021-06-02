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

# User can choose whiche engine to take
engine=$(printf "%s\n" "${!searchengines[@]}" | dmenu -l ${#searchengines[@]} -i)

# When no searchengine is selected, exit:
if [ -z $engine ]
then
    exit 0
fi

# Searching for the right url
url=${searchengines[$engine]}

# Propting for the search term
prompt="${engine}: "
query=$(echo "" | dmenu -p $prompt | tr " " "+")
if [[ ! $query == $prompt ]] && [ ! -z $query ]
then
    $browser "${url}${query}"
fi
