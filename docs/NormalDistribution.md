---
output: html_document
---
***
### Die Normalverteilung

Schreibweise:

$$ X \sim N(\mu, \sigma^2)$$

Die Normalverteilung ist eine stetige Verteilung mit $\text{E}(X) = \mu$ und 
$\text{Var}(X) = \sigma^2$.

#### Dichtefunktion

$$ f(x) = \frac{1}{\sqrt{2\pi\sigma}}e^{-\frac{1}{2}\frac{(x - \mu)^2}{\sigma^2}} $$

#### Verteilungsfunktion

$$ F(x) = P(X \leq x) = \int^{+\infty}_{-\infty}f(x) dx $$