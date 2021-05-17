
#ifndef EG02_H
#define EG02_H

#define VIDEO_MEMORY 0xb8000
#define VIDEO_ATTRIBUTE 0X02


void __attribute((naked, fastcall)) print (const char *str);



#endif
