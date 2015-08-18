#ifndef _CRC32_H
#define _CRC32_H

/* contrib/rltree/crc32.h */

/* Returns crc32 of data block */
extern unsigned int rltree_crc32_sz(char *buf, int size);

/* Returns crc32 of null-terminated string */
#define crc32(buf) rltree_crc32_sz((buf),strlen(buf))

#endif
