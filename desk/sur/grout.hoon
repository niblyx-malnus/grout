/-  c=chat, g=groups
|%
+$  reply  $@(cord content:c)
+$  data  grags=(jug flag:g @ta)
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
      [%portal n=@]
      [%flare t=@dr]
      :: [%tag-group tags=(set @ta)]
      :: [%list-grags ~]
  ==  ==
--
