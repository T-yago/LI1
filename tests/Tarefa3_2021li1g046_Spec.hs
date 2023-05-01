module Tarefa3_2021li1g046_Spec where

import Test.HUnit
import Tarefa3_2021li1g046
import Fixtures

testsT3 =
  test
    [ "Tarefa 3 - Teste Imprime Jogo m1e1" ~: "      <\n      X\n      X\nP   C X\nXXXXXXX" ~=?  show m1e1
    , "Tarefa 3 - Teste Imprime Jogo m1e2" ~: "       \n      X\n      X\nP < C X\nXXXXXXX" ~=?  show m1e2
    , "Tarefa 3 - Teste Imprime Jogo sqr3x3e1" ~: "P   \nX   \nXX>C\nXXXX" ~=? show  sqr3x3e1
    , "Tarefa 3 - Teste Imprime Jogo sqr3x3e2" ~: "P   \nX   \nXX<C\nXXXX" ~=? show  sqr3x3e2
    , "Tarefa 3 - Teste Imprime Jogo sqr3x3e3" ~: "P   \nX C \nXX<C\nXXXX" ~=? show  sqr3x3e3
    ]
