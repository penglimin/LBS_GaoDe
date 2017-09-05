//
//  ViewController.m
//  HomePosition
//
//  Created by 彭利民 on 2017/9/5.
//  Copyright © 2017年 bwton. All rights reserved.
//

#import "ViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
@interface ViewController ()


// 地图下半部分

@property (nonatomic, strong) MAMapView *mapView;

// 上半部分 -- 右半边
@property (nonatomic, strong) UIView *rightView;


@property (nonatomic, strong) AMapNaviCompositeManager *compositeManager;

@end

@implementation ViewController



- (UIView *)rightView
{

    if (_rightView == nil) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 60, 50, 260)];
        _rightView.backgroundColor = [UIColor redColor];
        
    }
    
    return _rightView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:mapView];
    
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    mapView.showsUserLocation = YES;
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    self.mapView = mapView;
    
    // 自定义定位小蓝点
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];

    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    r.showsHeadingIndicator = NO;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    r.fillColor = [UIColor redColor];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
    r.strokeColor = [UIColor blueColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    r.lineWidth = 2;///精度圈 边线宽度，默认0
    r.enablePulseAnnimation = YES;///内部蓝色圆点是否使用律动效果, 默认YES
    r.locationDotBgColor = [UIColor greenColor];///定位点背景色，不设置默认白色
    r.locationDotFillColor = [UIColor grayColor];///定位点蓝色圆点颜色，不设置默认蓝色
//    r.image = [UIImage imageNamed:@"aaa"]; ///定位图标, 与蓝色原点互斥
    [_mapView updateUserLocationRepresentation:r];
    
    [self setupMapSettingRightView];
    
    
}

- (void)setupMapSettingRightView
{
    
    UIButton *btnMapTypeBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    btnMapTypeBtn.backgroundColor = [UIColor whiteColor];
    
    [btnMapTypeBtn setTitle:@"标准" forState:UIControlStateNormal];
    [btnMapTypeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btnMapTypeBtn addTarget:self action:@selector(changeMapTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnMapTypeBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(5, 41 + 5, 40, 40)];
    btnMapTypeBtn1.backgroundColor = [UIColor whiteColor];
    
    [btnMapTypeBtn1 setTitle:@"卫星" forState:UIControlStateNormal];
    [btnMapTypeBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btnMapTypeBtn1 addTarget:self action:@selector(changeMapTypeBtnClick1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnMapTypeBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(5, 41 + 41+5, 40, 40)];
    btnMapTypeBtn2.backgroundColor = [UIColor whiteColor];
    
    [btnMapTypeBtn2 setTitle:@"夜景" forState:UIControlStateNormal];
    [btnMapTypeBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btnMapTypeBtn2 addTarget:self action:@selector(changeMapTypeBtnClick2) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnMapTypeBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(5, 41 + 41+41+5, 40, 40)];
    btnMapTypeBtn3.backgroundColor = [UIColor whiteColor];
    
    [btnMapTypeBtn3 setTitle:@"导航" forState:UIControlStateNormal];
    [btnMapTypeBtn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btnMapTypeBtn3 addTarget:self action:@selector(changeMapTypeBtnClick3) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnMapTypeBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(5, 41 + 41+41+41+5, 40, 40)];
    btnMapTypeBtn4.backgroundColor = [UIColor whiteColor];
    
    [btnMapTypeBtn4 setTitle:@"公交" forState:UIControlStateNormal];
    [btnMapTypeBtn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btnMapTypeBtn4 addTarget:self action:@selector(changeMapTypeBtnClick4) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnMapTypeBtn5 = [[UIButton alloc] initWithFrame:CGRectMake(1, 41 + 41+41+41+41+8, 48, 40)];
    btnMapTypeBtn5.backgroundColor = [UIColor whiteColor];
    
    [btnMapTypeBtn5 setTitle:@"+路况" forState:UIControlStateNormal];
    [btnMapTypeBtn5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btnMapTypeBtn5 addTarget:self action:@selector(changeMapTypeBtnClick5) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.rightView addSubview:btnMapTypeBtn];
    [self.rightView addSubview:btnMapTypeBtn1];
    [self.rightView addSubview:btnMapTypeBtn2];
    [self.rightView addSubview:btnMapTypeBtn3];
    [self.rightView addSubview:btnMapTypeBtn4];
    [self.rightView addSubview:btnMapTypeBtn5];

    [self.view addSubview:self.rightView];
    
    
    
    UIButton *daohang = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.height - 100, 60, 40)];
    
    [self.view addSubview:daohang];
    daohang.backgroundColor = [UIColor grayColor];
    [daohang setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [daohang setTitle:@"导航" forState:UIControlStateNormal];
    
    [daohang addTarget:self action:@selector(daohang) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 输入出发地
    // 输入目的地
    
    
    

}

- (void)changeMapTypeBtnClick
{
    NSLog(@"点击了切换标准地图按钮");
    [self.mapView setMapType:MAMapTypeStandard];
    self.mapView.showTraffic = NO;

}
- (void)changeMapTypeBtnClick1
{
    NSLog(@"点击了切换卫星地图按钮");
    [self.mapView setMapType:MAMapTypeSatellite];
    self.mapView.showTraffic = NO;

    
}
- (void)changeMapTypeBtnClick2
{
    NSLog(@"点击了切换夜景模式地图按钮");
    self.mapView.showTraffic = NO;

    [self.mapView setMapType:MAMapTypeStandardNight];

}
- (void)changeMapTypeBtnClick3
{
    NSLog(@"点击了切换导航模式地图按钮");
    self.mapView.showTraffic = NO;

    [self.mapView setMapType:MAMapTypeNavi];
}
- (void)changeMapTypeBtnClick4
{
    NSLog(@"点击了切换导航模式地图按钮");
    self.mapView.showTraffic = NO;

    [self.mapView setMapType:MAMapTypeBus];
}
//MAMapTypeStandard = 0,  ///< 普通地图
//MAMapTypeSatellite,     ///< 卫星地图
//MAMapTypeStandardNight, ///< 夜间视图
//MAMapTypeNavi,          ///< 导航视图
//MAMapTypeBus            ///< 公交视图
- (void)changeMapTypeBtnClick5
{
    NSLog(@"点击了路况地图按钮");
    self.mapView.showTraffic = YES;
}

- (void)daohang{

    // 初始化
    self.compositeManager = [[AMapNaviCompositeManager alloc] init];
    // 如果需要使用AMapNaviCompositeManagerDelegate的相关回调（如自定义语音、获取实时位置等），需要设置delegate
    self.compositeManager.delegate = self;
    // 通过present的方式显示路线规划页面, 在不传入起终点启动导航组件的模式下，options需传入nil
    [self.compositeManager presentRoutePlanViewControllerWithOptions:nil];
}
@end
