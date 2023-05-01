{- |
Module      : Tarefa4_2021li1g046
Description : Movimentação do personagem
Copyright   : Diogo Guimarães Pereira <a100748@alunos.uminho.pt>;
            : Tiago Nuno Magalhães Teixeira  <a100665@alunos.uminho.pt>;

Módulo para a realização da Tarefa 4 do projeto de LI1 em 2021/22.
-}
module Tarefa4_2021li1g046 where

import LI12122

import Tarefa1_2021li1g046
import Tarefa2_2021li1g046
import Tarefa3_2021li1g046

{- | A função 'moveJogador' recebe um Jogo, com um determinado mapa e Jogador a aplica o efeito de um comando, isto é, 
     um movimento sobre o Jogador e devolve o Jogo com esse movimento aplicado. Dependendo do movimento, a função 'moveJoador' aplica uma de quatro funções auxiliares diferentes.
     Além disso, como a função 'moveJogador' recebe um mapa, utilizamos a função 'desconstroiMapa' da Tarefa 2 para podermos trabalhar com as 
     coordenadas das peças e do 'Jogador'.

     Assim, definimos a função da seguinte forma: 

@
moveJogador (Jogo l (Jogador (x,y) dir c)) mov = case mov of AndarEsquerda -> esquerdaJogador (desconstroiMapa l) (Jogador (x,y) dir c)
                                                             AndarDireita -> direitaJogador (desconstroiMapa l) (Jogador (x,y) dir c)
                                                             Trepar -> trepaJogador (desconstroiMapa l) (Jogador (x,y) dir c)
                                                             InterageCaixa -> caixaJogador (desconstroiMapa l) (Jogador (x,y) dir c)
@
-}

moveJogador :: Jogo -> Movimento -> Jogo
moveJogador (Jogo l (Jogador (x,y) dir c)) mov = case mov of AndarEsquerda -> esquerdaJogador (desconstroiMapa l) (Jogador (x,y) dir c)
                                                             AndarDireita -> direitaJogador (desconstroiMapa l) (Jogador (x,y) dir c)
                                                             Trepar -> trepaJogador (desconstroiMapa l) (Jogador (x,y) dir c)
                                                             InterageCaixa -> caixaJogador (desconstroiMapa l) (Jogador (x,y) dir c)

{- | A função 'correrMovimentos' é semelhante à anterior, pois em vez de receber apenas um movimento, esta recebe uma lista de movimentos.
     Sabendo isto, definimos a função da seguinte forma:

@
correrMovimentos jogo [] = jogo
correrMovimentos jogo (h:t) = correrMovimentos (moveJogador jogo h) t
@

-}

correrMovimentos :: Jogo -> [Movimento] -> Jogo
correrMovimentos jogo [] = jogo
correrMovimentos jogo (h:t) = correrMovimentos (moveJogador jogo h) t

{- | A função 'ymin' é uma função auxiliar utilizada nas funções 'esquerdaJogador' e 'direitaJogador' e vai determinar
     para uma dada abcissa e ordenada o próximo 'Bloco' ou 'Caixa', nessa abcissa, que se encontra abaixo dessa ordenada.

@
ymin x y ac l = if elem (Caixa,(x,y+ac)) l || elem (Bloco,(x,y+ac)) l then y+ac-1 else ymin x y (ac+1) l
@

== Exemplos de utilização
>>> ymin 1 0 1 [(Bloco, (0,2)), (Porta, (0,1)), (Bloco, (2,1)), (Bloco, (0,2)), (Bloco, (1,2)), (Bloco, (2,2))]
2

-}

ymin :: Int -> Int -> Int -> [(Peca,Coordenadas)] -> Int
ymin x y ac l = if elem (Caixa,(x,y+ac)) l || elem (Bloco,(x,y+ac)) l then y+ac-1 else ymin x y (ac+1) l

{- | A função auxiliar 'esquerdaJogador' tem como objetivo mover o jogador para a esquerda. No entanto, é necessário ter em conta todos os casos em que o Jogador não pode avançar, sendo estes:

     * Quando o 'Jogador' carrega uma 'Caixa' e existe um 'Bloco' à esquerda dessa 'Caixa';

     * Quando o 'Jogador' se encontra no x = 0;

     * Quando existe um 'Bloco' ou 'Caixa' à esquerda do 'Jogador';

     Definimos também para quando existe uma "queda" à esquerda do 'Jogador'

     Tendo em conta as condições, definimos a função da seguinte forma:

@
esquerdaJogador l (Jogador (x,y) dir c) = case c of True -> if (elem (Caixa,(x-1,y)) l || elem (Bloco,(x-1,y)) l) then Jogo (constroiMapa l) (Jogador (x,y) Oeste c)
                                                            else if (elem (Caixa,(x-1,y+1)) l || elem (Bloco,(x-1,y+1)) l) then Jogo (constroiMapa l) (Jogador (x-1,y) Oeste c)
                                                                 else if (elem (Bloco,(x-1,y-1)) l) then Jogo (constroiMapa l) (Jogador (x,y) Oeste c)
                                                                      else if x == 0 then Jogo (constroiMapa l) (Jogador (x,y) Oeste c)
                                                                           else Jogo (constroiMapa l) (Jogador (x-1,(ymin (x-1) y 1 l)) Oeste c)
                                                    
                                                    False -> if elem (Caixa,(x-1,y)) l || elem (Bloco,(x-1,y)) l then Jogo (constroiMapa l) (Jogador (x,y) Oeste c)
                                                             else if elem (Caixa,(x-1,y+1)) l || elem (Bloco,(x-1,y+1)) l then Jogo (constroiMapa l) (Jogador (x-1,y) Oeste c)
                                                                  else if x == 0 then Jogo (constroiMapa l) (Jogador (x,y) Oeste c)
                                                                       else Jogo (constroiMapa l) (Jogador (x-1,(ymin (x-1) y 1 l)) Oeste c)
@

== Exemplos de utilização
>>> esquerdaJogador ([(Bloco, (3,1)), (Porta, (0,2)), (Bloco, (3,2)), (Bloco, (0,3)), (Bloco, (1,3)), (Bloco, (2,3)), (Bloco, (3,3))] (Jogador (3,0) Este False))
"
    X
 P <X
 XXXX
"

-}

esquerdaJogador :: [(Peca,Coordenadas)] -> Jogador -> Jogo
esquerdaJogador l (Jogador (x,y) dir c) = case c of True -> if (elem (Caixa,(x-1,y)) l || elem (Bloco,(x-1,y)) l) then Jogo (constroiMapa l) (Jogador (x,y) Oeste c)
                                                            else if (elem (Caixa,(x-1,y+1)) l || elem (Bloco,(x-1,y+1)) l) then Jogo (constroiMapa l) (Jogador (x-1,y) Oeste c)
                                                                 else if (elem (Bloco,(x-1,y-1)) l) then Jogo (constroiMapa l) (Jogador (x,y) Oeste c)
                                                                      else if x == 0 then Jogo (constroiMapa l) (Jogador (x,y) Oeste c)
                                                                           else Jogo (constroiMapa l) (Jogador (x-1,(ymin (x-1) y 1 l)) Oeste c)
                                                    
                                                    False -> if elem (Caixa,(x-1,y)) l || elem (Bloco,(x-1,y)) l then Jogo (constroiMapa l) (Jogador (x,y) Oeste c)
                                                             else if elem (Caixa,(x-1,y+1)) l || elem (Bloco,(x-1,y+1)) l then Jogo (constroiMapa l) (Jogador (x-1,y) Oeste c)
                                                                  else if x == 0 then Jogo (constroiMapa l) (Jogador (x,y) Oeste c)
                                                                       else Jogo (constroiMapa l) (Jogador (x-1,(ymin (x-1) y 1 l)) Oeste c)

{- | A função 'direitaJogador' é semelhante à função 'esquedaJogador', tendo o propósito de avançar no eixo das abcissas. Também é necessário ter em conta 
     todas as condições em que o 'Jogador' não pode avançar:

     * Quando o 'Jogador' carrega uma 'Caixa' e existe um 'Bloco' à direita dessa 'Caixa';

     * Quando o 'Jogador' se encontra no x = xmax desse 'Mapa';

     * Quando existe um 'Bloco' ou 'Caixa' à direita do 'Jogador';

     Definimos também para quando existe uma "queda" à direita do 'Jogador'.

     Tendo em conta as condições, definimos a função da seguinte forma:

@
direitaJogador l (Jogador (x,y) dir c) = case c of True -> if elem (Caixa,(x+1,y)) l || elem (Bloco,(x+1,y)) l then Jogo (constroiMapa l) (Jogador (x,y) Este c)
                                                           else if elem (Caixa,(x+1,y+1)) l || elem (Bloco,(x+1,y+1)) l then Jogo (constroiMapa l) (Jogador (x+1,y) Este c)
                                                                 else if elem (Bloco,(x+1,y-1)) l then Jogo (constroiMapa l) (Jogador (x,y) Este c)
                                                                      else if x == (xmax 0 l) then Jogo (constroiMapa l) (Jogador (x,y) Este c)
                                                                           else Jogo (constroiMapa l) (Jogador (x+1, (ymin (x+1) y 1 l)) Este c) 
                                                   
                                                   False -> if elem (Caixa,(x+1,y)) l || elem (Bloco,(x+1,y)) l then Jogo (constroiMapa l) (Jogador (x,y) Este c)
                                                            else if elem (Caixa,(x+1,y+1)) l || elem (Bloco,(x+1,y+1)) l then Jogo (constroiMapa l) (Jogador (x+1,y) Este c)
                                                                 else if x == (xmax 0 l) then Jogo (constroiMapa l) (Jogador (x,y) Este c)
                                                                      else Jogo (constroiMapa l) (Jogador (x+1,(ymin (x+1) y 1 l)) Este c)
@

== Exemplos de utilização 
>>> direitaJogador ([(Bloco, (0,1)), (Bloco, (0,2)), (Porta, (3,2)), (Bloco, (0,3)), (Bloco, (1,3)), (Bloco, (2,3)), (Bloco, (3,3))] (Jogador (0,0) Este False))
"
 X
 X> P
 XXXX
"
-}

direitaJogador :: [(Peca,Coordenadas)] -> Jogador -> Jogo
direitaJogador l (Jogador (x,y) dir c) = case c of True -> if elem (Caixa,(x+1,y)) l || elem (Bloco,(x+1,y)) l then Jogo (constroiMapa l) (Jogador (x,y) Este c)
                                                           else if elem (Caixa,(x+1,y+1)) l || elem (Bloco,(x+1,y+1)) l then Jogo (constroiMapa l) (Jogador (x+1,y) Este c)
                                                                 else if elem (Bloco,(x+1,y-1)) l then Jogo (constroiMapa l) (Jogador (x,y) Este c)
                                                                      else if x == (xmax 0 l) then Jogo (constroiMapa l) (Jogador (x,y) Este c)
                                                                           else Jogo (constroiMapa l) (Jogador (x+1, (ymin (x+1) y 1 l)) Este c) 
                                                   
                                                   False -> if elem (Caixa,(x+1,y)) l || elem (Bloco,(x+1,y)) l then Jogo (constroiMapa l) (Jogador (x,y) Este c)
                                                            else if elem (Caixa,(x+1,y+1)) l || elem (Bloco,(x+1,y+1)) l then Jogo (constroiMapa l) (Jogador (x+1,y) Este c)
                                                                 else if x == (xmax 0 l) then Jogo (constroiMapa l) (Jogador (x,y) Este c)
                                                                      else Jogo (constroiMapa l) (Jogador (x+1,(ymin (x+1) y 1 l)) Este c)

{- | A função 'trepaJogador' vai verificar se o 'Jogador' pode trepar o 'Bloco' ou a 'Caixa' que se encontra à sua frente, se conseguir o 'Jogador' trepa esse 'Bloco' ou 'Caixa'.  
     Assim como as funções 'esquerdaJogador' e 'direitaJogador' é necessário enunciar as condições em que o 'Jogador' não pode trepar:

     * Quando o 'Jogador' se encontra na direção oposta ao 'Bloco' ou 'Caixa', isto é, se o 'Jogador' estiver direcionado para 'Este' e o 'Bloco' que pretende subir está à sua esquerda;

     * Quando o 'Jogador' carrega uma 'Caixa' e acima do 'Bloco' ou 'Caixa' que pretende subir, só existe espaço para o 'Jogador' e não para a 'Caixa';

     * Quando o 'Jogador' pretende subir um 'Bloco' ou 'Caixa' e acima deste existe outro 'Bloco' ou 'Caixa'

     Tendo em conta as condições definimos a função da seguinte forma:

@
trepaJogador l (Jogador (x,y) dir c) 
                    | dir == Este = case c of True -> if (elem (Bloco, (x+1,y)) l || elem (Caixa, (x+1,y)) l) && (elem (Bloco, (x+1,y-1)) l || elem (Caixa, (x+1,y-1)) l)
                                                      then Jogo (constroiMapa l) (Jogador (x,y) dir c) 
                                                      else if elem (Bloco, (x+1,y)) l || elem (Caixa, (x+1,y)) l then Jogo (constroiMapa l) (Jogador (x+1,y-1) dir c)
                                                           else if (elem (Bloco, (x+1,y)) l || elem (Caixa, (x+1,y)) l) && (elem (Bloco, (x+1,y-2)) l || elem (Caixa, (x+1,y-2)) l)
                                                                then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                else Jogo (constroiMapa l) (Jogador (x,y) dir c)

                                              False -> if (elem (Bloco, (x+1,y)) l || elem (Caixa, (x+1,y)) l) && (elem (Bloco, (x+1,y-1)) l || elem (Caixa, (x+1,y-1)) l)
                                                       then Jogo (constroiMapa l) (Jogador (x,y) dir c) 
                                                       else if elem (Bloco, (x+1,y)) l || elem (Caixa, (x+1,y)) l then Jogo (constroiMapa l) (Jogador (x+1,y-1) dir c)
                                                            else Jogo (constroiMapa l) (Jogador (x,y) dir c)

                    | dir == Oeste = case c of True -> if (elem (Bloco, (x-1,y)) l || elem (Caixa, (x-1,y)) l) && (elem (Bloco, (x-1,y-1)) l || elem (Caixa, (x-1,y-1)) l)
                                                       then Jogo (constroiMapa l) (Jogador (x,y) dir c) 
                                                       else if elem (Bloco, (x-1,y)) l || elem (Caixa, (x-1,y)) l then Jogo (constroiMapa l) (Jogador (x-1,y-1) dir c)
                                                            else if (elem (Bloco, (x-1,y)) l || elem (Caixa, (x-1,y)) l) && (elem (Bloco, (x-1,y-2)) l || elem (Caixa, (x+1,y-2)) l)
                                                                 then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                 else Jogo (constroiMapa l) (Jogador (x,y) dir c)

                                               False -> if (elem (Bloco, (x-1,y)) l || elem (Caixa, (x-1,y)) l) && (elem (Bloco, (x-1,y-1)) l || elem (Caixa, (x-1,y-1)) l)
                                                        then Jogo (constroiMapa l) (Jogador (x,y) dir c) 
                                                        else if elem (Bloco, (x-1,y)) l || elem (Caixa, (x-1,y)) l then Jogo (constroiMapa l) (Jogador (x-1,y-1) dir c)
                                                             else Jogo (constroiMapa l) (Jogador (x,y) dir c)
@

== Exemplos de utilização
>>> trepaJogador [(Bloco, (0,0)),(Bloco, (0,1)), (Bloco, (0,2)), (Caixa, (2,2)), (Porta, (4,2)), (Bloco, (0,3)), (Bloco, (1,3)), (Bloco, (2,3)), (Bloco, (3,3)), (Bloco, (4,3))] (Jogador (1,2) Este False)
"
 X
 X >
 X C P
 XXXXX"
>>> trepaJogador [(Bloco, (0,0)),(Bloco, (0,1)), (Bloco, (0,2)), (Caixa, (2,2)), (Porta, (4,2)), (Bloco, (0,3)), (Bloco, (1,3)), (Bloco, (2,3)), (Bloco, (3,3)), (Bloco, (4,3))] (Jogador (1,2) Oeste False) 
"
 X
 X 
 X>C P
 XXXXX
"
-}

trepaJogador :: [(Peca,Coordenadas)] -> Jogador -> Jogo
trepaJogador l (Jogador (x,y) dir c) 
                    | dir == Este = case c of True -> if (elem (Bloco, (x+1,y)) l || elem (Caixa, (x+1,y)) l) && (elem (Bloco, (x+1,y-1)) l || elem (Caixa, (x+1,y-1)) l)
                                                      then Jogo (constroiMapa l) (Jogador (x,y) dir c) 
                                                      else if elem (Bloco, (x+1,y)) l || elem (Caixa, (x+1,y)) l then Jogo (constroiMapa l) (Jogador (x+1,y-1) dir c)
                                                           else if (elem (Bloco, (x+1,y)) l || elem (Caixa, (x+1,y)) l) && (elem (Bloco, (x+1,y-2)) l || elem (Caixa, (x+1,y-2)) l)
                                                                then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                else Jogo (constroiMapa l) (Jogador (x,y) dir c)

                                              False -> if (elem (Bloco, (x+1,y)) l || elem (Caixa, (x+1,y)) l) && (elem (Bloco, (x+1,y-1)) l || elem (Caixa, (x+1,y-1)) l)
                                                       then Jogo (constroiMapa l) (Jogador (x,y) dir c) 
                                                       else if elem (Bloco, (x+1,y)) l || elem (Caixa, (x+1,y)) l then Jogo (constroiMapa l) (Jogador (x+1,y-1) dir c)
                                                            else Jogo (constroiMapa l) (Jogador (x,y) dir c)

                    | dir == Oeste = case c of True -> if (elem (Bloco, (x-1,y)) l || elem (Caixa, (x-1,y)) l) && (elem (Bloco, (x-1,y-1)) l || elem (Caixa, (x-1,y-1)) l)
                                                       then Jogo (constroiMapa l) (Jogador (x,y) dir c) 
                                                       else if elem (Bloco, (x-1,y)) l || elem (Caixa, (x-1,y)) l then Jogo (constroiMapa l) (Jogador (x-1,y-1) dir c)
                                                            else if (elem (Bloco, (x-1,y)) l || elem (Caixa, (x-1,y)) l) && (elem (Bloco, (x-1,y-2)) l || elem (Caixa, (x+1,y-2)) l)
                                                                 then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                 else Jogo (constroiMapa l) (Jogador (x,y) dir c)

                                               False -> if (elem (Bloco, (x-1,y)) l || elem (Caixa, (x-1,y)) l) && (elem (Bloco, (x-1,y-1)) l || elem (Caixa, (x-1,y-1)) l)
                                                        then Jogo (constroiMapa l) (Jogador (x,y) dir c) 
                                                        else if elem (Bloco, (x-1,y)) l || elem (Caixa, (x-1,y)) l then Jogo (constroiMapa l) (Jogador (x-1,y-1) dir c)
                                                             else Jogo (constroiMapa l) (Jogador (x,y) dir c)

{- | A função 'caixaJogador' vai verificar se o 'Jogador' pode pegar numa 'Caixa', se este ainda não estiver a carregar nenhuma, ou se pode pousar, à sua frente, se já estiver a carregar uma.
     Assim como as outras funções também é necessário enunciar as condições em que o 'Jogador' não pode pegar ou pousar a 'Caixa':

     * Se a 'Caixa' estiver à direita do 'Jogador' e este estiver direcionado para Oeste e vice-versa;

     * Se o 'Jogador' estiver a carregar uma 'Caixa' e à frente dessa 'Caixa' existir um obstáculo;

     Definimos também para quando existe uma "queda" e o 'Jogador' pretende pousar a 'Caixa'.

     Assim, escrevemos a função da seguinte maneira:

@
caixaJogador l (Jogador (x,y) dir c) 
                    | c == True = case dir of Este -> if (elem (Caixa,(x+1,y)) l || elem (Bloco, (x+1,y)) l) && ((elem (Caixa, (x+1,y-1)) l) || elem (Bloco, (x+1,y-1)) l)
                                                      then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                      else if (elem (Caixa,(x+1,y)) l || elem (Bloco, (x+1,y)) l) then Jogo (constroiMapa (insereCaixa l (x+1,y-1))) (Jogador (x,y) dir False)
                                                           else if x == xmax 0 l then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                else if elem (Bloco, (x+1,y-1)) then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                     else if (elem (Bloco, (x+1,y+1)) l) == False then Jogo (constroiMapa (insereCaixa l (x+1,(ymin (x+1) y 1 l)))) (Jogador (x,y) dir False)
                                                                          else Jogo (constroiMapa (insereCaixa l (x+1,y))) (Jogador (x,y) dir False)

                                              Oeste -> if (elem (Caixa,(x-1,y)) l || elem (Bloco, (x-1,y)) l) && ((elem (Caixa, (x-1,y-1)) l) || elem (Bloco, (x-1,y-1)) l)
                                                       then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                       else if (elem (Caixa,(x-1,y)) l || elem (Bloco, (x-1,y)) l) then Jogo (constroiMapa (insereCaixa l (x-1,y-1))) (Jogador (x,y) dir False)
                                                            else if x == 0 then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                 else if elem (Bloco, (x-1,y-1)) then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                      else if (elem (Bloco, (x-1,y+1)) l) == False then Jogo (constroiMapa (insereCaixa l (x-1,(ymin (x+1) y 1 l)))) (Jogador (x,y) dir False)
                                                                           else Jogo (constroiMapa (insereCaixa l (x-1,y))) (Jogador (x,y) dir False)


                    | c == False = case dir of Este -> if elem (Caixa,(x+1,y)) l && (elem (Caixa, (x+1, y-1)) l || elem (Bloco, (x+1,y-1)) l)
                                                       then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                       else if elem (Caixa,(x+1,y)) l && elem (Bloco, (x,y-1)) l then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                            else if elem (Caixa,(x+1,y)) l then Jogo (constroiMapa (removeCaixa l (x+1,y))) (Jogador (x,y) dir True)
                                                                 else Jogo (constroiMapa l) (Jogador (x,y) dir c)

                                               Oeste -> if elem (Caixa,(x-1,y)) l && (elem (Caixa, (x-1, y-1)) l || elem (Bloco, (x-1,y-1)) l)
                                                        then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                        else if elem (Caixa,(x-1,y)) l && elem (Bloco, (x,y-1)) l then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                             else if elem (Caixa,(x-1,y)) l then Jogo (constroiMapa (removeCaixa l (x-1,y))) (Jogador (x,y) dir True)
                                                                  else Jogo (constroiMapa l) (Jogador (x,y) dir c)
@

== Exemplos de utilização
>>> caixaJogador [(Bloco,(0,2)),(Bloco, (1,2)), (Bloco,(2,2)), (Bloco,(1,0)), (Porta, (2,1))] (Jogador (0,1) Este True)
"
 CX
 > P
 XXX
"

-}

caixaJogador :: [(Peca,Coordenadas)] -> Jogador -> Jogo
caixaJogador l (Jogador (x,y) dir c) 
                    | c == True = case dir of Este -> if (elem (Caixa,(x+1,y)) l || elem (Bloco, (x+1,y)) l) && ((elem (Caixa, (x+1,y-1)) l) || elem (Bloco, (x+1,y-1)) l)
                                                      then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                      else if (elem (Caixa,(x+1,y)) l || elem (Bloco, (x+1,y)) l) then Jogo (constroiMapa (insereCaixa l (x+1,y-1))) (Jogador (x,y) dir False)
                                                           else if x == xmax 0 l then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                else if elem (Bloco, (x+1,y-1)) l then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                     else if (elem (Bloco, (x+1,y+1)) l == False) then Jogo (constroiMapa (insereCaixa l (x+1,(ymin (x+1) y 1 l)))) (Jogador (x,y) dir False)
                                                                          else Jogo (constroiMapa (insereCaixa l (x+1,y))) (Jogador (x,y) dir False)

                                              Oeste -> if (elem (Caixa,(x-1,y)) l || elem (Bloco, (x-1,y)) l) && ((elem (Caixa, (x-1,y-1)) l) || elem (Bloco, (x-1,y-1)) l)
                                                       then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                       else if (elem (Caixa,(x-1,y)) l || elem (Bloco, (x-1,y)) l) then Jogo (constroiMapa (insereCaixa l (x-1,y-1))) (Jogador (x,y) dir False)
                                                            else if x == 0 then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                 else if elem (Bloco, (x-1,y-1)) l then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                                      else if (elem (Bloco, (x-1,y+1)) l) == False then Jogo (constroiMapa (insereCaixa l (x-1,(ymin (x+1) y 1 l)))) (Jogador (x,y) dir False)
                                                                           else Jogo (constroiMapa (insereCaixa l (x-1,y))) (Jogador (x,y) dir False)


                    | c == False = case dir of Este -> if elem (Caixa,(x+1,y)) l && (elem (Caixa, (x+1, y-1)) l || elem (Bloco, (x+1,y-1)) l)
                                                       then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                       else if elem (Caixa,(x+1,y)) l && elem (Bloco, (x,y-1)) l then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                            else if elem (Caixa,(x+1,y)) l then Jogo (constroiMapa (removeCaixa l (x+1,y))) (Jogador (x,y) dir True)
                                                                 else Jogo (constroiMapa l) (Jogador (x,y) dir c)

                                               Oeste -> if elem (Caixa,(x-1,y)) l && (elem (Caixa, (x-1, y-1)) l || elem (Bloco, (x-1,y-1)) l)
                                                        then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                        else if elem (Caixa,(x-1,y)) l && elem (Bloco, (x,y-1)) l then Jogo (constroiMapa l) (Jogador (x,y) dir c)
                                                             else if elem (Caixa,(x-1,y)) l then Jogo (constroiMapa (removeCaixa l (x-1,y))) (Jogador (x,y) dir True)
                                                                  else Jogo (constroiMapa l) (Jogador (x,y) dir c)

{- | A função 'removeCaixa' é uma função auxiliar, utilizada na função 'caixaJogador', e tem como objetivo retirar do mapa a 'Caixa' que o 'Jogador' acabou de pegar.
     Definimo-la da seguinte forma:

@
removeCaixa [] (_,_) = []
removeCaixa ((p, (x1,y1)):t) (x2,y2) 
       | x1 == x2 && y1 == y2 = t 
       | otherwise = (p, (x1,y1)) : removeCaixa t (x2,y2)
@

== Exemplo de utilização
>>> removeCaixa [(Bloco, (2,0)), (Caixa, (0,1)), (Bloco, (2,1)), (Bloco, (0,2)), (Bloco, (1,2)), (Bloco, (2,2))] (0,1)
[(Bloco, (2,0)), (Bloco, (2,1)), (Bloco, (0,2)), (Bloco, (1,2)), (Bloco, (2,2))]

-}

removeCaixa :: [(Peca, Coordenadas)] -> Coordenadas -> [(Peca, Coordenadas)]
removeCaixa [] (_,_) = []
removeCaixa ((p, (x1,y1)):t) (x2,y2) 
       | x1 == x2 && y1 == y2 = t 
       | otherwise = (p, (x1,y1)) : removeCaixa t (x2,y2)

{- | A função auxiliar 'insereCaixa', utilizada na função 'caixaJogador', vai inserir no mapa a 'Caixa' que o 'Jogador' acabou de pousar.
     Esta função é também a inversa da função 'removeCaixa'.
     Definimo-la da seguinte forma:

@
insereCaixa l (x,y) = (Caixa,(x,y)) : l
@

== Exemplo de utilização
>>> insereCaixa [(Bloco, (2,0)), (Bloco, (2,1)), (Bloco, (0,2)), (Bloco, (1,2)), (Bloco, (2,2))] (0,1)
[(Caixa, (0,1)), (Bloco, (2,0)), (Bloco, (2,1)), (Bloco, (0,2)), (Bloco, (1,2)), (Bloco, (2,2))] 

-}
insereCaixa :: [(Peca, Coordenadas)] -> Coordenadas -> [(Peca, Coordenadas)]
insereCaixa l (x,y) = (Caixa,(x,y)) : l
