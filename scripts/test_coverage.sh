#!/bin/bash

# --- Colores para la terminal ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🚀 Iniciando pruebas unitarias con Coverage...${NC}"

# 1. Limpiar reportes anteriores
if [ -d "coverage" ]; then
    echo -e "${YELLOW}🧹 Limpiando reportes antiguos...${NC}"
    rm -rf coverage
fi

# 2. Ejecutar tests con el flag de coverage
# Se especifica 'lib' porque los tests fueron movidos a esa carpeta
flutter test --coverage lib

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Tests completados con éxito.${NC}"
    
    # 3. Tip Senior: Filtrar archivos generados de los mocks o de archivos .g.dart
    # Si usas inyección de dependencias o generación de código, esto limpia el reporte:
    if command -v lcov &> /dev/null; then
        echo -e "${BLUE}📊 Generando reporte HTML...${NC}"
        lcov --remove coverage/lcov.info 'lib/**/*.g.dart' 'lib/**/*.freezed.dart' -o coverage/lcov.info
        genhtml coverage/lcov.info -o coverage/html
        echo -e "${GREEN}✨ Reporte listo en: coverage/html/index.html${NC}"
        open coverage/html/index.html
    else
        echo -e "${YELLOW}⚠️  lcov/genhtml no instalados. Solo se generó lcov.info.${NC}"
        echo -e "Tip: En Windows puedes instalarlo con 'choco install lcov' o usar una extensión de VS Code."
    fi
else
    echo -e "\033[0;31m❌ Algunos tests fallaron. Revisa los logs arriba.${NC}"
    exit 1
fi