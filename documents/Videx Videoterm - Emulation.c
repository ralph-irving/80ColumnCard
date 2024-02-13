/* Apple II Simulator */
/* Slotbeschreibung fuer Videx 80-Zeichen Karte */
/* Normalerweise in Slot 3; konfiguriert fuer Slot SLOT */
/* Es darf nur EINE EINZIGE Karte eingesetzt werden */
/* Peter Koch, 6.5.93 */

#include <stdio.h>
#include <X11/Xlib.h>

/* Various X-Variables */
extern Display *display;
extern Window rw;
extern GC gc,rgc;
extern XSetWindowAttributes attrib;
extern int screen;
extern int depth;
extern char *displayname;
extern int black,white;

Window wSLOT;
Pixmap charsetSLOT,memorySLOT;
GC xgcSLOT;
XGCValues valuesSLOT;

/* external variables */
extern int readinhibit;
extern int writeinhibit;
extern int slot;

/* internal variables */
int bankSLOT,regvalSLOT;  /* active memory bank, selected register */
unsigned char regSLOT[17];/* registers of the CRT-controller */
int oldcursorSLOT;	  /* old cursor position */
int upperSLOT,lowerSLOT;  /* cursor size */
/*********************************************************/
/* Registerbelegung                                      */
/*    register r/w     normal value    Name              */
/*    00:      w       7B              Horiz. total      */
/*    01:      w       50              Horiz. displayed  */
/*    02:      w       62              Horiz. sync pos   */
/*    03:      w       29              Horiz. sync width */
/*    04:      w       1B              Vert. total       */
/*    05:      w       08              Vert. adjust      */
/*    06:      w       18              Vert. displayed   */
/*    07:      w       19              Vert. sync pos    */
/*    08:      w       00              Interlaced        */
/*    09:      w       08              Max. scan line    */
/*    10:      w       C0              Cursor upper      */
/*    11:      w       08              Cursor lower      */
/*    12:      w       00              Startpos Hi       */
/*    13:      w       00              Startpos Lo       */
/*    14:      r/w     00              Cursor Hi         */
/*    15:      r/w     00              Cursor Lo         */
/*    16:      r       00              Lightpen Hi       */
/*    17:      r       00              Lightpen Lo       */
/* Die Register werden folgendermassen angesprochen:     */
/*    Zum Schreiben             Zum Lesen                */
/*    LDA #$<register>          LDA #$<register>         */
/*    STA $C0B0                 STA $C0B0                */
/*    LDA #$<wert>              LDA $C0B1                */
/*    STA $C0B1                                          */
/*********************************************************/

unsigned char vramSLOT[2048]; /* 0x0800 at CC00-CDFF in 4 banks */
unsigned char vromSLOT[1024]; /* 0x0400 at C800-CBFF */
unsigned char vcromSLOT[4096]; /* 0x1000 character rom (12x8) Matrix) */

void drawSLOT(adr,value)
{
	int sadr,crow,ccol;

	/* update memory pixmap */
	XCopyArea(display,charsetSLOT,memorySLOT,gc,8*value,0,8,12,adr*8,0);
	
	/* update screen */
	sadr=(0x800+adr-256*regSLOT[12]-regSLOT[13]) & 0x7ff;
	crow=sadr/80;
	ccol=sadr%80;
	XCopyArea(display,charsetSLOT,wSLOT,gc,8*value,0,8,12,ccol*8,crow*12);
}

void cursorSLOT()
{
	int sadr,newcursor,crow,ccol;

	/* remove old cursor */
	drawSLOT(oldcursorSLOT,vramSLOT[oldcursorSLOT]);

	/* update cursor */
	newcursor=(256*regSLOT[14]+regSLOT[15]) & 0x7ff;
	sadr=(0x800+newcursor-(256*regSLOT[12]+regSLOT[13])) & 0x7ff;
	crow=sadr/80;
	ccol=sadr%80;
	XFillRectangle(display,wSLOT,xgcSLOT,ccol*8,crow*12+upperSLOT,7,lowerSLOT-upperSLOT);
	XFlush(display);

	/* remember old cursor */
	oldcursorSLOT=newcursor;
}

modifySLOT()
{
	int val;

	/* set upper cursor bound */
	upperSLOT=0;
	val=regSLOT[10] & 0x7f; /* remove blinking-flag */
	if (val)
		while ((val & 0x40) == 0)
		{
			upperSLOT++;
			val = val << 1;
		}
	
	/* set lower cursor bound */
	lowerSLOT=12;
	val=regSLOT[11];
	if (val)
		while ((val & 0x01) == 0)
		{
			lowerSLOT--;
			val = val >> 1;
		}

	/* if the setting is ridiculous */
	if (upperSLOT >= lowerSLOT)
	{
		upperSLOT=0;
		lowerSLOT=12;
	}

	/* draw new cursor */
	cursorSLOT();
}

void redrawSLOT()
{
	int sadr,crow,ccol;

	sadr=(256*regSLOT[12]+regSLOT[13]) & 0x7ff;
	for (crow=0;crow<24;crow++)
	{
		ccol=sadr+80;
		if (ccol > 0x800)
		{
			ccol &= 0x7ff;
			XCopyArea(display,memorySLOT,wSLOT,gc,8*sadr,0,8*(80-ccol),12,0,crow*12);
			XCopyArea(display,memorySLOT,wSLOT,gc,0,0,8*ccol,12,8*(80-ccol),crow*12);
		}
		else
			XCopyArea(display,memorySLOT,wSLOT,gc,8*sadr,0,8*80,12,0,crow*12);
		sadr=ccol;
	}
	cursorSLOT();
}

int getC0SLOTX(adr)
int adr;
{
	int value=0x00;

	bankSLOT=(adr & 0x000c) >> 2;

	if (adr & 0x0001)
		value=regSLOT[regvalSLOT];

	return(value);
}

void putC0SLOTX(adr,value)
int adr;
int value;
{
	bankSLOT=(adr & 0x000c) >> 2;

	if (adr & 0x0001)
	{
		regSLOT[regvalSLOT]=value;
		if ((regvalSLOT==10) || (regvalSLOT==11))
			modifySLOT();
		if ((regvalSLOT==14) || (regvalSLOT==15))
			cursorSLOT();
		if (regvalSLOT==13)
			redrawSLOT();
	}
	else
		regvalSLOT=value;
}

int getCSLOTXX(adr)
int adr;
{
	return(vromSLOT[((adr & 0x00ff)+0x100*SLOT) & 0x3ff]);
}

void putCSLOTXX(adr,value)
int adr;
int value;
{
}

int getSLOTC8XX(adr)
int adr;
{
	if (adr < 0x0400)
		return(vromSLOT[adr & 0x03ff]);
	else
		if (adr < 0x0600)
			return(vramSLOT[(adr & 0x01ff)+bankSLOT*0x0200]);
		else
			return(0);
}

void putSLOTC8XX(adr,value)
int adr;
int value;
{
	if ((adr >= 0x0400) && (adr <0x0600))
	{
		int vadr;

		vadr=(adr & 0x01ff)+bankSLOT*0x0200;
		vramSLOT[vadr]=value;
		drawSLOT(vadr,value);
		XFlush(display);
	}
}

int getSLOTinhibit(adr)
int adr;
{
}

void putSLOTinhibit(adr,value)
int adr;
int value;
{
}

void initslotSLOT()
{
	FILE *g;
	int i;
	int value,bits,crow,ccol;

	/* Read videx rom */
	g=fopen("videx.rom","r");
	if (g==0)
	{
		fprintf(stderr,"can't find 'videx.rom'.\n");
		exit(1);
	}
	fread(vromSLOT,1,0x0400,g);
	fclose(g);

	/* Read videx character rom */
	g=fopen("videx.char.rom","r");
	if (g==0)
	{
		fprintf(stderr,"can't find 'videx.char.rom'.\n");
		exit(1);
	}
	fread(vcromSLOT,1,0x1000,g);
	fclose(g);

	bankSLOT=0;
	upperSLOT=0;
	lowerSLOT=8;
	regvalSLOT=0;
	regSLOT[0]=0x7b;
	regSLOT[1]=0x50;
	regSLOT[2]=0x62;
	regSLOT[3]=0x29;
	regSLOT[4]=0x1b;
	regSLOT[5]=0x08;
	regSLOT[6]=0x18;
	regSLOT[7]=0x19;
	regSLOT[8]=0x0;
	regSLOT[9]=0x8;
	regSLOT[10]=0xc0;
	regSLOT[11]=0x8;
	regSLOT[12]=0x0;
	regSLOT[13]=0x0;
	regSLOT[14]=0x0;
	regSLOT[15]=0x0;
	regSLOT[16]=0x0;
	regSLOT[17]=0x0;
	oldcursorSLOT=0;

	for (i=0;i<2048;i++)
		vramSLOT[i]=i & 0xff;

	/* Open Window */
	wSLOT=XCreateSimpleWindow(display,rw,0,0,640,288,0,white,black);
	XStoreName(display,wSLOT,"Videx 80 Column Card");
	xgcSLOT=XCreateGC(display,wSLOT,0,0);
	XSetForeground(display,xgcSLOT,1);
	valuesSLOT.function=GXxor;
	XChangeGC(display,xgcSLOT,GCFunction,&valuesSLOT);
	XMapWindow(display,wSLOT);
	XFlush(display);

	/* Charset Pixmap aufbauen */
	charsetSLOT=XCreatePixmap(display,wSLOT,256*8,12,depth);
	XFillRectangle(display,charsetSLOT,rgc,0,0,256*8,12);
	for (value=0;value<256;value++)
	{
		for (crow=0;crow<12;crow++)
		{
			bits=vcromSLOT[16*value+crow];
			for (ccol=0;ccol<8;ccol++)
			{
				if (bits & 0x01)
					XFillRectangle(display,charsetSLOT,gc,8*value+(7-ccol),crow,1,1);
				else
					XFillRectangle(display,charsetSLOT,rgc,8*value+(7-ccol),crow,1,1);
				bits=bits >> 1;
			}
		}
	}

	/* Memory Pixmap aufbauen */
	memorySLOT=XCreatePixmap(display,wSLOT,2048*8,12,depth);
	XFillRectangle(display,memorySLOT,rgc,0,0,2048*8,12);

	redrawSLOT();
}
