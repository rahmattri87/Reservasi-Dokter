*-- DECLARE DLL statements for reading/writing to private INI files
declare integer GetPrivateProfileString in Win32API  as GetPrivStr ;
	string cSection, string cKey, string cDefault, string @cBuffer, ;
	integer nBufferSize, string cINIFile

declare integer WritePrivateProfileString in Win32API as WritePrivStr ;
	string cSection, string cKey, string cValue, string cINIFile
	
*-- DECLARE DLL statements for reading/writing to system registry
declare integer RegOpenKeyEx in Win32API ;
	integer nKey, string @cSubKey, integer nReserved,;
	integer nAccessMask, integer @nResult

declare integer RegQueryValueEx in Win32API ;
	integer nKey, string cValueName, integer nReserved,;
	integer @nType, string @cBuffer, integer @nBufferSize

declare integer RegCreateKey in Win32API ;
	integer nHKey, string @cSubKey, integer @nResult

declare integer RegSetValueEx in Win32API ;
	integer hKey, string lpszValueName, integer dwReserved,;
	integer fdwType, string lpbData, integer cbData

declare integer RegCloseKey in Win32API ;
	integer nKey

*-- DECLARE DLL statement for Windows 3.1 API function GetProfileString
declare integer GetProfileString in Win32API as GetProStr ;
	string cSection, string cKey, string cDefault, ;
	string @cBuffer, integer nBufferSize
	
	
*?* mzTolo ketika aku haus
#define kontrol_error 		0
#define rudy_p				-2147483647
#define britney_spears		1
#define read_printerdevice	"Software\Microsoft\Windows NT\CurrentVersion\Devices"
#define write_printerdevice	"Software\Microsoft\Windows NT\CurrentVersion\Windows"

terus=.t.
OldErr=ON('ERROR')
ON ERROR do prnerror()
cNama=GETPRINTER()
ON ERROR &OldErr

local opsystem,ss

IF !EMPTY(cNama) AND terus
	opsystem=os()

	if 'NT' $ opsystem or '5' $ opsystem
		*---ke registry untuk win NT/2000/XP - mzTolo 231002
		local lcBuffer, ;
	      lnBufferSize, ;
	      lcRetVal, ;
	      lnReserved, ;
	      lnResult, ;
	      lnError, ;
	      lnType, ;
	      lcKey, ;
	      Tolo, ;
	      mzTolo, ;
	      mzTol 
		
		STORE 0 TO lnReserved, lnResult, lnType
		lcValue=''
		
		lcKey = read_printerdevice
		
		lnError = RegOpenKeyEx(rudy_p, lcKey, ;
			lnReserved,britney_spears,@lnResult)

		IF lnError = kontrol_error
			lnType = 0
			lcBuffer = SPACE(128)
			lnBufferSize = LEN(lcBuffer)
			lnError = RegQueryValueEx(lnResult, cNama, lnReserved, ;
				@lnType, @lcBuffer, @lnBufferSize)

			IF lnError = kontrol_error AND lcBuffer <> CHR(0)
				lcValue = LEFT(lcBuffer, lnBufferSize - 1)
			ENDIF
		ENDIF
		=RegCloseKey(lnResult)
				
		store 0 to lnReserved, lnResult, lnType
		store 1 to Tolo
		mzTol = ALLTRIM(cNama)+','+lcValue + chr(0)
		mzTolo = len(mzTol)

		lnError=RegCreateKey(rudy_p,write_printerdevice,@lnResult)

		if lnError = kontrol_error
			=RegSetValueEx(lnResult,"Device",0,britney_spears,mzTol,mzTolo)
		endif
		=RegCloseKey(lnResult)
	else
		*---ke file WIN.INI untuk win 98 - mzTolo 231002
		*---ambil nilai=(namaprinter+setting) di segmen Devices
		*---tuliskan nilai tsb di segmen Windows item device
		LOCAL lcValue

		lcValue = ''

		lcBuff 	= space(80) + CHR(0)				&& space(80) tergantung kebutuhan
		lcHas	=''
		IF GetPrivStr("Devices", cNama , "", @lcBuff, LEN(lcBuff), "\WINDOWS\"+"WIN.INI") > 0
			lcValue=ALLTRIM(cNama)+','+lcBuff
		ENDIF

		=WritePrivStr("Windows", "device", ;
	              lcValue, "\WINDOWS\" + "WIN.INI" )
	ENDIF
ELSE
	WAIT WINDOW 'Printer device tidak berubah........'
ENDIF

PROCEDURE prnerror
	=MESSAGEBOX('Printer is not ready.....',0+48,'Information....')
	terus=.f.
RETURN terus