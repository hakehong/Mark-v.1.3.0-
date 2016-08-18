//
//  FindViewController.m
//  Mark
//
//  Created by hongqing on 16/4/11.
//  Copyright © 2016年 hongqing. All rights reserved.
//
#define spaceing  10

#import "FindViewController.h"
#import "HttpTool.h"
#import "CycleMovieList.h"
#import "CycleMovie.h"
#import "NSObject+YYModel.h"
#import "YYWebImage.h"
#import "SDCycleScrollView.h"
#import "AFHTTPSessionManager.h"
#import "testCell.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "UIView+Extension.h"

static NSString *const CellID1 =@"CellID1";
static NSString *const CellID =@"CellID";
static NSString *const CycleUrl =@"http://114.215.104.21/v130/singles/banner?";
static NSString *const SecondUrl =@"http://114.215.104.21/v130/singles/cat?";
static NSString *const MovieListUrl =@"http://114.215.104.21/v130/singles/list";


@interface FindViewController() <SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CycleMovieList *list;
    CycleMovieList  *list2;
    CycleMovieList  *list3;
   
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *btnOne;
@property(nonatomic,strong)UIButton *btnTwo;
@property(nonatomic,strong)UIButton *btnThird;
@property(nonatomic,strong) UIView *secondView;
@property (nonatomic , strong) UICollectionView *collectionView;
@property(nonatomic,strong )SDCycleScrollView *cycleScrollView;
@property(nonatomic,copy)NSMutableArray *imagesURLStrings;
@property(nonatomic,copy)NSMutableArray *imagesURLStrings2;
@property(nonatomic,copy)NSDictionary *params;
@property(nonatomic,assign) NSNumber *startNum;
@end

@implementation FindViewController
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    _btnOne.frame =_secondView.bounds;
//    _btnOne.width =_secondView.width/3.0;
//    _btnOne.height =_btnOne.height;
//    _btnTwo.x = _btnOne.width;
//    _btnTwo.width =_secondView.width/3.0;
//    _btnTwo.height =_btnOne.height;
//    _btnTwo.x = _btnOne.width * 2;
//    _btnTwo.width =_secondView.width/3.0;
//    _btnTwo.height =_btnOne.height;
//    
//}
-(void)viewDidLoad
{
    [super viewDidLoad];
//    self.tabBarController.tabBar.hidden =NO;
   
//     _params = @{@"10":@"count",
//                 @"HU0QIAGVzI0xIDq6k9RHcA%3D%3D": @"muid",
//                 @"0":_startNum,
//                 @"1718":@"uid"};
//     _params = @{@"count": @"muid",@"start":@"uid": @[@10, @"HU0QIAGVzI0xIDq6k9RHcA%3D%3D", @0,@1718]};
   
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Kwidth,Kheight)];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, 250)];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
//   [self getTableViewData];
//    _secondView =[[UIView alloc]initWithFrame:CGRectMake(0, 150, Kwidth,90)];
    _secondView = [[[NSBundle mainBundle] loadNibNamed:@"SecondView" owner:nil options:nil] firstObject];
    _secondView.frame =CGRectMake(0,150, Kwidth,90);
    [self.view addSubview:_tableView];
    [_tableView.tableHeaderView addSubview:_secondView];
    [self initCycleScrollView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
}
-(void)loadNewData
{
    _params =  [NSDictionary dictionaryWithObjectsAndKeys:@"10",@"count",@"HU0QIAGVzI0xIDq6k9RHcA%3D%3D",@"muid",@"0",@"start",@"1718",@"uid", nil];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [HttpTool get:CycleUrl withCompletionBlock:^(id returnValue) {
        list=[CycleMovieList yy_modelWithDictionary:returnValue];
        _imagesURLStrings =[NSMutableArray arrayWithCapacity:list.data.count];
        NSArray *array =list.data;
        for (CycleMovie* movie in array) {
            [_imagesURLStrings addObject:movie.img_url];
        }
        _cycleScrollView.imageURLStringsGroup =_imagesURLStrings;
        dispatch_group_leave(group);
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [HttpTool post:MovieListUrl parameters:_params  withCompletionBlock:^(id returnValue) {
        list3=[CycleMovieList yy_modelWithJSON:returnValue];
        
        dispatch_group_leave(group);
    } withFailureBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.collectionView reloadData];
        [self.tableView reloadData];
    });
}
//-(void)loadMoreData
//{
//    _startNum =_startNum +10;
//    NSNumber *number =[NSNumber numberWithInteger:_startNum];
//    [_params setValue:number forKey:@"start"];
//    
//    [self getTableViewData];
//}

//-(void)getTableViewData
//{
//    
//        [HttpTool post:MovieListUrl parameters:_params  withCompletionBlock:^(id returnValue) {
//            list3=[CycleMovieList yy_modelWithJSON:returnValue];
//         
//        } withFailureBlock:^(NSError *error) {
//            NSLog(@"%@",error);
//        }];
//}
//-(void)initSencondView
//{
//    _btnOne.
//    [_secondView addSubview:_btnOne];
//    [_secondView addSubview:_btnTwo];
//    [_secondView addSubview:_btnThird];
//    
//    
//}
-(void)initCycleScrollView
{
    _cycleScrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Kwidth, 150) imageURLStringsGroup:nil];
    _cycleScrollView.delegate =self;
    _cycleScrollView.autoScrollTimeInterval =5.0;
    [self.view addSubview:_cycleScrollView];
    
//    list2 =[self getSecondMovieList];
   
    [_tableView.tableHeaderView addSubview:_cycleScrollView];

}
#pragma mark -循环播放图片的点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DetailViewController *DetailView =[DetailViewController new];
    DetailView.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:DetailView animated:YES];
    CycleMovie *movie =list.data[index];
    DetailView.movieId =movie.Cycle_id;
//    DetailView.movieId =[list.data[index] Cycle_id];
    NSLog(@"%@",[list.data[index] Cycle_id]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return list3.data.count;
    }
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    NSString *str =[NSString stringWithFormat:@"这个是%ld",section];
    return str;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    testCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell ==nil) {
            cell = [[testCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }

    CycleMovie *movie =list3.data[indexPath.item];
    cell.image.yy_imageURL=[NSURL URLWithString:movie.img_url];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
   cell.likeNum.text = [numberFormatter stringFromNumber:movie.likes];
    cell.nameLabel.text =movie.name;
//    cell.likeNum.text = movie.likes;
    return cell;
    }
#pragma mark -点击对应cell进入影单详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *DetailView =[DetailViewController new];
    DetailView.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:DetailView animated:YES];
    CycleMovie *movie2 =list3.data[indexPath.item];
    DetailView.movieId =movie2.Cycle_id;
    //    DetailView.movieId =[list.data[index] Cycle_id];
    NSLog(@"%@", DetailView.movieId);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 200;
}

@end