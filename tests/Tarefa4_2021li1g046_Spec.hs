module Tarefa4_2021li1g046_Spec where

import Test.HUnit
import LI12122
import Tarefa3_2021li1g046
import Tarefa4_2021li1g046
import Fixtures

testsT4 =
  test
    [ "Tarefa 4 - Teste Move m1e1 Oeste" ~: moveJogador m1e1 AndarEsquerda  ~=?  Jogo m1r (Jogador (5, 3) Oeste False)
    , "Tarefa 4 - Teste Move m1e1 Este" ~:  moveJogador m1e1 AndarDireita ~=?  Jogo m1r (Jogador (6, 0) Este False)
    , "Tarefa 4 - Teste Move m1e1 Trepar" ~:  moveJogador m1e1 Trepar  ~=? m1e1
    , "Tarefa 4 - Teste Move m1e1 InterageCaixa" ~:  moveJogador m1e1 InterageCaixa ~=? m1e1
    , "Tarefa 4 - Teste movimentos m1e1" ~: correrMovimentos m1e1 [AndarEsquerda, Trepar, AndarEsquerda, AndarEsquerda]  ~=? m1e2
    , "Tarefa 4 - Teste movimentos m1e2 Caixa1" ~: correrMovimentos m1e2 [AndarDireita, InterageCaixa] ~=? Jogo 
        [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Porta, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
        ]
        (Jogador (3, 3) Este True) 
    , "Tarefa 4 - Teste movimentos m1e2 Caixa2" ~: correrMovimentos m1e2 [AndarDireita, InterageCaixa, AndarEsquerda, InterageCaixa] ~=?
      Jogo
        [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Porta, Caixa, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
        ]
        (Jogador (2, 3) Oeste False) 
    , "Tarefa 4 - Teste movimentos sqr3x3e2 subir e descer escadas" ~: correrMovimentos sqr3x3e2 [Trepar, AndarDireita, InterageCaixa] ~=? Jogo sqr3x3r2 (Jogador (2,2) Este True)
    , "Tarefa 4 - Teste Move Andaresquerda quando há obstáculo" ~: moveJogador m1e4 AndarEsquerda ~=? Jogo m1r (Jogador (5,3) Oeste False)
    , "Tarefa 4 - Teste Move AndarDireita quando há obstáculo" ~: moveJogador m1e3 AndarDireita ~=? Jogo m1r (Jogador (5,3) Este False)
    , "Tarefa 4 - Teste Move Trepar quando há mais que um bloco de altura" ~: moveJogador m1e4 Trepar ~=?  m1e4
    , "Tarefa 4 - Teste Move AndarDireita quando há buraco" ~: moveJogador mapacairdireitae1 AndarDireita ~=? Jogo mapacairdireitar (Jogador (1,3) Este False)
    ]