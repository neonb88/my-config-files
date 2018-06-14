
# TODO:   vim "repeat any"
# TODO:   vim command "undo any"
# TODO:   auto-updating ls, l, pwd, etc. commands (variable gets updated every 10 seconds within python shell and automatically pretty-prints)

def newline(f):
    f.write('\n')

def h():
    hist()

def hist():
    '''
        print python history
        TODO:  hg() == UNIX hg
    '''
    import readline
    for i in range(readline.get_current_history_length()):
        print (readline.get_history_item(i + 1))

def print_visible(s):
    s = str(s)
    '''
            Prints like the following: {
 





        ("pad" # of newlines)


    =================================
            inputted string here
    =================================


        ("pad" # of newlines)





    }               '''
    pad = 21
    num_eq = 3*len(s)
    print(pad*"\n"           +\
            (num_eq*"="+"\n")+\
            len(s)*" "+s+"\n"+\
            (num_eq*"=")     +\
            (pad*"\n"))



