---
output: html_document
---

***

## Die Normalverteilung

Schreibweise:

$$ X \sim N(\mu, \sigma^2)$$

Die Normalverteilung ist eine stetige Verteilung mit:

$$ \text{E}(X) = \mu \qquad\text{und}\qquad \text{Var}(X) = \sigma^2 $$

### Dichtefunktion

Die Dichtefunktion ist gegeben durch:

$$ f(x) = \frac{1}{\sqrt{2\pi}\sigma}\exp{-\frac{1}{2}\frac{(x - \mu)^2}{\sigma^2}} $$

### Verteilungsfunktion

Die Verteilungsfunktion ist definiert als:

$$ F(x) = P(X \leq x) = \int^{+\infty}_{-\infty}f(x) dx $$

Der Wert der Verteilungsfunktion gibt an, mit welcher Wahrscheinlichkeit die 
Zufallsvariable $X$ einen Wert kleiner oder gleich $x$ annimmt.

### Quantilsfunktion

Die Quantilsfunktion gibt an, welcher Wert (= Quantil $x_0$) zur Wahrscheinlichkeit
korrespondiert, dass $p\%$ der Beobachtungen unter diesem Wert liegen. Formal ist
die Quantilsfunktion die Umkehrfunktion der Verteilungsfunktion: 

$$ x = F(p)^{-1} = F[P(X \leq x)]^{-1} $$

---

### Excel Befehle

#### Dichte- bzw. Verteilungsfunktion der Normalverteilung

+ `=NORM.VERT`($x$; $\mu$; $\sigma$; **kumuliert**)

    + $x$ := Ein x-Wert
    + $\mu$ := Der Mittelwert
    + $\sigma$ := Die Standardabweichung (nicht Varianz!)
    + kumuliert = 1 := Wert der Verteilungsfunktion (eine Wahrscheinlichkeit)
    + kumuliert = 0 := Wert der Dichtefunktion (keine Wahrscheinlichkeit!)

#### Dichte- bzw. Verteilungsfunktion der Standardnormalverteilung

+ `=NORM.S.VERT`($x$; **kumuliert**)

    + $x$ := Ein x-Wert
    + kumuliert = 1 := Wert der Verteilungsfunktion (eine Wahrscheinlichkeit)
    + kumuliert = 0 := Wert der Dichtefunktion (keine Wahrscheinlichkeit!)

#### Quantilsfunktion der Normalverteilung

+ `=NORM.INV`($p$; $\mu$; $\sigma$)

    + $p$ := Eine Wahrscheinlichkeit
    + $\mu$ := Der Mittelwert
    + $\sigma$ := Die Standardabweichung (nicht Varianz!)

#### Quantilsfunktion der Standardnormalverteilung

+ `=NORM.S.INV`($p$)

    + $p$ := Eine Wahrscheinlichkeit
