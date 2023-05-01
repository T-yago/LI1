{- |
Module      : Tarefa1_2021li1g046
Description : Validação de um potencial mapa
Copyright   : Diogo Guimarães Pereira <a100748@alunos.uminho.pt>;
            : Tiago Nuno Magalhães Teixeira  <a100665@alunos.uminho.pt>;

Módulo para a realização da Tarefa 1 do projeto de LI1 em 2021/22.
-}
module Tarefa1_2021li1g046 where

import LI12122
{-|
A função 'validaPotencialMapa' recebe uma lista de peças e coordenadas e testa se o mapa é ou não válido.
O mapa apenas será válido se todas as funções auxiliares cujo propósito é testar os critérios necessários forem verdadeiras. Basta um dos crtérios não corresponder ao esperado para o mapa ser inválido (uma vez que utilizamos interseçoes lógicas).

@
validaPotencialMapa [] = False
validaPotencialMapa l = (verificaPos (head l) (tail l)) && (verificaPorta l) && (verificaCaixa l) && (verificaVazio l) && (verificaChao l (0,(ymax 0 l))) && (semblocosSoltos l 0) && (portaAbaixo l (0,0)) && (portaFlutuante l (0,0))
@

== Exemplos de utilização 
>>> validaPotencialMapa [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (3,1)), (Porta, (0,0)), (Caixa, (3,0))]
True

>>> validaPotencialMapa [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (3,1)), (Porta, (0,0)), (Porta, (3,0))]
-}

validaPotencialMapa :: [(Peca, Coordenadas)] -> Bool
validaPotencialMapa [] = False
validaPotencialMapa l = (verificaPos l) && (verificaPorta l) && (verificaCaixa l) && (verificaVazio l) && (verificaChao l (0,(ymax 0 l))) && (semblocosSoltos l 0) && (portaAbaixo l (0,0)) && (portaFlutuante l (0,0))

{-|
A função 'verificaPos' recebe um par do tipo (Pecas,Coordenadas) e testa se existem outras peças diferentes à primeira na mesma posição da lista correspondente ao eventual mapa.

@
verificaPos _ [] = True
verificaPos (p1, (x1,y1)) ((p2, (x2,y2)) :t)
  | x1 == x2 && y1 == y2 && p1 /= p2 = False 
  | otherwise = verificaPos (p1, (x1,y1)) t && verificaPos (p2, (x2,y2)) t
@

== Exemplos de utilização
>>> verificaPos (Bloco, (0,1)) [(Bloco, (0,1)),(Bloco, (2,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (3,1)), (Bloco, (2,5)), (Porta, (2,4))]
True

>>> verificaPos (Bloco, (0,1)) [(Bloco, (0,1)),(Bloco, (2,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (3,1)), (Bloco, (2,5)), (Porta, (2,4)), (Caixa, (0,1))]
False  
-}

verificaPos :: [(Peca,Coordenadas)] -> Bool 
verificaPos [p,(x,y)] = True
verificaPos ((p, (x,y)):t) = case p of Porta -> if elem (Caixa, (x,y)) t || elem (Bloco, (x,y)) t then False else verificaPos t 
                                       Caixa -> if elem (Bloco, (x,y)) t || elem (Porta, (x,y)) t then False else verificaPos t 
                                       Bloco -> if elem (Caixa, (x,y)) t || elem (Porta, (x,y)) t then False else verificaPos t 
  
{-|
A função 'verificaPorta' recebe uma lista de peças e coordenadas e verifica se existe mais que uma porta para nessa lista. Caso exista, a função retorna o boleano False.
Se a lista contiver duas ou mais portas na mesma posição, ela retorna o boleano True.

@
verificaPorta :: [(Peca, Coordenadas)] -> Bool
verificaPorta [] = False
verificaPorta ((p, (x, y):t) = case p of Porta -> if elem (Porta,(x,y)) t then False 
                                                  else True
                                         Bloco -> verificaPorta t
                                         Caixa -> verificaPorta t
@

== Exemplos de utilização
>>>verificaPorta [(Porta, (0,0)), (Porta, (1,0)), (Bloco, (0,1)), (Bloco, (1,1))]
False

>>>verificaPorta [(Porta, (0,1)), (Porta, (0,1)), (Porta, (0,1))]
True
-}

verificaPorta :: [(Peca, Coordenadas)] -> Bool
verificaPorta [] = False
verificaPorta ((p, (x, y)):t) = case p of Porta -> if verificaPorta t == True then False 
                                                  else True
                                          Bloco -> verificaPorta t
                                          Caixa -> verificaPorta t
{-| 
A função 'portaFlutuante' analisa recursivamente se não existem portas relativas às quais não exista um bloco por baixo. 
Para esse fim, a função deve receber a lista e as coordenadas (0,0). A não ser que a porta esteja nas coordenadas (0,0) e que exista um bloco nas coordenadas (0,1), a função vai percorrer recursivamente todas as coordenadas e ordenadas até encontrar um caso análogo a este pelo mapa.

@ 
portaFlutuante l (x,y)
          | x == 0 && y == (ymax 0 l) +1 = True
          | x == (xmax 0 l) +1  = portaFlutuante l (0,y+1)
          | elem (Porta, (x,y)) l && elem (Bloco, (x,y+1)) l = True
          | elem (Porta, (x,y)) l = False
          | otherwise = portaFlutuante l (x+1,y)
@

==Exemplos de utilização 
>>>portaFlutuante [(Bloco, (0,2)), (Porta, (0,0))] (0,0)
False

>>>portaFlutuante [(Bloco, (0,2)), (Bloco, (0,1)), (Caixa, (0,0)] (0,0)
True
-}

portaFlutuante :: [(Peca,Coordenadas)] -> Coordenadas -> Bool
portaFlutuante l (x,y)
          | x == 0 && y == (ymax 0 l) +1 = True
          | x == (xmax 0 l) +1  = portaFlutuante l (0,y+1)
          | elem (Porta, (x,y)) l && elem (Bloco, (x,y+1)) l = True
          | elem (Porta, (x,y)) l = False
          | otherwise = portaFlutuante l (x+1,y)
{-| 
A função 'verificaCaixa' recebe uma lista de peças e coordenadas e verifica se não existem caixas a "flutuar", isto é, se não existem caixas que não têm ou um bloco ou uma caixa por baixo de si.
Note-se que uma caixa não pode constituir um chão, ou seja, terá sempre que existir um bloco a servir de chão para, pelo menos, uma das caixas em cada coordenada x (coluna).
A função utiliza o reverse da ´verificaCaixa'´ para analisar recursivamente se existe uma caixa flutuante cujo par (Peca, Coordenadas) apareça à esquerda (na lista) da peça que lhe serve de base.   
@ 
verificaCaixa l = verificaCaixa' l || verificaCaixa' (reverse l)
@

== Exemplos de utilização
>>>verificaCaixa [(Caixa, (0,0)), (Bloco, (0,1)), (Caixa, (1,0))]
False

>>>verificaCaixa [(Caixa, (0,0)), (Bloco, (0,1)), (Caixa, (1,0)), (Bloco, (1,1))]
True

>>>verificaCaixa [(Caixa, (0,0)), (Bloco, (0,1)), (Caixa, (1,0)), (Caixa, (1,1))]
False
-}

verificaCaixa :: [(Peca, Coordenadas)] -> Bool
verificaCaixa l = verificaCaixa' l || verificaCaixa' (reverse l)

{-| 
A função 'verificaCaixa'' analisa recursivamente se um par do tipo Caixa coordenadas possui na tail da lista um par do tipo Bloco ou Caixa na ordenada acima ou abaixo.

@ 
verificaCaixa' [] = True
verificaCaixa' ((p,(x,y)):t) =  case p of Bloco -> verificaCaixa t
                                          Porta -> verificaCaixa t
                                          Caixa -> if elem (Caixa,(x,(y+1))) ((p, (x,y)):t) || elem (Bloco,(x,(y+1))) ((p, (x,y)):t) then verificaCaixa t
                                                   else False
@ 

== Exemplo de utilização 
>>> verificaCaixa' [(Caixa, (0,1)), (Bloco, (0,2))]
True

>>> verificaCaixa' [(Bloco, (0,2)), (Caixa, (0,1))]
-}

verificaCaixa' :: [(Peca, Coordenadas)] -> Bool
verificaCaixa' [] = True
verificaCaixa' ((p,(x,y)):t) =  case p of Bloco -> verificaCaixa t
                                          Porta -> verificaCaixa t
                                          Caixa -> if elem (Caixa,(x,(y+1))) ((p, (x,y)):t) || elem (Bloco,(x,(y+1))) ((p, (x,y)):t) then verificaCaixa t
                                                   else False


{-| 
A função 'verificaVazio' vai averiguar se existe pelo menos um espaço vazio no mapa. Assim, se o produto do número de linhas com o número de colunas for igual ao número de elementos que a lista possui, a função irá concluir que não existem espaços fazios.

@ 
verificaVazio l = if length l == (((xmax 0 l)+1) * ((ymax 0 l)+1)) then False else True
@

== Exemplos de utilização
>>> verificaVazio [(Bloco, (0,1)), (Bloco, (1,1)), (Porta, (0,0)), (Caixa, (1,0))]
False 

>>> verificaVazio [(Bloco, (0,1)), (Bloco, (1,1)), (Porta, (0,0))]
True

-}
verificaVazio :: [(Peca, Coordenadas)] -> Bool
verificaVazio l = if length l == (((xmax 0 l)+1) * ((ymax 0 l)+1)) then False else True

{-| 
A função 'xmax' vai procurar na lista de pares (Pecas, Coordenadas) a peça cujo x é máximo e retornar esse x. Para isso, a função 'xmax' deve ser iniciada com n = 0, já que não estão a ser consideradas coordenadas x negativas.

@ 
xmax n [] = n
xmax n ((p, (x,_)):t) = if x >= n then xmax x t else xmax n t
@

== Exemplos de utilização
>>> xmax 0 [(Bloco, (0,1)), (Bloco, (0,2)), (Bloco, (1,2)), (Bloco, (2,2)), (Bloco, (3,2))]
3

>>> xmax 0 [(Bloco, (0,0)), (Bloco, (0,1)), (Bloco, (0,2)), (Bloco, (0,3))]
0
-}

xmax :: Int -> [(Peca, Coordenadas)] -> Int
xmax n [] = n
xmax n ((p, (x,_)):t) = if x >= n then xmax x t else xmax n t

{-| 
A função 'ymax' vai procurar na lista de pares (Pecas, Coordenadas) a peça cujo y é máximo e retornar esse y, de forma análoga à função 'xmax'.

@ 
ymax n [] = n
ymax n ((p, (_,y)):t) = if y >= n then ymax y t else ymax n t
@

== Exemplos de utilização
>>> ymax 0 [(Bloco, (0,1)), (Bloco, (0,2)), (Bloco, (1,2)), (Bloco, (2,2)), (Bloco, (3,3))]
3

>>> ymax 0 [(Bloco, (0,0)), (Bloco, (1,0)), (Bloco, (1,0)), (Bloco, (1,0))]
0
-}

ymax :: Int -> [(Peca, Coordenadas)] -> Int
ymax n [] = n
ymax n ((p, (_,y)):t) = if y >= n then ymax y t else ymax n t

{-| 
A função 'verificaChão' vai utilizar recursivamente a função auxiliar ´verificaChao'´ para averiguar a existência de blocos unidos ao longo de uma ou mais linhas, ou seja, a existência de um chão válido. Para isso, deve ser iniciada com as coordenadas (0,(ymax 0 l))

@
verificaChao l (_, 0) = False
verificaChao l (x,y)= if elem (Bloco,(x,y)) l then verificaChao' (x, y) l
                      else verificaChao l (x,y-1)
@

== Exemplos de utilização
>>> verificaChao [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (3,1))] (0,1)
True

>>> verificaChao [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (3,5))] (0,5)
False
-}
verificaChao :: [(Peca, Coordenadas)] -> Coordenadas -> Bool
verificaChao l (_, 0) = False
verificaChao l (x,y)= if elem (Bloco,(x,y)) l then verificaChao' (x, y) l
                      else verificaChao l (x,y-1)

{-| 
A função 'verificaChão'' recebe incialmente (0, (ymax 0 l)) e procura elementos que estejam ligados a esse bloco que se situa na coordenada 0 e na ordenada máxima, quer horizontalmente quer na diagonal.
 
@
verificaChao' :: Coordenadas -> [(Peca, Coordenadas)] -> Bool
verificaChao' (n,y) l = True 
      where n = (xmax 0 l) +1
verificaChao' (x,y) l 
                        | elem (Bloco, (x+1,y)) l = verificaChao' (x+1,y) l
                        | elem (Bloco, (x+1,y-1)) l = verificaChao' (x+1,y-1) l 
                        | elem (Bloco, (x+1,y+1)) l = verificaChao' (x+1,y+1) l 
                        | elem (Bloco, (x,y-1)) l = verificaChao' (x,y-1) l
                        | elem (Bloco, (x,y+1)) l = verificaChao' (x,y+1) l
                        |otherwise = False
@

== Exemplos de utilização
>>> verificaChao' (0,1) [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (3,1))] 
True

>>> verificaChao' (0,5)  [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (3,5))] 
False
-}
verificaChao' :: Coordenadas -> [(Peca, Coordenadas)] -> Bool
verificaChao' (n,y) l = True 
      where n = (xmax 0 l) +1
verificaChao' (x,y) l 
                        | elem (Bloco, (x+1,y)) l = verificaChao' (x+1,y) l
                        | elem (Bloco, (x+1,y-1)) l = verificaChao' (x+1,y-1) l 
                        | elem (Bloco, (x+1,y+1)) l = verificaChao' (x+1,y+1) l 
                        | elem (Bloco, (x,y-1)) l = verificaChao' (x,y-1) l
                        | elem (Bloco, (x,y+1)) l = verificaChao' (x,y+1) l
                        |otherwise = False


{-| 
A função 'semblocossoltos' examina  recursivamente a existência de blocos soltos que estejam em ordenadas superiores ao chão, ou seja, por baixo do chão. Para este efeito, a função deve ser iniciada com a coordenada 0.
@
semblocosSoltos l x = if x == (xmax 0 l)+1 then True
                      else if verificaChao l (x,(ymax 0 l)) then semblocosSoltos l (x+1)
                           else False
@

== Exemplos de utilização
>>> semblocosSoltos [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1))] 0
True

>>> semblocosSoltos [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (0,5))] 0
False
-}
semblocosSoltos :: [(Peca, Coordenadas)] -> Int -> Bool
semblocosSoltos l x = if x == (xmax 0 l)+1 then True
                      else if verificaChao l (x,(ymax 0 l)) then semblocosSoltos l (x+1)
                           else False

{-| 
A função 'portaAbaixo' apura se existe uma porta numa ordena superior ao chão, ou seja, por baixo do chão. Para isso, a função deve ser iniciada com as coordenadas (0,0), de forma a percorrer todo o mapa.

@
portaAbaixo l (x,y)
          | x == 0 && y == (ymax 0 l) +1 = True
          | x == (xmax 0 l) +1  = portaAbaixo l (0,y+1)
          | elem (Porta, (x,y)) l && elem (Bloco, (x,y+1)) l = verificaChao' (x,y+1) l
          | elem (Porta, (x,y)) l = False
          | otherwise = portaAbaixo l (x+1,y)
@

== Exemplos de utilização
>>> portaAbaixo [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (3,1)), (Porta, (0,0))] (0,0)
True

>>> portaAbaixo [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Bloco, (3,1)), (Bloco, (2,5)), (Porta, (2,4))] (0,0)
False
-}
portaAbaixo :: [(Peca,Coordenadas)] -> Coordenadas -> Bool
portaAbaixo l (x,y)
          | x == 0 && y == (ymax 0 l) +1 = True
          | x == (xmax 0 l) +1  = portaAbaixo l (0,y+1)
          | elem (Porta, (x,y)) l && elem (Bloco, (x,y+1)) l = verificaChao' (x,y+1) l
          | elem (Porta, (x,y)) l = False
          | otherwise = portaAbaixo l (x+1,y)

