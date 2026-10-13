# Guía de contribución

Esta guía define cómo trabajar en este repositorio. Léela antes de abrir un PR.

---

## Flujo de trabajo

```
1. Asignarse el issue correspondiente (pregunta o investigación)
2. Crear una rama con el formato: tipo/px-descripcion-corta
   - pregunta/p1-trade-offs
   - investigacion/p1-regla-dependencia
3. Trabajar en la carpeta correspondiente (preguntas/ o investigacion/)
4. Abrir PR apuntando a main
5. Completar la plantilla de PR (carga automáticamente)
6. Solicitar revisión de al menos un integrante del equipo
7. Merge solo cuando el revisor aprueba
```

### Convención de ramas

| Tipo | Formato | Ejemplo |
|------|---------|---------|
| Solución de pregunta | `pregunta/pN-slug` | `pregunta/p3-ddd-bounded-context` |
| Investigación | `investigacion/pN-slug` | `investigacion/p3-bounded-context` |
| Corrección | `fix/pN-descripcion` | `fix/p1-referencias-faltantes` |

---

## Formato de archivos

### Solución de pregunta (`preguntas/pN-tema/solucion.md`)

```markdown
# P[N]: [Título de la pregunta]

**Integrante:** Nombre Apellido
**Issue:** #N
**Rama:** pregunta/pN-slug

---

## Respuesta

[Desarrollo argumentado. Cada afirmación no trivial debe tener una cita
en formato (Autor, año, p. XX) o una nota al pie.]

### [Sub-sección por apartado de la pregunta]

...

---

## Notas de diseño

[Decisiones tomadas al redactar la respuesta que no son evidentes:
por qué se eligió este ángulo, qué alternativa se descartó y por qué.]

---

## Referencias citadas

- Autor, A. (año). *Título*. Editorial. p. XX.
```

### Referencias de pregunta (`preguntas/pN-tema/referencias.md`)

```markdown
# Referencias — P[N]

Lista de fuentes consultadas para esta respuesta. Toda fuente aquí
debe aparecer citada en solucion.md y viceversa.

## Fuentes primarias

| Fuente | Capítulo / Sección | Concepto que justifica |
|--------|--------------------|------------------------|
| Martin (2017) — *Clean Architecture* | Cap. 22 | La Regla de Dependencia |
| Cockburn (2005) — *Hexagonal Architecture* | Sección "The hexagon" | Simetría del hexágono |

## Fuentes secundarias (si aplica)

...
```

### Notas de investigación (`investigacion/pN-tema/notas.md`)

```markdown
# INV-P[N]: [Tema de investigación]

**Integrante:** Nombre Apellido
**Issue:** #N
**Cubre preguntas:** P[N]

---

## Síntesis

[Resumen del tema en 200-400 palabras. Qué es, qué problema resuelve,
cómo funciona. Sin copiar textualmente — síntesis propia.]

## Conceptos clave

| Concepto | Definición | Fuente |
|----------|-----------|--------|
| Regla de Dependencia | Las dependencias del código fuente solo pueden apuntar hacia adentro | Martin (2017), p. 203 |

## Puntos de conexión con las preguntas

- **P[N]:** [cómo este tema ayuda a responder esa pregunta]

---

## Checklist de investigación

- [ ] Concepto A — (Autor, año, p. XX)
- [ ] Concepto B — (Autor, año, p. XX)
```

### Fuentes de investigación (`investigacion/pN-tema/fuentes.md`)

```markdown
# Fuentes — INV-P[N]

Toda fuente listada aquí debe ser verificable. Si es online, incluir URL
y fecha de acceso. Si es libro, incluir ISBN o URL de la editorial.

## Fuentes documentadas

### [Apellido, año] — Título completo

- **Tipo:** Libro / Artículo / Web oficial / Paper
- **Acceso:** ISBN XXXX / https://... (consultado YYYY-MM-DD)
- **Secciones relevantes:** Cap. X, pp. YY-ZZ
- **Verificabilidad:** [Disponible en biblioteca / O'Reilly Learning / URL pública]
- **Conceptos extraídos:**
  - Concepto A — pág. XX
  - Concepto B — pág. YY
```

---

## Qué NO hacer

- No abrir un PR sin completar la plantilla.
- No hacer merge sin revisión.
- No citar fuentes que no puedas verificar (blogs sin autor, resúmenes de terceros sin cita original).
- No mezclar solución e investigación en la misma rama.
