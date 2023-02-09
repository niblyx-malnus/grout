/-  *grout
|%
++  command-parser
  |=  [line=cord =bowl:gall =data]
  ^-  command
  %+  rash  line
  ;~  plug
    ;~  pose
      (cold | (jest ';'))
      (cold & (jest '!'))
    ==
    ;~  pose
      parse-extract-pals
      parse-portal
      parse-flare
    ==
  ==
::    
++  parse-extract-pals
  %+  cold
    [%extract-pals ~]
  (jest 'xpals')
::
++  parse-portal
  ;~  plug
    (cold %portal (jest 'portal'))
    (may 5 (cook tail ;~(plug ace dem)))
  ==
::
++  parse-flare
  ;~  plug
    (cold %flare (jest 'flare'))
    %+  may  ~s10
    %+  cook
      |=([@t a=@ud] (mul a ~s1))
    ;~(plug ace dem)
  ==
::
++  may  |*([else=* =rule] ;~(pose rule (easy else)))
++  opt  |*(=rule (may ~ rule))
--
