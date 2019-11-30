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