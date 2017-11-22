/*
 * doubleword.flex is a turing machine that takes in a words and see if they are double word. 
 *
 * From the TM Diagram on page 455 of Introduction to Computer Theory, 2nd edition
 */

%%

%public
%class test
%standalone

%{
    char[] tape = new char[1024];
    String original;
    int cursor = 0;

    private void setTape(char c) {
        tape[cursor] = c;
        return;
    }

    private char getTape() {
        return tape[cursor];
    }

    private int left() {
        if(cursor == 0)
            return -1;
        else {
            cursor--;
            return 0;
        }
    }

    private void right() {
        cursor++;
        return;
    }

    private void msg(String str) {
        System.out.println(str);
        return;
    }
%}

%eof{
    //doesn't do anything
%eof}

%state START S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 FAILURE
%%
<YYINITIAL> {
    [^\r\n]+ {
        original = yytext();
        java.util.Arrays.fill(tape, '\0');
        for (int i = 0; i < original.length(); i++) {
            tape[i] = original.charAt(i);
        }

        String outString = new String(tape);
        cursor = 0;
    }
    [^] {
        yybeing(START);
    }
}

<START> {
    [\r\n]+ {
        yypushback(yytest().length());
        switch(getTape()) {
            case 'a':
                setTape('A');
                right();
                yybegin(S2);
                break;
            case 'b':
                setTape('B');
                right();
                yybegin(S2);
                break;
            default:
                msg("Something has gone extreme FAILURE")
                yybegin(FAILURE);
                break;
        }
    }
}

<S2> {
    
}


