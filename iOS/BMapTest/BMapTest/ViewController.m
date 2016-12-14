//
//  ViewController.m
//  BMapTest
//
//  Created by parkinwu on 2016/12/6.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>

@interface ViewController ()<BMKMapViewDelegate>

@property (nonatomic, strong) BMKLocationService * service;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) BMKMapView * mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    _mapView.zoomLevel = 20;
    _mapView.showsUserLocation = YES;
    
    
    self.service = [[BMKLocationService alloc] init];
    [_service startUserLocationService];
    BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc] init];
    [_mapView addAnnotation:annotation];
    
    [self.view bringSubviewToFront:_btn];
    
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        return newAnnotationView;
    }
    return nil;
}
- (IBAction)mylocation:(id)sender {
    _mapView.centerCoordinate = _service.userLocation.location.coordinate;
    BMKPointAnnotation * annotation = [[_mapView annotations] firstObject];
    annotation.coordinate = _service.userLocation.location.coordinate;
}


#pragma mark - BMKMapViewDelegate

- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi {
    
    BMKPointAnnotation * annotation = [[_mapView annotations] firstObject];
    annotation.coordinate = mapPoi.pt;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    BMKPointAnnotation * annotation = [[_mapView annotations] firstObject];
    annotation.coordinate = coordinate;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
