{- |
Module      : Tarefa3_2021li1g046
Description : Representação textual do jogo
Copyright   : Diogo Guimarães Pereira <a100748@alunos.uminho.pt>;
            : Tiago Nuno Magalhães Teixeira  <a100665@alunos.uminho.pt>;

Módulo para a realização da Tarefa 3 do projeto de LI1 em 2021/22.
-}
module Tarefa3_2021li1g046 where

import LI12122

instance Show Jogo where
  show (Jogo l (Jogador (x,y) dir c)) = representaJogo l (x,y) dir c (0,0)

{- | A função 'representaJogo' tem como objetivo tornar o tipo de dados Jogo em uma 'String' (instância de classe Show), que dependendo 
     das peças do 'Mapa' e do 'Jogador',  terá uma determinada representação textual. 
     
     Definimo-la da seguinte forma:

@
representaJogo ([]:t) (x1,y1) dir c (x2,y2) = if null t then "" else "\n" ++  representaJogo t (x1,y1) dir c (0,y2+1)
representaJogo (h:t) (x1,y1) dir c (x2,y2) 
                                        | x1 == x2 && y1 == y2 = if dir == Este then ">" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                                                 else "<" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2) 
                                        | x1 == x2 && (y1-1) == y2 = if c == True then "C" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                                                     else " " ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                        | otherwise = case head h of Vazio -> " " ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                                                     Porta -> "P" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                                                     Bloco -> "X" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                                                     Caixa -> "C" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
@

== Exemplos de utilização:
>>> Jogo [[Vazio,Vazio,Vazio,Bloco],[Vazio,Vazio,Vazio,Bloco],[Porta,Vazio,Caixa,Bloco],[Bloco,Bloco,Bloco,Bloco]] (Jogador (2,1) Oeste False)
"
    X
   <X
 P CX
 XXXX"
>>> Jogo [[Bloco,Vazio,Vazio,Vazio],[Bloco,Vazio,Vazio,Vazio],[Bloco,Vazio,Vazio,Porta],[Bloco,Bloco,Bloco,Bloco]] (Jogador (1,2) Este True)
"
 X
 XC
 X> P
 XXXX"
-}

representaJogo :: Mapa -> Coordenadas -> Direcao -> Bool -> (Int,Int) -> String
representaJogo ([]:t) (x1,y1) dir c (x2,y2) = if null t then "" else "\n" ++  representaJogo t (x1,y1) dir c (0,y2+1)
representaJogo (h:t) (x1,y1) dir c (x2,y2) 
                                        | x1 == x2 && y1 == y2 = if dir == Este then ">" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                                                 else "<" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2) 
                                        | x1 == x2 && (y1-1) == y2 = if c == True then "C" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                                                     else " " ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                        | otherwise = case head h of Vazio -> " " ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                                                     Porta -> "P" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                                                     Bloco -> "X" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)
                                                                     Caixa -> "C" ++ representaJogo ((tail h):t) (x1,y1) dir c (x2+1,y2)