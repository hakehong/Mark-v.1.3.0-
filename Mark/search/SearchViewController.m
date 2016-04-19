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
static NSString *const searchUrl =@"https://api.douban.com//v2/movie/search?q=";
static NSString *const CellID =@"searchCell";
@interface SearchViewController ()<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) seachMovieList *movieList;
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
    
     [_searchTF addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self setSearchView];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.collectionView reloadData];
//    }); 

    
}
-(void)setSearchView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(Kwidth/3-10, Kwidth/3);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;//设置每个item之间的间距
//  搜索框的高度为40
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, Kwidth, Kheight-120) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView=collectionView;
    
    [self.collectionView registerClass:[searchCell class] forCellWithReuseIdentifier:CellID];

    
}
//- (IBAction)movieListBtn:(UIButton *)sender {
//    MovieListViewController *movieList =[[MovieListViewController alloc]init];
//    [self.navigationController pushViewController:movieList animated:YES];
//}
- (void)textFieldEditChanged:(UITextField *)textField

{
    
    NSLog(@"textfield text %@",textField.text);
    if (textField.text.length != 0 ) {
        [self getSearchMovieList:textField.text];
        [self.centerView removeFromSuperview];
        [self.view addSubview:_collectionView];
    }
   
}
-(seachMovieList *)getSearchMovieList:(NSString *)searchText
{
    NSString *url =[searchUrl stringByAppendingString:searchText];
    [HttpTool get:url withCompletionBlock:^(id returnValue) {
        _movieList =[seachMovieList yy_modelWithDictionary:returnValue];
//        CompletionBlock(_movieList);
        
    } withFailureBlock:^(NSError *error) {
        nil;
    }];
    return _movieList;
}
- (IBAction)dismissSearch:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return YES;
}
-(seachMovieList *)setMovieList
{
    if (_movieList ==nil) {
        _movieList =[seachMovieList new];
    }
    return _movieList;
}
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
    cell.movieImage.image =[UIImage imageNamed:@"guidePageBackImage"];
    cell.movieName.text =@"111";
//    searchMovie *movie =_movieList.subjects[indexPath.item];
//    [cell setImage:movie.imageAll[0] content:movie.title];
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
@end
