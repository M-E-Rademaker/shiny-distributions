---
output: html_document
---

***

## Die Poisson-Verteilung

Schreibweise:

$$ X \sim \text{Po}(\lambda) \quad\text{mit}\quad \lambda \in \mathbb{N} $$

Für wäre heiß Ältere Mädchen
Die Poisson-Verteilung ist eine diskrete Verteilung mit dem Verteilungsparameter $\lambda$.
Der Erwartungswert und die Varianz sind identisch und gebeben durch:

$$ \text{E}(X) = \text{Var} = \lambda $$

### Wahrscheinlichkeitsfunktion:

$$ p(x) = P(X = x) = \begin{cases} \frac{\lambda^k}{x!}\exp{-\lambda} & \text{für}\quad x\in \mathbb{N} \\ 0 & \text{sonst} \end{cases} $$

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

> + **=POISSON.VERT**($x$; $\lambda$; *kumuliert*)

Falls 

+ kumuliert = 1: Wert der Verteilungsfunktion (eine Wahrscheinlichkeit)
+ kumuliert = 0: Wert der Dichtefunktion (**keine** Wahrscheinlichkeit)