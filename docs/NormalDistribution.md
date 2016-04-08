---
output: html_document
---

***
## Die Normalverteilung

Schreibweise:

$$ X \sim N(\mu, \sigma^2)$$

Die Normalverteilung ist eine stetige Verteilung mit $\text{E}(X) = \mu$ und 
$\text{Var}(X) = \sigma^2$.

### Dichtefunktion

Die Dichtefunktion ist definiert als:

$$ f(x) = \frac{1}{\sqrt{2\pi\sigma}}\exp{-\frac{1}{2}\frac{(x - \mu)^2}{\sigma^2}} $$

### Verteilungsfunktion

Die Verteilungsfunktion ist definiert als:

$$ F(x) = P(X \leq x) = \int^{+\infty}_{-\infty}f(x) dx $$

Der Wert der Verteilungsfunktion gibt an, mit welcher Wahrscheinlichkeit die 
Zufallsvariable $X$ einen Wert kleiner oder gleich $x$ annimmt.

### Quantilsfunktion

Die Quantilsfunktion gibt an, welcher Wert (= Quantil $x_0$) zur Wahrscheinlichkeit
korrespondiert, dass $p\%$ der Beobachtungen unter diesem Wert liegen. Formal ist
die Quantilsfunktion die Umkehrfunktion der Verteilungsfunktion: 

$$ x = F(p)^{-1} $$

---

### Excel Befehle

>+ **=NORM.VERT**($x$; $\mu$; $\sigma$; *kumuliert*)
+ **=NORM.S.VERT**($x$; kumuliert)
+ **=NORM.INV**($p$; $\mu$; $\sigma$; kumuliert)
+ **=NORM.S.INV**($p$; $\mu$; $\sigma$; kumuliert)

Falls 

+ kumuliert = 1: Wert der Verteilungsfunktion (eine Wahrscheinlichkeit)
+ kumuliert = 0: Wert der Dichtefunktion (**keine** Wahrscheinlichkeit)

