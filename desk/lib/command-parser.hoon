/-  *grout
|%
++  command-parser
  |=  [line=cord =bowl:gall state-0]
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
      parse-lurn
      parse-moun
      parse-flare
      parse-print-commands
      parse-set-home
      parse-go-home
      parse-tag-group
    ==
  ==
++  parse-tag-group
  ;~  (glue (star ace))
    (cold %tag-group (jest 'tg'))
    (cook crip (star prn))
  ==
::
++  parse-go-home
  %+  cold
    [%go-home ~]
  (jest 'go-home')
::    
++  parse-set-home
  %+  cold
    [%set-home ~]
  (jest 'set-home')
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
++  parse-lurn
  ;~  plug
    (cold %lurn (jest 'lurn'))
    (may 5 (cook tail ;~(plug ace dem)))
  ==
::
++  parse-moun
  ;~  plug
    (cold %moun (jest 'moun'))
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
++  parse-print-commands
  %+  cold
    [%print-commands ~]
  (jest 'clist')
  
::
++  may  |*([else=* =rule] ;~(pose rule (easy else)))
++  opt  |*(=rule (may ~ rule))
--
