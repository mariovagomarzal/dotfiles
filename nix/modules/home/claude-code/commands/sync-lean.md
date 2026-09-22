# /sync-lean

Implement Lean 4 code corresponding to the blueprint content specified in the
argument.

**Argument:** $ARGUMENTS

The argument may refer to one or more of the following:
- A chapter or section name within the blueprint
- One or more blueprint labels (e.g., `def:Foo`, `thm:Bar`)
- A `.tex` file path within the blueprint source directory

---

## Workflow

1. **Locate the blueprint structure** — find the blueprint source directory
   (typically `blueprint/src/` or similar). Read `content.tex` or the equivalent
   root file to understand the chapter/section organisation.

2. **Read the relevant blueprint source** — identify all `\begin{definition}`,
   `\begin{theorem}`, `\begin{lemma}`, `\begin{proposition}`,
   `\begin{corollary}`, and `\begin{notation}` environments in scope, along with
   their `\label`, `\lean`, `\uses`, `\leanok`, and `\mathlibok` annotations.

3. **Locate the Lean project structure** — read the root `.lean` file (the one
   that imports everything), the `lakefile.toml` or `lakefile.lean`, and the
   directory layout of the source files to understand the module structure and
   naming conventions.

4. **Read the relevant Lean source** — read the files most related to the
   blueprint content in scope. Pay attention to: existing naming conventions,
   import structure, tactic helpers defined in the project, notation, universe
   variables, and proof styles.

5. **Check for an authoritative mathematical source** — if the project
   references an external paper or document (e.g., via `\cite` in the blueprint
   or a README link), use it to resolve ambiguities in definitions or theorem
   statements if available.

6. **Implement** the missing or incomplete Lean declarations following all
   conventions below.

7. **Update blueprint annotations** — for every declaration you implement,
   ensure the corresponding blueprint environment has `\leanok` (and
   `\lean{...}` pointing to the correct fully-qualified name if not already
   present).

---

## Lean conventions to follow

Infer all conventions from the existing codebase. In particular:

- **File header:** Match the copyright/license block, author list, and `import`
  style of existing files exactly.
- **Module docstring:** Every file must have an `/-! ... -/` docstring
  describing its contents, main definitions, and main results. Model it on
  existing files.
- **Namespace:** Follow the namespace structure already established in the
  project.
- **Universe polymorphism:** Use the same universe variable names and patterns
  as existing files.
- **Doc-comments:** Every `def`, `abbrev`, `class`, `structure`, `theorem`,
  `lemma`, `instance`, and `macro` must have a `/-- ... -/` doc-comment.
  Reference the corresponding blueprint label when relevant.
- **Simp lemmas:** Add `@[simp]` only where existing files do so for analogous
  declarations.
- **Default proofs and tactic helpers:** If the project defines custom tactics
  or macros for discharging routine goals, use them as defaults, exactly as the
  existing code does.
- **Notation:** Reuse all notation already defined in the project. Do not
  introduce new notation unless the blueprint introduces a new operation not yet
  covered.
- **`abbrev` vs `def`:** Follow the pattern in existing files — use `abbrev` for
  transparent type aliases, `def`/`class`/`structure` for opaque definitions.
- **Proof style:** Match the proof style of existing files (e.g., `calc` chains,
  `apply Iff.intro`, `simp`, `grind`, `omega`, structured tactic blocks). Avoid
  `sorry` in final output.
- **Mathlib compatibility:** When Mathlib provides a relevant definition or
  instance, prefer it if it is compatible with the project's conventions. Do not
  silently diverge from Mathlib definitions without noting it.
- **Root import file:** If you create a new `.lean` file, add the corresponding
  `import` to the root file that aggregates all modules.

---

## Blueprint annotation rules

When a Lean declaration is implemented:
- Ensure `\lean{Fully.Qualified.DeclName}` is present in the blueprint
  environment.
- Add `\leanok` to mark the environment as formalised.
- Add `\leanok` inside the corresponding `\begin{proof}...\end{proof}` if the
  proof is complete.
- Do **not** remove or alter `\uses{...}` dependency lists.
- Replace `\notready` with `\leanok` once formalisation is complete.

---

## What NOT to do

- Do not change the mathematical content of blueprint definitions or theorem
  statements.
- Do not rename existing Lean declarations.
- Do not use `sorry` without an explicit comment explaining why, and never in
  final output.
- Do not introduce new axioms or weaken existing ones.
- Do not add `\mathlibok` unless the result is a direct specialisation of a
  named Mathlib lemma.
