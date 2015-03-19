//
//  UIImage+loadScan.m
//  Wine Grabber
//
//  Created by DOUINEAU Romain on 10/11/2014.
//  Copyright (c) 2014 Toucouleur. All rights reserved.
//

#import "UIImage+loadScan.h"

@implementation UIImage (loadScan)

#pragma SAVE AND LOAD

- (void)saveScan:(NSString*)name{
    if (self != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithString:name] ];
        NSData* data = UIImagePNGRepresentation(self);
        [data writeToFile:path atomically:YES];
    }
}

- (UIImage *)loadScan:(NSString*)name theImage:(UIImage*)theImg{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, name];
    NSLog(@"loading %@", path);
    
    //NSData *imgData = [NSData dataWithContentsOfFile:path];
    //UIImage *image = [[UIImage alloc] initWithData:imgData];
    
    [theImg initWithContentsOfFile:path];
    return theImg;
}



@end
