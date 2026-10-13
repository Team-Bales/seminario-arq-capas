<!--
  Selecciona el tipo de PR marcando con [x] y borra la sección que no aplique.
  Las líneas que empiezan con <!-- son comentarios y no se muestran en el PR.
-->

## Tipo de PR

- [ ] Solución de pregunta (`preguntas/pN-tema/`)
- [ ] Investigación (`investigacion/pN-tema/`)
- [ ] Corrección / ajuste

---

## Referencia

**Issue relacionado:** Closes #<!-- número del issue -->
**Pregunta(s) que cubre:** P<!-- N -->
**Integrante responsable:** <!-- Nombre Apellido -->

---

<!-- ═══════════════════════════════════════════════════════════
     SECCIÓN A — llenar si este PR es una SOLUCIÓN DE PREGUNTA
     ═══════════════════════════════════════════════════════════ -->

## A. Solución de pregunta

> Llenar solo si el tipo es "Solución de pregunta". Borrar si no aplica.

### Resumen de la respuesta

<!-- Una síntesis de 3-5 líneas de lo que argumenta la solución.
     El revisor debe poder entender la tesis sin leer el archivo completo. -->

### Decisiones no evidentes

<!-- Cada punto que no sea directamente deducible del enunciado o la bibliografía
     requiere una nota aquí. Explica el razonamiento que te llevó a esa elección.
     Ejemplos: por qué aplicaste Clean y no Hexagonal, por qué descartaste X,
     por qué la analogía del ejemplo usa ese dominio específico. -->

- [ ] Decisión 1 — justificación: ...
- [ ] Decisión 2 — justificación: ...

### Citas que respaldan cada parte de la respuesta

<!-- Para cada afirmación no trivial de solucion.md, confirma aquí que tiene cita.
     Formato: "Afirmación → (Autor, año, p. XX)" -->

| Afirmación en solucion.md | Fuente que la respalda |
|---------------------------|------------------------|
| ...                       | (Autor, año, p. XX)    |

### Checklist de solución

- [ ] `solucion.md` responde todos los sub-apartados del enunciado
- [ ] `referencias.md` lista todas las fuentes citadas en `solucion.md`
- [ ] Toda afirmación no trivial tiene cita en formato (Autor, año, p. XX)
- [ ] No hay afirmaciones que dependan solo de conocimiento previo sin cita
- [ ] El archivo sigue el formato definido en [CONTRIBUTING.md](../CONTRIBUTING.md)

---

<!-- ═══════════════════════════════════════════════════════════
     SECCIÓN B — llenar si este PR es una INVESTIGACIÓN
     ═══════════════════════════════════════════════════════════ -->

## B. Investigación

> Llenar solo si el tipo es "Investigación". Borrar si no aplica.

### Qué cubre esta investigación

<!-- Lista de conceptos investigados y su relevancia para las preguntas del seminario. -->

- **Concepto principal:** ...
- **Preguntas que alimenta:** P...

### Síntesis de hallazgos

<!-- 3-5 líneas. Qué encontraste, qué fue sorprendente o contraintuitivo,
     qué concepto cambió tu comprensión inicial. -->

### Fuentes documentadas

<!-- Para cada fuente en fuentes.md confirma que cumple los requisitos de verificabilidad. -->

| Fuente | Tipo | Verificable vía |
|--------|------|-----------------|
| Martin (2017) — *Clean Architecture* | Libro | ISBN / O'Reilly Learning |
| Cockburn (2005) — Hexagonal Architecture | Web oficial | https://alistair.cockburn.us/hexagonal-architecture/ |

### Checklist de investigación

- [ ] `notas.md` sintetiza el tema con palabras propias (no copia textual)
- [ ] `fuentes.md` lista todas las fuentes con acceso verificable
- [ ] Cada fuente tiene: tipo, acceso (ISBN o URL), secciones relevantes y conceptos extraídos
- [ ] Los conceptos en `notas.md` tienen cita de página o sección específica
- [ ] No hay fuentes de blogs sin autor o resúmenes de terceros sin citar el original
- [ ] La investigación cubre todos los items del checklist del issue correspondiente

---

## Notas para el revisor

<!-- Cualquier cosa que el revisor deba saber antes de empezar:
     secciones pendientes, dudas sobre una fuente, partes que necesitan
     discusión del equipo, etc. Dejar vacío si no hay nada especial. -->
