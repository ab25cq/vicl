
initscr();
keypad(stdscr, true);
noecho();

key := getch();

endwin();

key.to_int().toString().println();
