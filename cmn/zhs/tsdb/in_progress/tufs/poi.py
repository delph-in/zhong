
def touch_files(path):
    """
    This function creates all necessary files for to 
    be used with Arbiter or FFTB.
    """

    touch = ['parse',
             'edge',
             'run',
             'analysis',
             'decision',
             'fold',
             'item-phenomenon',
             'item-set',
             'output',
             'parameter',
             'phenomenon',
             'preference',
             'result',
             'rule',
             'score',
             'set',
             'tree',
             'update']
    
    for f in touch:
        write_f = open(path+f,"w+")
        write_f.close()

    return True
touch_files('')
