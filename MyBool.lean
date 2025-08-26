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

/-! ====== ENUMERAÇÕES ====== -/
-- Vamos definir o tipo `MyBool`, cujos membros são `True`
-- e `False`.

-- Definição do tipo MyBool.
inductive MyBool where
  | True : MyBool
  | False : MyBool

open MyBool

#check True                        -- Esperado: MyBool
#check False                       -- Esperado: MyBool
#check MyBool                      -- Type

def bvar : MyBool := True
def btype : Type := MyBool

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

#check Bits

-- True se b for um byte zerado; False, caso contrário.
def all_zero (b : Byte) : MyBool :=
  match b with
  | Bits B0 B0 B0 B0 B0 B0 B0 B0 => True
  | Bits _ _ _ _ _ _ _ _ => False

#eval all_zero (Bits B0 B0 B0 B0 B0 B0 B0 B0)
#eval all_zero (Bits B0 B0 B0 B0 B0 B1 B0 B0)

-- True se b for par; False, caso contrário.
def is_even (b : Byte) : MyBool :=


-- True se b for ímpar; False, caso contrário.
def is_odd (b : Byte) : MyBool :=

#eval is_odd (Bits B0 B0 B0 B0 B0 B1 B0 B0)  -- Esperado: False
#eval is_odd (Bits B0 B0 B0 B0 B1 B0 B0 B0)  -- Esperado: False
#eval is_odd (Bits B0 B0 B0 B0 B0 B1 B0 B1)  -- Esperado: True
#eval is_odd (Bits B0 B0 B0 B0 B0 B0 B1 B1)  -- Esperado: True

end MyBoolPlayground



open MyBoolPlayground


/-! ====== PROVAS POR SIMPLIFICAÇÃO ====== -/
-- A própria definição dos tipos sobre os quais estamos
-- conduzindo provas pode ser suficiente para concluir
-- o objetivo

-- ∀b ∈ MyBool, False ∧ b = False
theorem false_and_b_eq_false :
  ∀(b : MyBool), (MyBool.False ∧ b) = MyBool.False :=
by intros b
   simp [andb]

-- ∀b ∈ MyBool, True ∧ b = True
theorem true_or_b_eq_true :
  ∀(b : MyBool), (MyBool.True ∨ b) = MyBool.True :=
by admit


/-! ====== PROVAS POR REESCRITA ====== -/

-- ∀b1, b2 ∈ MyBool, (b1 = Flase) → (b1 ∧ b2 = False)
theorem if_b1_false_then_b1_and_b2_eq_false :
  ∀(b1 b2 : MyBool),
    (b1 = MyBool.False) -> (andb b1 b2 = MyBool.False) :=
by admit

-- ∀b ∈ Byte, (is_even b = True) → (is_odd b = False)
theorem if_even_byte_then_not_odd_byte :
  ∀(b : Byte),
    (is_even b = MyBool.True) -> (is_odd b = MyBool.False) :=
by admit


/-! ====== PROVAS POR ANÁLISE DE CASOS ====== -/
-- Imagine que temos que provar um teorema sobre alguma
-- enumeração (e.g., MyBool).

-- Podemos testar se o teorema vale para cada constructo
-- separadamente.

-- Se de fato o teorema é válido para qualquer um dos
-- constructos, então está provado para qualquer variável
-- daquele tipo.

theorem andb_comm :
  ∀(b1 b2 : MyBool), (b1 ∧ b2) = (b2 ∧ b1) :=
by intros b1
   intros b2
   cases b1
   case True =>
    cases b2
    case True => rfl
    case False => rfl
   case False =>
    cases b2
    case True => rfl
    case False => rfl


-- Nossa primeira prova foi que
--          ∀b ∈ MyBool, False ∧ b = False

-- Como poderíamos provar o seguinte teorema?
--          ∀b ∈ MyBool, b ∧ False = False

-- Vamos começar tentando uma prova por simplificação.
theorem b_and_false_eq_false' :
  ∀(b : MyBool), (b ∧ MyBool.False) = MyBool.False :=
by intros b
   simp [andb]


-- E uma prova por casos?
theorem b_and_false_eq_false'' :
  ∀(b : MyBool), (b ∧ MyBool.False) = MyBool.False :=
by intros b
   cases b
   case True => rfl
   case False => rfl


-- Mas mais simples que isso: reaproveitar resultados
-- já obtidos!
theorem b_and_false_eq_false :
  ∀(b : MyBool), (b ∧ MyBool.False) = MyBool.False :=
by intros b
   rw [andb_comm]              -- b ∧ False = False ∧ b
   simp [andb]



/-! ====== PARA PRATICAR ====== -/
-- Tente identificar quais táticas usar para concluir
-- as seguintes provas. As soluções estão disponíveis
-- em `solucoes/MyBool.lean`.

-- ¬True = False
-- Prova por simplificação.
theorem negb_true :
  negb MyBool.True = MyBool.False :=
by admit

-- ¬False = True
-- Prova por simplificação
theorem negb_false :
  negb MyBool.False = MyBool.True :=
by admit

-- ∀b1, b2 ∈ MyBool, ¬(b1 ∧ b2) = ¬b1 ∨ ¬b2
-- Prova por casos e por reescrita (poderia também ser
-- usada apenas prova por casos).
theorem de_morgan :
  ∀(b1 b2 : MyBool), negb (andb b1 b2) = (orb (negb b1) (negb b2)) :=
by admit



-- Considere a seguinte definição de xorb.
def xorb (b1 b2 : MyBool) : MyBool :=
  match b1, b2 with
  | MyBool.True, MyBool.False => MyBool.True
  | MyBool.False, MyBool.True => MyBool.True
  | _, _ => MyBool.False

-- ∀b1, b2 ∈ MyBool, b1 = True -> b1 ⊕ b2 = ¬b2
-- Prova por reescrita e casos.
theorem xor_True_b :
  ∀(b1 b2 : MyBool), (b1 = MyBool.True) -> (xorb b1 b2 = negb b2) :=
by admit


-- Considere a nova definição de xorb (nomeado xorb').
def xorb' (b1 b2 : MyBool) : MyBool :=
  match b1 with
  | MyBool.True => negb b2
  | MyBool.False => b2

-- ∀b1, b2 ∈ MyBool, b1 = True -> b1 ⊕' b2 = ¬b2
-- Prova por reescrita.
theorem xor_True_b' :
  ∀(b1 b2 : MyBool), (b1 = MyBool.True) -> (xorb' b1 b2 = negb b2) :=
by admit
