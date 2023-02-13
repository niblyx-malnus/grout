/-  c=chat, g=groups
|%
+$  state-0
  $:  %0
      home=flag:g
      grags=(jug flag:g @ta)
  ==
::
+$  reply  $@(cord content:c)
::
:: context from command message
+$  papers
  $:  author=ship
      =flag:c
      =id:c
      rid=(unit id:c)
      =story:c
  ==
+$  tale  $>(%story content:c)
+$  action  
  $%  [%command papers command]
  ==
+$  command
  $:  zap=?
  $%  [%extract-pals ~]
      [%confirm-pals group=term fleet=(set ship)]
      [%old-portal n=@]
      [%portal n=@] :: recent poster overlap (pove?)
      [%lurn n=@]  :: groups with latest unreads
      [%moun n=@]  :: groups with most unreads
                   :: most mentioned in group (mome)
      [%flare t=@dr]
      [%print-commands ~]
      [%set-home ~]
      [%go-home ~]
      [%tag-group tag=@ta]
      :: [%list-grags ~]
  ==  ==
--
