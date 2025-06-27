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
- Inserta registros de ejemplo: tipos de tarjeta, niveles de descuento, clientes, etc.

### 📊 `data/diagrama.png`
- Representación visual del modelo de datos (entidades y relaciones).

### 🧠 `dql_funciones.sql`
- Funciones personalizadas para:
  - Calcular descuentos.
  - Evaluar montos y condiciones.

### 🔁 `dql_procedimientos.sql`
- Procedimientos para:
  - Registrar nuevas cuotas automáticamente.
  - Procesar pagos.
  - Generar reportes financieros.

### ⚠️ `dql_triggers.sql`
- Triggers reactivos para:
  - Registrar pagos automáticamente en el historial.
  - Establecer fechas de vencimiento.
  - Validar cambios importantes.

### ⏰ `dql_eventos.sql`
- Automatización mediante eventos programados (cron jobs internos de MySQL).

### 📑 `dql_select.sql`
- Consultas para:
  - Listar cuotas vencidas.
  - Calcular ingresos proyectados.
  - Medir descuentos aplicados.
  - Detectar inactividad de clientes.

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
