##Frameworking
_A collection of different types of iOS frameworks_



_###Embedded Frameworks_
####Branding Framework
[Tutorial Source](http://code.hootsuite.com/an-introduction-to-creating-and-distributing-embedded-frameworks-in-ios/)

###Mixed-Swift-Obc-Framework
[Tutorial Source](https://github.com/danieleggert/mixed-swift-objc-framework)

_####Static Frameworks__



####Apple Docs
[Dynamic Libraries](https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/DynamicLibraries/100-Articles/OverviewOfDynamicLibraries.html#//apple_ref/doc/uid/TP40001873-SW1)


####Terminology

* Framework
	is a skeleton where the application defines the "meat" of the operation by filling out the skeleton. The skeleton still has code to link up the parts but the most important work is done by the application.
	*Example: Web application system, Plug-in manager, GUI system. The framework defines the concept but the application defines the fundamental functionality that end-users care about.

* Library
	performs specific, well-defined operations.
	*Example:Network protocols, compression, image manipulation, string utilities, regular expression evaluation, math. Operations are self-contained.

* Static
	a unit of code linked at compile time, which does not change.
	However, iOS static libraries are not allowed to contain images/assets (only code). You can get around this challenge by using a media bundle though.

* Dynamic
	a unit of code and/or assets linked at runtime that may change.(Does not require re-linking,Apple provides template for iOS 8+

*Thin frameworks 
	contain compiled code for one architecture

*fat frameworks
	contain compiled code for multiple architectures. Compiled code for an architecture within a framework is typically referred to as a “slice.” For example, if a framework had compiled code for just the two architectures used by the Simulator (i386 and x86_64), we would say it contained two slices.


