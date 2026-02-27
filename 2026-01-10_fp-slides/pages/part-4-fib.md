# Fib - Infinity List

`fib = 0 : 1 : zipWith (+) fib (drop 1 fib)`

<img class="w-70 mx-auto mb-8"  src="/infinity.png"/>

```
take 10 fib
[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
```

---

# 🤔

````md magic-move
```hs
zipWith (+) [1 .. 5] [100 .. ]
-- [101,103,105,107,109]

```

```hs
fib = 0 : 1 : zipWith (+) fib (drop 1 fib)

-- same as ↓
fib = 0 : 1 : zipWith (+) [0, 1] [1]
zipWith (+) [0, 1] [1] == [1]

-- same as ↓
fib = 0 : 1 : 1 : zipWith (+) [0, 1, 1] [1, 1]
zipWith (+) [0, 1, 1] [1, 1] = [1, 2]

-- same as ↓
fib = 0 : 1 : 1 : 2: zipWith (+) [0, 1, 1, 2] [1, 1, 2]
zipWith (+) [0, 1, 1, 2] [1, 1, 2] = [1, 2, 3]

-- etc

```
````
