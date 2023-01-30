//
//  NYCSDetailViewController.h
//  NYCSchools
//
//  Created by Yi Yin on 1/29/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYCSDetailViewController : UIViewController

@property(weak,nonatomic) IBOutlet UILabel* lbSchoolName;
@property(weak,nonatomic) IBOutlet UILabel* lbSchoolAddress;
@property(weak,nonatomic) IBOutlet UILabel* lbSchoolTelephone;
@property(weak,nonatomic) IBOutlet UITextView* tvSchoolOverview;

@property(weak,nonatomic) IBOutlet UILabel* lbSatTotal;
@property(weak,nonatomic) IBOutlet UILabel* lbSatReading;
@property(weak,nonatomic) IBOutlet UILabel* lbSatWriting;
@property(weak,nonatomic) IBOutlet UILabel* lbSatMath;

@property(weak,nonatomic) IBOutlet UIProgressView* pvSatTotal;
@property(weak,nonatomic) IBOutlet UIProgressView* pvSatReading;
@property(weak,nonatomic) IBOutlet UIProgressView* pvSatWriting;
@property(weak,nonatomic) IBOutlet UIProgressView* pvSatMath;

-(void)setSchoolIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
