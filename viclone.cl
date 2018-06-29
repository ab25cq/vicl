vicl := ViClone();

while(true) {
    vicl.view();

    key := vicl.input();

    vicl.runKeyInvent(key);

    if(vicl.endOfAplication) {
        break;
    }
}
