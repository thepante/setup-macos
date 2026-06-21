## Rules for generated code

Do not use emoji in the generated content. NEVER.
Try to match and follow existing coding style and nomeclature.

Limit yourself to do the asked task, do not try to do more than that.

Do not write comments unless to express implementation decisions. Never comment logic, you should use the code itself to express that logic. Comments should be used to explain why the code is written the way it is, not what the code does.

DO NOT WRITE DOCUMENTATION FILES UNLESS EXPLICITLY ASKED FOR BY THE USER.
LIMIT YOURSELF TO DO ONLY THE ASKED TASK.

## Stop Slop (Bilingual EN/ES)

Write human way. Eliminate predictable AI writing patterns in English and Spanish.

## 1. Core Rules & Formatting
* **Active Voice Only:** Humans do things. No passive voice (*Voz pasiva*). No inanimate objects with agency (e.g., use "The team fixed it," not "The complaint becomes a fix" / Use "El equipo lo arregló," not "La queja se convirtió en solución").
* **Be Specific:** Name the specific actor or constraint. Cut vague extremes (every, always, nobody / todos, siempre, nadie) and vague declaratives ("The implications are significant" / "Las implicaciones son profundas").
* **Show, Don't Tell:** Don't announce difficulty or importance ("This is genuinely hard", "This actually matters" / "Esto es realmente difícil", "Esto es lo que importa").
* **Put Reader in the Room:** Use "You" (*Tú/Usted*). No narrator-from-a-distance ("Nobody designed this" / "Nadie diseñó esto").
* **Rhythm:** Vary sentence lengths. Avoid 3-item lists. **Never use em-dashes (—).** Do not end every paragraph with a punchy one-liner.
* **No Wh- Openers:** Restructure sentences starting with What, When, Why, How / Qué, Cuándo, Por qué, Cómo. Don't start paragraphs with "So" or "Entonces".

## 2. Banned Words & Phrases (EN/ES)
* **No Adverbs / Sin adverbios:** Kill -ly / -mente words (really, simply, literally, actually / realmente, simplemente, literalmente, actualmente, fundamentalmente).
* **No Throat-Clearing / Sin rodeos:** Cut "Here's the thing/why," "It turns out," "The truth is," "At its core," "In today's world" / "Es importante destacar que," "En el mundo actual," "La realidad es que," "Resulta que," "Cabe decir que."
* **No Emphasis Crutches:** Cut "Full stop," "Period," "Make no mistake," "I promise" / "Punto final," "No te equivoques," "Te lo prometo," "De hecho."
* **No Meta-Commentary:** Cut "Plot twist," "Hint," "Think about it," "As we'll see" / "Spoiler," "Piénsalo bien," "Como veremos," "En conclusión," "En resumen."
* **No Jargon:** Replace navigate, unpack, leverage, synergy / navegar, desglosar, apalancar, sinergia, empoderar.

## 3. Banned Structures
* **No Binary Contrasts:** Never use "Not X, but Y" or "X isn't the problem, Y is" / "No es X, sino Y" or "El problema no es X, es Y." Drop the negation and state Y directly.
* **No Negative Listing:** Don't list what something *is not* before revealing what it *is*. State the point immediately.
* **No Rhetorical Setups:** Skip Socratic posturing ("What if...?") and unnecessary permissions ("And that's okay" / "Y eso está bien").

## 4. Scoring (Revise if < 35/50)
1. **Directness:** Statements or announcements?
2. **Rhythm:** Varied or metronomic?
3. **Trust:** Respects reader intelligence?
4. **Authenticity:** Sounds human?
5. **Density:** Anything cuttable?

## 5. Before/After Examples (ES/EN)
* **Bad (ES):** La realidad es que construir productos es difícil. No por la tecnología, sino por las personas. Piénsalo bien.
    **Good:** Construir productos es difícil. La tecnología es manejable. Las personas no.
* **Bad (EN):** Here's the thing: speed matters. Not because of the market, but because of survival. 
    **Good:** Speed ensures survival.
* **Bad (ES):** En el mundo actual, debemos apalancar la sinergia del equipo. Punto final.
    **Good:** El equipo debe trabajar unido.

## Tests

DO NOT WRITE TESTS UNLESS STRICTLY REQUESTED FOR IT BY THE USER.

## Tools usage and Version Control

Git:
- NEVER run `git add` or `git commit`.

Files:
- When assets are needed, always download the original files and rename or modify them as required.
- NEVER recreate or manually rewrite files that can be obtained directly (avoids errors).

File operations:
- When moving files, use `mv`.
- NEVER recreate files just to move or rename them.
- When deleting files, use `trash` instead of `rm`.
- Before deleting or performing heavy modifications, create a backup using `cp`, appending `.bak` to the filename.
