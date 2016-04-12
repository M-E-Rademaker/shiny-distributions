---
output: html_document
---

***

## Die stetige Gleichverteilung

Schreibweise:

$$ X \sim \text{SG}(a, b) \quad\text{mit}\quad a, b \in \mathbb{R}\quad\text{und}\quad a \neq b$$

Die stetige Gleichverteilung hat zwei Verteilungsparameter. Man nennt $a$ die *untere Grenze*
und $b$ die *obere Grenze*. Der Erwartungswert und die Varianz sind

$$ \text{E}(X) = \frac{b + a}{2} \qquad\text{und}\qquad \text{Var}(X) = \frac{(b - a)^2}{12} $$

### Dichtefunktion

Die Dichtefunktion ist gegeben durch:

$$ f(x) = \begin{cases} \frac{1}{b-a} & \text{für}\quad a \leq x \leq b \\\\ 0 & \text{sonst} \end{cases} $$

### Verteilungsfunktion

Die Verteilungsfunktion ist definiert als:

$$ F(x_m) = P(X \leq x_m) = \int^{x}_{-\infty}f(x) = \frac{x-a}{b-a} $$

Der Wert der Verteilungsfunktion gibt an, mit welcher Wahrscheinlichkeit die 
Zufallsvariable $X$ einen Wert kleiner oder gleich $x$ annimmt.

### Quantilsfunktion

Die Quantilsfunktion gibt an, welcher Wert (= Quantil $x_0$) zur Wahrscheinlichkeit
korrespondiert, dass $p\%$ der Beobachtungen unter diesem Wert liegen. Formal ist
die Quantilsfunktion die Umkehrfunktion der Verteilungsfunktion: 

$$ x = F(p)^{-1} = F[P(X \leq x)]^{-1} $$

---

### Excel Befehle

#### Dichte- bzw. Verteilungsfunktion der stetigen Gleichverteilung

+ `=a + (b-a)*ZUFALLSZAHL()`

    + $a$ := Untere Grenze
    + $b$ := Obere Grenze

#### Quantilsfunktion der stetigen Gleichverteilung

+ `=a + (b-a)*p`

    + $p$ := Eine Wahrscheinlichkeit
    + $a$ := Untere Grenze
    + $b$ := Obere Grenze
