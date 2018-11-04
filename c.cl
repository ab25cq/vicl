a := slist { "1", "2", "3" }
a.map { it.println(); }

b := slist { ls(), pwd(). ls("-al") }

b.map { it.less() }

c := slist { p"src/main.c", p"src" }

c.each { it.read() }