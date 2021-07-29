//
//  ViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/27.
//
#define APP_SCREEN_WIDTH                    [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT                   [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "ContentModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *tbView;
@property (nonatomic, strong) ContentModel *contentModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tbView];
    // Do any additional setup after loading the view.
}

#pragma mark - delegate & dataSource;

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 40)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = [self.contentModel.headNameArray objectAtIndex:section];
    return label;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.contentModel.demoArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.contentModel.demoArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *type = self.contentModel.demoArray[indexPath.section][indexPath.row];
    cell.textLabel.text = type;
    cell.detailTextLabel.text = [self.contentModel.describeDict objectForKey:type];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *type = self.contentModel.demoArray[indexPath.section][indexPath.row];
    if ([self respondsToSelector:NSSelectorFromString(type)]) {
        ( (void (*) (id, SEL)) objc_msgSend ) (self, NSSelectorFromString(type));
    }

}
- (UITableView *)tbView{
    
    if (_tbView == nil) {
        //        CGRect tbRect = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - HEADER_HEIGHT);
        _tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];;
        _tbView.delegate =  self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [[UIView alloc] init];
    }
    return _tbView;
}
- (ContentModel *)contentModel {
    
    if (_contentModel == nil) {
        _contentModel = [[ContentModel alloc] init];
    }
    return _contentModel;
    
}
//信号量
- (void)dispatch_semaphore{
    YYSafeDictViewController * m = [YYSafeDictViewController new];
    [self.navigationController pushViewController:m animated:YES];
}

//栅栏函数

-(void)dispatch_barrier{
    AFBarrierViewController * m = [AFBarrierViewController new];
    [self.navigationController pushViewController:m animated:YES];
}

-(void)synchronized{
    SynchronizedViewController * m = [SynchronizedViewController new];
    [self.navigationController pushViewController:m animated:YES];
}

-(void)Threaded_Programming{
    AppleThreadGuideViewController * m = [AppleThreadGuideViewController new];
    [self.navigationController pushViewController:m animated:YES];
}
-(void)NSOperation_Demo{
    
    
    WPOperationViewController * m = [WPOperationViewController new];
    [self.navigationController pushViewController:m animated:YES];
}

-(void)GCD_Demo{
    
    WPGCDViewController * m = [WPGCDViewController new];
    [self.navigationController pushViewController:m animated:YES];
    
}

-(void)dispatch_group_demo{
    WPDispathGroupViewController * m = [WPDispathGroupViewController new];
    [self.navigationController pushViewController:m animated:YES];
}
@end
