/-  *grout, c=chat, g=groups
/+  *command-parser, verb, dbug, default-agent
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 data]
+$  card  card:agent:gall
++  promo
  ^-  (list inline:c)
  :~  'Install '
      [%inline-code '%grout']
      ' with '
      [%inline-code '|install ~dister-dozzod-niblyx-malnus %grout']
      ' and find the code '
      [%link p='https://github.com/niblyx-malnus/grout' q='here']  '.'
  ==
--
::
=|  state-0
=*  state  -
=>
  |_  =bowl:gall
  ++  en-beak  |=(=desk /(scot %p our.bowl)/[desk]/(scot %da now.bowl))
  ++  chat-subscribe-card
    [%pass /chat/updates %agent [our.bowl %chat] %watch /ui]
  ++  reply-to-content
    |=  =reply
    ^-  content:chat
    ?^  reply  reply
    [%story [~ ~[reply]]]
  ++  message-card
    |=  [=flag:chat id=(unit id:chat) =reply]
    ^-  card
    :*  %pass  /chat/poke  %agent  [our.bowl %chat]  %poke
        :-  %chat-action
        !>  ^-  action:chat
        :*  flag  now.bowl
            %writs  [our now]:bowl  %add  replying=id
            author=our.bowl  sent=now.bowl
            (reply-to-content reply)
        ==
    ==
  ++  first-cord
    |=  inlines=(list inline:chat)
    |-
    ?~  inlines  !!
    ?@  i.inlines  i.inlines
    $(inlines t.inlines)
  ++  jaccard
    |=  [a=(set) b=(set)]
    ^-  @rs
    %+  div:rs
      (sun:rs ~(wyt in (~(int in a) b)))
    (sun:rs ~(wyt in (~(uni in a) b)))
  ::
  :: get group flag of a chat
  ++  group-flag
    |=  =flag:c
    ^-  flag:g
    =-  group
    .^  perm:c  %gx
        ;:  welp
          (en-beak %chat)
          /chat/(scot %p p.flag)/[q.flag]
          /perm/chat-perm
        ==
    ==
  ++  group-to-fleet
    |=  =flag:g
    ^-  (set ship)
    .^  (set ship)  %gx
        ;:  welp
          (en-beak %groups)
          /groups/(scot %p p.flag)/[q.flag]
          /fleet/ships
          /ships
        ==
    ==
  --
%-  agent:dbug
%+  verb  |
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    hc    ~(. +> bowl)
::
++  on-init
  ^-  (quip card _this)
  :_  this
  ~[chat-subscribe-card:hc]
::
++  on-save  !>(state)
::
++  on-load
  |=  ole=vase
  ^-  (quip card _this)
  =/  old=state-0  !<(state-0 ole)
  :_  this(state old)
  ?:  (~(has by wex.bowl) [/chat/updates our.bowl %chat])  ~
  ~[chat-subscribe-card:hc]
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ?+    mark  (on-poke:def mark vase)
      %grout-action
    =^  cards  state
      (handle-poke !<(action vase))
    [cards this]
  ==
  ++  handle-poke
    |=  axn=action
    ^-  (quip card _state)
    ?-    -.axn
        %command
      ?-    +>-.axn
          %portal
        ?>  =(author.axn our.bowl)
        =/  galf  (group-flag:hc flag.axn)
        =/  groups  .^(groups:g %gx (welp (en-beak:hc %groups) /groups/groups))
        =/  fleet=(set ship)  ~(key by fleet:(~(got by groups) galf))
        :: 
        :: remove self and secret groups
        =+  %+  murn  ~(tap by groups)
            |=  [=flag:g group:g]
            ?:(|(secret =(flag galf)) ~ (some +<))
        ::
        :: compute jaccard index with current group
        =+  %+  turn  -
            |=  [=flag:g group:g]
            ^-  [flag:g @rs]
            [flag (jaccard:hc ^fleet ~(key by fleet))]
        ::
        :: sort by jaccard index
        =/  jack=(list [flag:g @rs])
          %+  sort  -
          |=  [a=[flag:g @rs] b=[flag:g @rs]]
          (gth:rs +.a +.b)
        ::
        :: convert groups to cite blocks
        =/  cites=(list block:c)
          %+  turn  (scag (min n.axn 10) jack)
          |=([=flag:g @rs] [%cite %group flag])
        ::
        :: create reply
        =/  plain=(list inline:c)
          :~  [%inline-code ';portal']
              ' is a '
              [%inline-code '%grout']
              'command which opens up a portal to the (non-secret) groups '
              'which you are a member of and which are nearest to '
              'the one you are currently in. Nearness is measured by '
              'membership overlap (Jaccard index).'
              [%break ~]
          ==
        =/  =reply  [%story cites (weld plain promo)]
        =/  id  ?~(rid.axn (some id.axn) rid.axn)
        :_(state [(message-card:hc flag.axn id reply)]~)
        ::
          %extract-pals
        ~&  "Extracting pals..."
        ?>  =(author.axn our.bowl)
        =/  galf  (group-flag:hc flag.axn)
        =/  fleet  (group-to-fleet:hc galf)
        =/  pals-cards
          %+  turn  ~(tap in fleet)
          |=  =ship
          ^-  card
          :*  %pass  /  %agent  [our.bowl %pals]  %poke
              %pals-command
              !>([%meet ship (sy [q.galf]~)])
          ==
        :_  state
        %+  welp
          pals-cards
        :~  :*  %pass  /  %agent  [our.bowl %grout]  %poke
                :-  %grout-action
                !>  [%command +<.axn %confirm-pals q.galf fleet]
        ==  ==
        ::
          %confirm-pals
        ?>  =(src.bowl our.bowl)
        =/  targets
          .^((set ship) %gx (welp (en-beak:hc %pals) /targets/noun))
        =/  mutuals
          .^((set ship) %gx (welp (en-beak:hc %pals) /mutuals/noun))
        =/  diff=(set ship)
          %-  ~(dif in (~(del in fleet.axn) our.bowl))
          (~(uni in targets) mutuals)
        =/  msg
          ?~  diff
            (crip "%grout: extracted pals from group %{(trip group.axn)}")
          (crip "%grout: failed to extract pals from group %{(trip group.axn)}")
        =/  =reply  [%story ~ [%code msg]~]
        =/  id  ?~(rid.axn (some id.axn) rid.axn)
        :_  state
        :~  (message-card:hc flag.axn id reply)
            =.  now.bowl  +(now.bowl)
            (message-card:hc flag.axn id [%story ~ promo])
        ==
      ==
    ==
  --
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+  wire  (on-agent:def wire sign)
      [%chat %updates ~]
    ?+    -.sign  (on-agent:def wire sign)
      %watch-ack  `this
        %kick
      :_  this
      ~[chat-subscribe-card:hc]
    ::
        %fact
      ?+    p.cage.sign  `this
          %chat-action-0
        =/  =action:chat  !<(action:chat q.cage.sign)
        =/  =flag:chat  p.action
        =/  =diff:chat  q.q.action
        ~&  diff
        ?+  -.diff  `this
            %writs
          =/  =id:chat           p.p.diff
          =/  =delta:writs:chat  q.p.diff
          ?+  -.delta  `this
              %add
            =/  =memo:chat  p.delta
            =/  rid=(unit id:chat)  replying.memo
            ?>  ?=(%story -.content.memo)
            =/  line  (first-cord:hc q.p.content.memo)
            =/  axn=^action
              :+  %command
                [author.memo flag id rid p.content.memo]
              (command-parser line bowl +.state)
            :_  this
            :~  :*  %pass  /  %agent  [our dap]:bowl  %poke
                    grout-action+!>(axn)
            ==  ==
          ==
        ==
      ==
    ==
  == 
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
