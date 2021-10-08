//
//  ViewController.h
//  ActMobileTask
//
//  Created by Anas P on 07/10/21.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnSelectProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblCountryWithSales;
@property (weak, nonatomic) IBOutlet UITableView *productListTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnTopCountry;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHC;

@property (strong, nonatomic) NSMutableDictionary *productList;
@property (strong, nonatomic) NSMutableArray<NSDictionary*> *items;



@end


