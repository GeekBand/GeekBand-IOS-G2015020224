//
//  TLMSquareViewController.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/24/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMSquareViewController.h"
#import "TLMSquareRequestParser.h"
#import "TLMSquareRequest.h"
#import "TLMGlobal.h"
#import "TLMSquareCell.h"
#import <CoreLocation/CoreLocation.h>
#import "KxMenu.h"

@interface TLMSquareViewController () <TLMSquareRequestDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableArray *addrArray;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableDictionary *locationDic;

@end

@implementation TLMSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add titlebutton to the NavigationBar
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitle:@"全部" forState:UIControlStateNormal];
    titleButton.frame = CGRectMake(0, 0, 200, 35);
    [titleButton setImage:[UIImage imageNamed:@"square"] forState:UIControlStateNormal];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 133, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    self.locationDic = [NSMutableDictionary dictionary];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100.0f;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"fail to locate" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    
    [self requestAllData];
    
}


#pragma mark - TableView Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"addrArray: %zd", self.addrArray.count);
    return self.addrArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLMSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"squareCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[TLMSquareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"squareCell"];
    }
    
    TLMSquareModel *squareModel = self.addrArray[indexPath.row][0];
    cell.squareVC = self;
    cell.locationLabel.text = squareModel.addr;
    cell.dataArr = self.dataDic[self.addrArray[indexPath.row]];
    [cell.collectionView reloadData];
    return cell;
}


#pragma mark - Fetching data methods

- (void)requestAllData {
    NSDictionary *paramDic = @{@"user_id":[TLMGlobal shareGlobal].user.userId, @"token":[TLMGlobal shareGlobal].user.token, @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"1000"};
    
    TLMSquareRequest *squareRequest = [[TLMSquareRequest alloc] init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
}


#pragma mark - TLMSquareRequestDelegate methods

- (void)squareRequestSuccess:(TLMSquareRequest *)request dictionary:(NSDictionary *)dictionary {
    self.addrArray = [NSMutableArray arrayWithArray:[dictionary allKeys]];
    self.dataDic = dictionary;
    [self.tableView reloadData];
}

- (void)squareRequestFailed:(TLMSquareRequest *)request error:(NSError *)error {
    
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.locationDic = [NSMutableDictionary dictionary];
    NSLog(@"纬度:%f", newLocation.coordinate.latitude);
    NSLog(@"经度:%f", newLocation.coordinate.longitude);
    NSString *latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    [self.locationDic setValue:latitude forKey:@"latitude"];
    [self.locationDic setValue:longitude forKey:@"longitude"];
    CLLocationDegrees latitude2 = newLocation.coordinate.latitude;
    CLLocationDegrees longitude2 = newLocation.coordinate.longitude;
    
    CLLocation *c = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:c completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error && [placemarks count] > 0) {
            NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
            NSLog(@"street address: %@", [dict objectForKey:@"Street"]);
            [self.locationDic setValue:dict[@"Name"] forKey:@"location"];
        } else {
            NSLog(@"ERROR: %@", error);
        }
    }];
    
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
}

#pragma mark - SearchButton method

- (void)titleButtonClicked:(UIButton *)button {
    NSArray *menuItems = @[[KxMenuItem menuItem:@"显示全部" image:nil target:self action:@selector(requestAllData)],
                           [KxMenuItem menuItem:@"附近500米" image:nil target:self action:@selector(request500kmData)],
                           [KxMenuItem menuItem:@"附近1000米" image:nil target:self action:@selector(request1000kmData)],
                           [KxMenuItem menuItem:@"附近1500米" image:nil target:self action:@selector(request1500kmData)]];
    UIButton *btn = (UIButton *)button;
    CGRect editImageFrame = btn.frame;
    
    UIView *targetSuperview = btn.superview;
    CGRect rect = [targetSuperview convertRect:editImageFrame toView:[[UIApplication sharedApplication] keyWindow]];
    
    [KxMenu showMenuInView:[[UIApplication sharedApplication] keyWindow] fromRect:rect menuItems:menuItems];
}

- (void)request500kmData {
    NSDictionary *paramDic = @{@"user_id":[TLMGlobal shareGlobal].user.userId, @"token":[TLMGlobal shareGlobal].user.token, @"longitude":[self.locationDic valueForKey:@"longitude"], @"latitude":[self.locationDic valueForKey:@"latitude"], @"distance":@"500"};
    TLMSquareRequest *squareRequest = [[TLMSquareRequest alloc] init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
}

- (void)request1000kmData {
    NSDictionary *paramDic = @{@"user_id":[TLMGlobal shareGlobal].user.userId, @"token":[TLMGlobal shareGlobal].user.token, @"longitude":[self.locationDic valueForKey:@"longitude"], @"latitude":[self.locationDic valueForKey:@"latitude"], @"distance":@"1000"};
    TLMSquareRequest *squareRequest = [[TLMSquareRequest alloc] init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
}

- (void)request1500kmData {
    NSDictionary *paramDic = @{@"user_id":[TLMGlobal shareGlobal].user.userId, @"token":[TLMGlobal shareGlobal].user.token, @"longitude":[self.locationDic valueForKey:@"longitude"], @"latitude":[self.locationDic valueForKey:@"latitude"], @"distance":@"1500"};
    TLMSquareRequest *squareRequest = [[TLMSquareRequest alloc] init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
}



#pragma mark - Memory Management methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
