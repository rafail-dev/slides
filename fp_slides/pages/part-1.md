part 1

# Definition

---
layout: diff
---

# f from f from f ...

Mutate State or Many Results

<template v-slot:left>

```ts
type State = { v: number };

const p = (state: State) => {
  state.v += 1;
};

const state = { v: 0 };

p(state);
p(state);
p(state);
p(state);

// mutated state is result
```

sequence of statements <br /> 🕛 -> 🕐 -> 🕒

</template>

<template v-slot:right>

```ts
type State = { v: number };

const f = (state: State) => ({ v: state.v + 1 });

const state = { v: 0 };

const result = f(f(f(f(state))));

//
//
//
// result is result
//
// state is immutable
```

trees of expressions <br /> 🌲 . 🌳 . 🌴

</template>

---

## FP is ...programs are constructed <br /> by <u>applying</u> and <u>composing</u> functions

<p class="text-muted">that’s all</p>

[wiki](https://en.wikipedia.org/wiki/Functional_programming)

<v-click>

but pure function? 🤔

</v-click>

---

# Pure Functions & Purely FP

like in mathematics: <br /> `summ 4 5 = 9`<br /> `triangleAngles 3 4 5 = 90°, 37°, 53°`
<br />...always

---

# Pure Function Properties

<Badges :colorStartIndex=6 :badges="['Deterministic', 'No Side Effects']" />

<p class="text-muted p-4">consequently ↓</p>

<Badges :badges="['Referential Transparency', '↑ Predictable', '↑ Testable', '↑ Composable', '↑ Cacheable', '↑ Parallelizable', '...']" />

[wiki](https://en.wikipedia.org/wiki/Pure_function)

---

# Pure or Impure?

````md magic-move
```ts
let x = 5

// ???
const f1(v) => v + 5

// ???
const f2(v) => v + x

// ???
const f3(v) => x = 10

// ???
const f4(v) => {
  doRequest( ... )
  return v + 10
}
```

```ts
let x = 5

// pure
const f1(v) => v + 5

// impure
const f2(v) => v + x

// impure
const f3(v) => x = 10

// impure
const f4(v) => {
  doRequest( ... )
  return v + 10
}
```

```ts
// ???
const f5(v) => v + new Date().getSeconds()
```

```ts
// impure
const f5(v) => v + new Date().getSeconds()
```

```ts
// ???
const f6(v) => {
  console.log('hello')
  return v + 10
}
```

```ts
// impure or debug mode
const f6(v) => {
  console.log('hello')
  return v + 10
}
```

```haskell
-- pure
addTen x = x + 10

-- ok, ok 🙆‍♂️
addTen = (+10)
-- (+10) 5 is 15
```

```haskell
import Debug.Trace

-- sorry 😏
addTen x =
  trace ("X is " ++ show x)
  x + 10
```
````

---

# Partial function

Not defined for all inputs

<img class="my-1 mx-auto w-65" src="/partial.png"/>

`🔵 -> 🟣` but `⭐ -> ❓`

`head [1,2,3] = 1` but `head [] = ?`

<p class="text-muted text-xs">⚠️ not to be confused with partially applied functions</p>

---

# Solutions

Narrow the domain or expand the codomain

````md magic-move
```ts
const head = <T>(v: T[]): T => {
  if (v.length == 0) {
    throw new Error("Oops");
  } else {
    return v[0];
  }
};
```

```ts
const head = <T>(v: [T, ...T[]]): T => v[0];
```

```ts
const head = <T>(v: [T, ...T[]]): T => v[0];
```

```ts
const head = <T>(v: T[]): T | undefined => v[0];
```

```ts
// narrow the domain
const head = <T>(v: [T, ...T[]]): T => v[0];

// expand the codomain
const head = <T>(v: T[]): T | undefined => v[0];
```

```haskell
data Box a = Oops | Some a deriving Show

head [] = Oops
head (x:xs) = Some x

-- and... functors? destruct? patterm matching?

```
````

---

# Divergence

infinite loop

```haskell
-- ok 👍
count [] = 0
count (x:xs) = 1 + count xs

-- ok? 🤔
collatzStepCount 1 = 1
collatzStepCount n =
  if even n
    then 1 + collatzStepCount (n `div` 2)
    else 1 + collatzStepCount (n * 3 + 1)
```

`29,88,44,22,11,34,17,52,26,13,40,20,10,5,16,8,4,2,1`

[Collatz conjecture - wiki](https://en.wikipedia.org/wiki/Collatz_conjecture)

---

# Totally & Dependently Typed <br /> Functional Programming

<img class="my-1 mx-auto w-65" src="/totally.png"/>

- recursion operates only upon 'reduced' forms of its arguments
- every function must be a total

<div class="flex gap-4 justify-center">

[Walther recursion - wiki](https://en.wikipedia.org/wiki/Walther_recursion)

[Idris - wiki](<https://en.wikipedia.org/wiki/Idris_(programming_language)>)

[Agda - wiki](<https://en.wikipedia.org/wiki/Agda_(programming_language)>)

</div>

---

# Declarative

Logic of a computation without describing its control flow

```ts
// imperative
state = ...
// ~~ because the time has come
mutate(state)
// ⏰
mutate(state)


// declarative
state1 = ...
// ~~ because state 2 is computed
state3 = f(state2)
// ~~because state 1 is computed
state2 = f(state1)
```

[wiki](https://en.wikipedia.org/wiki/Declarative_programming)

---

# OOP?

<img class="w-30% mx-auto"  src="/fence-and-wall.png"/>

`State.method(arguments) == function(state, arguments)`

---

# Data, calculations & actions

What is what?

<img class="w-30% mx-auto"  src="/dca.png"/>
