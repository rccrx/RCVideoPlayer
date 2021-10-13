//
//  RCAVAResourceLoaderDelegate.m
//  RCVideoPlayer
//
//  Created by crx on 2021/5/3.
//

#import "RCAVAResourceLoaderDelegate.h"

@implementation RCAVAResourceLoaderDelegate

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSLog(@"rl: shouldWaitForLoadingOfRequestedResource: request=%@", loadingRequest);
    return YES;
}










- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSLog(@"rl: didCancelLoadingRequest");
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)authenticationChallenge {
    NSLog(@"rl: didCancelAuthenticationChallenge");
}

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForRenewalOfRequestedResource:(AVAssetResourceRenewalRequest *)renewalRequest {
    NSLog(@"rl: shouldWaitForRenewalOfRequestedResource");
    return YES;
}

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForResponseToAuthenticationChallenge:(NSURLAuthenticationChallenge *)authenticationChallenge {
    NSLog(@"rl: shouldWaitForResponseToAuthenticationChallenge");
    return YES;
}
@end
