[Conan](//conan.io) package for [machinezone/IXWebSocket](https://github.com/machinezone/IXWebSocket).


[ ![Download](https://api.bintray.com/packages/oliviazoe0/conan-packages/IXWebSocket%3ALunarWatcher/images/download.svg) ](https://bintray.com/oliviazoe0/conan-packages/IXWebSocket%3ALunarWatcher/_latestVersion)

# Build status

---
| Windows| Linux/OSX |
| --- | --- |
| [![Build status](https://ci.appveyor.com/api/projects/status/eaa6oevawbihu90i?svg=true)](https://ci.appveyor.com/project/LunarWatcher/conan-ixwebsocket) | [![Build Status](https://travis-ci.org/LunarWatcher/conan-IXWebSocket.svg?branch=master)](https://travis-ci.org/LunarWatcher/conan-IXWebSocket) |

---

# Installing manually 

You can install the project locally by typing:

```bash
conan create . LunarWatcher/stable --build missing 
```

# Adding to a project 

Uploading to Conan Center is planned in the future. 

Either way, to add it to your project, you need to make sure your Conan profile setting `settings.compiler.libcxx` is set to `libstdc++11`. If it's set to `libstdc++`, the build may fail with undefined references to IXWebSocket. 

Until it's linked to Conan Center, the package is accessible by adding another remote:

```
conan remote add remote_name_here https://api.bintray.com/conan/oliviazoe0/conan-packages 
```

The latest version can be found in the badge at the top of this readme, and has the signature `IXWebSocket/version_here@LunarWatcher/stable`.

# Options 

* `use_mbed_tls` - whether or not to use MbedTLS. By default, this is false to allow platform-specific SSL providers (Both Mac and UNIX supports MbedTLS, but they fall back to platform-specific providers). **NOTE:** Windows uses MbedTLS regardless of this option. 
* `use_tls` - whether to enable TLS. By default, this is enabled.
* `use_vendored_third_party` - whether or not to build (some) third party dependencies using the ones defined in IXWebSocket/third_party. this only applies to MbedTLS. This Conan recipe doesn't offer MbedTLS, which means if it's set to false, you need to have it installed on your system. 
* `use_ws` - whether to include the example folder `ws` from the repo. By default, this is false. 


