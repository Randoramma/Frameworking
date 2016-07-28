##Frameworking
*A collection of different types of iOS frameworks*
*Note all the code in the framework belong to their corresponding party*

###Embedded Frameworks
*Branding Framework*
[Tutorial Source](http://code.hootsuite.com/an-introduction-to-creating-and-distributing-embedded-frameworks-in-ios/)

*Mixed-Swift-Obc-Framework*
[Tutorial Source](https://github.com/danieleggert/mixed-swift-objc-framework)

*Dynamic Framework*
[Tutorial Source](https://www.raywenderlich.com/126365/ios-frameworks-tutorial)



###Protocols inside Dynamic Library sending Messages to App 
This Project shows a class inside a library can send messages (via Protocols) to a class in the main App



###Apple Docs
[Dynamic Libraries](https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/DynamicLibraries/000-Introduction/Introduction.html)

[Build Setting Reference](https://developer.apple.com/library/mac/documentation/DeveloperTools/Reference/XcodeBuildSettingRef/1-Build_Setting_Reference/build_setting_ref.html#//apple_ref/doc/uid/TP40003931-CH3-SW159)


###Terminology

* **Framework** is a skeleton where the application defines the "meat" of the operation by filling out the skeleton. The skeleton still has code to link up the parts but the most important work is done by the application.
	* **Example:** Web application system, Plug-in manager, GUI system. The framework defines the concept but the application defines the fundamental functionality that end-users care about.

* **Library** performs specific, well-defined operations.
	* **Example:**Network protocols, compression, image manipulation, string utilities, regular expression evaluation, math. Operations are self-contained.

* **Static** is a unit of code linked at compile time, which does not change.
	However, iOS static libraries are not allowed to contain images/assets (only code). You can get around this challenge by using a media bundle though.

* **Dynamic** is a unit of code and/or assets linked at runtime that may change without the need of relinking.

* **Embedded frameworks** are placed within an app’s sandbox and are only available to that app. (Starting iOS 8+ Apple provides a template for embedded framework)

* **System frameworks** are stored at the system-level and are available to all apps. (As of iOS 10, this is NOT supported by Apple)

* **Thin frameworks** contain compiled code for one architecture

* **Fat frameworks** contain compiled code for multiple architectures. Compiled code for an architecture within a framework is typically referred to as a “slice.” For example, if a framework had compiled code for just the two architectures used by the Simulator (i386 and x86_64), we would say it contained two slices.



###Drawbacks of xcodebuild
There are a few disadvantages with using the xcodebuild technique which must be weighed against the importance of building a subproject with a different configuration.

1. Warnings in the subproject will not show up consistently.
This is a big one. For a clean build of the subproject, all warnings will show up in the Xcode warnings tab. In certain scenarios, building again will make these warnings disappear, and only warnings from the files that changed since the last build will show up. For this reason, I would only recommend using this technique when testing particular configurations, and not during regular debugging, as it can be easy to lose track of outstanding warnings in the subproject.

2. Cleaning the parent project will not clean the subproject.

3. It can potentially be confusing when working with a team.
Since this is not a “standard” Xcode workflow, anyone else working on the project may have questions (and/or stern words) for you as to what is going on in the build settings.

4. Not CI-friendly.
Since cleaning the parent project does not clean the subproject, this technique is not very CI-friendly. Practically anything can be done with careful scripting, but depending on how important it is that you build the subproject with multiple configurations, it may or may not be worth the extra effort.
