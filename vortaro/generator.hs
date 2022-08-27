import Control.Monad
import Data.Text (Text)
import Data.List
import qualified Data.Text as T
import qualified Data.Text.IO as I

repList :: Text -> [Text] -> [Text] -> Text
repList t c r = foldl (flip (uncurry T.replace)) t $ zip c r

repHat :: Text -> Text
repHat a = repList a (map T.pack ["cx", "gx", "hx", "jx", "sx", "ux"]) (map T.pack ["ĉ", "ĝ", "ĥ", "ĵ", "ŝ", "ŭ"])

expandWord :: Text -> [Text]
expandWord origion = map (\f -> f origion) $ [e, a, i, is, as, os] ++ nonu ++ malmis ++ igigx
  where
    n f = flip (<>) (T.pack "n") . f
    j f = flip (<>) (T.pack "j") . f
    nonu = [n, j, n . j, id] <*> ([ig, igx, id] <*> [o, ejo])

    mal f = (<>) (T.pack "mal") . f
    mis f = (<>) (T.pack "mis") . f
    malmis = [mal, mis] <*> (nonu ++ [i, is, as, os] ++ igigx)

    ig f t = f $ t <> T.pack "ig"
    igx f t = f $ t <> T.pack "igx"
    igigx = [ig, igx] <*> [i, is, as, os]

    o = flip (<>) $ T.pack "o"
    ejo = flip (<>) $ T.pack "ejo"

    e = flip (<>) $ T.pack "e"
    a = flip (<>) $ T.pack "a"

    i = flip (<>) $ T.pack "i"
    is = flip (<>) $ T.pack "is"
    as = flip (<>) $ T.pack "as"
    os = flip (<>) $ T.pack "os"

convertToDictItem :: Text -> Text
convertToDictItem w = repHat w <> T.pack "\t" <> w

main :: IO ()
main = do
  readFile "vortaro/header.txt" >>= putStrLn
  origion <- T.lines <$> I.readFile "vortaro/origion.txt"
  addition <- T.lines <$> I.readFile "vortaro/addition.txt"
  mapM_ I.putStrLn $ nub $sort $concatMap (map convertToDictItem . expandWord) origion ++ addition