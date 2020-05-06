REM Install headers with projectConfig.cmake files with cmake

mkdir build
cd build
cmake -G "NMake Makefiles" ^
      -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -D PYBIND11_TEST=OFF ^
      %SRC_DIR%
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1

REM Install Python package
set PYBIND11_USE_CMAKE=1
cd %SRC_DIR%
python %SRC_DIR%\setup.py install --single-version-externally-managed --record record.txt
