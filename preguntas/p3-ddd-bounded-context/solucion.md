# P3: DDD y Bounded Context — Sistema de Seguros

**Integrante:** Ernesto A. Soler Choong
**Issue:** #5
**Rama:** pregunta/p3-ddd-bounded-context

---

## Respuesta

La respuesta está redactada en **LaTeX**, como fragmento puro del documento final `SemArq1_TeamBales.tex` (igual que P1 y P4):

| Archivo | Contenido |
|---------|-----------|
| [`solucion.tex`](solucion.tex) | Capítulo `\chapter{P3: …}`, sin preámbulo; se incluye con `\include` desde el documento final. Al final carga las notas de investigación con `\input{investigacion/p3-bounded-context/notas}` |
| [`referencias.bib`](referencias.bib) | Solo las fuentes que no están en `core.bib` (`palermo2008`) |

Requisitos para el preámbulo común:
- **Paquetes:** `xcolor`, `tikz`, `listings`, `booktabs`, `tabularx`, `array` y `enumitem`.
- **Idioma:** babel en español con `es-nolists`.
- **Citas:** biblatex (APA).

Los colores, el estilo del listado y las librerías TikZ se definen dentro del propio fragmento.

---

## Notas de diseño

- **Cuatro contextos delimitados:** Suscripción y Pólizas, Facturación de Primas, Siniestros y Peritaje. Peritaje se separa de Siniestros por tres motivos:
  - tiene un lenguaje propio;
  - no comparte transacción con Siniestros;
  - sus características operativas son distintas (app móvil usada en campo).

  La alternativa de integrarlo en Siniestros se discute en el texto.
- **Comunicación:** eventos de dominio asíncronos (topología *broker*) como mecanismo por defecto. Hay una única consulta síncrona (`ConsultarCobertura`), porque Siniestros necesita certeza sobre la cobertura en la fecha del siniestro.
- **Context Map de Evans (ACL, Shared Kernel, etc.):** no está en la bibliografía oficial. El aislamiento se fundamenta con los Agentes de Servicios de De la Torre et al. (2010) y con los adaptadores de Cockburn (2005) y Martin (2017). El término *Anti-Corruption Layer* aparece solo en una nota al pie, como orientación.
- **Cita de Evans:** el enunciado lo nombra, pero su libro no está en la bibliografía oficial. Se cita de forma indirecta: "como se citó en Richards & Ford, 2020".
- **"Adaptador de Servicio":** en la Guía de De la Torre et al. (2010) se llama "Agentes de Servicios externos". Se aclara en el texto.

---

## Referencias citadas

Ver [`referencias.md`](referencias.md) y [`referencias.bib`](referencias.bib).
