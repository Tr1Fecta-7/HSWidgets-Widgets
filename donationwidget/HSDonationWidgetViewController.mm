#import "HSDonationWidgetViewController.h"

@implementation HSDonationWidgetViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	UIViewController *donationViewController = [[[HSDonationContentViewInterface alloc] init] makeContentView];
	UIView *donationView = donationViewController.view;
	donationView.layer.masksToBounds = YES;
	donationView.layer.cornerRadius = 13.0;
	donationView.layer.cornerCurve = kCACornerCurveContinuous;
	donationView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:donationView];

	[NSLayoutConstraint activateConstraints:@[
		[donationView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
		[donationView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
		[donationView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
		[donationView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
	]];
	
}

+ (HSWidgetSize)minimumSize {
	return HSWidgetSizeMake(3, 3); // least amount of rows and cols the widget needs
}

@end
