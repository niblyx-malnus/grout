/-  *grout, c=chat, g=groups
/+  verb, dbug, default-agent
/+  *command-parser, groups-core
|%
+$  versioned-state
  $%  state-0
  ==
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
:: generic helper core
::
|_  =bowl:gall
++  en-beak  |=(=desk /(scot %p our.bowl)/[desk]/(scot %da now.bowl))
++  chat-subscribe-card
  [%pass /chat/updates %agent [our.bowl %chat] %watch /ui]
::
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
::
++  reply-to-content
  |=  =reply
  ^-  content:c
  ?^  reply  reply
  [%story [~ ~[reply]]]
::
++  message-card
  |=  [=flag:c rid=(unit id:c) =reply]
  ^-  card
  =/  =id:c  [our now]:bowl
  :*  %pass  /  %agent  [our.bowl %chat]  %poke
      :-  %chat-action
      !>  ^-  action:c
      :*  flag  now.bowl
          %writs  id  %add  replying=rid
          author=our.bowl  sent=now.bowl
          (reply-to-content reply)
      ==
  ==
::
++  message-cards
  |=  [=flag:c rid=(unit id:c) replies=(list reply)]
  ^-  (list card)
  =|  messages=(list card)
  |-  ?~  replies  messages
  %=  $
    now.bowl  (add now.bowl (div ~s1 1.000))
    replies   t.replies
    messages  [(message-card flag rid i.replies) messages]
  ==
++  send-replies
  |=  $:  =flag:c
          src=id:c
          rep=(unit id:c)
          replies=(list reply)
      ==
  ^-  (list card)
  =/  rid=id:c  ?~(rep src u.rep)
  (message-cards flag (some rid) replies)
::
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
    [(message-card flag (some id) content)]~
  [(message-card flag (some id) flare-content)]~
  ++  flare-text
    ^-  (list inline:c)
    :~  '\0a'
        'Don\'t mind me! '
        'This message will self-destruct '
        (scot %dr t)  ' after it was posted.'
        [%break ~]  '🫡🔥🔥🫡'  [%break ~]
    ==
  --
::
++  enflare
  |=  $:  [zap=? t=@dr]
          =flag:c
          src=id:c
          rep=(unit id:c)
          =content:c
      ==
  ^-  (list card)
  ?.  zap
    (send-replies flag src rep [content]~)
  (flare-cards flag src rep t content)
::
++  encite-groups
  |=  groups=(list flag:g)
  ^-  (list block:c)
  %+  turn  groups
  |=(=flag:g [%cite %group flag])
::
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
::
%-  agent:dbug
%+  verb  |
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    gc    ~(. groups-core bowl)
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
      ?>  =(author.axn our.bowl)
      =/  cmd=command  +>.axn
      ?-    +<.cmd
          %tag-group
        ?>  =(author.axn our.bowl)  :: can be changed
        =/  galf  (group-flag:gc flag.axn)
        =/  =content:c
          :+  %story  ~
          :~  [%inline-code ';tg']
              ' is a '
              [%inline-code '%grout']
              'command which tags a group for use in '
              'later filtering.'
              [%break ~]
          ==
        :_  state(grags (~(put ju grags) galf tag.cmd))
        %-  enflare:hc 
        [[zap.cmd ~s10] flag.axn id.axn rid.axn content]
        ::
          %go-home
        ?>  =(author.axn our.bowl)
        =/  window  ~d30  :: constant
        =/  galf  (group-flag:gc flag.axn)
        ::
        :: convert groups to cite blocks
        =/  cites=(list block:c)  [%cite %group galf]~
        ::
        :: create reply
        =/  plain=(list inline:c)
          :~  [%inline-code ';go-home']
              ' is a '
              [%inline-code '%grout']
              'command which opens up a portal to the groups '
              'which you have set as your home base.'
              [%break ~]
          ==
        =/  =content:c  [%story cites (weld plain promo)]
        :_  state
        %-  enflare:hc 
        [[zap.cmd ~s10] flag.axn id.axn rid.axn content]
        ::
          %set-home
        ?>  =(author.axn our.bowl)
        =/  galf  (group-flag:gc flag.axn)
        =/  =content:c
          :+  %story  ~
          :~  [%inline-code ';set-home']
              ' is a '
              [%inline-code '%grout']
              'command which sets a group as a home base '
              'to be quickly portalled into.'
              [%break ~]
          ==
        :_  state(home galf)
        %-  enflare:hc 
        [[zap.cmd ~s10] flag.axn id.axn rid.axn content]
        ::
          %print-commands
        ?>  =(author.axn our.bowl)
        ::
        :: create reply
        =/  =content:c
          :+  %story  ~
          :~  :-  %code
              %-  crip  ;:  weld
              "replace ';' with '!' for self-destruction "
              "after 10 seconds.\a0"
              ";portal: drop portal to other groups\a0"
              ";xpals: extract pals from group\a0"
              ==
          ==
        :_  state
        %-  enflare:hc 
        [[zap.cmd ~s10] flag.axn id.axn rid.axn content]
        ::
          %flare
        ?>  =(author.axn our.bowl)
        :_  state
        =/  empty=content:c  [%story ~ ~]
        %-  enflare:hc 
        [[zap.cmd t.cmd] flag.axn id.axn rid.axn empty]
        ::
          %lurn
        ?>  =(author.axn our.bowl)
        =/  galf  (group-flag:gc flag.axn)
        =/  lurn
          %+  sort  ~(tap by (group-latest-unread:gc galf))
          |=  [a=[flag:g @] b=[flag:g @]]
          (gth +.a +.b)
        :: convert groups to cite blocks
        ::
        =/  cites=(list block:c)
          %-  encite-groups:hc
          (turn (scag (min n.cmd 10) lurn) head)
        :: create reply
        ::
        =/  plain=(list inline:c)
          :~  [%inline-code ';lurn']
              ' is a '
              [%inline-code '%grout']
              'command which opens up a portal to the groups '
              'which contain the latest messages you have not read.'
              [%break ~]
          ==
        =/  =content:c  [%story cites (weld plain promo)]
        :_  state
        %-  enflare:hc 
        [[zap.cmd ~s10] flag.axn id.axn rid.axn content]
        ::
          %moun
        ?>  =(author.axn our.bowl)
        =/  galf  (group-flag:gc flag.axn)
        =/  moun
          %+  sort  ~(tap by (group-most-unread:gc galf))
          |=  [a=[flag:g @] b=[flag:g @]]
          (gth +.a +.b)
        :: convert groups to cite blocks
        ::
        =/  cites=(list block:c)
          %-  encite-groups:hc
          (turn (scag (min n.cmd 10) moun) head)
        :: create reply
        ::
        =/  plain=(list inline:c)
          :~  [%inline-code ';moun']
              ' is a '
              [%inline-code '%grout']
              'command which opens up a portal to the groups '
              'which contain the most messages which you have not read.'
              [%break ~]
          ==
        =/  =content:c  [%story cites (weld plain promo)]
        :_  state
        %-  enflare:hc 
        [[zap.cmd ~s10] flag.axn id.axn rid.axn content]
        ::
          %portal
        ?>  =(author.axn our.bowl)
        =/  window  ~d30  :: constant
        =/  galf  (group-flag:gc flag.axn)
        =/  jack  (jaccard-postership:gc galf window)
        :: convert groups to cite blocks
        ::
        =/  cites=(list block:c)
          %-  encite-groups:hc
          (turn (scag (min n.cmd 10) jack) head)
        :: create reply
        ::
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
        :_  state
        %-  enflare:hc 
        [[zap.cmd ~s10] flag.axn id.axn rid.axn content]
        ::
          %old-portal
        ?>  =(author.axn our.bowl)
        =/  galf=flag:g  (group-flag:gc flag.axn)
        =/  jack=(list [flag:g @rs])
          (jaccard-membership:gc galf)
        =/  cites=(list block:c)
          %-  encite-groups:hc
          (turn (scag (min n.cmd 10) jack) head)
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
        :_  state
        %-  enflare:hc 
        [[zap.cmd ~s10] flag.axn id.axn rid.axn content]
        ::
          %extract-pals
        ~&  "Extracting pals..."
        ?>  =(author.axn our.bowl)
        =/  galf  (group-flag:gc flag.axn)
        =/  fleet  (group-to-fleet:gc galf)
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
        :_  state
        %-  enflare:hc 
        [[zap.cmd ~s10] flag.axn id.axn rid.axn content]
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
              (command-parser line bowl state)
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
