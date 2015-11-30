//
//  IoBranchSdkBranchUniversalProxy.m
//  Titanium-Deferred-Deep-Linking-SDK
//
//  Created by Kevin Milo on 26/11/2015.
//
//

#import "IoBranchSdkBranchUniversalProxy.h"

@implementation IoBranchSdkBranchUniversalProxy

-(id)init
{
    return [super init];
}

-(void)_destroy
{
    [super _destroy];
}

-(id)_initWithPageContext:(id<TiEvaluator>)context
{
    // This method is one of the initializers for the proxy class. If the
    // proxy is created without arguments then this initializer will be called.
    // This method is also called from the other _initWithPageContext method.
    // The superclass method calls the init and _configure methods.
    
    NSLog(@"_initWithPageContext (no arguments)");
    
    return [super _initWithPageContext:context];
}

-(id)_initWithPageContext:(id<TiEvaluator>)context_ args:(NSArray*)args
{
    // This method is one of the initializers for the proxy class. If the
    // proxy is created with arguments then this initializer will be called.
    // The superclass method calls the _initWithPageContext method without
    // arguments.
    
    NSLog(@"_initWithPageContext %@", args);
    
    return [super _initWithPageContext:context_ args:args];
}

-(void)_configure
{
    // This method is called from _initWithPageContext to allow for
    // custom configuration of the module before startup. The superclass
    // method calls the startup method.
    
    NSLog(@"_configure");
    
    [super _configure];
}

-(void)_initWithProperties:(NSDictionary *)properties
{
    // This method is called from _initWithPageContext if arguments have been
    // used to create the proxy. It is called after the initializers have completed
    // and is a good point to process arguments that have been passed to the
    // proxy create method since most of the initialization has been completed
    // at this point.
    
    NSLog(@"_initWithProperties %@", properties);
    
    [super _initWithProperties:properties];
    
    self.branchUniversalObj = [[BranchUniversalObject alloc] init];
    
    for (id key in properties) {
        if ([key isEqualToString:@"contentMetadata"]){
            NSDictionary *metadata = (NSDictionary *)[properties valueForKey:key];
            
            for (id key_ in metadata) {
                [self.branchUniversalObj addMetadataKey:key_ value:[metadata valueForKey:key_]];
            }
        }
        else if ([key isEqualToString:@"contentIndexingMode"]) {
            NSString *indexingMode = [properties valueForKey:key];
            if ([indexingMode isEqualToString:@"private"]) {
                self.branchUniversalObj.contentIndexMode = ContentIndexModePrivate;
                
            }
            else if ([indexingMode isEqualToString:@"public"]){
                self.branchUniversalObj.contentIndexMode = ContentIndexModePublic;
            }
        }
        else {
            [self.branchUniversalObj setValue:[properties objectForKey:key] forKey:key];
        }
    }
    
}

- (id)initWithCanonicalIdentifier:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    if (!self.branchUniversalObj) {
        self.branchUniversalObj = [[BranchUniversalObject alloc] initWithCanonicalIdentifier:args];
    }
    else {
        self.branchUniversalObj.canonicalIdentifier = args;
    }
    
    return self;
}

- (id)initWithTitle:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    if (!self.branchUniversalObj){
        self.branchUniversalObj = [[BranchUniversalObject alloc] initWithTitle:args];
    }
    else {
        self.branchUniversalObj.title = args;
    }

    return self;
}

- (void)addMetadata:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    [self.branchUniversalObj addMetadataKey:[args objectForKey:@"key"] value:[args objectForKey:@"value"]];
}

- (void)registerView:(id)args
{
    ENSURE_ARG_COUNT(args, 0);
    [self.branchUniversalObj registerView];
}

@end
