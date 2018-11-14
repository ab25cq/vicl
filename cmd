gcc -E a.c | grep extern | sed -r 's/^extern [a-zA-Z0-9_]+ \*?([a-zA-Z0-9_]+ \(.+)/\1/' 
