vicl := ViClone();

while(!vicl.endOfAplication) {
    vicl.view();
    refresh();

    key := vicl.input();

    vicl.runKeyEvents(key);
}
