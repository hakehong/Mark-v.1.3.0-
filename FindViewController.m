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
#import "SecondCell.h"
#import "AFHTTPSessionManager.h"
#import "testCell.h"
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
@property (nonatomic , strong) UICollectionView *collectionView;
@property(nonatomic,strong )SDCycleScrollView *cycleScrollView;
@property(nonatomic,copy)NSMutableArray *imagesURLStrings;
@property(nonatomic,copy)NSMutableArray *imagesURLStrings2;
@end

@implementation FindViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary *params =  [NSDictionary dictionaryWithObjectsAndKeys:@"10",@"count",@"HU0QIAGVzI0xIDq6k9RHcA%3D%3D",@"muid",@"0",@"start",@"1718",@"uid", nil];
    
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
    [HttpTool get:SecondUrl withCompletionBlock:^(id returnValue) {
      list2 =[CycleMovieList yy_modelWithDictionary:returnValue];
        dispatch_group_leave(group);
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_group_leave(group);
    }];

    dispatch_group_enter(group);
    [HttpTool post:MovieListUrl parameters:params  withCompletionBlock:^(id returnValue) {
        list3=[CycleMovieList yy_modelWithJSON:returnValue];
      
     dispatch_group_leave(group);
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
   
        
       [self.collectionView reloadData];
        [self.tableView reloadData];
    });
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Kwidth,Kheight)];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, 250)];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    [self initCycleScrollView];
    [self initCollectionView];
    
}
-(void)initCycleScrollView
{
    _cycleScrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Kwidth, 150) imageURLStringsGroup:nil];
    _cycleScrollView.delegate =self;
    _cycleScrollView.autoScrollTimeInterval =5.0;
    [self.view addSubview:_cycleScrollView];
    
//    list2 =[self getSecondMovieList];
   
    [_tableView.tableHeaderView addSubview:_cycleScrollView];

}
-(void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //   设置每个item的大小，依据大小可以改成几种样式，无限循播，横向流
    flowLayout.itemSize = CGSizeMake((Kwidth -spaceing*6)/4, 80);
//   flowLayout.itemSize = CGSizeMake(60, 80);

    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing =10;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 160, Kwidth, 80) collectionViewLayout:flowLayout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
//    collectionView.bounces =NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView=collectionView;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_tableView.tableHeaderView addSubview:self.collectionView];
    
    [self.collectionView registerClass:[SecondCell class] forCellWithReuseIdentifier:CellID1];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID1 forIndexPath:indexPath];
    if(!cell){
        cell = [[SecondCell alloc] init];
    }
//    [cell setSecondMovieList:list2];
    CycleMovie *movie =list2.data[indexPath.item];
    cell.image.yy_imageURL =[NSURL URLWithString:movie.img_url];
    return cell;
}

//-(CycleMovieList *)getSecondMovieList
//{
//    NSURL *url =[NSURL URLWithString:@"http://114.215.104.21/v130/singles/cat?"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url ];
//    
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
//    CycleMovieList *movieList =[CycleMovieList yy_modelWithDictionary:resultDict];
//    return movieList;
//}
#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (list3.data.count)/2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
    }
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    NSString *str =[NSString stringWithFormat:@"这个是%ld",section];
    return str;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    testCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell ==nil) {
            cell = (testCell *)[[[NSBundle mainBundle] loadNibNamed:@"testCell" owner:self options:nil] lastObject];
        }
    CycleMovie *movie =list3.data[indexPath.row];
        cell.image.yy_imageURL=[NSURL URLWithString:movie.img_url];
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    cell.likeNum.text = [numberFormatter stringFromNumber:movie.likes];
    cell.nameLabel.text =movie.name;
//    cell.likeNum.text = movie.likes;
    return cell;
    }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 200;
}

@end