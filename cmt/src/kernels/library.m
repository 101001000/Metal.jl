/*
 * Copyright (c), Recep Aslantas.
 * MIT License (MIT), http://opensource.org/licenses/MIT
 */

#import "impl/common.h"
#import "cmt/common.h"
#import "cmt/kernels/library.h"

CF_RETURNS_RETAINED
MT_EXPORT
MtLibrary*
mtNewDefaultLibrary(MtDevice *device) {
  return [(id<MTLDevice>)device newDefaultLibrary];
}

CF_RETURNS_RETAINED
MT_EXPORT
MtLibrary*
mtNewLibraryWithFile(MtDevice *device, char *filepath, NsError **error) {
  return [(id<MTLDevice>)device newLibraryWithFile: mtNSString(filepath) error: (NSError**)error];
}

CF_RETURNS_RETAINED
MT_EXPORT
MtLibrary*
mtNewLibraryWithSource(MtDevice *device, char *source, MtCompileOptions *Opts, NsError **error) {
  return [(id<MTLDevice>)device newLibraryWithSource: mtNSString(source)
  								                           options: (MTLCompileOptions*)Opts
  								                             error: (NSError**) error];
}

CF_RETURNS_RETAINED
MT_EXPORT
MtLibrary*
mtNewLibraryWithData(MtDevice *device, void* buffer, size_t size, NsError **error) {
  dispatch_data_t dispatch_data =
    dispatch_data_create(buffer, size, dispatch_get_main_queue(),
                         DISPATCH_DATA_DESTRUCTOR_DEFAULT);
  return [(id<MTLDevice>)device newLibraryWithData: dispatch_data error:(NSError**)error];
}

MT_EXPORT
void
mtLibraryRelease(MtLibrary *lib) {
  [(id<MTLLibrary>)lib release];
}

MT_EXPORT
MtDevice*
mtLibraryDevice(MtLibrary *lib) {
	return [(id<MTLLibrary>)lib device];
}

MT_EXPORT
const char*
mtLibraryLabel(MtLibrary *lib) {
	return Cstring([(id<MTLLibrary>)lib label]);
}

MT_EXPORT
int
mtLibraryFunctionCount(MtLibrary *lib) {
  NSArray<NSString*> *_names = [(id<MTLLibrary>)lib functionNames];
  return [_names count];
}

MT_EXPORT
void
mtLibraryFunctionNames(MtLibrary *lib, const char** names) {
  NSArray<NSString*> *_names = [(id<MTLLibrary>)lib functionNames];
  int n = [_names count];
  for (int i=0; i < n; i++)
  	names[i] = Cstring([_names objectAtIndex:i]);
  return;
}

