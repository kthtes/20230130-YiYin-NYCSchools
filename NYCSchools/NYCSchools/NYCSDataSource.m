//
//  NYCSJsonManager.m
//  NYCSchools
//
//  Created by Yi Yin on 1/29/23.
//

#import "NYCSDataSource.h"

static NYCSDataSource* _singleton=nil;

@interface NYCSDataSource () {
    NSArray<NSDictionary*>* schoolInfo;
}
@end

@implementation NYCSDataSource
+(instancetype)singleton{
    if(_singleton==nil){
        _singleton=[[NYCSDataSource alloc] init];
    }
    return _singleton;
}
+(instancetype)alloc{
    NSAssert(_singleton==nil, @"***Don't alloc 2nd instance of NYCSDataSource***");
    return [super alloc];
}
-(instancetype)init{
    if((self=[super init])){
        schoolInfo=[self createSchoolInfo];
    }
    return self;
}

-(void)sortByKey:(NSString*)key ascendOrder:(BOOL)isAscend{
    NSArray* desc=@[[NSSortDescriptor sortDescriptorWithKey:key ascending:isAscend]];
    schoolInfo=[schoolInfo sortedArrayUsingDescriptors:desc];
}

-(NSDictionary*)schoolInfoAtIndex:(NSUInteger)index{
    return schoolInfo[index];
}

-(NSUInteger)count{
    return schoolInfo.count;
}

-(NSArray<NSDictionary*>*)createSchoolInfo{
    // TODO: may fetch the two JSON files over the network for better flexibility
    NSMutableDictionary* schoolDetails=[self convertJsonToArray:@"NYC_Schools_Details" includedKeys:@[NYCSSchoolNameKey, NYCSLocationKey, NYCSPhoneNumberKey, NYCSSchoolEmailKey, NYCSWebsiteKey, NYCSBoroughKey, NYCSOverviewKey]];
    NSMutableDictionary* schoolSATs=[self convertJsonToArray:@"NYC_Schools_SAT_Results" includedKeys:@[NYCSSATReadingScoreKey, NYCSSATMathScoreKey, NYCSSATWritingScoreKey, NYCSSATNumberOfTakersKey]];
    NSLog(@"createSchoolInfo: created %lu schoolDetails and %lu schoolSATs", schoolDetails.count, schoolSATs.count);
    // Merge the two dictionaries into one array
    NSMutableArray* result=[NSMutableArray arrayWithCapacity:schoolDetails.count];
    for(NSString* schoolId in schoolDetails.allKeys){
        NSMutableDictionary* oneResult=[NSMutableDictionary dictionary];
        // Add K/V from schoolDetails
        oneResult[NYCSSchoolNameKey]=schoolDetails[schoolId][NYCSSchoolNameKey];
        oneResult[NYCSLocationKey]=schoolDetails[schoolId][NYCSLocationKey];
        oneResult[NYCSPhoneNumberKey]=schoolDetails[schoolId][NYCSPhoneNumberKey];
        oneResult[NYCSSchoolEmailKey]=schoolDetails[schoolId][NYCSSchoolEmailKey];
        oneResult[NYCSWebsiteKey]=schoolDetails[schoolId][NYCSWebsiteKey];
        oneResult[NYCSBoroughKey]=schoolDetails[schoolId][NYCSBoroughKey];
        oneResult[NYCSOverviewKey]=schoolDetails[schoolId][NYCSOverviewKey];
        // Add K/V from schoolSATs, then compute the SAT total score
        oneResult[NYCSSATReadingScoreKey]=@([schoolSATs[schoolId][NYCSSATReadingScoreKey] intValue]);
        oneResult[NYCSSATMathScoreKey]=@([schoolSATs[schoolId][NYCSSATMathScoreKey] intValue]);
        oneResult[NYCSSATWritingScoreKey]=@([schoolSATs[schoolId][NYCSSATWritingScoreKey] intValue]);
        oneResult[NYCSSATNumberOfTakersKey]=@([schoolSATs[schoolId][NYCSSATNumberOfTakersKey] intValue]);
        oneResult[NYCSSATTotalScoreKey]=@([oneResult[NYCSSATReadingScoreKey] intValue]+[oneResult[NYCSSATMathScoreKey] intValue]+[oneResult[NYCSSATMathScoreKey] intValue]);
        [result addObject:oneResult];
    }
    NSLog(@"createSchoolInfo: created %lu entries.", result.count);
    return result.copy;
}

-(NSMutableDictionary*)convertJsonToArray:(NSString*)jsonFile includedKeys:(NSArray*)keys{
    NSString* filePath=[[NSBundle mainBundle] pathForResource:jsonFile ofType:@"json" inDirectory:@"SchoolData"];
    NSData* data=[NSData dataWithContentsOfFile:filePath];
    NSError* error;
    NSArray* array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if(error){
        NSLog(@"Unable to read resource file: %@", filePath);
        return nil;
    }
    NSMutableDictionary* result=[NSMutableDictionary dictionaryWithCapacity:array.count];
    for(NSDictionary* dict in array){
        NSString* schoolId=dict[@"dbn"];
        result[schoolId]=[NSMutableDictionary dictionaryWithCapacity:keys.count];
        for(NSString* key in keys){
            result[schoolId][key]=dict[key];
        }
    }
    return result;
}

@end
