set MSVCDIR_DEFAULT=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community

if "%MSVCDIR%"=="" (
    set "MSVCDIR=%MSVCDIR_DEFAULT%"
    echo Using default MSVCDIR "%MSVCDIR_DEFAULT%", to change set the MSVCDIR environment variable to your install location
) else (
    echo MSVCDIR: "%MSVCDIR%"
)

set VCVARS_DIR="%MSVCDIR%\VC\Auxiliary\Build"

call %VCVARS_DIR%\vcvars64.bat

echo Navigate to source root
cd jasp-desktop

cmake -E remove_directory build

cmake -E make_directory build

echo start build
cmake -S . -B build -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=D:/Qt/6.4.2/msvc2019_64

cmake --build build --target all

cmake --build build --target install

cmake --build build --target collect-junctions

cmake --build build --target wix

cmake --build build --target zip

cmake --build build --target upload
