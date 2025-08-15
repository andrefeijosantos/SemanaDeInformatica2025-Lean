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

/-! ====== DEFININDO TIPOS INDUTIVOS - MyNat ====== -/
-- Todos os tipos que definimos até agora (MyBool, Byte) são
--finitos. O tipo dos naturais – por outro lado – é infinito.

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
  match m with
  | O => n
  | S m' => S (plus n m')

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
  match n with
  | O => O
  | S n' => n'

#eval pred (S (S O))
#eval pred (S O)
#eval pred O

-- Multiplicação entre naturais.
def mul (n m : MyNat) : MyNat :=
  match n with
  | O => O
  | S n' => m + (mul n' m)

#eval mul (S (S O)) (S (S (S O)))

notation:60 x " × " y => mul x y
notation:60 x " vezes " y => mul x y

#eval (S (S O)) × (S (S (S O)))
#eval (S (S O)) vezes (S (S (S O)))

end MyNatPlayground
