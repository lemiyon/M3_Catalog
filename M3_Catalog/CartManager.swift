//
//  CatalogDataManager.swift
//  M3_Catalog
//
//  Created by sdt5 on 2015. 10. 26..
//  Copyright © 2015년 TAcademyBola. All rights reserved.
//
/*
웹 디비의 서버 통신을 구현하낟.
 카트에 추가한다.
 카트 목록 보기를 전적으로 온라인 통신에 의존한다. (렘 디비 관련 모두 주석)
*/

import UIKit
//import RealmSwift
import Alamofire
import SwiftyJSON
//카트뷰컨트롤러의 MODEL님
//여기에 카트뷰컨트롤러에 필요한 데이터가 들어간다.
//하나만 존재해야 하므로 당연히 싱글턴이다.
class CartManager: NSObject {
    
    //카트에 들어갈 데이터.
    //dynamic var userCart : [CartData] = []
    var userCart = [CartData]()
    
    //Parse.com의 디비와 통신하기 위한 헤더값들
    let headers = ["X-Parse-Application-Id":"wTDkJZLkXqAalEB3Ma1GMBVv2BpcS9CKhSd6Od5x", "X-Parse-REST-API-Key":"lpG0HGORC0hDGIIRKXSFde3kFKHnfBmVfm0HyMgn"
    ]
    let serverURL = "https://api.parse.com/1/classes/Cart"
    
    //싱글턴구현
    static let sharedManager = CartManager()
    
    override init() {
        super.init()
        //아이템을 원격에서 가져온다.
        getItemFromServer()
    }
    
    
    
    //DB의 모든 아이템을 지운다.
    func clearDB()
    {
        
    }
    
    //아이템을 서버에서 가져온다.
    func getItemFromServer()
    {
        //HTTP 요청을 전송해 서버에서 정보를 가져온다.
        sendGetRequest()
        //받아왔다고 어떻게 알려줄까??? 델리게이트 방법이 가장 낫다. 노티피케이션도 있긴 하지만 SwiftyJSON과 함께 쓰기가 어렵다.
    }
    
    func sendGetRequest() {
        
        // My API (GET https://api.parse.com/1/classes/Cart)
        // Fetch Request
        
        
        
        //headers에 딕셔너리 형태로 헤더값을 넣어주면 HTTP헤더에 설정
        Alamofire.request(.GET, serverURL, headers: headers).validate(statusCode: 200..<300).responseJSON {
                response in
                // result of response serialization
            
            
                if let resultJSON = response.result.value {
                    print("JSON: \(resultJSON)")
           
                    self.userCart.removeAll()
                    
                    //Alamofire의 리턴 코드 -999??? 이게 뭐야ㅋㅋㅋ
                    //처리 취소가 됬다는 의미. Alamofire의 manager가 not owned, 즉 로컬 변수면 콜백이 늦게 와 취소 될 수 있다.
                    //그러니 스트롱 프로퍼티 혹은 싱글턴으로 만들어주는 것이 좋다.
                    
                    resultJSON["user"]
                    
                //JSON이 왔으니 SwiftyJSON이 활약할 차례
                
                    
                    //AnyObject으로 온 결과를 JSON로 바꾸어준다.
         
                    //통신이 끝난 뒤 강제로 리로드 한다.
                  }
    
    }
    }
    
    func deleteItem(index : Int)
    {
        let item_Save = userCart[index]
        
        //JSON몸뚱아리의 Integer는 객체가 아니므로, NSNumber(integer: )로 해줘야 한다. 근데 난 왜 되지?
        //배성필 님(photofarm) 기트 참고!
        let param_JSON = ["name" : item_Save.name, "count" : item_Save.count];

        
        Alamofire.request(.DELETE, serverURL, parameters:  param_JSON as! [String : AnyObject], encoding: Alamofire.ParameterEncoding.JSON, headers: headers).validate(statusCode: 200..<300).responseJSON { (response) -> Void in
            print(response)
        }
    }
    
    //DB에 아이템들을 저장한다.
    func saveItem(index : Int)
    {


        //한번에 하나의 객체만을 보냄. 지금은 +를 클릭할 때 마다 네트워크를 통해 올린다.
        let item_Save = userCart[index]
        let param_JSON = ["name" : item_Save.name, "count" : item_Save.count];

        //한번의 요청에 여러개의 객체를 실어보내려고 시도함. 올라는 가는 것 같으나, 저장은 하나의 객체, 그것도 값이 다 빈 널 객체로 들어갔다.
        //아무래도 다른 방법으로 여러개의 객체를 parse서버에서 인식하게 해야 할 것 같다.
        /*
        var parameters : Array<[String : NSObject]> = []
        //userCart를 딕셔너리로 바꿔준다.
        for (_, value) in userCart.enumerate()
        {
            parameters.append(["name" : value.name, "count" : value.count])
        }
        

        var param_JSON = ["requests" : parameters]
        print(parameters)
        */
     /*
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: serverURL)! )
        mutableURLRequest.HTTPMethod = "POST"
        var error: NSError? = nil
        
        let options = NSJSONWritingOptions()
        let data = try! NSJSONSerialization.dataWithJSONObject(parameters, options: options)
            mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            mutableURLRequest.setValue("wTDkJZLkXqAalEB3Ma1GMBVv2BpcS9CKhSd6Od5x", forHTTPHeaderField: "X-Parse-Application-Id")
            mutableURLRequest.setValue("lpG0HGORC0hDGIIRKXSFde3kFKHnfBmVfm0HyMgn", forHTTPHeaderField: "X-Parse-REST-API-Key")
            mutableURLRequest.HTTPBody = data
        
        
        Alamofire.request(mutableURLRequest).responseJSON { (response) -> Void in
            print(response)
        }
*/
        
        
        Alamofire.request(.POST, serverURL, parameters: param_JSON as! [String : AnyObject], encoding: Alamofire.ParameterEncoding.JSON, headers: headers).validate(statusCode: 200..<300).responseJSON { (response) -> Void in
            print(response)
        }
    }
    
    //카트 데이터를 위한 데이터 스트럭쳐

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
            if value.name == itemName
            {
                
                userCart[index].count = userCart[index].count + 1
                   self.saveItem(index)
                return
            }
        }
       
        //만약 같은 이름의 아이템이 없으면 새로 추가해 준다.
        //배열의 맨 앞에 추가하게 Index를 0으로

        let newData = CartData()
        newData.name = itemName
        newData.count = 1
        
        self.userCart.insert(newData, atIndex: 0)
        self.saveItem(0)
        NSNotificationCenter.defaultCenter().postNotificationName("ModelChangeNotification", object: nil)
        
    }
    
    func removeItem(itemName  itemName : String)
    {
        
        for (index , value) in userCart.enumerate()
        {
            if value.name == itemName
            {
                
            
                userCart[index].count = userCart[index].count - 1
                self.saveItem(index)
                
                if userCart[index].count <= 0
                {
                    self.deleteItem(index)
                    userCart.removeAtIndex(index)
                
                }
            }
        }
        
    NSNotificationCenter.defaultCenter().postNotificationName("ModelChangeNotification", object: nil)
        
    //userInfo로 수신자에게 데이터를 넘길 수 있다. 이를 이용하
    // NSNotificationCenter.defaultCenter().postNotificationName(<#T##aName: String##String#>, object: <#T##AnyObject?#>, userInfo: <#T##[NSObject : AnyObject]?#>)
    }
    
    
}
