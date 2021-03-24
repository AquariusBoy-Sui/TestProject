//
//  ChooseCountryIDTableViewController.m
//  CatPregnent2
//
//  Created by MrSui on 2020/4/28.
//  Copyright © 2020 Binky Lee. All rights reserved.
//
#define LanguageIsEnglish ([CURR_LANG isEqualToString:@"en-US"] || [CURR_LANG isEqualToString:@"en-CA"] || [CURR_LANG isEqualToString:@"en-GB"] || [CURR_LANG isEqualToString:@"en-CN"] || [CURR_LANG isEqualToString:@"en"])
#import "ChooseCountryIDTableViewController.h"

@interface ChooseCountryIDTableViewController (){
    NSDictionary *sortedNameDict; //代码字典
    
    //首字母
    NSArray *indexArray;
    NSMutableArray *searchResultValuesArray;
    
    //当前选择的国家及区号字符
    NSString *currentCountryCodeStr;
}

@end

@implementation ChooseCountryIDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"menu_button_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(closeButtonClick)];
    

    self.navigationItem.title=@"选择国家和代码";
    
    
    

    
    //判断当前系统语言
//    if (LanguageIsEnglish) {
//        sortedNameDict = [NSDictionary dictionaryWithContentsOfFile:plistPathEN];
//    }else{
//        sortedNameDict = [NSDictionary dictionaryWithContentsOfFile:plistPathCH];
//    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DefaultCountry" ofType:@"plist"];
    sortedNameDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    indexArray = [sortedNameDict allKeys];
    indexArray = [indexArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
}
-(void)closeButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
   return indexArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [sortedNameDict allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *array = [sortedNameDict objectForKey:[indexArray objectAtIndex:section]];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSString *str = [[sortedNameDict objectForKey:[indexArray objectAtIndex:section]] objectAtIndex:row];
    [cell.textLabel setText:[self getCountryNameWith:str]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    
    [cell.detailTextLabel setText:[self getCountryCodeWith:str]];
    [cell.detailTextLabel setTextColor:[UIColor darkGrayColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.deleagete && [self.deleagete respondsToSelector:@selector(returnCountryCode:)]) {
        [self.deleagete returnCountryCode:cell.detailTextLabel.text];
    }
    [self closeButtonClick];
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 30;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [indexArray objectAtIndex:section];
}
#pragma mark - 截取字符串
//截取国家名称
-(NSString *)getCountryNameWith:(NSString *)str{
    NSRange plus = [str rangeOfString:@"+"];
    return [str substringToIndex:plus.location];
}
//截取国家代码
-(NSString *)getCountryCodeWith:(NSString *)str{
    NSRange plus = [str rangeOfString:@"+"];
    return [str substringFromIndex:plus.location];
}
//拼合
-(NSString *)getResultCodeWith:(NSString *)countryName and:(NSString *)code{
    return [NSString stringWithFormat:@"%@%@",countryName,code];
}
@end
