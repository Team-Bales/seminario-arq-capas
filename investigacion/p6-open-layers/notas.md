# INV-P6: Open Layers y Sinkhole Anti-pattern

**Integrante:** Enrique A Gonzalez Moreira
**Issue:** #12
**Cubre preguntas:** P6

---

## Síntesis

La arquitectura en capas (N-Capas) organiza el sistema en capas horizontales donde cada capa solo conoce a la capa inmediatamente inferior. Una capa puede ser **cerrada** (una solicitud no puede saltarse ninguna capa intermedia) o **abierta** (una solicitud puede evitar la capa y acceder directamente a una capa más profunda). Las capas abiertas se introdujeron para resolver el problema de que una solicitud simple tuviera que atravesar varias capas sin que ninguna agregara valor —por ejemplo, el patrón **fast-lane reader**, que permite lecturas directas a la base de datos evitando la capa de negocio.

Sin embargo, abrir capas tiene un costo: debilita el concepto de **layers of isolation** (aislamiento de capas), que garantiza que los cambios en una capa no afecten a las demás. Cuando una capa intermedia deja de agregar lógica y solo reenvía solicitudes a la inferior, surge el **sinkhole anti-pattern** (agujero negro): una capa que absorbe peticiones sin transformarlas. La regla del **80-20** ayuda a decidir si abrir capas está justificado: si solo el 20% de las solicitudes son passthrough simples, abrir capas puede ser aceptable; si el 80% lo son, la arquitectura en capas no es el estilo correcto para ese dominio.

Para sistemas con alta escalabilidad y agilidad, las arquitecturas Hexagonal y Clean son estructuralmente más adecuadas porque invierten las dependencias: el núcleo de negocio define puertos (interfaces) y la infraestructura los implementa, sin que el núcleo conozca detalles externos.

---

## Conceptos clave

| Concepto | Definición | Fuente |
|----------|-----------|--------|
| Capa cerrada (Closed Layer) | Capa que no puede ser saltada; toda solicitud debe atravesarla para llegar a la capa inferior | Richards & Ford (2020), Cap. 10 |
| Capa abierta (Open Layer) | Capa que puede ser evitada por una solicitud, permitiendo acceso directo a capas más profundas | Richards & Ford (2020), Cap. 10 |
| Layers of Isolation | Concepto por el cual cambios en una capa no impactan a otras, siempre que los contratos entre capas se mantengan | Richards & Ford (2020), Cap. 10; Richards (2015), Cap. 1 |
| Fast-lane reader | Patrón que permite lecturas directas a la base de datos evitando la capa de negocio, para consultas simples de alto volumen | Richards & Ford (2020), Cap. 10; Richards (2015), Cap. 1 |
| Sinkhole anti-pattern | Capa intermedia que no agrega valor y solo reenvía solicitudes a la capa inferior (passthrough) | Richards & Ford (2020), Cap. 10; Richards (2015), Cap. 1 |
| Regla del 80-20 | Criterio para evaluar sinkhole: si el 20% de las solicitudes son passthrough es aceptable; si el 80% lo son, N-Capas no es el estilo adecuado | Richards & Ford (2020), Cap. 10; Richards (2015), Cap. 1 |
| Regla de Dependencia | Las dependencias del código fuente apuntan solo hacia adentro, hacia políticas de alto nivel | Martin (2017), Cap. 22, p. 203 |
| Testable | El núcleo de negocio puede probarse sin UI, base de datos, servidor web ni servicios externos | Martin (2017), Cap. 22, p. 202 |

---

## Puntos de conexión con las preguntas

- **P6:** Este tema proporciona la base teórica para responder cómo las capas abiertas afectan el Aislamiento de Capas y la mantenibilidad, por qué pueden llevar a sinkhole anti-pattern, qué dice la regla del 80-20 al respecto, y por qué Hexagonal y Clean Architecture son inherentemente más adecuadas para alta escalabilidad y agilidad que N-Capas, incluso con optimizaciones como capas abiertas o fast-lane reader.

---

## Checklist de investigación

- [x] Capa cerrada vs. capa abierta — (Richards & Ford, 2020, Cap. 10)
- [x] Layers of isolation — (Richards & Ford, 2020, Cap. 10; Richards, 2015, Cap. 1)
- [x] Fast-lane reader — (Richards & Ford, 2020, Cap. 10; Richards, 2015, Cap. 1)
- [x] Sinkhole anti-pattern — (Richards & Ford, 2020, Cap. 10; Richards, 2015, Cap. 1)
- [x] Regla del 80-20 — (Richards & Ford, 2020, Cap. 10; Richards, 2015, Cap. 1)
- [x] Regla de Dependencia — (Martin, 2017, Cap. 22, p. 203)
- [x] Testabilidad del núcleo — (Martin, 2017, Cap. 22, p. 202)
- [x] Comparación con Hexagonal/Clean — (Martin, 2017, Cap. 22; Cockburn, 2005; Palermo, 2008)
