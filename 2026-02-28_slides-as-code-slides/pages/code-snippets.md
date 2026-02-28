# Code Snippets

- 🎨 **Syntax highlighting** — powered by Shiki
- 🔦 **Line highlighting** — focus on what matters
- ✨ **Transformations** — Shiki Magic Move animations
- 🔍 **Type information** — TwoSlash hover types & errors
- ✏️ **Monaco editor** — edit code live in the slide
- ▶️ **Execution** — run code directly in the browser

---

# Code Snippets

Lines, Magic Move

````md magic-move
```haskell
-- step 1: explicit recursion
sumList :: [Int] -> Int
sumList []     = 0
sumList (x:xs) = x + sumList xs

main :: IO ()
main = print $ sumList [1..10]  -- 55
```

```haskell {1-3|4-5}
-- step 1: explicit recursion
sumList :: [Int] -> Int
sumList []     = 0
sumList (x:xs) = x + sumList xs

main :: IO ()
main = print $ sumList [1..10]  -- 55
```

```haskell {3}
-- step 2: fold
sumList :: [Int] -> Int
sumList xs = foldr (+) 0 xs

main :: IO ()
main = print $ sumList [1..10]  -- 55
```

```haskell {1-2}
-- step 3: point-free + polymorphic
sumList :: Num a => [a] -> a
sumList = foldr (+) 0

main :: IO ()
main = print $ sumList [1..10]  -- 55
```

```haskell
-- step 3: point-free + polymorphic
sumList :: Num a => [a] -> a
sumList = foldr (+) 0

main :: IO ()
main = print $ sumList [1..10]  -- 55
```
````

---
layout: left
class: text-left
---

# Two Slash

_Hover over any identifier — inline types and errors, powered by TwoSlash_

```ts {all|3|5-7|all} twoslash
const f = <T>(a: [T, ...T[]]) => a[0];

const a = f([]);

const b = f([1, 2, 3]);

const c = f(["a", "b", "c"]);
```

---
layout: ldefaultt
class: text-left
---

# Monaco Editor

Slidev provides built-in Monaco Editor support.

Add `{monaco}` to the code block to turn it into an editor:

```ts {monaco}
import { f } from "./external";

const a = f([]);
```

---
layout: default
class: text-left
---

# Monaco Run

Use `{monaco-run}` to create an editor that can execute the code directly in the slide:

```ts {monaco-run}
import { f } from "./external";

console.log(f([1, 2, 3]));
```
