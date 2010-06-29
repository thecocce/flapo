set path=%path%;c:\flex_sdk_4\bin\

mxmlc -default-frame-rate 30 -default-size 550 400 	-default-background-color=#6D6DFF -use-network -optimize=true -output WFlapo2.swf -frame=Test,Test Preloader.as
pause