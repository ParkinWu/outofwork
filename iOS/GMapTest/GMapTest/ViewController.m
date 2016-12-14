//
//  ViewController.m
//  GMapTest
//
//  Created by parkinwu on 2016/12/6.
//  Copyright © 2016年 parkinwu. All rights reserved.
//



#import "ViewController.h"
#import "MyMarkView.h"
@import GoogleMaps;
@interface ViewController ()<GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) GMSMarker * marker;
@property (nonatomic, strong) GMSMapView * mapView;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.290664
                                                            longitude:114.195304
                                                                 zoom:15];
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    _mapView.delegate = self;
    self.marker = [[GMSMarker alloc] init];
    _mapView.myLocationEnabled = YES;
    _marker.position = _mapView.myLocation.coordinate;
    _marker.title = @"当前位置";
    _marker.appearAnimation = kGMSMarkerAnimationPop;
    _marker.map = _mapView;
    
    [self.view addSubview:_mapView];
    
    [_mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self.view bringSubviewToFront:self.btn];
    
}
- (IBAction)myLocation:(id)sender {
    
    _marker.position = _coordinate;
    GMSCameraUpdate * update = [GMSCameraUpdate setTarget:_coordinate zoom:20];
    [_mapView moveCamera:update];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", [change objectForKey:NSKeyValueChangeNewKey]);
    CLLocation * location = [change objectForKey:NSKeyValueChangeNewKey];
    self.coordinate = location.coordinate;
}

#pragma mark - GMSMapViewDelegate
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {

    _marker.position = coordinate;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
