#!/bin/sh

YesNo(){
    while true ; do
        read -p "$1 (y/n)" yn
        case "$yn" in
            [yY] ) return 0 ;;
            [nN] ) return 1 ;;
            * ) echo "Error! illegal string"
        esac
    done
}

cd $(dirname $0)

read -p "Please input a file name:" filename
[ -z "$filename" ] && (echo "Error! blank can't become file name" 1>&2 ; exit 1)

read -p "Please input a blog title:" title 
[ -z "$title" ] && (echo "Error! blank can't become blog title" 1>&2 ; exit 1)

filename=$(date +"%Y-%m-%d-")"$filename"

head="---\nlayout: post\ntitle: \"$title\"\n---"
echo -e "$head" > _posts/"${filename}.md" && echo "created _posts/${filename}.md"

imagehead="\n{% capture images %}{{ site.baseurl }}/images/{{ page.path | replace: '_posts/','' | replace: '.md','' }}{% endcapture %}"

YesNo "Do you want to create image file?:"
[ $? -eq 0 ] && (mkdir images/"$filename" ; echo -e "$imagehead" >> _posts/${filename}.md) && echo "created images/$filename"

echo "Processing is complete"
