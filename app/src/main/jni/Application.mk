
# Uncomment this if you're using STL in your project
# See CPLUSPLUS-SUPPORT.html in the NDK documentation for more information
APP_STL := c++_static
APP_PLATFORM = android-10
APP_ABI :=  all
APP_MODULES := hciviewer
APP_CPPFLAGS += -frtti 
APP_CPPFLAGS += -fexceptions

# Support for 16 KB page sizes (required for Android 15+)
APP_LDFLAGS += -Wl,-z,max-page-size=16384
