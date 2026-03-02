part 2

# Collections

---

# HOF & FCF

<div class="flex gap-8">

[Higher Order Function - wiki](https://en.wikipedia.org/wiki/Higher-order_function)

[First Class Function - wiki](https://en.wikipedia.org/wiki/First-class_function)

</div>

````md magic-move
```ts
const withLog = <I, R>(f: (v: I) => R) => {
  console.log(f.name);
  return f;
};

const addTen = (n: number) => n + 10;
console.log(withLog(addTen)(5));
// addTen
// 15
```

```ts
const withLog =
  <A extends unknown[], R>(fn: (...args: A) => R) =>
  (...args: A): R => {
    console.log(fn.name);
    return fn(...args);
  };

const addTen = (v: number) => v + 10;
const addTenLogged = withLog(addTen);
console.log(addTenLogged(5));
// addTen
// 15
```

```ts
const withLog =
  <A extends unknown[], R>(fn: (...args: A) => R) =>
  (...args: A): R => (console.log(fn.name), fn(...args));

const addTen = (v: number) => v + 10;
const addTenLogged = withLog(addTen);
console.log(addTenLogged(5));
// addTen
// 15
```

```ts
const pipe =
  <T>(...fns: ((v: T) => T)[]) =>
  (v: T) =>
    fns.reduce((result, fn) => fn(result), v);

const increment = (x: number) => x + 1;
const triple = (x: number) => x * 3;
const halve = (x: number) => x / 2;

const transform = pipe(increment, triple, halve);

console.log(transform(10));
```
````

---
layout: diff
---

# Currying

All functions in Haskell are curried by default

<template v-slot:left>

```haskell
add :: Int -> Int -> Int
add x y = x + y

add' :: Int -> Int -> Int
add' = (+)

-- partial application
add3 = add 3

add3 5 == 8
```

</template>

<template v-slot:right>

```typescript
const add = (a: number) => (b: number) => a + b;

// partial application
const add3 = add(3);

add3(5) === 8;
```

</template>

---

# TS Arrays

<Badges class="mb-6" :badges="['Intention', 'Expression', 'Mutation', 'Straightforwardly', 'Chaining']" />

````md magic-move
```ts
const arr = ["a", "b", "c"];

for (let i = 0; i < arr.length; i++) {
  // do something
}

for (const [i, value] of arr.entries()) {
  // do something
}

const newArr = ["a"];
arr.forEach((value, i) => {
  // do something and
  newArr.push("!");
});
```

```ts
const arr = ["a", "b", "c"];

const newArr1 = arr.map((item) => `${item}!`);

const newArr2 = arr.filter((item) => item !== "b");

const newArr3 = arr.reduce((result, item) => `${item}${result}`);

const result1 = arr.some((item) => item === "a");

const result2 = arr.every((item) => item === "a");
```

```ts
const arr = ["a", "b", "c"];

const result = arr
  .filter((item) => item !== "b")
  .map((item) => item.charCodeAt(0))
  .reduce((sum, code) => sum + code, 0);
```

```ts{1,7}
const charCodeAt = (s: string) => s.charCodeAt(0)

const arr = ['a', 'b', 'c']

const result = arr
  .filter((item) => item !== 'b')
  .map(charCodeAt))
  .reduce((sum, code) => sum + code, 0)

```
````

---

# RS Arrays

```rust
let arr = vec![1, 2, 3, 4, 5];

let doubled: Vec<_> = arr.iter().map(|x| x * 2).collect();

let evens: Vec<_> = arr.iter().filter(|x| *x % 2 == 0).collect();

// reduce (fold)
let sum: i32 = arr.iter().fold(0, |acc, x| acc + x);

let result: i32 = arr.iter()
    .filter(|x| *x % 2 == 0)
    .map(|x| x * 10)
    .sum();
```

---

# Haskell Lists

<img class="w-30% mx-auto"  src="/hs-lists.png"/>

`[1,2,3] == 1 : [2,3]`

`[2,3] == 2 : [3]`

`[3] == 3 : []`

`[1,2] == [1] ++ [2]`

---

# HS Lists Primitives

Pattern Matching

````md magic-move
```hs
myDropOne [] = []
myDropOne (_:xs) = xs
```

```hs
myDrop _ [] = []
myDrop 0 xs = xs
myDrop n (x:xs) = myDrop (n - 1) xs
```

```hs
myReverse [] = ???
myReverse (x:xs) = ???
```

```hs
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]
```

```haskell
myFilter _ [] = []
myFilter predicate (x:xs) =
  if predicate x
    then x : myFilter predicate xs
    else myFilter predicate xs

-- myFilter (>3) [1 .. 10]
```

```haskell
myFilter _ [] = []
myFilter predicate (x:xs) =
  [x | predicate x] ++ myFilter predicate xs

-- myFilter (>3) [1 .. 10]
```

```haskell
myMap _ [] = ???
myMap f (x:xs) = ???

-- myMap (*2) [1 .. 10]
```

```haskell
myMap _ [] = []
myMap f (x:xs) = (f x) : myMap f xs

-- myMap (*2) [1 .. 10]
```
````

---

# HS Folds

````md magic-move
```haskell
myFoldl f init [] = init
myFoldl f init (x : xs) = myFoldl f (f init x) xs

myFoldl' f init [] = trace "reached base case" init
myFoldl' f init (x : xs) =
  let acc = (f init x)
  in trace (show init ++ "-" ++ show x) myFoldl' f acc xs

-- myFoldl (-) 0 [1..5]
{-
   0  - 1
  -1  - 2
  -3  - 3
  -6  - 4
  -10 - 5
  -15
-}
```

```haskell
myFoldr f init [] = init
myFoldr f init (x : xs) = f x (myFoldr f init xs)

myFoldr' f init [] = trace "reached base case" init
myFoldr' f init (x : xs) =
  let acc = myFoldr' f init xs
  in trace (show x ++ "-" ++ show acc) (f x acc)

-- myFoldr (-) 0 [1..5]
{-
  5 -  0
  4 -  5
  3 - -1
  2 -  4
  1 - -2
  3
-}

```
````

---

# HS Infinity Lazy Lists

`fromOneToFive = [1 .. 5]`

`infinity = [1 .. ]`

`firstTen = take 10 [1 .. ]`

`harmonic = map (1 /) [1 ..]`

[harmonic sequence - wiki](<https://en.wikipedia.org/wiki/Harmonic_progression_(mathematics)>)
