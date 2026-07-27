@echo off
echo ===================================================
echo   Local Web Server for PDF Annotator MVP
echo ===================================================
echo.
echo Make sure you have built the web version first by running:
echo   flutter build web
echo.
echo Starting server on http://localhost:8080...
cd build\web
python -m http.server 8080
