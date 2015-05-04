//
//  Marker+MarkerExtension.m
//  MyRoutineViewer
//
//  Created by bizappman on 5/4/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import "Marker+MarkerExtension.h"

@implementation Marker (MarkerExtension)

-(NSArray *)getImageUrlsArray{
    NSError *error;
    NSData *data=[self.imgUrls dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
    if(jsonObject!=nil && error==nil){
        return jsonObject;
    }else{
        return nil;
    }
}

@end
