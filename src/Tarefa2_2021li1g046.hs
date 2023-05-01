{- |
Module      : Tarefa2_2021li1g046
Description : Construção/Desconstrução do mapa
Copyright   : Diogo Guimarães Pereira <a100748@alunos.uminho.pt>;
            : Tiago Nuno Magalhães Teixeira  <a100665@alunos.uminho.pt>;

Módulo para a realização da Tarefa 2 do projeto de LI1 em 2021/22.
-}
module Tarefa2_2021li1g046 where

import LI12122
import Tarefa1_2021li1g046


import Tarefa1_2021li1g046 

{- | A função 'constroiMapa' que dada uma lista de peças e respetivas coordenadas, váida, constroí um mapa, com a ajuda de uma função auxiliar.
     Definimos a função da seguinte forma:

@
constroiMapa l 
     | validaPotencialMapa l == True = constroiMapa' (0,0) l
     | otherwise = []
@
-}

constroiMapa :: [(Peca, Coordenadas)] -> Mapa
constroiMapa l 
     | validaPotencialMapa l == True = constroiMapa' (0,0) l
     | otherwise = []

{- |
     A função 'constroiMapa'' utiliza coordenadas que percorrem todas as coordenadas deste futuro mapa e verificam se esse elemento existe.
     Se existir a função devolve a peça respetiva a essas coordenadas, se não existir devolve Vazio, e a função continua até ao fim do mapa.

@
constroiMapa' (_,_) [] = []
constroiMapa' (x,y) l | x == (xmax 0 l) +1 && y == ymax 0 l = [[]]
                      | x == (xmax 0 l) +1  = [] : constroiMapa' (0,y+1) l
                      | otherwise = if elem (Bloco,(x,y)) l then (Bloco : r) :rs
                                    else if elem (Porta,(x,y)) l then (Porta : r) :rs
                                         else if elem (Caixa,(x,y)) l then (Caixa : r) :rs
                                              else (Vazio : r) :rs
                                                   where (r:rs) = constroiMapa' (x+1,y) l
@

== Exemplos de utilização
>>> constroimapa [(Bloco, (2,0)),(Porta, (0,1)), (Bloco, (2,1)), (Bloco, (0,2)), (Bloco, (1,2)), (Bloco, (2,2))]
[[Vazio,Vazio,Bloco],[Porta,Vazio,Bloco],[Bloco,Bloco,Bloco]]

-}

constroiMapa' :: Coordenadas -> [(Peca,Coordenadas)] -> Mapa
constroiMapa' (_,_) [] = []
constroiMapa' (x,y) l | x == (xmax 0 l) +1 && y == ymax 0 l = [[]]
                      | x == (xmax 0 l) +1  = [] : constroiMapa' (0,y+1) l
                      | otherwise = if elem (Bloco,(x,y)) l then (Bloco : r) :rs
                                    else if elem (Porta,(x,y)) l then (Porta : r) :rs
                                         else if elem (Caixa,(x,y)) l then (Caixa : r) :rs
                                              else (Vazio : r) :rs
                                                   where (r:rs) = constroiMapa' (x+1,y) l

{- | A função 'desconstroiMapa' é a função inversa à função 'constroiMapa', pois quando recebe um mapa irá retornar uma lista de peças com as respetivas coordenadas,
     com a ajuda de uma função auxiliar.
     Definimos a função da seguinte forma:

@
desconstroiMapa l = desconstroiMapa' l (0,0)
@
-}

desconstroiMapa :: Mapa -> [(Peca,Coordenadas)]
desconstroiMapa l = desconstroiMapa' l (0,0)

{- |
     A funçao auxiliar, 'desconstroiMapa'' utiliza coordenadas que também vão percorrer o mapa.
     Quando a peça é Vazio a função continua, quando nao é a função devolve a peça, com as coordenadas atuais, e continua até ao fim do mapa.

@
desconstroiMapa' ([]:t) (x,y) = desconstroiMapa' t (0,y+1)
desconstroiMapa' [] (x,y) = []
desconstroiMapa' ((h:xs):t) (x,y) = case h of Vazio -> desconstroiMapa' (xs:t) (x+1,y)
                                              Bloco -> (h,(x,y)): desconstroiMapa' (xs:t) (x+1,y) 
                                              Porta -> (h,(x,y)): desconstroiMapa' (xs:t) (x+1,y)
                                              Caixa -> (h,(x,y)): desconstroiMapa' (xs:t) (x+1,y)
@
== Exemplos de utilização
>>> desconstroiMapa [[Vazio,Vazio,Bloco],[Porta,Vazio,Bloco],[Bloco,Bloco,Bloco]]
[(Bloco, (2,0)),(Porta, (0,1)), (Bloco, (2,1)), (Bloco, (0,2)), (Bloco, (1,2)), (Bloco, (2,2))]

-}

desconstroiMapa' :: Mapa -> Coordenadas -> [(Peca, Coordenadas)]
desconstroiMapa' ([]:t) (x,y) = desconstroiMapa' t (0,y+1)
desconstroiMapa' [] (x,y) = []
desconstroiMapa' ((h:xs):t) (x,y) = case h of Vazio -> desconstroiMapa' (xs:t) (x+1,y)
                                              Bloco -> (h,(x,y)): desconstroiMapa' (xs:t) (x+1,y) 
                                              Porta -> (h,(x,y)): desconstroiMapa' (xs:t) (x+1,y)
                                              Caixa -> (h,(x,y)): desconstroiMapa' (xs:t) (x+1,y)