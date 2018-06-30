vicl := ViClone();

while(!vicl.endOfAplication) {
    vicl.view();

    key := vicl.input();

    vicl.runKeyInvent(key);
}
