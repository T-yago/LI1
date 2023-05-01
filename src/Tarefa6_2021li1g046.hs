{- |
Module      : Tarefa6_2021li1g046
Description : Resolução de um puzzle
Copyright   : Diogo Guimarães Pereira <a100748@alunos.uminho.pt>;
            : Tiago Nuno Magalhães Teixeira  <a100665@alunos.uminho.pt>;

Módulo para a realização da Tarefa 6 do projeto de LI1 em 2021/22.
-}
module Tarefa6_2021li1g046 where

import LI12122
import Tarefa4_2021li1g046
import Data.List 


resolveJogo :: Int -> Jogo -> Maybe [Movimento]
resolveJogo nmovimentos jogo = let jogosGanhos = filter jogoconcluido (verificaJogos nmovimentos jogo) in
    if length jogosGanhos == 0 then Nothing else Just (jogosParaMovimentos (head (sortOn length jogosGanhos)))


verificaJogos :: Int -> Jogo -> [[Jogo]]
verificaJogos nmovimentos jogo
    | nmovimentos <= 0 = [[jogo]] 
    | otherwise = [jogo] : map (jogo :) (concatMap (verificaJogos (nmovimentos - 1)) (adicionaJogos jogo)) 


adicionaJogos :: Jogo -> [Jogo]
adicionaJogos = geraJogos [AndarEsquerda, AndarDireita, Trepar, InterageCaixa] where 
    geraJogos :: [Movimento] -> Jogo -> [Jogo]
    geraJogos [] _ = []
    geraJogos (h:t) jogo = let novoJogo = moveJogador jogo h in
        if novoJogo /= jogo then novoJogo : geraJogos t jogo else geraJogos t jogo


jogoconcluido :: [Jogo] -> Bool
jogoconcluido l = (mapa !! y) !! x == Porta where
        Jogo mapa (Jogador (x,y) _ _) = last l

jogoparamapa :: Jogo -> Mapa 
jogoparamapa (Jogo mapa (Jogador (_, _) _ _)) = mapa

jogosParaMovimentos :: [Jogo] -> [Movimento]
jogosParaMovimentos [] = []
jogosParaMovimentos [_] = [] 
jogosParaMovimentos (x:y:t) = parDeJogosParaMovimento x y : jogosParaMovimentos (y:t) where
       parDeJogosParaMovimento :: Jogo -> Jogo -> Movimento
       parDeJogosParaMovimento (Jogo _ (Jogador (_,y1) _ caixa1)) (Jogo _ (Jogador (_,y2) dir caixa2))
        | y1 > y2 = Trepar 
        | caixa1 /= caixa2 = InterageCaixa  
        | dir == Este = AndarDireita 
        | otherwise = AndarEsquerda 
      
