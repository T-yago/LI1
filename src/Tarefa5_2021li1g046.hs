{- |
Module      : Tarefa5_2021li1g046
Description : Aplicação Gráfica

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2021/22.
-}
module Main where

import Graphics.Gloss

janela :: Display
janela = InWindow "BlockDude" fullscreen

corFundo :: Color
corFundo = greyN 1

mapaToPictures :: String -> Pictures



main = play janela corFundo 10 