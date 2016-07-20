##Frameworking
*A collection of different types of iOS frameworks*


###Embedded Frameworks
*Branding Framework*
[Tutorial Source](http://code.hootsuite.com/an-introduction-to-creating-and-distributing-embedded-frameworks-in-ios/)

*Mixed-Swift-Obc-Framework*
[Tutorial Source](https://github.com/danieleggert/mixed-swift-objc-framework)

###Static Frameworks



###Apple Docs
[Dynamic Libraries](https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/DynamicLibraries/100-Articles/OverviewOfDynamicLibraries.html#//apple_ref/doc/uid/TP40001873-SW1)


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


