---
output: html_document
---

## Die Poisson-Verteilung

Schreibweise:

$$ X \sim \text{Po}(\lambda) \quad\text{mit}\quad \lambda \in \mathbb{N} $$

Die Poisson-Verteilung ist eine diskrete Verteilung mit dem Verteilungsparameter $\lambda$.
Der Erwartungswert und die Varianz sind identisch und gebeben durch

$$ \text{E}(X) = \text{Var}(X) = \lambda $$

### Wahrscheinlichkeitsfunktion

Die Wahrscheinlichkeitsfunktion ist gegeben durch:

$$ p(x) = P(X = x) = \begin{cases} \frac{\lambda^k}{x!}\exp{-\lambda} & \text{für}\quad x\in \mathbb{N} \\\\ 0 & \text{sonst} \end{cases} $$

### Verteilungsfunktion

Die Verteilungsfunktion ist definiert als:

$$ F(x) = P(X \leq x) = \sum_{x_i < x}P(X = x_i) $$

Der Wert der Verteilungsfunktion gibt an, mit welcher Wahrscheinlichkeit die 
Zufallsvariable $X$ einen Wert kleiner oder gleich $x$ annimmt.

### Quantilsfunktion

Die Quantilsfunktion gibt an, welcher Wert (= Quantil $x_0$) zur Wahrscheinlichkeit
korrespondiert, dass $p\%$ der Beobachtungen unter diesem Wert liegen. Formal ist
die Quantilsfunktion die Umkehrfunktion der Verteilungsfunktion: 

$$ x = F(p)^{-1} = F[P(X \leq x)]^{-1} $$

### Excel Befehle

#### Wahrscheinlichkeits- bzw. Verteilungsfunktion der Poisson-Verteilung

+ `=POISSON.VERT`($x$; $\lambda$; **kumuliert**)

    + $x$ := Eine natürliche Zahl
    + $\lambda$ := Der Verteilungsparameter
    + kumuliert = 1 := Wert der Verteilungsfunktion (eine Wahrscheinlichkeit)
    + kumuliert = 0 := Wert der Wahrscheinlichkeitsfunktion (eine Wahrscheinlichkeit)

