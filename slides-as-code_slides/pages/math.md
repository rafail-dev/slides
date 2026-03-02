# Proof by Induction

$$\sum_{k=1}^{n} \frac{1}{k(k+1)} = \frac{n}{n+1}$$

_KaTeX: `$$...$$` block math_

---

# Base Case: $n = 1$

$$
{1|2|3}
\begin{aligned}
\frac{1}{1 \cdot 2} &= \frac{1}{1+1} \\
&= \frac{1}{2} \\
&= \frac{1}{2} \quad \checkmark
\end{aligned}
$$

_KaTeX: `{1|2|3}` line highlighting in math blocks_

---

# Inductive Step

**Assume** for $n = k$, **show** for $n = k+1$.

Add $\frac{1}{(k+1)(k+2)}$ to both sides:

$$
{1|2|3}
\begin{aligned}
\sum_{i=1}^{k} \frac{1}{i(i+1)} + \frac{1}{(k+1)(k+2)}
  &= \frac{k}{k+1} + \frac{1}{(k+1)(k+2)} \\
  &= \frac{k(k+2)+1}{(k+1)(k+2)} \\
  &= \frac{(k+1)^2}{(k+1)(k+2)} = \frac{k+1}{k+2} \quad \checkmark
\end{aligned}
$$

_KaTeX: `$...$` inline math + `{1|2|3}` line highlighting_

---

# Conclusion

By the principle of mathematical induction, the formula

$$\sum_{i=1}^{n} \frac{1}{i(i+1)} = \frac{n}{n+1}$$

holds for all $n \geq 1$.

$\blacksquare$

_KaTeX: `$\blacksquare$` inline math_
