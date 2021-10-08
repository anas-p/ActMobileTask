//
//  ViewController.m
//  ActMobileTask
//
//  Created by Anas P on 07/10/21.
//

#import "ProductViewController.h"
#import "ActMobileTask-Swift.h"

@interface ProductViewController ()


@end

@implementation ProductViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self readInputFromFile];
}


/// Initializing UIs
- (void) initUI {
    self.lblCountryWithSales.text = @"";
    self.tableViewHC.constant = 0;
    self.btnSelectProduct.backgroundColor = UIColor.systemBlueColor;
    self.btnTopCountry.backgroundColor = UIColor.systemBlueColor;
    self.productListTableView.layer.borderWidth = 1;
    self.productListTableView.layer.cornerRadius = 10;
    self.productListTableView.layer.borderColor = UIColor.systemBlueColor.CGColor;
}

#pragma mark - Tableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell" forIndexPath:indexPath];
    NSString *prodName = self.items[indexPath.row][@"prod"];
    cell.textLabel.text = prodName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

#pragma mark - Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *prodName = self.items[indexPath.row][@"prod"];
    self.lblCountryWithSales.text = @"";
    [self.btnSelectProduct setTitle: prodName forState: UIControlStateNormal];
    [self handleDropdown];
}

#pragma mark - Actions
- (IBAction)btnProductOnClick:(UIButton *)sender {
    [self handleDropdown];
}

- (IBAction)btnTopCountryOnClick:(UIButton *)sender {
    if ([self.btnSelectProduct.titleLabel.text  isEqual: @"Select Product"]) {
        [self showSelectProductAlert];
    }
    else {
        ProductViewModel *viewModel = [ProductViewModel alloc];
        NSString *countryWithTotal = [viewModel findCountryWithMaxTotalWithProductDict:self.items selectedProduct:self.btnSelectProduct.titleLabel.text];
        self.lblCountryWithSales.text = countryWithTotal;
        
//        NSPredicate *prodPredicate = [NSPredicate predicateWithFormat:@"SELF.prod LIKE[c] %@", self.btnSelectProduct.titleLabel.text];
//        NSArray *filteredArray = [self.items filteredArrayUsingPredicate:prodPredicate];
//        NSLog(@"%@", filteredArray);
    }
}

#pragma mark - Helper methods

/// To open or close dropdown menu
- (void) handleDropdown {
    if (self.tableViewHC.constant == 320) {
        self.tableViewHC.constant = 0;
    }
    else {
        self.tableViewHC.constant = 320;
    }
    [UIView animateWithDuration:0.35f animations:^{
        [self.view layoutIfNeeded];
    }];
}

/// Read inputs from JSON
- (void) readInputFromFile {
    NSString *path = [[NSBundle mainBundle] pathForResource: @"input_ios" ofType: @"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    self.productList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *sales = self.productList[@"sales"];
    self.items = [[NSMutableArray alloc] init];

    for (NSDictionary* currentItem in sales) {
        [self.items addObject:currentItem];
    }

    if ([self.items count] > 0) {
        self.productListTableView.dataSource = self;
        self.productListTableView.delegate = self;
    }
}

/// Show alert if not selected any products
- (void) showSelectProductAlert {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message: @"Please select a product" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle: @ "OK"
                                                      style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
        NSLog(@"Dismiss Tapped");
    }];
    [alertVC addAction: action];
    [self presentViewController:alertVC animated: YES completion:nil];
}

@end

