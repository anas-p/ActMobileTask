//
//  ViewModel.swift
//  ActMobileTask
//
//  Created by Anas P on 08/10/21.
//

import Foundation

struct EachProduct {
    var name: String
    var country: String
    var price: Float
    
    internal init(name: String, country: String, price: Float) {
        self.name = name
        self.country = country
        self.price = price
    }
}

@objc class ProductViewModel: NSObject {
    
    var productList = [EachProduct]()
    
    @objc func findCountryWithMaxTotal(productDict: [NSDictionary], selectedProduct: String) -> String {
        self.productList = [EachProduct]()
        productDict.forEach { each in
            let eachProduct = EachProduct(name: each["prod"] as! String, country: each["country"] as! String, price: each["price"] as! Float)
            self.productList.append(eachProduct)
        }
        
        // Filtering selected product from the whole list
        let selectedProductItems = self.productList.filter({ $0.name.lowercased() == selectedProduct.lowercased() })
        
        /// Generating array with country and total
        var totalArray = [(String, Float)]()
        selectedProductItems.forEach { eachProduct in
            if let index = totalArray.firstIndex(where: { $0.0 == eachProduct.country }) {
                totalArray[index].1 += eachProduct.price
            }
            else {
                totalArray.append((eachProduct.country, eachProduct.price))
            }
        }
        
        // Array with all totals
        let allTotals = totalArray.compactMap({ $0.1 })
        // Countries with maximum total sales
        let maxOfTotalCountries = totalArray.filter({ $0.1 == allTotals.max() })
        var countryWithTotal = String()
        maxOfTotalCountries.forEach { each in
            countryWithTotal = "\(each.0): \(each.1)\n"
        }
        return countryWithTotal
    }
    
    
}

