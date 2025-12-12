# 📱 Mind Your Business (MYB) - Frontend

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Web](https://img.shields.io/badge/Platform-Web%20%7C%20Android-green)

**Mind Your Business (MYB)** es la interfaz visual de una aplicación Full Stack diseñada para democratizar la comprensión de las nóminas laborales. Desarrollada con **Flutter**, ofrece una experiencia de usuario (UX) fluida, moderna y reactiva.

---

## Características Principales

* **⚡ Diseño Reactivo:** Interfaz construida con `StatefulWidgets` para gestionar estados de carga y respuesta en tiempo real.
* **📂 Gestión de Archivos:** Integración nativa para la selección y subida de documentos PDF mediante `file_picker`.
* **🔗 Conexión Full Stack:** Comunicación asíncrona con una API REST (FastAPI) mediante peticiones HTTP `Multipart`.
* **🎨 UI/UX Limpia:** Uso de Material Design 3 para una visualización clara de datos financieros complejos (Gráficos, Tarjetas, Listas).
* **🛡️ Feedback Visual:** Manejo de errores y estados de carga (Spinners, Snackbars) para mantener al usuario informado.

---

## 🛠️ Arquitectura del Proyecto

El código sigue una arquitectura limpia basada en la separación de responsabilidades:

```text
lib/
├── screens/         # Vistas de la aplicación (UI)
│   ├── upload_screen.dart   # Lógica de subida y estados de carga
│   └── results_screen.dart  # Visualización de datos (Stateless)
├── services/        # Capa de comunicación con el Backend
│   └── api_service.dart     # Cliente HTTP y manejo de JSON
└── main.dart        # Punto de entrada y configuración del tema
