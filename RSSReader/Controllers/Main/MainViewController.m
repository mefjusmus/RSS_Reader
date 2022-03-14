//
//  ViewController.m
//  RSSReader
//
//  Created by Vladislav Suslov on 3.03.22.
//

#import "MainViewController.h"
#import "RssParser.h"
#import "NewsModel.h"
#import "NewsCell.h"

#import <SafariServices/SafariServices.h>

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray<NewsModel*> *dataSource;

@end

@implementation MainViewController


RssParser *xmlParser = nil;
+ (void)initialize {
    if(!xmlParser)
        xmlParser = [[RssParser alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self startLoadingData];
}

-(void)setupTableView {
    [_tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:NewsCell.identifier];
}

- (void)startLoadingData {
    __weak __typeof(self) weakSelf = self;
    xmlParser.completion = ^void(NSArray <NewsModel*> *array) {
        weakSelf.dataSource = [[[NSArray arrayWithArray:array] copy] autorelease];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [weakSelf.tableView reloadData];
        });
    };
    
    [xmlParser startParsing];
}

- (void)dealloc {
    [_tableView release];
    [_dataSource release];
    [xmlParser release];
    
    [super dealloc];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCell.identifier forIndexPath:indexPath];
    NewsModel *model = _dataSource[indexPath.row];
    [cell setupWith:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    [[UIApplication sharedApplication] openURL:_dataSource[indexPath.row].link options:@{} completionHandler:nil];
    
    SFSafariViewController *controller = [[SFSafariViewController alloc] initWithURL:_dataSource[indexPath.row].link];
    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Setters
- (void)setTableView:(UITableView *)tableView {
    if (_tableView != tableView) {
        [_tableView release];
        _tableView = [tableView retain];
    }
}

@end
