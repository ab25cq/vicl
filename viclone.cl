vicl := ViClone();

while(!vicl.endOfAplication) {
    vicl.view();
    ViClone.refresh();

    key := vicl.input();

    vicl.runKeyEvents(key);
}
