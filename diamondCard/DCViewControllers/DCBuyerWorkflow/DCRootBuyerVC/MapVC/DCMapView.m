           //
//  DCMapView.m
//  diamondCard
//
//  Created by user-letsgo6 on 12.01.18.
//  Copyright © 2018 NSD NULL. All rights reserved.
//

#import "DCMapView.h"

@import MapKit;

@interface DCMapView () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DCMapView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.layer.cornerRadius = 5.f;
    self.mapView.layer.masksToBounds = YES;
    self.mapView.zoomEnabled = false;
    self.mapView.scrollEnabled = false;
    self.mapView.userInteractionEnabled = false;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[MKMapView class]])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
