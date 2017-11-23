//
//  ZYTestViewController.m
//  ZY_FoldingTableViewDemo
//
//  Created by 中商国际 on 2017/11/22.
//  Copyright © 2017年 中商国际. All rights reserved.
//

#import "ZYTestViewController.h"
#import "ChineseString.h"
#import "pinyin.h"

@interface ZYTestViewController () <ZYFoldingTableViewDelegate>

@property (nonatomic, weak) ZYFoldingTableView *foldingTableView;
@property(nonatomic,strong) NSArray * stringsToSort;
@property (nonatomic, strong) NSMutableArray * dataArr;


@end

@implementation ZYTestViewController
-(NSArray*)stringsToSort{
    
    if(!_stringsToSort){
        
        _stringsToSort=@[
                         @{@"title":@"北京",@"id":@"110000"},
                         @{@"title":@"天津",@"id":@"120000"},
                         @{@"title":@"河北省",@"id":@"130000"},
                         @{@"title":@"山西省",@"id":@"140000"},
                         @{@"title":@"内蒙古自治区",@"id":@"150000"},
                         @{@"title":@"辽宁省",@"id":@"210000"},
                         @{@"title":@"吉林省",@"id":@"220000"},
                         @{@"title":@"黑龙江省",@"id":@"230000"},
                         @{@"title":@"上海",@"id":@"310000"},
                         @{@"title":@"江苏省",@"id":@"320000"},
                         @{@"title":@"浙江省",@"id":@"330000"},
                         @{@"title":@"安徽省",@"id":@"340000"},
                         @{@"title":@"福建省",@"id":@"350000"},
                         @{@"title":@"江西省",@"id":@"360000"},
                         @{@"title":@"山东省",@"id":@"370000"},
                         @{@"title":@"河南省",@"id":@"410000"},
                         @{@"title":@"湖北省",@"id":@"420000"},
                         @{@"title":@"湖南省",@"id":@"430000"},
                         @{@"title":@"广东省",@"id":@"440000"}
                        
                         ];
    }
    
    return _stringsToSort;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建tableView
    [self setupFoldingTableView];
    //[self.foldingTableView reloadData];
    [self beginPaixu];
}

// 创建tableView
- (void)setupFoldingTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZYFoldingTableView *foldingTableView = [[ZYFoldingTableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    _foldingTableView = foldingTableView;
    
    [self.view addSubview:foldingTableView];
    foldingTableView.foldingDelegate = self;
    
    if (self.arrowPosition) {
        foldingTableView.foldingState = ZYFoldingSectionStateShow;
    }
}

#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）
// 返回箭头的位置
- (ZYFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(ZYFoldingTableView *)zyTableView
{
    // 没有赋值，默认箭头在左
    return self.arrowPosition ? :ZYFoldingSectionHeaderArrowPositionRight;
}
- (NSInteger )numberOfSectionForYUFoldingTableView:(ZYFoldingTableView *)zyTableView
{
    return self.dataArr.count;
}
- (NSInteger )zyFoldingTableView:(ZYFoldingTableView *)zyTableView numberOfRowsInSection:(NSInteger )section
{
    NSArray * ar = [self.dataArr[section] objectForKey:@"titleArr"];
    return ar.count;
}
- (CGFloat )zyFoldingTableView:(ZYFoldingTableView *)zyTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )zyFoldingTableView:(ZYFoldingTableView *)zyTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSString *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%@",[self.dataArr[section] objectForKey:@"firstname"]];
}
- (UITableViewCell *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [zyTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.dataArr[indexPath.section] objectForKey:@"titleArr"][indexPath.row] objectForKey:@"title"]];
    
    return cell;
}
- (void )zyFoldingTableView:(ZYFoldingTableView *)zyTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [zyTableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了== %@ ID == %@",[NSString stringWithFormat:@"%@",[[self.dataArr[indexPath.section] objectForKey:@"titleArr"][indexPath.row] objectForKey:@"title"]],[NSString stringWithFormat:@"%@",[[self.dataArr[indexPath.section] objectForKey:@"titleArr"][indexPath.row] objectForKey:@"id"]]);
}

#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）

- (NSString *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"";
}
- (UIColor *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView backgroundColorForHeaderInSection:(NSInteger)section{
    //return [UIColor purpleColor];
    return [UIColor colorWithRed:102/255.f green:102/255.f blue:255/255.f alpha:1.f];
    
}
- (void)beginPaixu{
    
    NSMutableArray *letterResult = [NSMutableArray array];
    
    for(int i =0; i<self.stringsToSort.count; i++){
        ChineseString*chineseString = [ [ChineseString alloc] init];
        chineseString.string=[self.stringsToSort[i] objectForKey:@"title"];
        chineseString.ID = [self.stringsToSort[i] objectForKey:@"id"];
        if(chineseString.string==nil){
            chineseString.string=@"";
            chineseString.ID = @"";
        }
        NSString *pinYinResult = [NSString string];
        if( ! [chineseString.string isEqualToString: @""]){
            for(int j =0; j<chineseString.string.length; j++){
                NSString*singlePinYinLetter = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])] uppercaseString];
                pinYinResult = [pinYinResult stringByAppendingString: singlePinYinLetter];
            }
            chineseString.pinYin = [pinYinResult substringToIndex:1] ;
            
        }else{
            chineseString.pinYin=@"";
            
        }
        
        [letterResult addObject:chineseString];
        
    }
    
    NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES];
    NSArray *descriptorArray = [NSArray arrayWithObjects: descriptor,nil];
    NSArray *descriptorResult = [letterResult sortedArrayUsingDescriptors : descriptorArray];
    for(int i =0; i<descriptorResult.count; i++){
        NSMutableDictionary * dic = [NSMutableDictionary new];
        ChineseString *result = descriptorResult[i];
        [dic setValue:result.string forKey:@"title"];
        [dic setValue:result.ID forKey:@"id"];
        [dic setValue:result.pinYin forKey:@"First"];
        [self.dataArr addObject:dic];
        
    }
    
    
    NSMutableDictionary *sortDic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSDictionary *dic in self.dataArr) {
        NSString *imageTime = dic[@"First"];
        NSMutableArray *groupArr = sortDic[imageTime];
        if (!groupArr) {
            groupArr = [NSMutableArray arrayWithCapacity:0];
            [sortDic setObject:groupArr forKey:imageTime];
        }
        [groupArr addObject:dic];
    }
    
    NSMutableArray * mut = [NSMutableArray new];
    for (NSString *key in sortDic) {
        NSArray * sortarr = sortDic[key];
        NSDictionary * setDic = @{
                                  @"firstname":key,
                                  @"titleArr":sortarr
                                  };
        [mut addObject:setDic];
    }
    
    
    for (int i = 0; i<mut.count; i++) {
        for (int j = i+1; j<mut.count; j++) {
            NSString * firstName = [mut[i] objectForKey:@"firstname"];
            NSString * secondName = [mut[j] objectForKey:@"firstname"];
            if ([firstName localizedCompare:secondName] == 1) {
                [mut exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:mut];
    NSLog(@"最后输出==%@",self.dataArr);
    [self.foldingTableView reloadData];
}

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
@end
