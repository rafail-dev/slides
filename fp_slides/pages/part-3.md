part 3

# Boxes & Contexts

---

# Haskell Composition

```haskell
f = (+2)
g = (*2)

r1 = f . g
r2 x= f(g(x))
r3 x = f $ g x

r1 10 == r2 10
r2 10 == r3 10
```

---

# Rust Option

`i32` in Box 🗳️

````md magic-move
```rust
fn main() {
    let some_value: Option<i32> = Some(10);
    let none_value: Option<i32> = None;

    match some_value {
        Some(x) => println!("Got: {x}"),
        None => println!("Nothing"),
    }

    if let Some(x) = some_value {
        println!("Value: {x}");
    }

    let x = none_value.unwrap_or(0);
    // 0

    let doubled = some_value.map(|x| x * 2);
    // Some(10)
}

```
````

---

# Functor

<Badges :colorStartIndex=6 :badges="['Identity Law', ' Composition Law']" />

<img class="w-90 mx-auto my-8"  src="/functor.png"/>

$$F(id_A) = id_{F(A)}$$

$$F(g \circ f) = F(g) \circ F(f)$$

---
layout: diff
---

# Functor in Langs

<Badges class="mx-auto mb-10" :badges="['Composition', 'Safety', 'Uniformity', 'Logic Separation']" />

<template v-slot:left>

```rust
// F(id) = id
Some(10).map(|v| v) == Some(10)

None::<i32>.map(|v| v) == None

// F(g ∘ f) = F(g) ∘ F(f)
Some(10).map(|v| v * 2).map(|v| v + 2) == Some(22)
Some(10).map(|v| (v * 2) + 2) == Some(22)

None::<i32>.map(|v| v * 2).map(|v| v + 2) == None
None::<i32>.map(|v| (v * 2) + 2) == None
```

rust
</template>

<template v-slot:right>

```haskell
-- F(id) = id
fmap id (Just 10) == Just 10

fmap id Nothing == Nothing

-- F(g ∘ f) = F(g) ∘ F(f)
fmap (+2) (fmap (*2) (Just 10)) == Just 22
fmap ((+2) . (*2)) (Just 10) == Just 22

fmap (+2) (fmap (*2) Nothing) == Nothing
fmap ((+2) . (*2)) Nothing == Nothing
```

haskell
</template>

---
layout: diff
---

# With Error Information

<template v-slot:left>

```rust
type DivResult = Result<f64, &'static str>;

fn divide(a: i32, b: i32) -> DivResult {
    if b == 0
      { Err("div by zero") }
    else
      { Ok(a as f64 / b as f64) }
}

divide(10, 2);
// Ok(5.0)
divide(10, 0);
// Err("div by zero")
```

</template>

<template v-slot:right>

```haskell
type DivResult = Either String Double

divide :: Int -> Int -> DivResult
divide _ 0 = Left "div by zero"
divide a b =
  Right (fromIntegral a / fromIntegral b)

divide 10 2
-- Right 5.0

divide 10 0
-- Left "div by zero"
```

</template>

---

# Try Catch?

<Badges class="mx-auto mb-10" :colorStartIndex=5 :badges="['Errors are invisible in signature', 'Can forget to handle', 'Breaks control flow', 'Requires mutable state', 'Goto?', 'Stack?']" />

```ts
let result1;

try {
  result1 = someWithError(); // mutate

  // code
  // ...
  // code
} catch (e: unknown) {
  // as "goto"?
  // do someting
}

// need try? 🤷
let result2 = someFunction();
```

---
layout: diff
---

# Monadic binding

`Functor + pure + bind`

<template v-slot:left>

```rust
fn f() -> Result<(), Box<dyn Error>> {
    let greeting_file = File::open("1.txt")?;

    let another = File::open("2.txt")?;

    Ok(())
}

// or

 File::open("1.txt")
  .and_then(|a| File::open("2.txt"))
  .map(|_| ())

```

 </template>

 <template v-slot:right>

```haskell
fIO :: IO (Either IOException ())
fIO = try $ do
    a <- openFile "1.txt" ReadMode
    b <- openFile "2.txt" ReadMode
    pure ()

-- or

fIO' :: IO (Either IOException ())
fIO' = try $
    openFile "1.txt" ReadMode
    >> openFile "2.txt" ReadMode
    >> pure ()
```

 </template>
