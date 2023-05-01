{- |
Module      : Tarefa5_2021li1gXXX
Description : Aplicação Gráfica

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2021/22.
-}
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Juicy (loadJuicy)

data Figura = 
    Quadrado Int Color 
  | Circulo Int Color 
  | Rectangulo Int Color

data Menu = Save | ModoJogo 
     deriving Eq

type Estado = (Menu, (Float, Float))

janela :: Display
janela = InWindow "blockdude" (800,800) (0,0)

corFundo :: Color
corFundo = black

sair :: Picture
sair = color white (Polygon [(-125,-75),(125,-75),(125,75),(-125,75),(-125,-75)])

novojogo :: Picture
novojogo = color white (Polygon [(-125,-75),(125,-75),(125,75),(-125,75),(-125,-75)])


estadoInicial :: Estado 
estadoInicial = (ModoJogo, (0,0))

estadoSave :: Estado 
estadoSave = (Save, (0,-5))

reageEvento :: Event -> Estado -> Estado
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (Save, (x,y)) = (ModoJogo, (x,y+5))
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (ModoJogo, (x,y)) = (Save, (x,y-5))
{-reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) (x,y) = (x-5,y)
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) (x,y) = (x+5,y)-}
reageEvento _ s = s

desenhaEstado :: Estado -> Picture 
desenhaEstado (_, (x,y)) = Translate x y poligono 
 where 
    poligono :: Picture 
    poligono = Polygon [(0,0),(10,0),(10,10),(0,10),(0,0)] 

figuraToPicture :: Figura -> Picture 
figuraToPicture (Quadrado l c) = Color c $ rectangleSolid (fromIntegral l) (fromIntegral l)
figuraToPicture (Circulo r c) = Color c $ Circle (fromIntegral r)

figurasToPicture :: [Figura] -> Picture 
figurasToPicture l = Pictures $ map figuraToPicture l 

fr :: Int 
fr = 50

reageTempo :: Float -> Estado -> Estado 
reageTempo n (e, (x,y)) = (e,(x,y))


main :: IO ()
main = do 
      novojogo <- loadJuicy "../pictures/novojogo.bmp"
      sair <- loadJuicy "../pictures/sair.bmp"
      play janela 
        corFundo
        fr
        estadoInicial
        desenhaEstado
        reageEvento
        reageTempo
        --(\_ e -> e)
