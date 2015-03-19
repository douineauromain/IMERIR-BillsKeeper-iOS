//
//  UIImage+loadScan.h
//  Wine Grabber
//
//  Created by DOUINEAU Romain on 10/11/2014.
//  Copyright (c) 2014 Toucouleur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (loadScan)

- (void)saveScan:(NSString*)name;

+ (UIImage *)imageWithScan:(NSString*)name;
@end
