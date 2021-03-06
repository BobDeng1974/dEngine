/*
 *  material.h
 *  dEngine
 *
 *  Created by fabien sanglard on 24/09/09.
 *
 */

#ifndef DE_MATERIAL
#define DE_MATERIAL

#include "globals.h"
#include "texture.h"
#include "math.h"

#define TEXTURE_DIFFUSE 0
#define TEXTURE_BUMP 1
#define TEXTURE_SPECULAR 2

#define PROP_BUMP      0x01
#define PROP_SPEC      0x02
#define PROP_DIFF	   0x04
#define PROP_UNDEF1    0x08
#define PROP_UNDEF2    0x10
#define PROP_UNDEF3	   0x20
#define PROP_UNDEF	   0x40	
#define PROP_SHADOW    0x80

typedef struct material_t
{
	char name[256];
	char loaded;
	
	float shininess;
	float specularColor[3];
	
	uchar prop;
	
	uchar hasAlpha;
	
	texture_t* textures[3];
	
} material_t;

#define MATERIAL_QUALITY_LOW 0
#define MATERIAL_QUALITY_HIGH 1

void MATLIB_SetMaterialQuality(uchar level);
void MATLIB_FreeMemory(void);
material_t* MATLIB_Create(char* materialName);
material_t* MATLIB_Get(char* materialName);
void MATLIB_MakeAvailable(material_t* material);

void MATLIB_LoadLibrary(char* mtlPath);
void MATLIB_LoadLibraries(void);

void MATLIB_printProp(uchar prop);

#endif