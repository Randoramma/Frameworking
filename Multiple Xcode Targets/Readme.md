####Apple Docs
 
    [Working with Projects](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Conceptual/Xcode_Overview/CreatingProjects.html#//apple_ref/doc/uid/TP40010215-CH31-SW1)
    [Xcode Targets](https://developer.apple.com/library/mac/featuredarticles/XcodeConcepts/Concept-Targets.html)



###Why have different Targets?

- To create different versions of your app which have different features. E.g. a ‘Lite’ or ‘Free’ version
- To create targets which are tailored for different devices, possible with the same model and controller classes, but different view classes E.g. one target for iPhone, and another for iPad


###Where to I add macros to distinguish target?

1) Build Settings > Preprocessing > Preprocessor Macros

OR
2) (Only if you want objective-c flags)  Build Settings >  Custom Compiler Flags > Other C Flags

