/-!
 * Arquivo do minicurso "Introdução ao Assistente de
 * Provas Lean", ministrado na `30ª Semana de Informática`
 * da Universidade Federal de Viçosa (UFV).
 * `autor:` @andrefeijosantos
 *
 * `ProgFun.lean`
 *   Este arquivo implementa as avaliações, variáveis e
 *  funções apresentadas na seção de conceitos básicos
 *  de Programação Funcional em Lean.
-/

/-! ====== AVALIANDO EXPRESSÕES ====== -/
-- Em Lean, podemos avaliar express˜oes utilizando `#eval`.

#eval 1 + 2                        -- Esperado: 3
#eval 10 + 4 * (3 + 1)             -- Esperado: 26
#eval 1 + 5 * 2                    -- Esperado: 11
#eval String.append "A" "B"        -- Esperado: "AB"
#eval if 4 >= 3 then "A" else "B"  -- Esperado: "A"
#eval (1 - 2 : Int)                -- Esperado: -1
#eval (1 - 2 : Nat)                -- Esperado: 0


/-! ====== AVALIANDO TIPOS ====== -/
-- Toda expressão possui um tipo, e este pode ser
-- obtido com `#check`.

#check 1 - 2                       -- Esperado: Nat
#check Float.sqrt 5                -- Esperado: Float
#check (1 - 2 : Int)               -- Esperado: Int
#check String.append ["A"] "B"     -- Esperado: Erro


/-! ====== DEFININDO VARIÁVEIS E FUNÇÕES ====== -/
-- Em Lean, definições são introduzidas com `def`.

-- Declarando Variaveis.
def hello := "Hello, "
def lean : String := "Lean"
def ano : Nat := 2025

#eval lean                         -- Esperado: Lean
#eval String.length lean           -- Esperado: 4
#eval String.append hello lean     -- Esperado: "Hello, Lean"
#eval ano - 2003                   -- Esperado: 22

-- Declarando funções.
def sum (n m : Nat) := n + m

#eval sum 1 2                      -- Esperado: 3
#eval sum 3 7                      -- Esperado: 10
#eval sum 4 (-1)                   -- Esperado: Erro
#eval sum 100 1                    -- Esperado: 101

def mask (n : Nat) (b : Bool) : Nat
  := if b then n else 0

#eval mask 100 True                -- Esperado: 100
#eval mask 100 False               -- Esperado: 0


/-! ====== TIPOS EM LEAN ====== -/
-- Em Lean, tipos são cidadãos de primeira classe.
-- O tipo dos tipos é Type.

def α : Type := Nat
#check α                           -- Esperado: Type

def β : Type := Bool
#check β                           -- Esperado: Type

def γ : Type := String
#check γ                           -- Esperado: Type

-- Qual o tipo de Type?
#check Type
#check Type 1
#check Type 2

-- Type é um apelido para Type 0.
#check Type 0


-- Se α e β são tipos, então
--   * α → β denota uma função de α em β.
--   * α × β denota um par que consiste em um elemento
--     do tipo α e outro do tipo β.

#check Float.sqrt                  -- Esperado: Float → Float
#check Float.sqrt 4                -- Esperado: Float
#check String.length               -- Esperado: String → Nat
#check (1, 0)                      -- Esperado: Nat × Nat

-- A função Nat.add tem tipo Nat → Nat → Nat, que é
-- equivalente a Nat → (Nat → Nat).
-- Nat.add pode, então, ser vista como uma função que
-- recebe um Nat e retorna outra função que recebe um
-- Nat, e retorna um Nat.

#check Nat.mul                     -- Esperado: Nat → Nat → Nat
#check Nat.mul 1 2                 -- Esperado: Nat
#check Nat.mul 1                   -- Esperado: Nat → Nat


-- A função dbl pode ser definida assim (com ' para evitar
-- dupla definição).
def dbl' (n : Nat) : Nat := Nat.mul 2 n

-- Ou assim...
def dbl : Nat → Nat := Nat.mul 2

#eval dbl 1                        -- Esperado: 2
#eval dbl 20                       -- Esperado: 40
#eval dbl 250                      -- Esperado: 500
