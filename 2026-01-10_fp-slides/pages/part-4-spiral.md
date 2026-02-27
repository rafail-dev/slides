# Spiral

---

````md magic-move
```haskell
import Data.List (transpose)

spiral [] = []
spiral (x : xs) = x ++ (spiral . reverse . transpose) xs

main :: IO ()
main = do
  let matrix =
        [
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]
        ]
  print $ spiral matrix
  -- [1, 2, 3, 6, 9, 8, 7, 4, 5]
```

```haskell
import Data.List (transpose)
import Debug.Trace (trace)

spiral [] = []
spiral (x : xs) =
  trace (show x ++ " ++ " ++show xs)
  x ++ (spiral . reverse . transpose) xs

main :: IO ()
main = do
  let matrix =
        [
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]
        ]
  print $ spiral matrix
  -- [1, 2, 3, 6, 9, 8, 7, 4, 5]
```

```haskell
[1,2,3] ++ [[4,5,6],[7,8,9]]
transpose [[4,5,6],[7,8,9]] == [[4,7],[5,8],[6,9]]
reverse [[4,7],[5,8],[6,9]] == [[6,9],[5,8],[4,7]]

[6,9] ++ [[5,8],[4,7]]
[8,7] ++ [[5,4]]
[4] ++ [[5]]
[5] ++ []
```
````
