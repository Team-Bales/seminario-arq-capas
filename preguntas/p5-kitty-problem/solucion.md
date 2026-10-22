# P5: Kitty Problem y Principio Abierto/Cerrado

**Integrante:** Ernesto A. Soler Choong
**Issue:** #9
**Rama:** pregunta/p5-kitty-problem

---

## Respuesta

La respuesta está redactada en **LaTeX**, como fragmento puro del documento final `SemArq1_TeamBales.tex` (igual que P1, P3 y P4):

| Archivo | Contenido |
|---------|-----------|
| [`solucion.tex`](solucion.tex) | Capítulo `\chapter{P5: …}`, sin preámbulo; se incluye con `\include` desde el documento final. Al final carga las notas de investigación con `\input{investigacion/p5-kitty-ocp/notas}` |
| [`referencias.bib`](referencias.bib) | Sin entradas propias: todas las fuentes están en `core.bib` o en el `.bib` de P3 |

Requisitos para el preámbulo común:
- **Paquetes:** `xcolor`, `tikz`, `listings` y `enumitem`.
- **Idioma:** babel en español con `es-nolists`.
- **Citas:** biblatex (APA).

---

## Notas de diseño

- **Fuente del Kitty Problem.** El enunciado lo atribuye a Richards & Ford (2020), pero en la bibliografía consultada aparece en Martin (2017, cap. 27). Se aclara en una nota al pie.
- **"Un solo componente", con matices.** En la solución de Martin, `TaxiUI` también cambia (p. 244); se reconoce explícitamente.
- **Contextos con un modelo mínimo compartido.** `Rides` y `Kittens` son contextos delimitados en su modelo propio, pero comparten a propósito identificadores y abstracciones del núcleo (acoplamiento aceptado).
- **Regla del cliente alérgico.** Es un ejemplo propio: muestra que, con un punto de extensión en el núcleo y los datos propios de `Kittens`, `Rides` no se modifica.
- **Adaptadores.** El capítulo 27 no los menciona. Su papel se fundamenta en Cockburn (2005), Martin (2017, p. 205), De la Torre et al. (2010, pp. 58, 108) y Richards (2015, p. 23), y se presenta como interpretación propia.

---

## Referencias citadas

Ver [`referencias.md`](referencias.md).
