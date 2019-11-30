module Hanoi where

-- Disks of different sizes
type Disk = Int
-- A rod can have several disks on it
type Rod  = [Disk]
-- A Hanoi problem consists of three rods
type Problem = (Rod, Rod, Rod)
-- Identifier for the rods
data RodID = A | B | C
  deriving (Eq, Ord, Show)
-- Move the topmost disk from one rod to another
type Move = (RodID, RodID)

initial :: Int -> Problem
initial n = ([1..n], [], [])

validateRod :: Rod -> Bool
validateRod [] = True
validateRod [x] = True
validateRod (x:y:xs) = x < y && validateRod xs

validateProblem :: Problem -> Bool
validateProblem (r1, r2, r3) = foldl (\a -> \b -> a && b) True [validateRod r1, validateRod r2, validateRod r3]

-- moving a disk from one rod to another one (first tought dummy solution, Need For Time™ ......)
move :: RodID -> RodID -> Problem -> Problem
move A B (a, b, c) = (tail a, (head a):b, c)
move A C (a, b, c) = (tail a, b, (head a):c)
move B A (a, b, c) = ((head b):a, tail b, c)
move B C (a, b, c) = (a, tail b, (head b):c)
move C A (a, b, c) = ((head c):a, b, tail c)
move C B (a, b, c) = (a, (head c):b, tail c)
move _ _ (a, b, c) = (a, b, c)

executeMove :: Move -> Problem -> Problem
executeMove (r1, r2) p = move r1 r2 p

executeMoves :: [Move] -> Problem -> Problem
executeMoves [] p = p
executeMoves ((r1, r2):xs) p = executeMoves xs (executeMove (r1, r2) p)

-- helper
substractFromList :: (Eq a) => a -> [a] -> [a]
substractFromList y [x] = if y == x then [] else [x]
substractFromList y (x:xs) = substractFromList y [x] ++ substractFromList y xs

freeRod :: RodID -> RodID -> RodID
freeRod r1 r2 = head $ substractFromList r1 (substractFromList r2 [A, B, C])