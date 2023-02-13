/-  *grout, c=chat, g=groups
|_  =bowl:gall
+*  sour  (scot %p our.bowl)
    snow  (scot %da now.bowl)
  ::
    all-groups
  ^-  groups:g
  .^  groups:g  %gx
    /[sour]/groups/[snow]/groups/groups
  ==
  :: all group-permissioned chats
  ::
    all-chats
  ^-  (map flag:c chat:c)
  %-  ~(gas by *(map flag:c chat:c))
  %+  murn
    %~  tap  by
    .^  (map flag:c chat:c)  %gx
      /[sour]/chat/[snow]/chats/chats
    ==
  |=  [=flag:c =chat:c]
  ?.  %.  group.perm.chat
      ~(has by all-groups)
  ~  (some +<)
  ::
    all-briefs
  ^-  briefs:c
  .^  briefs:c  %gx
    /[sour]/chat/[snow]/briefs/chat-briefs
  ==
  ::
    non-secret-groups
  ^-  groups:g
  %-  ~(gas by *groups:g)
  %+  murn  ~(tap by all-groups)
  |=  [=flag:g group:g]
  ?:(secret ~ (some +<))
  ::
    non-secret-fleets
  ^-  (map flag:g (set ship))
  %-  ~(run by non-secret-groups)
  |=(group:g `(set ship)`~(key by fleet))
:: get group flag of a chat
::
++  group-flag
  |=  =flag:c
  ^-  flag:g
  =-  group
  .^  perm:c  %gx
      ;:  welp
        /[sour]/chat/[snow]
        /chat/(scot %p p.flag)/[q.flag]
        /perm/chat-perm
      ==
  ==
:: get fleet from group flag
::
++  group-to-fleet
  |=  =flag:g
  ^-  (set ship)
  .^  (set ship)  %gx
      ;:  welp
        /[sour]/groups/[snow]
        /groups/(scot %p p.flag)/[q.flag]
        /fleet/ships
        /ships
      ==
  ==
::
++  chat-posts-since
  |=  window=@dr
  ^-  (map flag:c (list [time writ:c]))
  =/  since  (sub now.bowl window)
  %-  ~(run by all-chats)
  |=  =chat:c
  ^-  (list [time writ:c])
  =+  on:writs:c
  %-  flop  :: newest first
  %+  murn  :: ignore notices
    (tap (lot wit.pact.chat `since ~))
  |=  [time writ:c]
  ?.(?=(%story -.content) ~ (some +<))
::
++  chat-posters-since
  |=  window=@dr
  ^-  (map flag:c (set ship))
  %-  ~(gas by *(map flag:c (set ship)))
  %+  turn  ~(tap by (chat-posts-since window))
  |=  [=flag:c l=(list [time writ:c])]
  [flag (sy (turn l |=([time writ:c] author)))]
::
++  group-posters-since
  |=  window=@dr
  ^-  (map flag:g (set ship))
  =/  chaps  (chat-posters-since window)
  =/  chats=(list [=flag:c =chat:c])
    ~(tap by all-chats)
  =|  graps=(map flag:g (set ship))
  |-  ?~  chats  graps
  %=    $
    chats  t.chats
      graps
    =/  cflag  flag.i.chats
    =/  group  group.perm.chat.i.chats
    =/  r  ?~(r=(~(get by graps) group) ~ u.r)
    %+  ~(put by graps)  group
    (~(uni in r) (~(got by chaps) cflag))
  ==
::
++  jaccard
  |=  [a=(set) b=(set)]
  ^-  @rs
  %+  div:rs
    (sun:rs ~(wyt in (~(int in a) b)))
  (sun:rs ~(wyt in (~(uni in a) b)))
::
++  jacc
  |=  [=flag:g =(map flag:g (set ship))]
  ^-  (list [flag:g @rs])
  =/  our  (~(got by map) flag)
  =.  map  (~(del by map) flag)
  %+  sort
    %+  turn  ~(tap by map)
    |=  [=flag:g der=(set ship)]
    ^-  [flag:g @rs]
    [flag (jaccard our der)]
  |=  [a=[flag:g @rs] b=[flag:g @rs]]
  (gth:rs +.a +.b)
::
++  jaccard-membership
  |=  =flag:g
  ^-  (list [flag:g @rs])
  (jacc flag non-secret-fleets)
::
++  jaccard-postership
  |=  [=flag:g t=@dr]
  ^-  (list [flag:g @rs])
  (jacc flag (group-posters-since t))
::
++  group-latest-unread
  |=  =flag:g
  %.  flag
  %~  del  by
  ^-  (map flag:g time)
  =/  briefs  ~(tap by all-briefs)
  =|  latest=(map flag:g time)
  |-  ?~  briefs  latest
  =/  [=whom:c =brief:briefs:c]  i.briefs
  %=    $
    briefs  t.briefs
      latest
    ?-    -.whom
      ?(%ship %club)  latest
        %flag
      ?~  uchat=(~(get by all-chats) p.whom)  latest
      =/  group  group.perm.u.uchat
      =+  on:writs:c
      =/  times  (turn (flop (tap wit.pact.u.uchat)) head)
      ?~  times  latest
      ?:  =(0 count.brief)  latest
      ?~  t=(~(get by latest) group)
        (~(put by latest) group i.times)
      ?.  (gth i.times u.t)  latest
      (~(put by latest) group i.times)
    ==
  ==
++  group-most-unread
  |=  =flag:g
  %.  flag
  %~  del  by
  ^-  (map flag:g @)
  =/  briefs  ~(tap by all-briefs)
  =|  most=(map flag:g @)
  |-  ?~  briefs  most
  =/  [=whom:c =brief:briefs:c]  i.briefs
  %=    $
    briefs  t.briefs
      most
    ?-    -.whom
      ?(%ship %club)  most
        %flag
      ?~  uchat=(~(get by all-chats) p.whom)  most
      =/  group  group.perm.u.uchat
      ?~  m=(~(get by most) group)
        (~(put by most) group count.brief)
      %+  ~(put by most)  group
      (add u.m count.brief)
    ==
  ==
--
