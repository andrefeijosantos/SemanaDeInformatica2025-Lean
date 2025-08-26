/-!
 * Arquivos do minicurso "Introdução ao Assistente de
 * Provas Lean", ministrado na `30ª Semana de Informática`
 * da Universidade Federal de Viçosa (UFV).
 * `autor:` @andrefeijosantos
 *
 * `MyNat.lean`
 *   Este arquivo implementa o tipo MyNat, apresentado na
 *  seção de Programação em Lean, além de um conjunto de
 *  funções e provas de teoremas.
-/

namespace MyNatPlayground

/-! ====== TIPOS INDUTIVOS ====== -/
-- Todos os tipos que definimos até agora (MyBool, Byte) são
-- finitos. O tipo dos naturais – por outro lado – é infinito.

-- Existem diversas maneiras de representar números naturais
-- (base decimal, binária, hexadecimal, ...).

-- Vamos definir os números naturais usando dois constructos:
-- O, representando o 0, e S, representando o sucessor de um
-- natural (n+1).

-- Definição do tipo MyNat.
inductive MyNat where
  | O : MyNat
  | S (n : MyNat) : MyNat

open MyNat

#eval O
#eval S O
#eval S (S O)


-- Soma de naturais.
def plus (n m : MyNat) : MyNat :=
  match n with
  | O => m
  | S n' => S (plus n' m)

-- Subtração de naturais.
def minus (n m : MyNat) : MyNat :=
  match n, m with
  | O, _ => O
  | _ , O => n
  | S n', S m' => minus n' m'


-- Também podemos definir notação para plus e minus.
notation:60 x " + " y => plus x y
notation:60 x " - " y => minus x y

#eval S (S (S O)) - S O
#eval S (S (S O)) - S (S O)
#eval S (S (S O)) - S (S (S O))
#eval S (S (S O)) - S (S (S (S O)))

-- Definição da função `pred`, que retorna o predecessor
-- de um dado natural n.
def pred (n : MyNat) : MyNat :=


#eval pred (S (S O))
#eval pred (S O)
#eval pred O

-- Multiplicação entre naturais.
def mul (n m : MyNat) : MyNat :=

#eval mul (S (S O)) (S (S (S O)))

notation:60 x " vezes " y => mul x y
notation:60 x " × " y => mul x y

#eval (S (S O)) × (S (S (S O)))
#eval (S (S O)) vezes (S (S (S O)))

end MyNatPlayground


open MyNatPlayground
open MyNat

/-! ====== PROVAS POR SIMPLIFICAÇÃO ====== -/
-- A própria definição dos tipos sobre os quais estamos
-- conduzindo provas pode ser suficiente para concluir
-- o objetivo

-- ∀n ∈ MyNat, 0 + n = n
theorem plus_O_n :
  ∀(n : MyNat), (O + n) = n :=
by intros n
   simp [plus]

-- ∀n ∈ MyNat, 0 + n = n
-- Usando `rfl`
theorem plus_O_n_rfl :
  ∀(n : MyNat), (O + n) = n :=
by intros n
   rfl

-- ∀n ∈ MyNat, O × n = O
theorem mul_O_n_eq_O :
  ∀(n : MyNat), (O × n) = O :=
by admit

-- ∀n ∈ MyNat, (S O) + n = S n
theorem plus_n_1 :
  ∀(n : MyNat), ((S O) + n) = S n :=
by admit

-- ∀n, m ∈ MyNat, O × n = O × m
theorem mul_O_n_eq_O_m :
  ∀(n m : MyNat), (O × n) = (O × m) :=
by admit

/-! ====== PROVAS POR REESCRITA ====== -/
-- Vamos supor que desejamos provar o seguinte teorema:
--       ∀n, m ∈ MyNat, (n = m) → (n + n = m + m).

-- Em vez de fazermos uma declaração universal, sobre
-- quaisquer n e m do tipo MyNat, estamos tratando de
-- um caso mais específico, em que n = m.

-- Sendo assim, não podemos apenas simplificar o teorema
-- e identificar reflexividade, nós precisamos
-- reescrevê-lo considerando nossa hipótese.

-- ∀n, m ∈ MyNat, (n = m) → (n + n = m + m).
theorem plus_id :
  ∀(n m : MyNat), (n = m) → ((n + n) = (m + m)) :=
by intros n m
   intros H
   rw [H]

-- ∀n, m, o ∈ MyNat, (n = m) → (m = o) → (n + m = m + o).
theorem plus_id_3 :
  ∀(n m o : MyNat),
    (n = m) → (m = o) → ((n + m) = (m + o)) :=
by admit

-- Podemos também escolher a direção do rewritting.
-- ∀n, m, o ∈ MyNat, (n = m) → (m = o) → (n + m = m + o).
theorem plus_id_3' :
  ∀(n m o : MyNat),
    (n = m) → (m = o) → ((n + m) = (m + o)) :=
by admit


/-! ====== PROVAS POR INDUÇÃO ====== -/
-- Para provar teoremas interessantes sobre naturais ou
-- outros tipos definidos de maneira indutiva (como listas
-- e árvores), geralmente vamos precisar de uma abordagem
-- mais poderosa: a indução.
-- Para mostrar que P vale para todos os naturais:
    -- * Mostramos que um caso base P(O) vale;
    -- * Mostramos que, para qualquer n, se P(n) vale,
    --   então P(S n) também vale;
    -- * Finalmente, concluímos que P(n) vale para todo n.

-- ∀n ∈ MyNat, n + O = n
theorem plus_n_O :
  ∀(n : MyNat), (n + O) = n :=
by intros n
   induction n with
   | O => rfl
   | S n' IHn' => simp [plus]
                  rw[IHn']

-- ∀n, m ∈ MyNat, S (n + m) = n + S m
theorem plus_n_Sm :
  ∀(n m : MyNat), (S (n + m)) = (n + (S m)) :=
by admit

-- ∀n, m ∈ MyNat, n + m = m + n
theorem add_comm :
  ∀(n m : MyNat), (n + m) = (m + n) :=
by admit

-- ∀n ∈ MyNat, 2 × n = n + n
theorem double_n_plus_n_n :
  ∀(n : MyNat), (mul (S (S O)) n) = (n + n) :=
by admit



/-! ====== PARA PRATICAR ====== -/
-- Tente identificar quais táticas usar para concluir
-- as seguintes provas. As soluções estão disponíveis
-- em `solucoes/MyNat.lean`.

-- ∀n, m, o ∈ MyNat, (n + (m + o)) = ((n + m) + o).
-- Prova por indução
theorem plus_assoc :
  ∀(n m o : MyNat), (n + (m + o)) = ((n + m) + o) :=
by admit

-- ∀n ∈ MyNat, O - n = n
-- Prova por Simplificação.
theorem minus_O_n :
  ∀(n : MyNat), (O - n) = O :=
by admit

-- ∀n ∈ MyNat, n - n = O
-- Prova por Indução.
theorem minus_n_n_O :
  ∀(n : MyNat), (n - n) = O :=
by admit

-- ∀n ∈ MyNat, n × O = O
-- Prova por indução
theorem mul_n_O_eq_O :
  ∀(n : MyNat), (n × O) = O :=
by admit

-- ∀n ∈ MyNat, n × O × O = O
-- Prova por reescrita
theorem mul_n_O_O_eq_n :
  ∀(n : MyNat), (n × O × O) = O :=
by admit
