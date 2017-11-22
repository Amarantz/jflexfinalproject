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
    [^] {
        msg("START: FALLTHROUGH");
    }
}

<S2> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
			case 'a': 
                right();
				yybegin(S3);
				break;
			case 'b':
				right();
				yybegin(S3);
				break;
			case 0:
				yybegin(FAILURE);
				break;
			default:
				msg("Catastrophic failure in S2");
				break;
		}
	}

	[^] {
		msg("S2: FALLTHROUGH");
	}
}

<S3> {
	[\r\n]+ {
		//msg("S3");
		yypushback(yytext().length());
		switch (getTape()) {
			case 'a': 
                right();
				yybegin(S3);
				break;
			case 'b':
				right();
				yybegin(S3);
				break;
			case 0:
                left();
				yybegin(S4);
				break;
            case 'X':
                left();
                yybegin(S4);
                break;
            case 'Y'
                left();
                yybegin(S4);
			default:
				msg("Catastrophic failure in S3");
				break;
		}
	}

	[^] {
		msg("S3: FALLTHROUGH");
	}
}
<S4> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
			case 'a': 
                setTape('X');
                left();
				yybegin(S5);
				break;
			case 'b':
                setTape('Y');
                left();
				yybegin(S5);
			case 0:
				yybegin(FAILURE);
				break;
			default:
				msg("Catastrophic failure in S4");
				break;
		}
	}

	[^] {
		msg("S4: FALLTHROUGH");
	}
}

<S5> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
			case 'a': 
                left();
				yybegin(S6);
				break;
			case 'b':
                left();
				yybegin(S6);
				break;
            case 'A':
                left();
                yybegin(S7);
                break;
            case 'A':
                left();
                yybegin(S7);
                break;
			case 0:
				yybegin(FAILURE);
				break;
			default:
				msg("Catastrophic failure in S5");
				break;
		}
	}

	[^] {
		msg("S5: FALLTHROUGH");
	}
}

<S6> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
			case 'a': 
                left();
				yybegin(S6);
				break;
			case 'b':
                left();
				yybegin(S6);
				break;
            case 'A';
                right();
                yybegin(START);
                break;
            case 'B';
                right();
                yybegin(START);
                break;    
			case 0:
				yybegin(FAILURE);
				break;
			default:
				msg("Catastrophic failure in S2");
				break;
		}
	}

	[^] {
		msg("S6: FALLTHROUGH");
	}
}

<S7> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
			case 'a': 
				yybegin(FAILURE);
				break;
			case 'b':
				yybegin(FAILURE);
				break;
            case 'B':
                if(left() != -1)
                    yybegin(S7);
                else {
                    yybegin(S8);
                }
                break;
            case 'A':
                if(left() != -1)
                    yybegin(S7);
                else {
                    yybegin(S8);
                }
                break;
			case 0:
				yybegin(FAILURE);
				break;
			default:
				msg("Catastrophic failure in S7");
				break;
		}
	}

	[^] {
		msg("S7: FALLTHROUGH");
	}
}

<S8> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
			case 'a': 
				yybegin(FAILURE);
				break;
			case 'b':
				yybegin(FAILURE);
				break;
            case 'A':
                setTape('#');
                right();
                yybegin(S10);
                break;
            case 'B':
                setTape('#');
                right();
                yybegin(S9);
                break;
            case '*':
                right();
                yybegin(S13);
                break;   
			case 0:
				yybegin(FAILURE);
				break;
			default:
				msg("Catastrophic failure in S8");
				break;
		}
	}

	[^] {
		msg("S8: FALLTHROUGH");
	}
}

<S9> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
            case 'B':
                right();
                yybegin(S9);
                break;
            case 'A':
                right();
                yybegin(S9);
                break;
            case '*':
                right();
                yybegin(s10);
                break;
            case 'Y':
                setTape('*');
                left();
                yybegin(S11);
                break;
			default:
				msg("Catastrophic failure in S10");
				break;
		}
	}

	[^] {
		msg("S2: FALLTHROUGH");
	}
}

<S10> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
            case 'B':
                right();
                yybegin(S10);
                break;
            case 'A':
                right();
                yybegin(S10);
                break;
            case '*':
                right();
                yybegin(s10);
                break;
            case 'X':
                setTape('*');
                left();
                yybegin(S12);
                break;
			default:
				msg("Catastrophic failure in S10");
				break;
		}
	}

	[^] {
		msg("S10: FALLTHROUGH");
	}
}

<S11> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
            case 'B':
                if(left() != -1)
                    yybegin(S11);
                else {
                    yybegin(S8);
                }
                break;
            case '*':
                if(left() != -1)
                    yybegin(S11);
                else {
                    yybegin(S8);
                }
                break;
            case 'A':
                if(left() != -1)
                    yybegin(S11);
                else {
                    yybegin(S8);
                }
                break;
			default:
				msg("Catastrophic failure in S12");
				break;
		}
	}

	[^] {
		msg("S2: FALLTHROUGH");
	}
}

<S12> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
            case 'B':
                if(left() != -1)
                    yybegin(S12);
                else {
                    yybegin(S8);
                }
                break;
            case '*':
                if(left() != -1)
                    yybegin(S12);
                else {
                    yybegin(S8);
                }
                break;
            case 'A':
                if(left() != -1)
                    yybegin(S12);
                else {
                    yybegin(S8);
                }
                break;
			default:
				msg("Catastrophic failure in S12");
				break;
		}
	}

	[^] {
		msg("S12: FALLTHROUGH");
	}
}

<S13> {
	[\r\n]+ {
		//msg("S2");
		yypushback(yytext().length());
		switch (getTape()) {
			case 'a': 
				yybegin(FAILURE);
				break;
			case 'b':
				yybegin(FAILURE);
				break;
            case '*':
                right();
                break;
			case 0:
                right();
				yybegin(S14);
				break;
			default:
				msg("Catastrophic failure in S2");
				break;
		}
	}

	[^] {
		msg("S13: FALLTHROUGH");
	}
}

<S14> {
	[\r\n]+ {
		//msg("S4");
		msg("SUCCESS with " + original);
		yybegin(YYINITIAL);
	}
}

<FAILURE> {
	[\r\n]+ {
		msg("FAILURE with " + original);
		yybegin(YYINITIAL);
	}
}