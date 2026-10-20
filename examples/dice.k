/ Dice stacks: d dice per row for n rows. The dice columns add into one total per row, rows with the
/ same total stack together, and each stack prints beside the range it lands in 95% of the time.
/ Run:  kona examples/dice.k      (change n and d below; d:1 gives the six faces)
n:100000
d:3
/ d columns of n rolls, 1 to 6, drawn at once
cols:1+(d,n) _draw 6
/ add the columns into one total per row
t:+/cols
/ every total d dice can make
v:d+!1+5*d
/ one compare per total over the whole column, then count each: the stacks
s:+/'v=\:t
/ exact ways to roll each total: once per die, add the counts shifted by each face
w:,1
do[d; w:+/{(x#0),w,(5-x)#0}'!6]
p:w%1.0*+/w
e:n*p
h:1.96*_sqrt n*p*1-p
lo:_ 0.5+e-h
hi:_ 0.5+e+h
in:(s>lo-1)&s<hi+1
bar:_ (50.0%|/s)*s
row:{[v;s;lo;hi;in;b] (4$v),(9$s),(9$lo)," -",(7$hi),(:[in;"     ";"  OUT"]),"  ",b#"#"}
`0: ,"total    count   95% range"
`0: row'[v;s;lo;hi;in;bar]
`0: ($+/in)," of ",($#v)," stacks inside their 95% range"
/ the totals' own 95% range: cut 2.5% off each end of the exact odds
c:+\p
a:v@*&c>0.025
b:v@*&~c<0.975
`0: "95% of rows total ",($a)," to ",($b),"; this run: ",$(+/(t>a-1)&t<b+1)%1.0*n
