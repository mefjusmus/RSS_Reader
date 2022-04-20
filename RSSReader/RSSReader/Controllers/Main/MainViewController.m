//
//  ViewController.m
//  RSSReader
//
//  Created by Vladislav Suslov on 3.03.22.
//

#import "MainViewController.h"
#import "RssXMLParser.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "NewsCellWithDesc.h"
#import "WebViewController.h"


@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, ShowAnnotationForCellDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) NSArray<NewsModel*> *dataSource;
@property (retain, nonatomic) id <RssParserProtocol> parser;
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation MainViewController


- (instancetype)initWithParser: (id<RssParserProtocol>) parser {
    self = [super init];
    if (self) {
        [parser retain];
        _parser = parser;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self loadDataAndParsingOnNewThread];
}


-(void)setupTableView {
    [_tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:NewsCell.identifier];
    [_tableView registerNib:[UINib nibWithNibName:@"NewsCellWithDesc" bundle:nil] forCellReuseIdentifier:NewsCellWithDesc.identifier];
}

- (void)startLoadingData {
    __weak typeof(self) weakSelf = self;
    [self.parser parseWithCompletionHandler: ^void(NSArray <NewsModel*> *array, NSError *error) {
        weakSelf.dataSource = [[[NSArray arrayWithArray: array] copy] autorelease];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf.tableView reloadData];
            [weakSelf.activityIndicator setHidesWhenStopped: YES];
        });
    }];
}

- (void) showAlertWithMessage: (NSString * ) message {
  UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Alert"
                                 message: message
                                 preferredStyle: UIAlertControllerStyleAlert];
  UIAlertAction * action = [UIAlertAction actionWithTitle: @ "Refresh"
                            style: UIAlertActionStyleDefault handler: ^ (UIAlertAction *action) {
      [self loadDataAndParsingOnNewThread];
                            }];
  [alertController addAction: action];
    dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController: alertController animated:YES completion:nil];
        });
}

- (void) loadDataAndParsingOnNewThread {
    __weak typeof(self) weakSelf = self;
    [self.activityIndicator startAnimating];
    [NSThread detachNewThreadWithBlock:^{
        [weakSelf startLoadingData];
    }];
}

- (void)dealloc {
    [_tableView release];
    _tableView = nil;
    [_dataSource release];
    _dataSource = nil;
    [_parser release];
    _parser = nil;
    
    [super dealloc];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *model = _dataSource[indexPath.row];
    if (model.isExpand) {
        NewsCellWithDesc *cellWithDesc = [tableView dequeueReusableCellWithIdentifier:NewsCellWithDesc.identifier forIndexPath:indexPath];
        [cellWithDesc setupWith:model];
        return cellWithDesc;
    } else {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCell.identifier forIndexPath:indexPath];
        [cell setDelegate:self];
        [cell setupWith: model];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WebViewController *webViewController = [[WebViewController alloc] initWithLink:_dataSource[indexPath.row].link];
    [self.navigationController pushViewController: webViewController animated:true];
}

#pragma mark - Setters
- (void)setTableView:(UITableView *)tableView {
    if (_tableView != tableView) {
        [_tableView release];
        _tableView = [tableView retain];
    }
}

- (void) sendErrorWithMessage:(NSString *)message {
    [self showAlertWithMessage: message];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate
- (void)expandNewsWith:(NewsModel *)model {
    NewsModel *expanded = [[_dataSource filteredArrayUsingPredicate:
                        [NSPredicate predicateWithFormat:@"self.isExpand == YES"]] firstObject];
    expanded.isExpand = NO;
    
    NewsModel *news = [[_dataSource filteredArrayUsingPredicate:
                        [NSPredicate predicateWithFormat:@"self.link == %@", model.link]] firstObject];
    news.isExpand = YES;
    
    NSInteger index = [_dataSource indexOfObject:model];
    NSInteger expandedIndex = [_dataSource indexOfObject:expanded];
    
    NSIndexPath *expandedIndexPath = [NSIndexPath indexPathForRow:expandedIndex inSection:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    NSArray *indexPaths = [NSArray arrayWithObjects:expandedIndexPath, indexPath, nil];
    [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
