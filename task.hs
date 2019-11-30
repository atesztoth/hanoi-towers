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

validateRod :: Problem -> Bool
validateRod (r1, r2, r3) = foldl (\a -> \b -> a && b) True [valid r1, valid r2, valid r3] where
  valid :: Rod -> Bool
  valid [] = True
  valid [x] = True
  valid (x:y:xs) = x < y && valid xs

-- moving a disk from one rod to another one (first tought dummy solution, Need For Time™ ......)
move :: RodID -> RodID -> Problem -> Problem
move A B (a, b, c) = (tail a, (head a):b, c)
move A C (a, b, c) = (tail a, b, (head a):c)
move B A (a, b, c) = ((head b):a, tail b, c)
move B C (a, b, c) = (a, tail b, (head b):c)
move C A (a, b, c) = ((head c):a, b, tail c)
move C B (a, b, c) = (a, (head c):b, tail c)
move _ _ (a, b, c) = (a, b, c)

executeMoves :: [Move] -> Problem -> Problem
executeMoves moves p = undefined