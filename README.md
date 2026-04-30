# Auth Service

Microservicio de autenticación y autorización para la plataforma **MeTradingPlat**. Se encarga de la gestión de usuarios, roles (RBAC) y la generación de tokens JWT para asegurar la comunicación entre microservicios.

## Tabla de Contenido

- [Arquitectura](#arquitectura)
- [Tecnologías](#tecnologias)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [API Endpoints](#api-endpoints)
- [Seguridad](#seguridad)
- [Base de Datos](#base-de-datos)
- [Configuración](#configuracion)
- [Ejecución](#ejecucion)

## Arquitectura

El servicio sigue una arquitectura limpia orientada a dominio, integrándose con Spring Security para el manejo de la seguridad.

## Tecnologías

| Tecnología | Versión | Propósito |
|---|---|---|
| Java | 21 | Lenguaje principal (Virtual Threads) |
| Spring Boot | 3.5.14 | Framework |
| Spring Security | - | Autenticación y Autorización |
| Spring Data JPA | - | Persistencia |
| PostgreSQL | 15 | Base de datos |
| JWT (JJWT) | 0.11.5 | Generación de tokens |
| Docker | Multi-stage | Contenedorización |

## Estructura del Proyecto

```
src/main/java/com/metradingplat/auth/
├── application/
│   ├── input/                          # Casos de uso
│   └── output/                         # Adaptadores de salida
├── domain/
│   ├── models/                         # Usuario, Rol
│   └── repository/                     # Interfaces de persistencia
├── infrastructure/
│   ├── configuration/                  # SecurityConfig, BeanConfig
│   ├── input/
│   │   └── rest/                       # AuthController
│   └── output/
│       └── persistence/                # Implementación JPA
└── security/                           # JwtUtil, UserDetailsServiceImpl
```

## API Endpoints

Base path: `/api/auth`

| Método | Path | Descripción |
|---|---|---|
| `POST` | `/api/auth/login` | Iniciar sesión y obtener JWT |
| `POST` | `/api/auth/register` | Registrar un nuevo usuario |

## Seguridad

### Roles (RBAC)
- **ROLE_EDITOR**: Permiso total (lectura y escritura).
- **ROLE_VIEWER**: Permiso de solo lectura (GET).

### JWT
- Los tokens tienen una validez de 24 horas por defecto.
- La firma se realiza mediante una clave secreta configurada por variable de entorno.

## Base de Datos

- **Motor**: PostgreSQL 15
- **Base de datos**: `bd_auth`
- **Datos iniciales**: `import.sql` (crea usuarios `admin` y `user` con contraseñas por defecto).

## Configuración

### Variables de Entorno

| Variable | Descripción | Default |
|---|---|---|
| `DB_HOST` | Host de PostgreSQL | `postgres-auth` |
| `DB_NAME` | Nombre de la BD | `bd_auth` |
| `JWT_SECRET` | Clave secreta para JWT | (Obligatorio) |
| `EUREKA_HOST` | Host de Eureka | `directory` |

## Ejecución

### Con Docker Compose

```bash
# Desde la raiz de metradingplat/
docker compose up -d auth-service
```

### Desarrollo Local

```bash
cd auth-service
# Requiere Java 21, Maven, PostgreSQL
mvn spring-boot:run
```
