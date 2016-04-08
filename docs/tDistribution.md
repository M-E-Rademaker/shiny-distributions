---
output: html_document
---

***

## Die t-Verteilung

Schreibweise:

$$ X \sim t(k) \quad\text{mit}\quad k \in \mathbb{R}^{>0}$$

Die t-Verteilung ist eine stetige und symmetrische Verteilung mit $k$ *Freiheitsgraden*.
Die Form der t-Verteilung ist nur durch die Anzahl der Freiheitsgrade bestimmt.
Der Erwartungswert und die Varianz sind gegeben durch

$$ \text{E}(X) = 0 \quad\quad \text{Var}\left(\frac{k}{k - 2}\right)\quad\text{für}\quad k > 2 $$

### Dichtefunktion:

$$ f(x) = \frac{\Gamma\left(\frac{k + 1}{2}\right)}{\sqrt{k\pi}\Gamma\left(\frac{k}{2}\right)}
\left( 1 + \frac{x^2}{k} \right)^{- \frac{k + 1}{2}} \quad\text{wobei}\quad
\Gamma(x) = \int^{+\infty}_0 t^{x-1}e^{-t} dt $$

Für $k\to\infty$ strebt die t-Verteilung gegen die Standardnormalverteilung, d.h

$$ t_k \overset{d}{\longrightarrow} NV(0, 1) $$

Faustregel: für $k \geq 30$ kann die t-Verteilung relativ gut durch die
Standardnormalverteilung approximiert werden.

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

> + **=T.VERT**($x$; $k$; *kumuliert*)
+ **=T.VERT.RE**($x$; $k$)
+ **=T.VERT.2S**($x$; $k$)
+ **=T.INV**($p$; $k$)
+ **=T.INV.2S**($p$; $k$;)

Falls 

+ kumuliert = 1: Wert der Verteilungsfunktion (eine Wahrscheinlichkeit)
+ kumuliert = 0: Wert der Dichtefunktion (**keine** Wahrscheinlichkeit)
