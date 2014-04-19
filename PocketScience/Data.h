//
//  Data.h
//  PocketScience
//
//  Created by Pramesh Shrestha on 4/19/14.
//  Copyright (c) 2014 pramesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
{
    NSString *title;
    NSString *detail;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;

+ (id)dataInfo:(NSString*)title detail:(NSString*)detail;

@end
