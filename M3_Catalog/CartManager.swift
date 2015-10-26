//
//  CatalogDataManager.swift
//  M3_Catalog
//
//  Created by sdt5 on 2015. 10. 26..
//  Copyright © 2015년 TAcademyBola. All rights reserved.
//

import UIKit

//카트뷰컨트롤러의 MODEL님
//여기에 카트뷰컨트롤러에 필요한 데이터가 들어간다.
//하나만 존재해야 하므로 당연히 싱글턴이다.
class CartManager: NSObject {
    
    //카트에 들어갈 데이터
    var userCart : [(String, Int)] = []
    
    
    //싱글턴구현
    static let sharedManager = CartManager()
    
    override init() {
        
    }
    
    

    //카트 내 데이터의 개수를 반환한다.
    func count() ->(Int)
    {
        return userCart.count
    }
    
    
    
    func addItem (itemName itemName : String)
    {
        
        //이 방법으로 하면 배열의 요소에 직접 접근할 수 없다. item은 개별적으로 복사된 복사본이므로, 전혀 변화하지 않는다.
        
        /*  for var item in userCart
        {
        if item.0 == itemName
        {
        item.1++
        }
        
        }
        */
        
        //같은 이름의 아이템이 있는지 검사해 있으면 수량만 늘려준다.
        // index를 반복자를 통해 받아와서, 직접 userCart[index]에 접근해 바꾸어 줘야 한다.
        for (index , value) in userCart.enumerate()
        {
            if value.0 == itemName
            {
                userCart[index].1 = userCart[index].1 + 1
                return
            }
        }
        
        //만약 같은 이름의 아이템이 없으면 새로 추가해 준다.
        //배열의 맨 앞에 추가하게 Index를 0으로
        userCart.insert((itemName, 1), atIndex: 0)
        
        NSNotificationCenter.defaultCenter().postNotificationName("ModelChangeNotification", object: nil)
        
    }
    
    func removeItem(itemName  itemName : String)
    {
     
        for (index , value) in userCart.enumerate()
        {
            if value.0 == itemName
            {
                userCart[index].1 = userCart[index].1 - 1
                
                if userCart[index].1 <= 0
                {
                    userCart.removeAtIndex(index)
                }
                
            }
        }
        
    NSNotificationCenter.defaultCenter().postNotificationName("ModelChangeNotification", object: nil)
    }
    
    
}
