SET TALK OFF
_screen.Caption="Aplikasi Praktek Dokter"
*_screen.TitleBar = 0 
*_SCREEN.ShowInTaskBar = .f.
_screen.BackColor = RGB(0,0,0)
*_screen.ControlBox = .f.
*_screen.Picture = 'F:\VYPR2\IMAGES\BACKGROUND.BMP'
_screen.windowstate= 2 
_screen.FillStyle = 0 
_screen.FillColor = RGB(0,128,192)
_screen.Icon = 'G:\VHRDSTM\PICON\AESTHETICA_ICO\ICO\HOME.ICO'

*_screen.AutoCenter= .T. 
*_screen.Height = 100
*_screen.Width = 200
*_screen.MinButton = .f.
*_screen.MaxButton = .f.
*_Screen.WindowState = 1

SET SAFETY OFF
SET DATE BRITISH
SET DATE dmy
SET SEPA TO '.'
SET POINT TO ','
SET CENTURY on
SET MULTILOCKS ON
SET SYSMENU off
SET RESOURCE OFF 
SET CPDIALOG OFF
SET EXCLUSIVE OFF 
SET DELETED ON 
*SET PROCEDURE TO vproc.prg,utiliti.prg
SET PROCEDURE TO utiliti.prg
SET SYSMENU OFF 
SET STATUS OFF 
SET STATUS BAR OFF 
SET DISPLAY TO vga50
SET DATE DMY 
SET HOURS TO 24
SET SECONDS OFF 
CLOSE DATABASES
SET PATH TO TO SYS(2003)

PUBLIC _userid, _userlvl, gamenu[2,2],uname

OPEN DATABASE data.dbc SHARED 
VALIDATE DATABASE 
DO FORM login.scx TO plHasil

IF plHasil
	READ EVENTS 
ELSE 
	MESSAGEBOX('Login Batal !!',0,'INFO')
	RELEASE WINDOWS 
	CLEAR EVENTS
	KEYBOARD '{ALT+F4}' 
ENDIF 
