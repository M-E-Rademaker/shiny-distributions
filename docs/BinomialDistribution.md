---
output: html_document
---

***

## Die Binomialverteilung

Schreibweise:

$$ X \sim \text{B}(n, p) \quad\text{mit}\quad n \in \mathbb{N} 
\quad\text{und}\quad 0 \leq p \leq 1  $$

Die Binomialverteilung ist eine diskrete Verteilung mit den Verteilungsparametern
$n$ := Anzahl der Versuche und $p$ := Erfolgswahrscheinlichkeit.

### Wahrscheinlichkeitsfunktion:

$$ p(x) = \begin{cases} \binom{n}{x}p^x (1 - p)^{n-x} & \text{für}\quad x \in \{0,1,2,\dots,n\}\\
0 & \text{sonst} \end{cases} $$

mit $x$ := Anzahl der "Treffer"
### Verteilungsfunktion

Die Verteilungsfunktion ist definiert als:

$$ F(x_m) = P(X \leq x_m) = \sum^{m}_{i = 1}P(X = x_i) $$

wobei $x_m$ die $m$-ten Ausprägung der Zufallsvariablen $X$ in einer geordneten 
Reihenfolge bezeichnet.

Der Wert der Verteilungsfunktion gibt an, mit welcher Wahrscheinlichkeit die 
Zufallsvariable $X$ einen Wert kleiner oder gleich $x_m$ annimmt.

### Quantilsfunktion

Die Quantilsfunktion gibt an, welcher Wert (= Quantil $x_0$) zur Wahrscheinlichkeit
korrespondiert, dass $p\%$ der Beobachtungen unter diesem Wert liegen. Formal ist
die Quantilsfunktion die Umkehrfunktion der Verteilungsfunktion: 

$$ x = F(p)^{-1} $$

---

### Excel Befehle

> + **=BINOM.VERT**($x$; $n$; $p$; *kumuliert*)
+ **=BINOM.VERT.BEREICH**($n$; $p$; $x_1$; $x_2$)
+ **=BINOM.INV**($x$; $n$; $p$; *kumuliert*)

Falls 

+ kumuliert = 1: Wert der Verteilungsfunktion (eine Wahrscheinlichkeit)
+ kumuliert = 0: Wert der Dichtefunktion (**keine** Wahrscheinlichkeit)