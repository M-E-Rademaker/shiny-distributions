---
output: html_document
---

***

## Die $\chi^2$-Verteilung

Schreibweise:

$$ X \sim \chi^2(k) \quad\text{mit}\quad k \in \mathbb{R}^{>0} $$

Die $\chi^2$-Verteilung ist eine stetige Verteilung mit $k$ *Freiheitsgraden*. 
Erwartungswert und Varianz sind gegeben durch

$$ \text{E}(X) = k \qquad\text{und}\qquad \text{Var}(X) = 2k $$

### Dichtefunktion

Die Dichtefunktion ist gegeben durch:

$$ f(x) = \begin{cases}
\frac{x^{\frac{k}{2} - 1} \exp{-\frac{x}{2}}}{2^{\frac{k}{2}}\Gamma\left(\frac{k}{2}\right)} & \text{für}\quad x > 0 \\\\
0 & \text{sonst}
\end{cases} $$

wobei $\Gamma(x) = \int^{+\infty}_0 t^{x-1}e^{-t} dt$ die Gammafunktion an der Stelle
$x$ bezeichnet.

Motivieren lässt sich die $\chi^2$-Verteilung alternativ durch die Tatsache, dass eine *Summe
an stochastisch unabhängigen standardnormalverteilten Zufallsvariablen* gerade einer
$\chi^2$ Verteilung mit $k$ Freiheitsgraden folgt. Dabei ist $k$ die Anzahl der Summenglieder. 
Es gilt daher:

$$ \sum^n_{i = 1} z^2_i \sim \chi^2_k \quad\text{mit}\quad z \sim N(0,1) $$

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

#### Dichte- bzw. Verteilungsfunktion der $\chi^2$-Verteilung

+ `=CHIQU.VERT`($x$; $k$; **kumuliert**)

    + $x$ := Ein x-Wert
    + $k$ := Anzahl Zählerfreiheitsgrade
    + kumuliert = 1 := Wert der Verteilungsfunktion (eine Wahrscheinlichkeit)
    + kumuliert = 0 := Wert der Dichtefunktion (keine Wahrscheinlichkeit!)

#### Rechte Endfläche der $\chi^2$-Verteilung

+ `=CHIQU.VERT.RE`($x$; $k$)

    + $x$ := Ein x-Wert
    + $k_1$ := Anzahl Zählerfreiheitsgrade
    + $k_2$ := Anzahl Nennerfreiheitsgrade
    
Die Funktion `CHIQU.VERT.RE` berechnet: $P(X \geq x)$

#### Quantilsfunktion der $\chi^2$-Verteilung

+ `=CHIQU.INV`($p$; $k_1$; $k_2$)

    + $p$ := Eine Wahrscheinlichkeit
    + $k_1$ := Anzahl Zählerfreiheitsgrade
    + $k_2$ := Anzahl Nennerfreiheitsgrade

#### Zweiseitige Quantile der $\chi^2$-Verteilung

+ `=CHIQU.INV.RE`($p$; $k$)

    + $p$ := Eine Wahrscheinlichkeit
    + $k_1$ := Anzahl Zählerfreiheitsgrade
    + $k_2$ := Anzahl Nennerfreiheitsgrade
    
Die Funktion `CHIUQ.INV.RE` berechnet: $x = F[P(X > x)]^{-1} = F[1 - P(X \leq x)]^{-1}$
