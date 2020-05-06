if errorlevel 1 exit 1

COPY %PREFIX%\site.cfg site.cfg

python -m pip install . -vv
if errorlevel 1 exit 1
