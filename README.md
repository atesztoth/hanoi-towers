# Hanoi Towers

Will be formatted later: 🇭🇺

Hanoi tornyai
Ezen házi feladat keretében a Hanoi tornyai problémát kell megoldani. Ez a feladat nagyobb lélegzetvéletű, így akár +/- pontokat is lehet vele szerezni. Összesen 16 pontos a feladatsor, 8 pont ér egy pluszt. Tehát aki megoldja az egészet, az olyan mintha egy +/-t hibátlanra írt volna meg.

A probléma leírása
A Hanoi tornyai problémában három rúd áll rendelkezésünkre (A, B és C), és n darab különböző méretű korongunk, amelyeken eleinte mind az első rúdon helyezkednek el, méret szerint rendezett sorrendben. A legnagyobb korong van legalul, a legkisebb legfelül.

A feladat, hogy az első rúdról (A) átmozgassunk n darab korongot az utolsó rúdra (C), de olyan módon, hogy kisebb korongot kizárólag csak nagyobb korongra tehetünk.

A probléma modellezése Haskell-ben
A Hanoi tornyai problémát a következő módon modellezhetjük Haskell-ben:

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
Néhány megjegyzés az egyes típusokhoz:

Disk: Egy korongot kódol annak méretével.
Rod: Egy rúd állapotát küdolja a rajta lévő korongokkal. A lista első eleme a legfelső korong.
Problem: Magát a problémát kódolja, amely három rúdból áll.
RodID: A rudakat az A, B, C konstansokkal fogjuk azonosítani
Move: Egy korong mozgatását írja le. Az első komponens ahonnan mozgatunk, a második komponens ahova mozgatunk. Mindig a legfelső korongot mozgatjuk a legfelső pozícióra. Egy invariánsa ennek a típusnak, hogy a komponensei mindig külöbözőek, azaz egy korongot egy adott rúdról kizárólag egy másik, tőle különböző rúdra lehet mozgatni (ezt nem kódoljuk el Haskell-ben).
Implementáció
Inicializáció és validáció
initial (1p)
Az első lépés, hogy előállítsuk magát a problémát. Adjuk meg azt a függvényt, amely előállítja az n korongból álló Hanoi tornyai problémát!

initial :: Int -> Problem
validateRod (2p)
Fontos, hogy minden mozgatás helyes legyen, tehát a probléma minden egyes állapotában teljesüljön, hogy kisebb korong kizárólag nagyobb korongon lehet. Adjuk meg azt a függvényt, amely validálja egy rúd állapotát, azaz megállapítja, hogy a rúdon méret szerint szigorúan növekvően helyezkednek el a korongok!

validateRod :: Rod -> Bool
validateProblem (1p)
Adjuk meg azt a függvényt, amely mindhárom rúdat validálja!

validateProblem :: Problem -> Bool
Korongok mozgatása
move (2p)
Adjuk meg azt a függvényt, amely egy rúdról a legfelső korongot egy másik rúd legtetejére mozgat át. Fontos, hogy egy korongot egy adott rúdról kizárólag egy másik, tőle különböző rúdra lehet mozgatni.

move :: RodID -> RodID -> Problem -> Problem
executeMove (1p)
Adjuk meg azt a függvényt, amely végrehajt egy mozgatást egy adott probléma!

executeMove :: Move -> Problem -> Problem
Megjegyzés: Használjuk a move függvényt!

executeMoves (2p)
Adjuk meg azt a függvényt, amely egy végrehajt egy mozgatássorozatot! Ügyeljünk rá, hogy az első mozgatás után már az új problémán kell végrehajtani a következő mozgatást!

executeMoves :: [Move] -> Problem -> Problem
A probléma megoldása
A probléma megoldásának egy mozgatássorozatot tekintünk, melyet végrehajtva egy olyan állapotot kapunk, ahol az utolsó rúdon van az összes korong méret szerint növekvő sorrendben (legkisebb legfelül).

A problémát rekurzívan fogjuk megoldani. Minden esetben lesz egy rúd, amiről szeretnénk mozgatni a korongokat, és lesz egy rúd, amire mozgatni szeretnénk a korongokat. A rúd amit nem használtunk, az a “szabad” rúd, amire pedig mozgatni szeretnénk, az a célrúd. Tekintsük azt az állapotot, amikor n korongot szeretnénk mozgatni a célrúdra.

Az algoritmus a következő:

mozgassunk át n-1 korongot a szabad rúdra
mozgassuk át a maradék 1 korongot a célrúdra
mozgassuk át az n-1 korongot a szabad rúdról a célrúdra
ha 0 korongot kellene mozgatni, akkor hagyjuk helyben a problémát
freeRod (1p)
Adjuk meg azt a függvényt, amely megkapja, hogy melyik rúdról hova szeretnénk mozgatni korongokat, és meghatározza a szabad (harmadik rudat)!

freeRod :: RodID -> RodID -> RodID
moveM (1p)
A mozgatássorozatot a Writer monád segítségével fogjuk generálni. Mindig, amikor mozgatunk egy korongot, akkor logoljuk ezt a mozgatást a tell monadikus függvény használatával. Vezessük be a következő típust:

type SolverM = Writer [Move]
A fenti típusszinonima azt jelenti, hogy egy SolverM a típusú kifejezés egy olyan számítás, amely egy a típusú értékkel tér vissza, és [Move] típusú értékeket képest logolni. Tehát a tell-nek [Move] típusú értékeket tudunk megadni, amiket ő majd összefűz a <>-del.

Adjuk meg azt a függvényt, amely végrehajt egy mozgatást, és logolja magát a mozgatást is!

moveM :: RodID -> RodID -> Problem -> SolverM Problem
Megjegyzés: Használjuk a move függvényt!

moveManyM (4p)
Adjuk meg azt a függvényt, amely átmozgat n korongot az egyik rúdról egy másikra, és közben logolja az összes mozgatást!

moveManyM :: Int -> RodID -> RodID -> Problem -> SolverM Problem
Megjegyzés: Használjuk a moveM függvényt, amelybe már belekódoltuk a logolást!

solve (1p)
Adjuk meg azt a függvényt, amely előállítja egy Hanoi tornyai probléma megoldását!

solve :: Problem -> [Move]
Bónusz
Oldjuk meg a feladatot úgy, hogy egyszerű listák helyett differencialistákat használunk a logolásra! Ehhez szükség lesz a korábban definiált DList típusra és annak a Monoid példányára is. Ez egy újabb pluszt ér.

type SolverM = Writer (DList Move)