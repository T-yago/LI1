module Fixtures where

import LI12122

m1 :: [(Peca, Coordenadas)]
m1 =
  [ (Porta, (0, 3)),
    (Bloco, (0, 4)),
    (Bloco, (1, 4)),
    (Bloco, (2, 4)),
    (Bloco, (3, 4)),
    (Bloco, (4, 4)),
    (Caixa, (4, 3)),
    (Bloco, (5, 4)),
    (Bloco, (6, 4)),
    (Bloco, (6, 3)),
    (Bloco, (6, 2)),
    (Bloco, (6, 1))
  ]

m1r :: Mapa
m1r =
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

m1e1 :: Jogo
m1e1 = Jogo m1r (Jogador (6, 0) Oeste False)

m1e2 :: Jogo
m1e2 = Jogo m1r (Jogador (2, 3) Oeste False)

m1e3 :: Jogo 
m1e3 = Jogo m1r (Jogador (5,3) Oeste False)

m1e4 :: Jogo 
m1e4 = Jogo m1r (Jogador (5,3) Este False)

faq1 :: [(Peca, Coordenadas)]
faq1 = 
  [     (Bloco,(0,2)),
        (Bloco,(0,3)),
        (Bloco,(0,4)),
        (Bloco,(0,5)),
        (Bloco,(0,6)), 
        (Bloco,(0,7)),
        (Bloco,(0,8)),
        (Bloco,(0,9)),
        (Bloco,(0,10)),
        (Bloco,(1,0)),
        (Bloco,(1,1)),
        (Porta,(1,9)),
        (Bloco,(1,10)),
        (Bloco,(2,2)),
        (Bloco,(2,6)),
        (Bloco,(2,7)),
        (Bloco,(2,8)),
        (Bloco,(2,9)),
        (Bloco,(2,10)),
        (Bloco,(3,3)),
        (Bloco,(3,6)),
        (Bloco,(4,2)),
        (Bloco,(4,6)),
        (Bloco,(4,7)),
        (Bloco,(4,8)),
        (Bloco,(4,9)),
        (Bloco,(4,10)),
        (Bloco,(5,1)),
        (Caixa,(5,8)),
        (Bloco,(5,9)),
        (Bloco,(5,10)),
        (Bloco,(6,1)),
        (Caixa,(6,8)),
        (Bloco,(6,9)),
        (Bloco,(7,1)),
        (Bloco,(7,9)),
        (Bloco,(8,1)),
        (Bloco,(8,8)),
        (Bloco,(8,9)),
        (Bloco,(9,1)),
        (Bloco,(9,7)),
        (Bloco,(9,8)),
        (Bloco,(9,9)),
        (Bloco,(9,10)),
        (Bloco,(10,1)),
        (Bloco,(10,10)),
        (Bloco,(11,1)),
        (Bloco,(11,9)),
        (Bloco,(11,10)),
        (Bloco,(12,1)),
        (Bloco,(12,7)),
        (Bloco,(12,8)),
        (Bloco,(12,9)),
        (Bloco,(13,1)),
        (Bloco,(13,6)),
        (Bloco,(13,7)),
        (Bloco,(14,1)),
        (Caixa,(14,6)),
        (Bloco,(14,7)),
        (Bloco,(15,1)),
        (Bloco,(15,7)),
        (Bloco,(16,1)),
        (Caixa,(16,5)),
        (Bloco,(16,6)),
        (Bloco,(16,7)),
        (Bloco,(17,1)),
        (Caixa,(17,4)),
        (Caixa,(17,5)),
        (Bloco,(17,6)),
        (Bloco,(18,2)),
        (Bloco,(18,3)),
        (Bloco,(18,4)),
        (Bloco,(18,5))
        ]


faq1r :: Mapa
faq1r = 
  [ [Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
    [Vazio,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio],
    [Bloco,Vazio,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Bloco,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Bloco],
    [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Caixa,Bloco],
    [Bloco,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Caixa,Vazio,Bloco,Bloco,Vazio],
    [Bloco,Vazio,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Bloco,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio,Vazio],
    [Bloco,Vazio,Bloco,Vazio,Bloco,Caixa,Caixa,Vazio,Bloco,Bloco,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
    [Bloco,Porta,Bloco,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
    [Bloco,Bloco,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio]] 

faq1e1 :: Jogo
faq1e1 = Jogo faq1r (Jogador (9,6) Oeste False)

faq2 :: [(Peca, Coordenadas)]
faq2 = 
  [   (Bloco, (0,0)),
      (Bloco, (19,0)),
      (Bloco, (0,1)),
      (Bloco, (19,1)),
      (Bloco, (0,2)),
      (Bloco, (19,2)),
      (Bloco, (0,3)),
      (Bloco, (4,3)),
      (Bloco, (10,3)),
      (Bloco, (19,3)),
      (Bloco, (0,4)),
      (Porta, (1,4)),
      (Porta, (4,4)),
      (Bloco, (8,4)),
      (Caixa, (10,4)),
      (Bloco, (12,4)),
      (Caixa, (14,4)),
      (Bloco, (19,4)),
      (Bloco, (0,5)),
      (Bloco, (1,5)),
      (Bloco, (2,5)),
      (Bloco, (3,5)),
      (Bloco, (4,5)),
      (Bloco, (5,5)),
      (Bloco, (6,5)),
      (Bloco, (7,5)),
      (Bloco, (8,5)),
      (Bloco, (9,5)),
      (Bloco, (10,5)),
      (Bloco, (11,5)),
      (Bloco, (12,5)),
      (Bloco, (13,5)),
      (Bloco, (14,5)),
      (Bloco, (15,5)),
      (Bloco, (16,5)),
      (Bloco, (17,5)),
      (Bloco, (18,5)),
      (Bloco, (19,5))]

faq2r :: Mapa
faq2r = [ 
    [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Bloco,Vazio,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Bloco,Porta,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Bloco,Vazio,Caixa,Vazio,Bloco,Vazio,Caixa,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco],
    [Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio]]

mapacairdireita :: [(Peca, Coordenadas)]
mapacairdireita = 
 [  (Bloco, (0, 1)),
    (Bloco, (0, 2)),
    (Bloco, (0, 3)),
    (Bloco, (0, 4)),
    (Bloco, (1, 4)),
    (Bloco, (2, 4)),
    (Bloco, (3, 4)),
    (Porta, (3, 3)),
    (Bloco, (4, 4)),
    (Caixa, (4, 3)),
    (Bloco, (5, 4)),
    (Bloco, (6, 4)),
    (Bloco, (6, 3)),
    (Bloco, (6, 2)),
    (Bloco, (6, 1))
  ]


mapacairdireitar :: Mapa
mapacairdireitar = 
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Bloco, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Bloco, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Bloco, Vazio, Vazio, Porta, Caixa, Vazio, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

mapacairdireitae1 :: Jogo
mapacairdireitae1 = Jogo mapacairdireitar (Jogador (0,0) Oeste False)

sqr3x3 :: [(Peca,Coordenadas)]
sqr3x3 = 
  [
    (Porta, (0,0)), 
    (Bloco, (0,1)), 
    (Bloco, (0,2)),
    (Bloco, (0,3)), 
    (Bloco, (1,3)),
    (Bloco, (1,2)),
    (Bloco, (2,3)),
    (Bloco, (3,3)), 
    (Caixa, (3,2)) 
 ]

sqr3x3r :: Mapa 
sqr3x3r = 
  [ 
    [Porta, Vazio, Vazio, Vazio],
    [Bloco, Vazio, Vazio, Vazio],
    [Bloco, Bloco, Vazio, Caixa],
    [Bloco, Bloco, Bloco, Bloco]
  ]

sqr3x3r2 :: Mapa 
sqr3x3r2 = 
  [ 
    [Porta, Vazio, Vazio, Vazio],
    [Bloco, Vazio, Vazio, Vazio],
    [Bloco, Bloco, Vazio, Vazio],
    [Bloco, Bloco, Bloco, Bloco]
  ]

sqr3x3e1 :: Jogo 
sqr3x3e1 = Jogo sqr3x3r (Jogador (2,2) Este False)

sqr3x3e2 :: Jogo 
sqr3x3e2 = Jogo sqr3x3r (Jogador (2,2) Oeste False)

sqr3x3e3 :: Jogo 
sqr3x3e3 = Jogo sqr3x3r (Jogador (2,2) Oeste True)