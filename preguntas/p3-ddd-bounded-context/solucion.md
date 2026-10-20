# P3: DDD y Bounded Context — Sistema de Seguros

**Integrante:** Ernesto A. Soler Choong
**Issue:** #5
**Rama:** pregunta/p3-ddd-bounded-context

---

## Respuesta

La respuesta está redactada en **LaTeX**, para integrarse directamente en el documento final del seminario:

| Archivo | Contenido |
|---------|-----------|
| [`solucion.tex`](solucion.tex) | Texto de la respuesta (sección para incluir con `\input{}` en el documento final) |
| [`referencias.bib`](referencias.bib) | Referencias en formato BibTeX (APA 7 con `biblatex` + `biber`) |
| [`p3-standalone.tex`](p3-standalone.tex) | Documento autónomo con el preámbulo, para compilar y revisar P3 por separado |

Compilación (desde esta carpeta):

```
pdflatex -output-directory=build p3-standalone.tex
cd build && biber --input-directory=.. p3-standalone && cd ..
pdflatex -output-directory=build p3-standalone.tex
pdflatex -output-directory=build p3-standalone.tex
```

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
