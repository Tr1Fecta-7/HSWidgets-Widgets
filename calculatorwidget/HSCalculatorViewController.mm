#import "HSCalculatorViewController.h"

@implementation HSCalculatorViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.ccVC = [[CCCalcViewController alloc] init];
	self.ccVC.view.translatesAutoresizingMaskIntoConstraints = NO;
	self.ccVC.displayView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.ccVC.displayView];
	[self.view addSubview:self.ccVC.view];

	[NSLayoutConstraint activateConstraints:@[
		[self.ccVC.displayView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
		[self.ccVC.displayView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
		[self.ccVC.displayView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
		[self.ccVC.displayView.heightAnchor constraintEqualToConstant:40],

		[self.ccVC.view.topAnchor constraintEqualToAnchor:self.ccVC.displayView.bottomAnchor constant:20],
		[self.ccVC.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
		[self.ccVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
		[self.ccVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
	]];
}

- (BOOL)isAccessoryTypeEnabled:(AccessoryType)accessory {
    // check if expand or shrink
    if (accessory == AccessoryTypeExpand) {
		// Check if widget sizes 2,2 or 3,3 
		if (HSWidgetSizeEqualsSize(self.widgetFrame.size, HSWidgetSizeMake(2,2))) {
			return [super containsSpaceToExpandOrShrinkToWidgetSize:HSWidgetSizeMake(3,3)];
		}
		else if (HSWidgetSizeEqualsSize(self.widgetFrame.size, HSWidgetSizeMake(3,3))) {
			return [super containsSpaceToExpandOrShrinkToWidgetSize:HSWidgetSizeMake(4,4)];
		}
    } 
	else if (accessory == AccessoryTypeShrink) {
		// Check if widget sizes 4,4 or 3,3 
        if (HSWidgetSizeEqualsSize(self.widgetFrame.size, HSWidgetSizeMake(4,4))){
			return [super containsSpaceToExpandOrShrinkToWidgetSize:HSWidgetSizeMake(3,3)];
		}
		else if (HSWidgetSizeEqualsSize(self.widgetFrame.size, HSWidgetSizeMake(3,3))) {
			return [super containsSpaceToExpandOrShrinkToWidgetSize:HSWidgetSizeMake(2,2)];
		}
    }

    // anything else we don't support but let super class handle it incase new accessory types are added
    return [super isAccessoryTypeEnabled:accessory];
}

-(void)accessoryTypeTapped:(AccessoryType)accessory {
    if (accessory == AccessoryTypeExpand) {
        // new size to expand to
		if (HSWidgetSizeEqualsSize(self.widgetFrame.size, HSWidgetSizeMake(2,2))) {
			[super updateForExpandOrShrinkToWidgetSize:HSWidgetSizeMake(3,3)];
		}
		else if (HSWidgetSizeEqualsSize(self.widgetFrame.size, HSWidgetSizeMake(3,3))) {
			[super updateForExpandOrShrinkToWidgetSize:HSWidgetSizeMake(4,4)];
		}
    } 
	else if (accessory == AccessoryTypeShrink) {
        // new size to shrink to
		if (HSWidgetSizeEqualsSize(self.widgetFrame.size, HSWidgetSizeMake(4,4))){
			[super updateForExpandOrShrinkToWidgetSize:HSWidgetSizeMake(3,3)];
		}
		else if (HSWidgetSizeEqualsSize(self.widgetFrame.size, HSWidgetSizeMake(3,3))) {
			[super updateForExpandOrShrinkToWidgetSize:HSWidgetSizeMake(2,2)];
		}
    }
}

+ (HSWidgetSize)minimumSize {
	return HSWidgetSizeMake(2, 2); // least amount of rows and cols the widget needs
}
@end
