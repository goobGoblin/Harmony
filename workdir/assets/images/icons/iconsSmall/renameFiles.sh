for file in *.svg; do
    if [[ "$file" == *" "* ]]; then
        newname="${file// /-}"
        mv "$file" "$newname"
    fi
done
