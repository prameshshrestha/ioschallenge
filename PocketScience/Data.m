//
//  Data.m
//  PocketScience
//
//  Created by Pramesh Shrestha on 4/19/14.
//  Copyright (c) 2014 pramesh. All rights reserved.
//

#import "Data.h"

@implementation Data
@synthesize title, detail;

+ (id)dataInfo:(NSString*)title detail:(NSString*)detail
{
    Data *newData = [[self alloc]init];
    newData.title = title;
    newData.detail = detail;
    return newData;
}

@end
