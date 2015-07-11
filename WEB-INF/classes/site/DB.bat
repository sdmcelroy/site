@echo off

set java=C:\Program Files\Java\jdk1.8.0_31
set javabin=%java%\bin
set javac=%javabin%\javac.exe
set javalib=%java%\lib

set site=C:\xampp\tomcat\webapps\ROOT\WEB-INF
set siteLib=%site%\lib
set siteSrc=%site%\src

set fpath=%~dp0
set fname=%~n0
set fsrc=%fpath%\%fname%.java
echo Source File
echo %fsrc%

echo Classpath
echo %javalib%
echo %siteLib%

echo Sourcepath
echo %siteSrc%

set cmd="%javac%" -verbose -classpath "%javalib%";"%siteLib%" -sourcepath "%siteSrc%"   "%fsrc%"

echo Running...
echo %cmd%
@%cmd%

@rem move /y "%siteSrc%\%fname%.class" %class%

@rem 

:_PAUSE
pause C:\Program Files\Java\jdk1.8.0_31

:_END