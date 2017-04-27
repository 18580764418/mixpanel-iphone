//
//  AutomaticEvents.h
//  Mixpanel
//
//  Created by Yarden Eitan on 4/18/17.
//  Copyright © 2017 Mixpanel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "MixpanelPeople.h"

@protocol TrackDelegate <NSObject>
- (void)track:(NSString *)event properties:(NSDictionary *)properties;
@end

@interface AutomaticEvents: NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate>
@property (atomic, weak) id<TrackDelegate> delegate;
@property (class, atomic, assign) NSTimeInterval appStartTime;
@property (atomic, assign) UInt64 minimumSessionDuration;
- (void)initializeEvents:(MixpanelPeople *)peopleInstance;

@end

