#import "CCCalcUI/CCCalcUI.h"

%subclass CCCalcButton : TPNumberPadDarkStyleButton
%property (nonatomic, retain) id delegate;
%property (assign) BOOL shouldStayHighlighted;
//Using subclass of the lockscreen keypad buttons for ez and nice looking buttons

+ (id)imageForCharacter:(unsigned)character {
	if(character == BTN_MULTIPLY || character == BTN_NEGATE) {
		NSBundle *bundle = [[NSBundle alloc] initWithPath:@"/Library/MobileSubstrate/DynamicLibraries/com.gilesgc.cccalc.bundle"];
		return [UIImage imageWithContentsOfFile:[bundle pathForResource:(character == BTN_MULTIPLY ? @"multiply" : @"plus-minus") ofType:@"png"]];
	}
	UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0,0,75,75)];
	[text setTextColor:[UIColor whiteColor]];
	[text setFont:[UIFont boldSystemFontOfSize:25]];
	[text setTextAlignment:NSTextAlignmentCenter];

	[text setText:[[self class] textForButtonID:character]];

	return [text performSelector:@selector(_image)]; //private method which generates a UIImage from UILabel
}

- (void)setFrame:(CGRect)arg1 {
	%orig;

	for(UIView *view in [self subviews])
		[view setFrame:CGRectMake(0,0,arg1.size.width,arg1.size.height)];

	if([self character] == BTN_0) {
		for(UIView *subview in [self subviews]) {
			for(CALayer *sublayer in [[subview layer] sublayers]) {
				if([NSStringFromClass([sublayer class]) isEqualToString:@"CABackdropLayer"]) {
					//this fixes the visual issue with button 0
					[sublayer setFrame:CGRectMake(0,0,arg1.size.width,arg1.size.height)];
					break;
				}
			}
		}
	}
}

+ (CGRect)circleBounds {
	return CGRectMake(0,0,65,65);
}

- (void)setGlyphLayer:(CALayer *)layer {
	%orig;
	[layer setFrame:[[self class] circleBounds]];
}

%new +(NSString *)textForButtonID:(unsigned)identifier {
	if(identifier <= 9) {
		return [@(identifier) stringValue];
	} else {
		switch(identifier) {
			case BTN_CLEAR:
				return @"C";
			case BTN_NEGATE:
				return @"+/-";
			case BTN_PERCENT:
				return @"%";
			case BTN_DIVIDE:
				return @"÷";
			case BTN_MULTIPLY:
				return @"✕";
			case BTN_SUBTRACT:
				return @"−";
			case BTN_ADD:
				return @"+";
			case BTN_EQUAL:
				return @"=";
			case BTN_DECIMAL:
				return @".";
			default:
				return @"";
		}
	}
}

- (id)initForCharacter:(unsigned)character {
	CCCalcButton *me = %orig;
	[me addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
	return me;
}

%new - (void)tapped {
	if([self delegate] && [[self delegate] respondsToSelector:@selector(buttonTapped:)])
		[[self delegate] buttonTapped:[self character]];
}

- (void)setHighlighted:(BOOL)h {
	if([self shouldStayHighlighted])
		return;
	else
		%orig;
}

%end



@interface CCUIAppLauncherViewController : UIViewController
- (UIView *)contentView;
- (UIImage *)glyphImage;
- (BOOL)isCalcModule;
- (UIView *)buttonView;
- (CGFloat)headerHeight;
- (CGFloat)preferredExpandedContentWidth;
@end

@interface SBFApplication : NSObject
- (NSString *)applicationBundleIdentifier;
@end

static CCCalcViewController *ccCalcController;

%hook CCUIAppLauncherViewController

-(void)willTransitionToExpandedContentMode:(BOOL)expanded {
	%orig;

	if(![self isCalcModule])
		return;

	if(expanded) {

		if(!ccCalcController) {
			ccCalcController = [[CCCalcViewController alloc] init];
			MSHookIvar<UIView *>(self, "_contentView") = [ccCalcController view];
			[[self view] addSubview:[ccCalcController displayView]];
			[[self view] addSubview:[ccCalcController view]];

			[[ccCalcController displayView] setFrame:CGRectMake(0,0,[self preferredExpandedContentWidth],[self headerHeight])];
		}

		for(UIView *menuItem in MSHookIvar<UIStackView *>(self, "_menuItemsContainer").arrangedSubviews) {
			[menuItem setHidden:YES];
		}

		[[ccCalcController view] setHidden:NO];
		[[ccCalcController displayView] setHidden:NO];
		[[self buttonView] setHidden:YES];
	
	} else {
		[[ccCalcController view] setHidden:YES];
		[[ccCalcController displayView] setHidden:YES];
		[[self buttonView] setHidden:NO];
	}

}

-(CGFloat)preferredExpandedContentHeight {
	if([self isCalcModule])
		return 525.0f;
	else
		return %orig;
}

-(void)_setupTitleLabel {
	if([self isCalcModule])
		return;

	%orig;
}

%new -(BOOL)isCalcModule {
	return [[MSHookIvar<SBFApplication *>(self, "_application") applicationBundleIdentifier] isEqualToString:@"com.apple.calculator"];
}

%end