@echo off
echo ============================================================
echo  Creando entorno conda: D:\environments\venvCasasYpostes
echo ============================================================

REM Crear el entorno con Python 3.10 en la ruta especificada
call conda create --prefix D:\environments\venvCasasYpostes python=3.10 -y
if errorlevel 1 (
    echo ERROR: No se pudo crear el entorno conda.
    pause
    exit /b 1
)

REM Activar el entorno
call conda activate D:\environments\venvCasasYpostes
if errorlevel 1 (
    echo ERROR: No se pudo activar el entorno conda.
    pause
    exit /b 1
)

echo.
echo ============================================================
echo  Instalando PyTorch con soporte CUDA 12.1
echo  (Si no tienes GPU NVIDIA, ver comentario abajo)
echo ============================================================
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

REM Si NO tienes GPU NVIDIA, reemplaza la linea anterior por:
REM pip install torch torchvision torchaudio

echo.
echo ============================================================
echo  Instalando ultralytics y demas librerias
echo ============================================================
pip install ultralytics
pip install opencv-python
pip install matplotlib
pip install numpy
pip install scipy
pip install pillow
pip install jupyter
pip install ipykernel

echo.
echo ============================================================
echo  Registrando kernel en Jupyter
echo ============================================================
python -m ipykernel install --user --name venvCasasYpostes --display-name "Python (CasasYpostes)"

echo.
echo ============================================================
echo  Verificando instalaciones
echo ============================================================
python -c "import torch; print('PyTorch:', torch.__version__, '| CUDA disponible:', torch.cuda.is_available())"
python -c "import ultralytics; print('Ultralytics:', ultralytics.__version__)"
python -c "import cv2; print('OpenCV:', cv2.__version__)"

echo.
echo ============================================================
echo  LISTO! Entorno creado en D:\environments\venvCasasYpostes
echo  Kernel registrado como: Python (CasasYpostes)
echo ============================================================
pause
