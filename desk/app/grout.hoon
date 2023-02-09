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
  :~  :: 'Install '
      :: [%inline-code '%grout']
      :: ' with '
      :: [%inline-code '|install ~dister-dozzod-niblyx-malnus %grout']
      :: ' and find the code '
      'Find the code for '
      [%inline-code '%grout']  ' '
      [%link :_('here' 'https://github.com/niblyx-malnus/grout')]
      '.'
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
    ^-  content:c
    ?^  reply  reply
    [%story [~ ~[reply]]]
  ++  message-card
    |=  [=flag:c rid=id:c =reply]
    ^-  card
    :*  %pass  /chat/poke/message  %agent  [our.bowl %chat]  %poke
        :-  %chat-action
        !>  ^-  action:c
        :*  flag  now.bowl
            %writs  [our now]:bowl  %add  replying=(some rid)
            author=our.bowl  sent=now.bowl
            (reply-to-content reply)
        ==
    ==
  ++  delete-card
    |=  [=flag:c =id:c]
    ^-  card
    :*  %pass  /chat/poke/delete  %agent  [our.bowl %chat]  %poke
        :-  %chat-action
        !>  ^-  action:c
        [flag now.bowl %writs id %del ~]
    ==
  ++  first-cord
    |=  inlines=(list inline:c)
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
  ++  flare-cards
    |=  [=flag:c =id:c rid=(unit id:c) t=@dr =content:c]
    ^-  (list card)
    |^
    =/  wire  (en-wire:timers flag id)
    =/  id  ?~(rid id u.rid)
    =/  flare-content
      ?>  ?=(%story -.content)
      content(+> (welp flare-text +>.content))
    %+  weld
      [%pass wire %arvo %b %wait (add now.bowl t)]~
    ?:  ?=(^ rid)
      [(message-card flag id content)]~
    [(message-card flag id flare-content)]~
    ++  flare-text
      ^-  (list inline:c)
      :~  '\0a'
          'Don\'t mind me! '
          'This message will self-destruct '
          (scot %dr t)  ' after it was posted.'
          [%break ~]  '🫡🔥🔥🫡'  [%break ~]
      ==
    --
  ++  timers
    |%
    ++  en-wire
      |=  [=flag:c =id:c]
      ^-  wire
      %+  weld
        /timers/(scot %p p.flag)/[q.flag]
      /(scot %p p.id)/(scot %da q.id)
    --
  --
%-  agent:dbug
%+  verb  |
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    hc   ~(. +> bowl)
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
      =/  cmd=command  +>.axn
      ?-    +<.cmd
          %flare
        :_  state
        %:  flare-cards:hc
          flag.axn  id.axn  rid.axn  t.cmd  [%story ~ ~]
        ==
        ::
          %portal
        ?>  =(author.axn our.bowl)
        =/  window  ~d30  :: constant
        =/  galf  (group-flag:hc flag.axn)
        =/  chats=(map flag:c chat:c)
          .^  (map flag:c chat:c)  %gx
              (welp (en-beak:hc %chat) /chats/chats)
          ==
        ::
        :: get new posts
        =/  since  (sub now.bowl window)
        =/  new
          %-  ~(run by chats)
          |=  =chat:c
          ^-  [flag:g (list [time writ:c])]
          :-  group.perm.chat
          =+  on:writs:c
          %-  flop  :: newest first
          %+  murn  :: ignore notices
            (tap (lot wit.pact.chat `since ~))
          |=  [time writ:c]
          ?.(?=(%story -.content) ~ (some +<))
        ::
        :: remove dead chats
        =|  mems=(map flag:c [flag:g id:c (set ship)])
        =.  mems
          %-  ~(gas by mems)
          %+  turn
            %+  murn  ~(tap by new)
            |=  [=flag:c flag:g l=(list [time writ:c])]
            ?~(l ~ (some +<))
          |=  [=flag:c grup=flag:g l=(list [time writ:c])]
          ?~  l  !!
          :^  flag  grup  id:i.l
          (sy (turn l |=([time writ:c] author)))
        ::
        =/  us=(set ship)  +>:(~(got by mems) flag.axn)
        =/  not-us=(list [flag:c flag:g id:c (set ship)])
          %+  murn  ~(tap by mems)
          |=  [=flag:c grup=flag:g =id:c mem=(set ship)]
          ?:  =(flag flag.axn)  ~
          ?:  =(grup galf)  ~
          (some +<)
        ::
        :: get similarity
        =+  %+  turn  not-us
            |=  [=flag:c grup=flag:g =id:c mem=(set ship)]
            [grup (jaccard us mem)]
            :: [[flag id] (jaccard us mem)]
        :: =/  jack=(list [[flag:c id:c] @rs])
        =/  jack=(list flag:g)
          %~  tap  in
          %-  sy
          %+  turn
            %+  sort  -
            |*  [a=[* @rs] b=[* @rs]]
            (gth:rs +.a +.b)
          head
        ::
        :: convert groups to cite blocks
        =/  cites=(list block:c)
          %+  turn  (scag (min n.cmd 10) jack)
          |=(=flag:g [%cite %group flag])
          :: |=  [[=flag:c =id:c] @rs]
          :: :^  %cite  %chan  [%chat flag]
          :: /msg/(scot %p p.id)/(scot %ud q.id)
        ::
        :: create reply
        =/  plain=(list inline:c)
          :~  [%inline-code ';portal']
              ' is a '
              [%inline-code '%grout']
              'command which opens up a portal to the groups '
              'which you are a member of and which are nearest to '
              'the one you are currently in. Nearness is measured by '
              'recent-poster overlap (Jaccard index).'
              [%break ~]
          ==
        =/  =content:c  [%story cites (weld plain promo)]
        =/  id  ?~(rid.axn id.axn u.rid.axn)
        :_  state
        ?.  zap.cmd
          [(message-card:hc flag.axn id content)]~
        %:  flare-cards:hc
          flag.axn  id.axn  rid.axn  ~s10  content
        ==
        ::
          %old-portal
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
          %+  turn  (scag (min n.cmd 10) jack)
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
        =/  =content:c  [%story cites (weld plain promo)]
        =/  id  ?~(rid.axn id.axn u.rid.axn)
        :_  state
        ?.  zap.cmd
          [(message-card:hc flag.axn id content)]~
        %:  flare-cards:hc
          flag.axn  id.axn  rid.axn  ~s10  content
        ==
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
                !>  [%command +<.axn zap.cmd %confirm-pals q.galf fleet]
        ==  ==
        ::
          %confirm-pals
        ?>  =(src.bowl our.bowl)
        =/  targets
          .^((set ship) %gx (welp (en-beak:hc %pals) /targets/noun))
        =/  mutuals
          .^((set ship) %gx (welp (en-beak:hc %pals) /mutuals/noun))
        =/  diff=(set ship)
          %-  ~(dif in (~(del in fleet.cmd) our.bowl))
          (~(uni in targets) mutuals)
        =/  msg
          ?~  diff
            (crip "%grout: extracted pals from group %{(trip group.cmd)}")
          (crip "%grout: failed to extract pals from group %{(trip group.cmd)}")
        =/  =content:c
          :+  %story  ~
          ['' [%code msg] '\0a' promo]
        =/  rid=id:c
          ?~(rid.axn id.axn u.rid.axn)
        :_  state
        ?.  zap.cmd
          [(message-card:hc flag.axn rid content)]~
        %:  flare-cards:hc
          flag.axn  id.axn  rid.axn  ~s10  content
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
        =/  =action:c  !<(action:c q.cage.sign)
        =/  =flag:c  p.action
        =/  =diff:c  q.q.action
        ?+  -.diff  `this
            %writs
          =/  =id:c           p.p.diff
          =/  =delta:writs:c  q.p.diff
          ?+  -.delta  `this
              %add
            =/  =memo:c  p.delta
            =/  rid=(unit id:c)  replying.memo
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
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+    wire  (on-arvo:def wire sign-arvo)
      [%timers @t @ta @t @t ~]
    =/  =flag:c
      [(slav %p i.t.wire) i.t.t.wire]
    =/  =id:c
      [(slav %p i.t.t.t.wire) (slav %da i.t.t.t.t.wire)]
    ?+    sign-arvo  (on-arvo:def wire sign-arvo)
        [%behn %wake *]
      ?^  error.sign-arvo
        (on-arvo:def wire sign-arvo)
      :_(this [(delete-card:hc flag id)]~)
    ==
  ==
++  on-fail   on-fail:def
--
