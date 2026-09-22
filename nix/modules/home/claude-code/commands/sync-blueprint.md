# /sync-blueprint

Write or update blueprint LaTeX content corresponding to the Lean 4 code
specified in the argument.

**Argument:** $ARGUMENTS

The argument may refer to one or more of the following:
- A Lean file path (e.g., `MyProject/Foo/Bar.lean`)
- A Lean declaration name or namespace (e.g., `MyProject.Foo.Bar`)
- A module name (e.g., `Foo.Bar`)

---

## Workflow

1. **Locate the Lean project structure** — read the root `.lean` file and
   `lakefile.toml`/`lakefile.lean` to understand the module layout and project
   name.

2. **Read the relevant Lean source** — read all `.lean` files related to the
   argument. Identify every `def`, `abbrev`, `class`, `structure`, `theorem`,
   `lemma`, `instance`, and notation that should be documented in the blueprint,
   based on their doc-comments and mathematical significance.

3. **Locate the blueprint structure** — find the blueprint source directory
   (typically `blueprint/src/`). Read `content.tex` or the equivalent root file
   to understand the chapter/section organisation and where new content should
   be inserted.

4. **Read the existing blueprint source** — read the relevant `.tex` chapter
   files to understand: which declarations are already documented, what LaTeX
   style and macros are in use, and what the writing conventions are.

5. **Check for an authoritative mathematical source** — if the project
   references an external paper or document (e.g., via `\cite` in the blueprint
   or a README link), use it as the basis for mathematical prose and theorem
   statements, adapting to the blueprint's LaTeX style.

6. **Write or update** the blueprint `.tex` content following all conventions
   below.

7. **Verify cross-references** — ensure `\uses{...}` lists all labels that the
   current environment depends on, and `\lean{...}` refers to the correct
   fully-qualified Lean declaration name.

---

## Blueprint LaTeX conventions

### Preamble and macros

- Read `blueprint/src/preamble/common.tex` (or equivalent) to discover all
  available macros and theorem environments before writing anything.
- Do **not** introduce new LaTeX packages or `\newtheorem` calls in chapter
  files. If a new macro is genuinely needed, add it to the common preamble file
  and note the addition.

### Theorem environments

Use only the environments defined in the project preamble. Typical leanblueprint
projects define: `definition`, `theorem`, `lemma`, `proposition`, `corollary`,
`remark`, `notation`, `example`. Match the exact environment names used in
existing chapter files.

### Mandatory blueprint annotations

Every `definition`, `theorem`, `lemma`, `proposition`, and `corollary`
environment must include:

- `\label{kind:ShortName}` — where `kind` matches the environment (`def`, `thm`,
  `lem`, `prop`, `cor`) and `ShortName` is derived from the Lean declaration
  name (without the project namespace prefix). For example, a declaration
  `MyProject.Foo.myTheorem` gets label `thm:myTheorem`.
- `\lean{Fully.Qualified.DeclName}` — the fully-qualified Lean name, exactly as
  it appears in the Lean source.
- `\uses{label1, label2, ...}` — a comma-separated list of `\label` references
  for all mathematical dependencies. Infer these from the Lean `import`
  structure and the declaration's dependencies. Omit `\uses` only if there are
  genuinely no dependencies.
- `\leanok` — if the declaration is fully formalised in Lean (no `sorry`). Use
  `\notready` if not yet formalised.

`\begin{proof}...\end{proof}` blocks must also include `\leanok` if the proof is
complete in Lean.

### Writing style

- Match the mathematical writing style of the existing chapter files exactly
  (formal prose, notation choices, level of detail in proofs).
- Definitions should state the data/structure first, then the conditions or
  axioms.
- Theorems and lemmas should state hypotheses with "Let …" or "Suppose …", then
  the conclusion.
- Proofs should be mathematically complete but concise — they do not need to
  mirror Lean tactic details, but must make the argument clear.
- For trivial consequences, a one-sentence proof is sufficient.
- Use `\begin{itemize}` for lists of axioms or properties, and `align*` for
  groups of equations, consistent with existing chapters.

### Placement

- Insert new content in the chapter and section where it logically belongs,
  following the order: definitions before theorems that use them; more general
  before more specific.
- Add a new `\section{...}` if needed.
- If a new chapter is needed, create a new `.tex` file and add
  `\input{chapters/...}` (or equivalent) to the root content file.

---

## What NOT to do

- Do not alter the mathematical content of environments that already have
  `\leanok`.
- Do not add `\mathlibok` unless the result is a direct specialisation of a
  named Mathlib lemma (note the Mathlib name in a comment).
- Do not remove `\leanok` from environments that already have it.
- Do not invent theorem statements not present in the Lean source or the
  authoritative mathematical reference.
- Do not introduce new LaTeX packages in chapter files.
