# 💳 BancoCL - Sistema de Gestión de Cuotas y Pagos

> Proyecto de MySQL que simula el sistema de un banco real para administrar clientes, tarjetas, cuotas de manejo y pagos, con procedimientos almacenados y triggers inteligentes.

---

## 📘 Descripción General

**BancoCL** es una base de datos relacional desarrollada en MySQL que automatiza la gestión de:

- Clientes y sus tarjetas bancarias.
- Cuotas de manejo con descuentos por niveles.
- Historial de pagos.
- Reportes automáticos sobre ingresos, pagos y proyecciones.


---

## 🧠 Objetivos del Proyecto

- 📌 Practicar diseño relacional avanzado y normalización.
- 📊 Obtener reportes financieros a partir de consultas SQL.
- 🧪 Simular un entorno bancario funcional para propósitos educativos y de portafolio.

---

## 🧱 Modelo de Datos

El sistema está conformado por las siguientes entidades clave:

| Tabla               | Descripción                                                  |
|---------------------|--------------------------------------------------------------|
| `tipos_tarjeta`     | Tipos de tarjetas bancarias: Crédito, Débito, Prepago.       |
| `niveles_descuento` | Descuentos aplicables según el nivel del cliente.            |
| `clientes`          | Información personal y bancaria de los usuarios.             |
| `tarjetas`          | Relación cliente-tipo de tarjeta, con fecha de activación.   |
| `cuotas_manejo`     | Cuotas periódicas generadas, con valor base y descuento.     |
| `historial_pagos`   | Registro de cada pago realizado por los clientes.            |

📎 *Incluye un diagrama relacional detallado en `modelo_datos.png`.*

---


## 🧱 Estructura del Proyecto

```
PROYECTO-MYSQL2/
│
├── data/
│   ├── ddl.sql               # Definición de estructura (tablas y relaciones)
│   ├── dml.sql               # Inserción de datos base
│   └── diagrama.png          # Diagrama Entidad-Relación del sistema
│
├── dql_funciones.sql         # Funciones definidas por el usuario
├── dql_procedimientos.sql   # Procedimientos almacenados
├── dql_select.sql            # Consultas SELECT para análisis y reportes
├── dql_eventos.sql           # Eventos programados
├── dql_triggers.sql          # Triggers para automatización de acciones
└── readme.MD                 # Documentación del proyecto
```

---

## ⚙️ Componentes del Proyecto

### 📐 `data/ddl.sql`
- Crea las tablas necesarias y define claves primarias y foráneas.

### 📥 `data/dml.sql`
- Inserta registros de ejemplo: tipos de tarjeta, niveles de descuento, clientes, tarjetas, cuotas y pagos.

### 📊 `data/diagrama.png`
- Representación visual del modelo entidad-relación del sistema.

### 🧠 `dql_funciones.sql`
Contiene **funciones definidas por el usuario** que encapsulan lógica de negocio y cálculos específicos, como:
- Obtener el valor final de una cuota con descuento aplicado.
- Calcular el porcentaje descontado según el nivel del cliente.
- Determinar si una cuota está vencida.

Estas funciones facilitan la reutilización y simplifican los procedimientos y triggers.

---

### 🔁 `dql_procedimientos.sql`
Incluye **procedimientos almacenados** para automatizar tareas recurrentes del sistema, tales como:
- Registrar nuevas cuotas de manejo con descuentos dinámicos.
- Procesar pagos de cuotas y actualizar automáticamente el historial.
- Generar reportes mensuales de ingresos, pagos realizados y proyecciones.
- Registrar nuevos clientes y vincular tarjetas activas.
- Aplicar ajustes de valor base o de nivel de descuento según condiciones específicas.

Todos los procedimientos han sido validados con datos reales.

---

### ⚠️ `dql_triggers.sql`
Contiene **triggers (disparadores)** que reaccionan automáticamente a cambios en las tablas clave, asegurando la integridad de los datos. Incluye:
- Creación automática de la fecha de vencimiento al insertar una cuota.
- Registro en el historial de pagos cuando se realiza un pago válido.
- Prevención de inserciones o modificaciones erróneas en cuotas vencidas.
- Lógica para actualizar el estado de pagos y notificaciones internas.

Estos triggers garantizan reglas de negocio en tiempo real, sin intervención manual.

---

### ⏰ `dql_eventos.sql`
Contiene **eventos programados** usando `EVENT` de MySQL para ejecutar tareas automáticas según el tiempo. Ejemplos:
- Verificar diariamente cuotas vencidas y marcar alertas.
- Aplicar recargos a pagos vencidos si supera un número de días.
- Revisión mensual de niveles de descuento para actualizar condiciones.

Cada evento está programado con intervalos simulados para facilitar pruebas.

---

### 📑 `dql_select.sql`
Incluye más de **30 consultas SQL** enfocadas en análisis, monitoreo y reportes de negocio. Algunas de las más destacadas:
- Cuotas pendientes con más de 5 días de vencimiento.
- Total de dinero descontado en el año actual.
- Clientes con mayor número de pagos realizados.
- Promedio de ingresos por tipo de tarjeta.
- Proyección de ingresos futuros según cuotas registradas.

Las consultas cubren tanto reportes operativos como análisis financiero.

---


## 💡 Tecnologías Usadas

- **MySQL 8+**
- Modelo Entidad-Relación (E-R)
- Consultas complejas (JOINs, subqueries, funciones de agregación)
- DrawSQL

---

## 👨‍💻 Autores del Proyecto

- **Kevin Santiago Gutiérrez Amorocho**
- **Dylan Sneider Rueda Cardenas**

---

## 🏁 Estado del Proyecto

✅ Finalizado y 100% funcional  
🧩 Escalable: puede integrarse con backends en Python, PHP o Node.js  

---

## 📌 Licencia

Este proyecto está disponible para fines educativos. Si deseas adaptarlo para uso comercial o académico, por favor da crédito al autor.

---

## ⭐ ¿Te fue útil?

Si este proyecto te ayudó a aprender más sobre bases de datos, ¡considera darle una estrella ⭐ en GitHub!
```
