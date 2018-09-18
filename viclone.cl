vicl := ViClone();

var loop_num = 0;

while(!vicl.endOfAplication) {
    vicl.view();
    ViClone.refresh();

    key := vicl.input();

    if(loop_num % 256 == 0) {
        Clover.gc();
        Clover.compaction();
    }

    vicl.runKeyEvents(key);
}
