
Source:
http://code.hootsuite.com/an-introduction-to-creating-and-distributing-embedded-frameworks-in-ios/


When building the project, be sure to allow for all architectures to be build by:

In the build settings for the BrandingFramework target, make sure that “Build Active Architectures Only” is set to “No” for both debug and release. As well, “Valid Architectures” should include “armv7s”, “armv7” and “arm64.”  Depending on your version of Xcode, the “Standard Architectures” option will include all of these or just a subset of them.

Build the project against the Simulator. At this point, your framework will be created using only the slices for the Simulator (alternatively, if you built it for device it would only have the slices for the device). The default scheme for building is set to create a debug version, so this framework will be the debug version.
Locate the .framework file that was created. It will be in your project’s Derived Data folder in one of the subfolders of Build/Products, but the exact folder will depend on your build settings.

To locate the framework file:
If built for device, the folder will have “iphoneos” in its name instead of “iphonesimulator”, and if built for release it’ll have “Release” instead of “Debug.” You can locate your Derived Data folder easily in Xcode by selecting Window > Projects in the menu, selecting your project,and clicking the arrow icon next to the Derived Data path displayed in the Projects window.

Switch to the containing file in directory using terminal and enter the command:
lipo -info BrandingFramework.framework/BrandingFramework

As we’ve seen so far, in order to be able to consume our framework, we need it to contain the correct architectures that match with the build settings of the consumer. When the framework and the consumer of the framework are part of the same project, this isn’t a problem; Xcode will build the framework and the consumer using the same settings. A problem only arises when the framework and its consumer are in different projects. To solve this problem, we can use the same command line tool, lipo, that we used in the previous section. The basic idea is to use lipo to merge two frameworks together into one framework containing all the needed architectures. Of course, we don’t want to have to manually build for Simulator and device separately and then run lipo every time we want to build the framework, so we’ll use a build script to handle this for us. To automate the merging of the device and simulator slices into one framework, we’ll use a simple build script I wrote. It’s rather basic and geared toward demonstration purposes, but feel free to expand upon it and modify it as necessary.

