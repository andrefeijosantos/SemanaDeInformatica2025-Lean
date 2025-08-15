/-!
 * Arquivos do minicurso "Introdução ao Assistente de
 * Provas Lean", ministrado na `30ª Semana de Informática`
 * da Universidade Federal de Viçosa (UFV).
 * `autor:` @andrefeijosantos
 *
 * `MyBool.lean`
 *   Este arquivo implementa o tipo MyBool, apresentado na
 *  seção de Programação em Lean, além de um conjunto de
 *  funções e provas de teoremas.
-/

namespace MyBoolPlayground

/-! ====== DEFININDO TIPOS INDUTIVOS - MyBool ====== -/
-- Vamos definir o tipo `MyBool`, cujos membros são `True`
-- e `False`.

-- Definição do tipo MyBool.
inductive MyBool where
  | True : MyBool
  | False : MyBool

open MyBool

#check True                        -- Esperado: MyBool
#check False                       -- Esperado: MyBool

def bvar : MyBool := True

#eval bvar
#check bvar

/-! ====== CASAMENTO DE PADRÕES ====== -/
-- Verificar a presença de um determinado padrão em
-- uma dada entrada.
-- No caso do tipo MyBool, isto é consideravelmente
-- simples: ou é True ou é False.

-- Definição do operador lógico AND.
def andb (b1 b2 : MyBool) : MyBool :=
  match b1 with
  | MyBool.False => False
  | MyBool.True => b2

#eval andb True True                 -- Esperado: True
#eval andb False True                -- Esperado: False
#eval andb True False                -- Esperado: False
#eval andb False False               -- Esperado: False

-- Definição do operador lógico OR.
def orb (b1 b2 : MyBool) : MyBool :=
  match b1 with
  | MyBool.True => True
  | MyBool.False => b2

#eval orb True True                  -- Esperado: True
#eval orb False True                 -- Esperado: True
#eval orb True False                 -- Esperado: True
#eval orb False False                -- Esperado: False

-- Definição do operador lógico NOT.
def negb (b : MyBool) : MyBool :=
  match b with
  | MyBool.True => False
  | MyBool.False => True

#eval negb True                      -- Esperado: False
#eval negb False                     -- Esperado: True


/-! ====== DECLARANDO NOTAÇÕES ====== -/
-- É possível declarar notações para aplicações de funções
-- utilizando notation.

-- Notação para o operador lógico AND.
notation:60 x " ∧ " y => andb x y

-- Notação para o operador lógico OR.
notation:60 x " ∨ " y => orb x y

-- Notação para o operador lógico NOT.
notation:60 "¬"x      => negb x

#eval MyBool.False ∧ MyBool.True
#eval MyBool.True ∨ MyBool.False
#eval ¬MyBool.True
#eval ¬MyBool.False ∨ MyBool.False


/-! ====== CONSTRUCTOS COM ARGUMENTOS ====== -/
-- É também possível definir tipos enumerativos cujos
-- constructos recebem argumentos.

inductive Bit where
  | B0 : Bit
  | B1 : Bit

inductive Byte where
  | Bits (B₀ B₁ B₂ B₃ B₄ B₅ B₆ B₇ : Bit)

open Byte Bit

-- True se b for um byte zerado; False, caso contrário.
def all_zero (b : Byte) : MyBool :=
  match b with
  | Bits B0 B0 B0 B0 B0 B0 B0 B0 => True
  | Bits _ _ _ _ _ _ _ _ => False

#eval all_zero (Bits B0 B0 B0 B0 B0 B0 B0 B0)
#eval all_zero (Bits B0 B0 B0 B0 B0 B1 B0 B0)

-- True se b for par; False, caso contrário.
def is_even (b : Byte) : MyBool :=
  match b with
  | Bits _ _ _ _ _ _ _ B0 => True
  | Bits _ _ _ _ _ _ _ B1 => False

#eval is_even (Bits B0 B0 B0 B0 B0 B1 B0 B0)  -- Esperado: True
#eval is_even (Bits B0 B0 B0 B0 B1 B0 B0 B0)  -- Esperado: True
#eval is_even (Bits B0 B0 B0 B0 B0 B1 B0 B1)  -- Esperado: False
#eval is_even (Bits B0 B0 B0 B0 B0 B0 B1 B1)  -- Esperado: False

end MyBoolPlayground
