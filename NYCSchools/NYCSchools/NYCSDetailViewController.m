//
//  NYCSDetailViewController.m
//  NYCSchools
//
//  Created by Yi Yin on 1/29/23.
//

#import "NYCSDetailViewController.h"
#import "NYCSDataSource.h"

@interface NYCSDetailViewController () {
    NSUInteger schoolIndex;
}
@end

@implementation NYCSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Get the school details for this index
    NSDictionary* info=[[NYCSDataSource singleton] schoolInfoAtIndex:schoolIndex];
    NSString* schoolName=info[NYCSSchoolNameKey];
    NSString* schoolAddress=info[NYCSLocationKey];
    NSString* schoolTelephone=info[NYCSPhoneNumberKey];
    NSString* schoolOverview=info[NYCSOverviewKey];
    _lbSchoolName.text=schoolName;
    _lbSchoolAddress.text=schoolAddress;
    _lbSchoolTelephone.text=[NSString stringWithFormat:@"Tel: %@", schoolTelephone];
    _tvSchoolOverview.text=schoolOverview;
    // Get SAT results
    int satTotalScore=[info[NYCSSATTotalScoreKey] intValue];
    int satReadingScore=[info[NYCSSATReadingScoreKey] intValue];
    int satWritingScore=[info[NYCSSATWritingScoreKey] intValue];
    int satMathScore=[info[NYCSSATMathScoreKey] intValue];
    [self update:_lbSatTotal progressView:_pvSatTotal score:satTotalScore highestScore:2400];
    [self update:_lbSatReading progressView:_pvSatReading score:satReadingScore highestScore:800];
    [self update:_lbSatWriting progressView:_pvSatWriting score:satWritingScore highestScore:800];
    [self update:_lbSatMath progressView:_pvSatMath score:satMathScore highestScore:800];
}

-(void)setSchoolIndex:(NSUInteger)index{
    schoolIndex=index;
}

-(void)update:(UILabel*)label progressView:(UIProgressView*)progressView score:(int)score highestScore:(int)highestScore{
    label.text=score?@(score).stringValue:@"N/A";
    progressView.progress=(float)score/(float)highestScore;
}

@end
