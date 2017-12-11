//
//  MPConnectIntegrations.m
//  Mixpanel
//
//  Created by Peter Chien on 10/9/17.
//  Copyright © 2017 Mixpanel. All rights reserved.
//

#import "MPConnectIntegrations.h"

@interface MPConnectIntegrations ()

@property (nonatomic, weak) Mixpanel *mixpanel;
@property (nonatomic, strong) NSString *savedUrbanAirshipChannelID;

@end

@implementation MPConnectIntegrations

- (instancetype)initWithMixpanel:(Mixpanel *)mixpanel {
    if (self = [super init]) {
        _mixpanel = mixpanel;
    }
    return self;
}

- (void)reset {
    self.savedUrbanAirshipChannelID = nil;
}

- (void)setupIntegrations:(NSArray<NSNumber *> *)integrations {
    if ([integrations containsObject:@4]) {
        [self setUrbanAirshipPeopleProp];
    }
}

- (void)setUrbanAirshipPeopleProp {
    Class urbanAirship = NSClassFromString(@"UAirship");
    if (urbanAirship) {
        NSString *channelID = [[urbanAirship performSelector:NSSelectorFromString(@"push")] performSelector:NSSelectorFromString(@"channelID")];
        if (!channelID) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self setUrbanAirshipPeopleProp];
            });
        } else if (![channelID isEqualToString:self.savedUrbanAirshipChannelID]) {
            [self.mixpanel.people set:@"$urban_airship_channel_id" to:channelID];
            self.savedUrbanAirshipChannelID = channelID;
        }
    }
}

@end
