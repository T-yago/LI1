module Tarefa1_2021li1g046_Spec where

import Test.HUnit
import LI12122
import Tarefa1_2021li1g046
import Fixtures

-- Tarefa 1
testsT1 =
  test
    [ "Tarefa 1 - Teste Valida Mapa m1r" ~: validaPotencialMapa m1 ~=? True
    , "Tarefa 1 - Teste Valida Mapa vazio" ~: validaPotencialMapa [] ~=? False
    , "Tarefa 1 - Teste Valida Mapa com 2 portas" ~: validaPotencialMapa [(Bloco, (0,1)), (Bloco, (1,1)), (Bloco, (2,1)), (Porta, (0,0)), (Porta, (1,0))] ~=?  False
    , "Tarefa 1 - Teste Valida Mapa com porta flutuante" ~: validaPotencialMapa [(Porta,(0,1)), (Bloco, (0,3)), (Bloco, (1,3))] ~=? False 
    , "Tarefa 1 - Teste Valida Mapa com caixa flutuante" ~: validaPotencialMapa [(Bloco, (0,3)), (Bloco, (1,3)), (Bloco, (2,3)), (Caixa, (0,0)), (Porta, (0,2))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa sem chão definido" ~: validaPotencialMapa [(Caixa, (0,1)),(Caixa, (1,1)), (Caixa, (2,1)), (Porta, (0,0))] ~=? False 
    , "Tarefa 1 - Teste Valida Mapa com chão interrompido horizontalmente" ~: validaPotencialMapa [(Bloco, (0,3)), (Bloco, (1,3)), (Bloco ,(5,3))] ~=? False 
    , "Tarefa 1 - Teste Valida Mapa com chão interrompido verticalmente" ~: validaPotencialMapa [(Bloco, (0,3)), (Bloco, (1,3)), (Bloco ,(1,5)), (Bloco, (2,5))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa com apenas teto" ~: validaPotencialMapa [(Bloco, (0,0)), (Bloco, (1,0)), (Bloco ,(2,0))] ~=? False 
   ]