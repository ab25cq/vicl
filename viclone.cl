vicl := ViClone();

sockfd := socket(AF_UNIX, SOCK_STREAM,  0);

saddr := sockaddr_un();

saddr.sun_family = AF_UNIX;
saddr.sun_path = getenv("HOME").append("/.clover2/vicl/socket");

rm("-rf", saddr.sun_path);

bind(sockfd, saddr);
listen(sockfd, 1);

mask := fd_set();
read_ok := fd_set();

FD_ZERO(mask);
FD_SET(0, mask);
FD_SET(sockfd, mask);

loop_num := 0;

while(!vicl.endOfAplication) {
    vicl.view();
    vicl.refresh();

    read_ok = mask.clone();

    result := select(sockfd+1, read_ok, null, null, null);

    if(FD_ISSET(0, read_ok)) {
        key := System.getch();

        vicl.runKeyEvents(key);
    }
    elif(FD_ISSET(sockfd, read_ok)) {
        caddr := sockaddr_un();
        csockfd := accept(sockfd, caddr);

        buf := Buffer(128);
        read(csockfd, buf, 128);
        
        message := buf.toString();
        
        if(message.match(/^OPEN_FILE .+ \d+$/)) {
            array := message.scan(/^OPEN_FILE (.+) (\d+)/)
            
            file_name := array.items(1);
            line_num := array.items(2).to_int();
            
            vicl.openFile(file_name, line_num);
            
            vicl.dirPaneOff()
            vicl.setDirCursor(file_name)
        }
        elif(message.match(/^INSERT_FILE .+$/)) {
            array := message.scan(/^INSERT_FILE (.+)$/)
            
            file_name := array.items(1).chomp();

            text := file_name.toPath().read().toString();
            
            vicl.addUndoText();
            vicl.insertText(text);
        }
    }

    if(loop_num % 256 == 0) {
        #Clover.gc();
        Clover.compaction();
    }
    
    loop_num++;
}

close(sockfd);
