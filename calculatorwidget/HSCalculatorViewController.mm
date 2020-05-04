#import "HSCalculatorViewController.h"

@implementation HSCalculatorViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.ccVC = [[CCCalcViewController alloc] init];
	self.ccVC.view.translatesAutoresizingMaskIntoConstraints = NO;
	self.ccVC.displayView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.ccVC.displayView];
	[self.view addSubview:self.ccVC.view];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

	[NSLayoutConstraint activateConstraints:@[
		[self.ccVC.displayView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
		[self.ccVC.displayView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
		[self.ccVC.displayView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
		[self.ccVC.displayView.heightAnchor constraintEqualToConstant:50],

		[self.ccVC.view.topAnchor constraintEqualToAnchor:self.ccVC.displayView.bottomAnchor constant:20],
		[self.ccVC.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
		[self.ccVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
		[self.ccVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
	]];

	//[self.ccVC.displayView setFrame:CGRectMake(0,0, 525.0f, 97)];
}

+ (HSWidgetSize)minimumSize {
	return HSWidgetSizeMake(4, 4); // least amount of rows and cols the widget needs
}
@end
