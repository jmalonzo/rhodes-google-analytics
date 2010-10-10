
#import "Analytics.h"

#import "GANTracker.h"

// For our C interface
Analytics *analytics;

// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 10;

@implementation Analytics

- (void)start
{
  [[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-000000-01"
                                         dispatchPeriod:kGANDispatchPeriodSec
                                               delegate:nil];
  NSError* error;
  if (![[GANTracker sharedTracker] trackEvent:@"my_category"
                                       action:@"my_action"
                                        label:@"my_label"
                                        value:-1
                                    withError:&error]) {
    // handle error here
  }
  
  if (![[GANTracker sharedTracker] trackPageview:@"/app"
                                       withError:&error]) {
    // handle error here
  }
}

- (void)dealloc {
  [[GANTracker sharedTracker] stopTracker];
  [super dealloc];
}

@end


void start(void) {
  static bool started = false;
  if (!started) {
    analytics = [[Analytics alloc] init];
    [analytics start];
    started = true;
  }
}
