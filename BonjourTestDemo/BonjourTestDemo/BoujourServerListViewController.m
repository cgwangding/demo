//
//  BoujourServerListViewController.m
//  BonjourTestDemo
//
//  Created by AD-iOS on 16/2/23.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "BoujourServerListViewController.h"

@interface BoujourServerListViewController ()<NSNetServiceBrowserDelegate, UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *localNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *serverListTableView;

@property (strong, nonatomic) NSMutableArray *services;
@property (strong, nonatomic) NSNetServiceBrowser *browser;

@end

@implementation BoujourServerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addObserver:self forKeyPath:@"localService" options:0 context:&self->_localService];
    [self setupLocalServiceNameLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLocalServiceNameLabel
{
    if (self.localService == nil) {
        self.localNameLabel.text = @"注册中……";
    }else{
        self.localNameLabel.text = [NSString stringWithFormat:@"本机服务名称：%@",self.localService.name];
    }
}

#pragma mark - tableview data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.services.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSNetService * service = nil;
    service = [self.services objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [service.name stringByAppendingFormat:@"---%@",service.hostName];
    return cell;
}

#pragma mark - browser view callbacks

//排序
- (void)sortAndReloadTable
{
    [self.services sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[obj1 name] localizedCaseInsensitiveCompare:[obj2 name]];
    }];
    
    if (self.isViewLoaded) {
        [self.serverListTableView reloadData];
    }
}

#pragma mark -NSNetServiceBrowserDelegate 对等网络发现代理

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing
{
    if ((self.localService == nil) || ![self.localService isEqual:service]) {
        [self.services removeObject:service];
    }
    
    if (!moreComing) {
        [self sortAndReloadTable];
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing
{
    if ((self.localService == nil) || ![self.localService isEqual:service]) {
        [self.services addObject:service];
    }
    
    if (!moreComing) {
        [self sortAndReloadTable];
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary *)errorDict
{
 
    NSLog(@"error >>>> %@",errorDict);
    // The usual reason for us not searching is a programming error.
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == &self->_localService) {
        if (self.localNameLabel != nil) {
            [self setupLocalServiceNameLabel];
        }
        
        if (self.browser != nil) {
            [self stopSearchServices];
            [self startSearchServices];
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context ];
    }
}

#pragma mark - public method

- (void)startSearchServices
{
    [self.browser searchForServicesOfType:self.type inDomain:@"local"];
}

- (void)stopSearchServices
{
    [self.browser stop];
    [self.services removeAllObjects];
    if (self.isViewLoaded) {
        [self.serverListTableView reloadData];
    }
}

#pragma mark - dealloc

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"localService" context:&self->_localService];
}

#pragma mark - getter

- (NSMutableArray *)services
{
    if (_services == nil) {
        _services = [NSMutableArray array];
    }
    return _services;
}

- (NSNetServiceBrowser *)browser
{
    if (_browser == nil) {
        _browser = [[NSNetServiceBrowser alloc]init];
        _browser.includesPeerToPeer = YES;
        _browser.delegate = self;
    }
    return _browser;
}

@end
