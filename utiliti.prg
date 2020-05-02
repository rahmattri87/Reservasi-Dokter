*!* contoh enkripsi sederhana
FUNCTION enkripsi
LPARAMETERS data_asli
LOCAL xx,yy,zz,ww,aa,i,cc
STORE 0 TO i,bb,ww
STORE '' TO xx,yy,zz,aa,cc,dd

xx='ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
yy='MNOPQRSTUVWXYZABCDEFGHIJKL4567890123'

zz=ALLTRIM(UPPER(data_asli))
ww=LEN(zz)

FOR i=1 TO ww
   	aa=SUBSTR(zz,i,1)
   	bb=AT(aa,xx)
   	cc=SUBSTR(yy,bb,1)
   	dd=dd+cc
ENDFOR
RETURN dd

*!* contoh dekripsi sederhana
FUNCTION dekripsi
LPARAMETERS data_asli
LOCAL xx,yy,zz,ww,aa,i,cc
STORE 0 TO i,bb,ww
STORE '' TO xx,yy,zz,aa,cc,dd

xx='MNOPQRSTUVWXYZABCDEFGHIJKL4567890123'
yy='ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

zz=ALLTRIM(UPPER(data_asli))
ww=LEN(zz)

FOR i=1 TO ww
   	aa=SUBSTR(zz,i,1)
   	bb=AT(aa,xx)
   	cc=SUBSTR(yy,bb,1)
   	dd=dd+cc
ENDFOR
RETURN dd

FUNCTION konak
lcKonek="DRIVER=sql server;server=guzrud;database=siswa;"
lnhandle = SQLSTRINGCONNECT(lcKonek)
ll=SQLEXEC(lnhandle,'exec dianku','coba')
ENDFUNC 

FUNCTION Tgl(vTgl)
LOCAL NamaHari, NamaTanggal, NamaBulan
NamaHari=DOW(DATE())
NamaTanggal=DATE()
NamaBulan=MONTH(DATE())
DO CASE
   CASE NamaHari=1
        Hari='Minggu'
   CASE NamaHari=2
        Hari='Senin'
   CASE NamaHari=3
        Hari='Selasa'
   CASE NamaHari=4
        Hari='Rabu'
   CASE NamaHari=5
        Hari='Kamis'
   CASE NamaHari=6
        Hari='Jumat'
   CASE NamaHari=7
        Hari='Sabtu'
ENDCASE
DO CASE
   CASE NamaBulan=1
        Bulan='Januari'     
   CASE NamaBulan=2
        Bulan='Februari'
   CASE NamaBulan=3
        Bulan='Maret'
   CASE NamaBulan=4
        Bulan='April'
   CASE NamaBulan=5
        Bulan='Mei'
   CASE NamaBulan=6
        Bulan='Juni'
   CASE NamaBulan=7
        Bulan='Juli'
   CASE NamaBulan=8
        Bulan='Agustus'
   CASE NamaBulan=9
        Bulan='September'
   CASE NamaBulan=10
        Bulan='Oktober'
   CASE NamaBulan=11
        Bulan='November'
   CASE NamaBulan=12
        Bulan='Desember'
ENDCASE
vTgl=Hari+', '+ALLTRIM(STR(DAY(NamaTanggal)))+' '+;
     Bulan+' '+ALLTRIM(STR(YEAR(NamaTanggal)))
RETURN vTgl                             


FUNCTION Jam(Waktu)
LOCAL vJam
vJam=VAL(SUBSTR(Waktu,1,2))
RETURN STR(IIF(vJam=12,12,vJam % 12),2)+;
       SUBSTR(Waktu,3,3)+IIF(vJam >=12,' PM',' AM') 
       
FUNCTION NamaIndex(X)
X='Nama File Yang Di Reindex :'+X
 WAIT WINDOW X TIMEOUT 1
RETURN .t. 

FUNCTION BarIndex
LOCAL I
_SCREEN.ACTIVEFORM.oleMax.MIN=0
_SCREEN.ACTIVEFORM.oleMax.MAX=100
FOR I=_SCREEN.ACTIVEFORM.oleMax.MIN TO;
      _SCREEN.ACTIVEFORM.oleMax.MAX
       
    _SCREEN.ACTIVEFORM.oleMax.VALUe=I
    _SCREEN.ACTIVEFORM.lblMax.CAPTION=;
    TRANSFORM(I,'999')+' %'
NEXT I
RETURN .t.

