%module(directors="1") MySwig
%{
    #define SWIG_FILE_WITH_INIT
    #include "MySwig.h"
    using namespace Test;
%}

%include <std_string.i>
%include <typemaps.i>

%typemap(in)        (int size, unsigned char *ptr) {
	
	if (args[0]->IsUint8Array()) {
	    v8::Local<v8::Uint8Array> myarr = args[0].As<v8::Uint8Array>();
	    arg2 = myarr->Length ();
	    unsigned int offset = myarr->ByteOffset();
	    arg3 = (unsigned char*)((unsigned char*)myarr->Buffer()->GetContents().Data() + offset);
    } else {
    	SWIG_exception_fail(SWIG_ArgError(res1), "Illegal argument " "2"" must be of type '" "Uint8Array""'"); 
    }
} 


%include "MySwig.h"


