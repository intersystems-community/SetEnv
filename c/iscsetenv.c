/*
 ============================================================================
 Name        : iscsetenv.c
 Author      : Eduard
 Version     :
 Copyright   : MIT
 Description : SetEnv for InterSystems Platforms
 ============================================================================
 */

#define USE_CALLIN_CHAR

#define ZF_DLL  /* Required only for dynamically linked libraries. */

#include <cdzf.h>
#include <stdlib.h> 


int SetEnvVar(const char *envname, const char *envval) {
	#ifdef __linux__
		int overwrite = 1;
		int res = setenv(envname, envval, overwrite);
	#elif _WIN32
		int res = _putenv_s(envname, envval);
	#endif
	
	return ZF_SUCCESS;
}


ZFBEGIN
	ZFENTRY("SetEnvVar","cc",SetEnvVar)
ZFEND
