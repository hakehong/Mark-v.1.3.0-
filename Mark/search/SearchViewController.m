//
//  ViewController.m
//  Mark
//
//  Created by hongqing on 16/3/5.
//  Copyright © 2016年 hongqing. All rights reserved.
//



#import "SearchViewController.h"
#import "MovieListViewController.h"
#import "HttpTool.h"
#import "seachMovieList.h"
#import "searchMovie.h"
#import "NSObject+YYModel.h"
#import "YYWebImage.h"
#import "searchCell.h"
#import "imageAll.h"
static NSString *const searchUrl =@"https://api.douban.com//v2/movie/search?q=";
static NSString *const CellID =@"searchCell";
@interface SearchViewController ()<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) seachMovieList *list;
@property (nonatomic , strong) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *centerView;

@property (weak, nonatomic) IBOutlet UITextField *searchTF;

- (IBAction)dismissSearch:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

//- (IBAction)movieListBtn:(UIButton *)sender;

@property(nonatomic,strong)UILabel *label;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchTF.delegate =self;
    self.navigationItem.hidesBackButton =YES;
//    self.hidesBottomBarWhenPushed = YES;
     [_searchTF addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.collectionView reloadData];
//    });
    [self.collectionView reloadData];
    [self setSearchView];
    
}
-(void)setSearchView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((Kwidth -40)/3, (Kwidth -40)/3);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;//设置每个item之间的间距
//  搜索框的高度为40
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, Kwidth, Kheight-120) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView=collectionView;
    
//    [self.collectionView registerClass:[searchCell class] forCellWithReuseIdentifier:CellID];
     [self.collectionView registerNib:[UINib nibWithNibName:@"searchCell" bundle:nil] forCellWithReuseIdentifier:CellID];

    
}
//- (IBAction)movieListBtn:(UIButton *)sender {
//    MovieListViewController *movieList =[[MovieListViewController alloc]init];
//    [self.navigationController pushViewController:movieList animated:YES];
//}
- (void)textFieldEditChanged:(UITextField *)textField

{
    
    NSLog(@"textfield text %@",textField.text);
    if (textField.text.length != 0 ) {
        
        [self.centerView removeFromSuperview];
        [self.view addSubview:_collectionView];
//        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
//        
//        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//            [self getSearchMovieList:textField.text];
//        });
         [self getSearchMovieList:textField.text];
    }
   
}
-(void)getSearchMovieList:(NSString *)searchText
{
    NSString *url =[searchUrl stringByAppendingString:searchText];
    [HttpTool get:url withCompletionBlock:^(id returnValue) {
         _list =[seachMovieList yy_modelWithDictionary:returnValue];
//        CompletionBlock(_movieList);
        
    } withFailureBlock:^(NSError *error) {
        nil;
    }];
  
    
}
- (IBAction)dismissSearch:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_searchTF resignFirstResponder];
    return YES;
}
//-(seachMovieList *)setMovieList
//{
//    if (_movieList ==nil) {
//        _movieList =[seachMovieList new];
//    }
//    return _movieList;
//}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    searchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    if(!cell){
        cell = [[searchCell alloc] init];
    }
//    cell.movieImage.yy_imageURL =[NSURL URLWithString:_list.subjects]
//    cell.movieName.text =@"111";
    searchMovie *movie =_list.subjects[indexPath.item];
   
    cell.movieImage.yy_imageURL =[NSURL URLWithString:movie.images.small];
   
    cell.movieName.text =movie.title;
//    cell.movieName.text =@"11111";
    return cell;
}


//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    _searchTF =textField;
//    [self getSearchMovieList:_searchTF];
//    return  YES;
//}
//-(BOOL)textFieldShouldClear:(UITextField *)textField
//{
//    return YES;
//}
- (IBAction)PopView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
