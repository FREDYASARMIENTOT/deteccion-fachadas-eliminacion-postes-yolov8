# Detección de Fachadas y Eliminación de Postes con YOLOv8

Este proyecto desarrolla un flujo completo de Visión por Computador diseñado para la identificación de fachadas arquitectónicas y la remoción automatizada de elementos obstructores (postes y cableado aéreo) en entornos urbanos y rurales colombianos.

El sistema utiliza YOLOv8 para la detección de objetos y algoritmos de Inpainting (OpenCV Telea) para la reconstrucción de las zonas ocluidas.

---

## 📌 Contexto del Proyecto

Desarrollado para la materia de **Aplicaciones de Aprendizaje Automático de Máquinas** de la **Maestría en ICT de la Universidad del Rosario**. El enfoque principal es la "limpieza visual" de fotografías arquitectónicas mediante redes neuronales convolucionales.

---

## 🚀 Características Principales

- **Detección Especializada:** Entrenamiento de modelo YOLOv8 para identificar específicamente fachadas (`house`) y postes de servicios públicos (`poste`) en el contexto colombiano.
- **Procesamiento de Dataset:** Curaduría y etiquetado de 40+ imágenes reales (urbanas y rurales) mediante Roboflow.
- **Remoción de Objetos:** Generación automática de máscaras binarias a partir de las bounding boxes detectadas.
- **Restauración (Inpainting):** Uso del algoritmo de Telea para reconstruir el fondo detrás de los postes eliminados, devolviendo la estética a la fachada.

---

## 🛠️ Metodología Técnica

### 1. Dataset y Anotación

- **Origen:** Imágenes capturadas en entornos colombianos (variación de estratos, ángulos e iluminación).
- **Herramienta:** [Roboflow](https://roboflow.com).
- **Augmentation:** Se aplicaron técnicas de Horizontal Flip, Brightness (-15% a +15%) y Rotation (-10° a +10°) para mejorar la robustez del modelo.
- **Split:** 80% Entrenamiento / 20% Validación.

### 2. Entrenamiento (Fine-Tuning)

- **Arquitectura:** YOLOv8n (versión Nano para eficiencia en CPU/GPU).
- **Configuración:** `epochs=30`, `imgsz=640`.
- **Transfer Learning:** Pesos iniciales de `yolov8n.pt` reentrenados para clases personalizadas.

### 3. Pipeline de Inpainting

1. **Extracción de Máscara:** Transformación de coordenadas YOLO a máscaras de bits.
2. **Dilatación:** Uso de `cv2.dilate` para asegurar que el área de inpainting cubra los bordes del poste.
3. **Reconstrucción:** Aplicación de `cv2.inpaint` con el método `INPAINT_TELEA`.

---

## 📊 Resultados y Métricas

El modelo alcanzó un desempeño sólido durante las 30 épocas de entrenamiento:

| Métrica     | Valor  | Descripción                                      |
|-------------|--------|--------------------------------------------------|
| mAP@50      | ~0.85  | Alta precisión en la localización                |
| Precision   | >0.88  | Baja tasa de falsos positivos                    |
| Recall      | >0.80  | Capacidad efectiva de encontrar objetos en escena|

> Las gráficas de entrenamiento se encuentran en la carpeta `runs/detect/train/`.

---

## 📂 Estructura del Repositorio

```
deteccion-fachadas-eliminacion-postes-yolov8/
│── dataset/
│   ├── train/images          # Imágenes de entrenamiento
│   ├── valid/images          # Imágenes de validación
│   ├── test/images           # Imágenes de prueba
│   └── data.yaml             # Configuración de clases y rutas
│── masks_from_labels_valid/  # Máscaras generadas para inpainting
│── inpainting_results/       # Resultados tras la remoción de postes
│── runs/detect/              # Pesos y métricas del entrenamiento
│── entrenamiento_yolov8_fachadas_postes.ipynb
└── README.md
```

---

## ⚙️ Instalación y Uso

### Prerrequisitos

```bash
conda create --prefix D:\environments\venvCasasYpostes python=3.10 -y
conda activate D:\environments\venvCasasYpostes
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu121
pip install ultralytics opencv-python matplotlib numpy scipy pillow jupyter ipykernel
python -m ipykernel install --user --name venvCasasYpostes --display-name "Python (CasasYpostes)"
```

### Ejecución

1. Abre `entrenamiento_yolov8_fachadas_postes.ipynb` en VS Code o Google Colab.
2. Ejecuta la **primera celda** para detectar el entorno automáticamente (`BASE_DIR` se configura según la plataforma).
3. Ejecuta las celdas en orden.

---

## 🔗 Dataset

Dataset disponible en Roboflow:
[fachadas-postes · Roboflow Universe](https://app.roboflow.com/jorges-workspace-otzbe/fachadas-postes/3)