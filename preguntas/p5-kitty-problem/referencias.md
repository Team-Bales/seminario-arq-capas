# Referencias — P5: Kitty Problem y Principio Abierto/Cerrado

Fuentes citadas en [`solucion.tex`](solucion.tex). Toda fuente de esta lista aparece citada en la respuesta, y viceversa. Las entradas BibTeX están en `core.bib` y, para `palermo2008`, en `preguntas/p3-ddd-bounded-context/referencias.bib`.

## Fuentes primarias

| Fuente | Capítulo / Sección | Concepto que justifica |
|--------|--------------------|------------------------|
| Martin (2017) — *Clean Architecture* | Cap. 8, pp. 70, 73-74 | OCP (Meyer, cita indirecta); OCP a nivel arquitectónico; jerarquía de protección |
| Martin (2017) | Cap. 9, p. 80 | Primera aparición del agregador de taxis |
| Martin (2017) | Cap. 13, pp. 105-106 | CCP; cierre estratégico; vínculo explícito con el Kitty Problem |
| Martin (2017) | Cap. 17, p. 173 | Las fronteras se trazan sobre los ejes de cambio |
| Martin (2017) | Cap. 22, pp. 203, 205 | Regla de Dependencia; capa de adaptadores de interfaz |
| Martin (2017) | Cap. 26, pp. 232, 237 | Componente `Main` como *plugin* de configuración |
| Martin (2017) | Cap. 27, pp. 240-247 | Falacias de los servicios; Kitty Problem; solución con `Rides` y `Kittens`; las fronteras atraviesan los servicios |
| Richards (2015) — *Software Architecture Patterns* | Cap. 3, pp. 22-26 | Patrón microkernel: plug-ins y registro (p. 22), adaptador de contrato (p. 23), diseño evolutivo (pp. 24-25), análisis de características (pp. 25-26) |
| Richards & Ford (2020) — *Fundamentals of Software Architecture* | Cap. 8 ("Architecture Partitioning", "Entity trap") | Partición técnica vs. por dominio; *entity trap* |
| Richards & Ford (2020) | Cap. 17 ("Granularity") | Cohesión funcional; riesgo de servicios demasiado pequeños |
| Palermo (2008) — *The Onion Architecture: Part 1* | Artículo completo | Interfaces en el núcleo e implementaciones en los bordes |

## Fuentes citadas indirectamente

- Meyer, B. (1988). *Object-Oriented Software Construction*. Citado "como se citó en Martin (2017, p. 70)". No consultado directamente.
