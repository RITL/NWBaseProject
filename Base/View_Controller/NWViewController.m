//
//  ETViewController.m
//  Yuexiaowen
//
//  Created by YueWen on 2017/3/24.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import "NWViewController.h"
#import <RITLKit/RITLKit.h>

@interface NWViewController ()
@end


@implementation NWViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}


- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    if (_statusBarStyle != statusBarStyle) {
        
        _statusBarStyle = statusBarStyle;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

-(instancetype)init
{
    if (self = [super init])
    {
        [self loadPropertysAtInitialization];
    }
    return self;
}


- (void)actionBackItemInNavigationBar
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else {
        [self dismissViewControllerAnimated:true completion:nil];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (RITL_iOS_Version_GreaterThanOrEqualTo(11.0)) {
    
        if (@available(iOS 11.0,*)) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
        }
    }
    
    if (self.hasParentNavigationController) {//设置导航
        
        [self.navigationController.navigationBar setBackIndicatorImage:self.backIndicatorImage.ritl_image.ritl_renderOriginImage];
        
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:self.backIndicatorImage.ritl_image.ritl_renderOriginImage];
        
        [self setDefaultNavigationBarWhenHasParentNavigationController];
    }
}


- (void)setDefaultNavigationBarWhenHasParentNavigationController {
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    printf("I am %s\n",NSStringFromClass(self.class).UTF8String);
}


-(void)loadPropertysAtInitialization
{
    self.archiverManager = [RITLArchiverManager new];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"[dealloc] [%@]",NSStringFromClass([self class]));
}


-(void)doNothing
{
    
}


- (void)configRequestAPI
{
    
}


- (NSString *)archiverManagerDocument
{
    return nil;
}

- (BOOL)startArchiver:(NSArray<id<NSCoding>> *)archiverObjects
{
    if (!archiverObjects || !self.archiverManagerDocument) {
        return false;
    }
    
    return [self.archiverManager ritl_startArchiver:archiverObjects document:self.archiverManagerDocument error:nil];
}

- (NSArray<id<NSCoding>> *)readArchiverObjects
{
    if (!self.archiverManagerDocument) {
        return @[];
    }
    
    return [self.archiverManager ritl_readArchiverObjectsInDocument:self.archiverManagerDocument];
}

- (void)elementDidClick:(id)sender
{
    
}


#pragma mark - NavigationBar

- (BOOL)hasParentNavigationController
{
    return [self.parentViewController isKindOfClass:[UINavigationController class]];
}

- (NSString *)backIndicatorImage
{
    return @"navigationbar_back_gray";
}

#pragma mark - Autorotate

- (BOOL)shouldAutorotate
{
    return false;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end



