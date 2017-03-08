//
//  FeedViewController.m
//  InstFeedReader
//
//  Created by Gennadii on 3/5/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedMapper.h"
#import "Post.h"
#import "UIViewController+Alert.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "ImageLoader.h"
#import "FeedTableViewCell.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) FeedMapper *feedMapper;
@property (strong, nonatomic) ImageLoader *imageLoader;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray<Post *> *posts; // should not be used as datasource
@property (strong, nonatomic) NSArray<Post *> *filteredPosts;

@end

@implementation FeedViewController

static NSString *const cellIdentifier = @"postCell";

#pragma mark - getters & setters

-(FeedMapper *)feedMapper {
    if (!_feedMapper) {
        _feedMapper = [[FeedMapper alloc]init];
    }
    return _feedMapper;
}

-(ImageLoader *)imageLoader {
    if (!_imageLoader) {
        _imageLoader = [[ImageLoader alloc] init];
    }
    return _imageLoader;
}

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    self.searchBar.returnKeyType = UIReturnKeyDone;
    self.searchBar.delegate = self;
    
    // Remove the cell separators
    self.tableView.tableFooterView = [UIView new];
    
    // set custom load behaviour
    SDWebImageManager.sharedManager.delegate = self.imageLoader;
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    __weak typeof(self) weakSelf = self;
    [self.feedMapper fetchFeedWithSuccessBlock:^(NSArray *feed) {
        weakSelf.posts = feed;
        weakSelf.filteredPosts = feed;
        [weakSelf.tableView reloadData];
    } failureBlock:^(NSError *error) {
        [weakSelf showErrorPopup:error.description];
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredPosts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Post *post = self.filteredPosts[indexPath.row];
    
    cell.titleLabel.text = post.title;
    cell.authorLabel.text = post.author;
    [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:post.imageURL]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        self.filteredPosts = self.posts;
    } else {
        self.filteredPosts = [self.posts filteredArrayUsingPredicate:
                              [self predicateForSearchString:searchText]];
    }
    
    [self.tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}

#pragma mark - DZNEmptyDataSetDelegate & DZNEmptyDataSetDataSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"There is no records to display";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - Private methods

-(NSPredicate *)predicateForSearchString:(NSString *)string {
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@", string];
    NSPredicate *authorPredicate = [NSPredicate predicateWithFormat:@"author CONTAINS[c] %@", string];
    NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[titlePredicate,authorPredicate]];
    return compoundPredicate;
}

@end
