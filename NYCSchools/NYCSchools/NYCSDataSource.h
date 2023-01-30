//
//  NYCSJsonManager.h
//  NYCSchools
//
//  Created by Yi Yin on 1/29/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define NYCSSchoolNameKey @"school_name"
#define NYCSLocationKey @"location"
#define NYCSPhoneNumberKey @"phone_number"
#define NYCSSchoolEmailKey @"school_email"
#define NYCSWebsiteKey @"website"
#define NYCSBoroughKey @"borough"
#define NYCSOverviewKey @"overview_paragraph"
#define NYCSSATReadingScoreKey @"sat_critical_reading_avg_score"
#define NYCSSATMathScoreKey @"sat_math_avg_score"
#define NYCSSATWritingScoreKey @"sat_writing_avg_score"
#define NYCSSATNumberOfTakersKey @"num_of_sat_test_takers"
#define NYCSSATTotalScoreKey @"sat_total_score"

@interface NYCSDataSource : NSObject

+(instancetype)singleton;

// Sorts the school info by key
-(void)sortByKey:(NSString*)key ascendOrder:(BOOL)isAscend;

// Returns the school info at index
-(NSDictionary*)schoolInfoAtIndex:(NSUInteger)index;

// Returns the total count of school info entries
-(NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
