start
  = bin

bin
  = arg_one:spe sym:('+'/'-'/'*'/'/') arg_two:bin { return arg_one + sym + arg_two; }
  / one_arg:spe '\\cdot' ' '? two_arg:bin { return one_arg +'*'+ two_arg; }
  / one_arg:spe '^{' two_arg:bin '}' { return 'Math.pow('+one_arg +','+ two_arg+')'}
  / one_arg:spe '^' two_arg:bin { return 'Math.pow('+one_arg +','+ two_arg+')'; }
  / spe

spe
  = '\\' arg:una { return arg; }
  / '\\frac{' one_arg:bin '}{' two_arg:bin '}' {return '(('+ one_arg +')/('+ two_arg +'))'; }
  / '\\sqrt[' one_arg:bin ']{' two_arg:bin '}' {return 'Math.pow(' + two_arg + ',1/' + one_arg + ')';}
  / var

una
  = 'left|' arg:bin '\\right|' { return 'Math.abs('+arg+')'; }
  / 'left(' one_arg:bin '\\right)' { return '('+one_arg+')'; }
  / 'sqrt{' arg:bin '}' {return 'Math.sqrt('+arg+')'; }
  / fun:('sin'/'cos'/'tan') '\\left(' arg:bin '\\right)' { return 'Math.'+ fun + '('+arg+')'; }
  / 'csc' arg:bin { return '1/Math.sin('+arg+')'; }
  / 'sec' arg:bin { return '1/Math.cos('+arg+')'; }
  / 'cot' arg:bin { return '1/Math.tan('+arg+')'; }

var
  = 't'/'it'/'ft'/'dt'/'%'
  / con

con
  = '\\pi' {return 'Math.PI';}
  / 'e'  {return 'Math.E';}
  / num

num
  = arg:$([+-]?[0-9]*[.][0-9]+) { return arg; }
  / arg:$([+-]?[0-9]+) { return arg; }
