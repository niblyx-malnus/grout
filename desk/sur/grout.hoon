/-  chat
|%
+$  reply  $@(cord content:chat)
+$  data  ~
::
+$  action  
  $%  $:  %command
          $:  author=ship
              =flag:chat
              =id:chat
              rid=(unit id:chat)
              =story:chat
          ==
          command
  ==  ==
+$  command
  $%  [%extract-pals ~]
      [%confirm-pals group=term fleet=(set ship)]
      [%portal n=@]
  ==
--
