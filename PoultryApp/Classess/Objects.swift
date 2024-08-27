//
//  Objects.swift
//  RealEstates
//
//  Created by botan pro on 4/25/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit









var arr : [String:Any] = [:]



class ProfileObject{
    var name = ""
    var id = ""
    var image = ""
    var phone1 = ""
    var phone2 = ""
    var dis_type = ""
    var office_name = ""
    var office_img = ""
    var country_name = ""
    var city_name = ""
    var address = ""
    var lat = ""
    var long = ""
    var price = ""
    var views = ""
    var desc = ""
    
    
    init(name : String,id : String ,image : String ,  phone1 : String ,phone2 : String, dis_type : String , office_name : String , office_img : String , country_name : String , city_name : String , address : String ,lat : String , long : String , price: String, views : String , desc:String) {
        self.name = name
        self.id = id
        self.image = image
        self.phone1 = phone1
        self.phone2 = phone2
        self.address = address
        self.city_name = city_name
        self.country_name = country_name
        self.dis_type = dis_type
        self.lat = lat
        self.long = long
        self.office_img = office_img
        self.office_name = office_name
        self.price = price
        self.views = views
        self.desc = desc
    }
}


class ProfileObjectAPI {
    
    static func GetProfilesData(profileID: Int,completion : @escaping(_ SlideImage : ProfileObject)->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        let stringUrl = URL(string: API.URL);
        let param: [String: Any] = [
            "key":API.key,
            "username":API.UserName,
            "lang":lang,
            "fun":"get_estate_profile",
            "id":profileID,
            "ip":deviceID
        ]
        
       
        
        AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
            switch response.result
            {
            case .success(_):
                let jsonData = JSON(response.data ?? "")
                if(jsonData[0] != "error"){
                    print(jsonData)
                    for (_,val) in jsonData{
                        let profile = ProfileObject(name: val["profile_name"].string ?? "",
                                                    id: val["id"].string ?? "",
                                                    image:  val["image"].string ?? ""
                                                    , phone1:  val["phone1"].string ?? ""
                                                    , phone2:  val["phone2"].string ?? ""
                                                    , dis_type: val["dis_type"].string ?? ""
                                                    , office_name: val["office_name"].string ?? ""
                                                    , office_img: val["office_img"].string ?? ""
                                                    , country_name: val["country_name"].string ?? ""
                                                    , city_name: val["city_name"].string ?? ""
                                                    , address: val["address"].string ?? ""
                                                    , lat: val["lat"].string ?? ""
                                                    , long: val["long"].string ?? ""
                                                    , price: val["price"].string ?? ""
                                                    , views: val["views"].string ?? ""
                                                    , desc: val["descreption"].string ?? "")
                        completion(profile)
                    }
                    
                }
            case .failure(let error):
                print(error);
            }
        }
    }
}

























class  SlideShowObject {
    var id = ""
    var image = ""
    
    init(id : String ,image : String) {
        self.id = id
        self.image = image
    }
}

class SlideShowAPI {
    
    static func GetSlideImage(completion : @escaping(_ SlideImage : [SlideShowObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var Slide = [SlideShowObject]()
               let stringUrl = URL(string: API.URL);
               let param: [String: Any] = [
                   "key":API.key,
                   "username":API.UserName,
                   "lang":lang,
                   "fun" : "get_slider_img"
               ]
               
               AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                   switch response.result
                   {
                   case .success(_):
                       let jsonData = JSON(response.data ?? "")
                       if(jsonData[0] != "error"){
                           for (_,val) in jsonData{
                            let slide = SlideShowObject(id: val["id"].string ?? "",
                                                        image: val["image"].string ?? "")
                               Slide.append(slide)
                           }
                           completion(Slide)
                       }
                   case .failure(let error):
                       print(error);
                   }
               }
    }
}







class  EstatetypeObject {
    var id = ""
    var name = ""
    
    init(id : String ,name : String ) {
        self.id = id
        self.name = name
    }
}

class EstatetypeObjectAPI {
    
    static func GetSlideImage(completion : @escaping(_ SlideImage : [EstatetypeObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var types = [EstatetypeObject]()
               let stringUrl = URL(string: API.URL);
               let param: [String: Any] = [
                   "key":API.key,
                   "username":API.UserName,
                   "lang":lang,
                   "fun" : "get_estate_type"
               ]
               
               AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                   switch response.result
                   {
                   case .success(_):
                       let jsonData = JSON(response.data ?? "")
                       if(jsonData[0] != "error"){
                        print(jsonData)
                           for (_,val) in jsonData{
                            let type = EstatetypeObject(id: val["id"].string ?? "",
                                                        name: val["type_name"].string ?? "")
                            types.append(type)
                           }
                           completion(types)
                       }
                   case .failure(let error):
                       print(error);
                   }
               }
    }
}











class  ProfilesHomeObject {
    var id = ""
    var image = ""
    var dis_type = ""
    var name = ""
    var type_name = ""
    var price = ""
    var space = ""
    var views = ""
    
    init(id : String ,image : String, dis_type:String , type_name:String , price : String , space : String , views : String , name : String) {
        self.id = id
        self.image = image
        self.dis_type = dis_type
        self.type_name = type_name
        self.price = price
        self.space = space
        self.views = views
        self.name = name
    }
}

class ProfilesHomeObjectAPI {
    
    static func GetProfiles(start : Int,limit : Int,completion : @escaping(_ SlideImage : [ProfilesHomeObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var profils = [ProfilesHomeObject]()
               let stringUrl = URL(string: API.URL);
               let param: [String: Any] = [
                   "key":API.key,
                   "username":API.UserName,
                   "lang":lang,
                   "fun" : "get_home_estate",
                   "start" : start,
                   "limit":limit
               ]
               print("lang is : \(lang)")
               AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                   switch response.result
                   {
                   case .success(_):
                       let jsonData = JSON(response.data ?? "")
                       if(jsonData[0] != "error"){
                           for (_,val) in jsonData{
                            let profile = ProfilesHomeObject(id: val["id"].string ?? ""
                                                         , image: val["url"].string ?? ""
                                                         , dis_type: val["type_name"].string ?? ""
                                                         , type_name: val["type_name"].string ?? ""
                                                         , price: val["price"].string ?? ""
                                                         , space: val["space"].string ?? ""
                                                         , views: val["views"].string ?? ""
                                                         , name: val["profile_name"].string ?? "")
                            profils.append(profile)
                           }
                           completion(profils)
                       }
                   case .failure(let error):
                       print(error);
                   }
               }
    }
}








class  RelatedProfilesObject {
    var id = ""
    var image = ""
    var dis_type = ""
    var name = ""
    var type_name = ""
    var price = ""
    var space = ""
    var views = ""
    
    init(id : String ,image : String, dis_type:String , type_name:String , price : String , space : String , views : String , name : String) {
        self.id = id
        self.image = image
        self.dis_type = dis_type
        self.type_name = type_name
        self.price = price
        self.space = space
        self.views = views
        self.name = name
    }
}

class RelatedProfilesObjectAPI {
    
    static func GetProfiles(ProfileId : Int,completion : @escaping(_ SlideImage : [RelatedProfilesObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var profils = [RelatedProfilesObject]()
               let stringUrl = URL(string: API.URL);
               let param: [String: Any] = [
                   "key":API.key,
                   "username":API.UserName,
                   "lang":lang,
                   "fun" : "get_related_profile",
                   "id" : ProfileId
               ]
               
               AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                   switch response.result
                   {
                   case .success(_):
                       let jsonData = JSON(response.data ?? "")
                       if(jsonData[0] != "error"){
                        print(jsonData)
                           for (_,val) in jsonData{
                            let profile = RelatedProfilesObject(id: val["id"].string ?? ""
                                                         , image: val["url"].string ?? ""
                                                         , dis_type: val["type_name"].string ?? ""
                                                         , type_name: val["type_name"].string ?? ""
                                                         , price: val["price"].string ?? ""
                                                         , space: val["space"].string ?? ""
                                                         , views: val["views"].string ?? ""
                                                         , name: val["profile_name"].string ?? "")
                            profils.append(profile)
                           }
                           completion(profils)
                       }
                   case .failure(let error):
                       print(error);
                   }
               }
    }
}












class  ProfilesByIdObject {
    var id = ""
    var image = ""
    var dis_type = ""
    var name = ""
    var type_name = ""
    var price = ""
    var space = ""
    var views = ""
    
    init(id : String ,image : String, dis_type:String , type_name:String , price : String , space : String , views : String , name : String) {
        self.id = id
        self.image = image
        self.dis_type = dis_type
        self.type_name = type_name
        self.price = price
        self.space = space
        self.views = views
        self.name = name
    }
}

class ProfilesByIdObjectAPI {
    
    static func GetProfiles(OfficeId : Int,completion : @escaping(_ SlideImage : [ProfilesByIdObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var profils = [ProfilesByIdObject]()
               let stringUrl = URL(string: API.URL);
               let param: [String: Any] = [
                   "key":API.key,
                   "username":API.UserName,
                   "lang":lang,
                   "fun" : "get_office_estate",
                   "id" : OfficeId
               ]
               
               AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                   switch response.result
                   {
                   case .success(_):
                       let jsonData = JSON(response.data ?? "")
                       if(jsonData[0] != "error"){
                           for (_,val) in jsonData{
                            let profile = ProfilesByIdObject(id: val["id"].string ?? ""
                                                         , image: val["url"].string ?? ""
                                                         , dis_type: val["type_name"].string ?? ""
                                                         , type_name: val["type_name"].string ?? ""
                                                         , price: val["price"].string ?? ""
                                                         , space: val["space"].string ?? ""
                                                         , views: val["views"].string ?? ""
                                                         , name: val["profile_name"].string ?? "")
                            profils.append(profile)
                           }
                           completion(profils)
                       }
                   case .failure(let error):
                       print(error);
                   }
               }
    }
}













class  CuntryObject {
    var id = ""
    var CuntryName = ""
    
    init(id : String ,CuntryName : String) {
        self.id = id
        self.CuntryName = CuntryName
    }
}

class CuntryObjectAPI {
    
    static func GetCuntrys(completion : @escaping(_ SlideImage : [CuntryObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var Cuntrys = [CuntryObject]()
               let stringUrl = URL(string: API.URL);
               let param: [String: Any] = [
                   "key":API.key,
                   "username":API.UserName,
                   "lang":lang,
                   "fun" : "get_country"
               ]
               print(lang)
               AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                   switch response.result
                   {
                   case .success(_):
                       let jsonData = JSON(response.data ?? "")
                       if(jsonData[0] != "error"){
                        print(jsonData)
                           for (_,val) in jsonData{
                            let Cuntry = CuntryObject(id: val["id"].string ?? "",
                                                        CuntryName: val["country_name"].string ?? "")
                            Cuntrys.append(Cuntry)
                           }
                           completion(Cuntrys)
                       }
                   case .failure(let error):
                       print(error);
                   }
               }
    }
}


class  profileImageObject {
    var image = ""
    
    init(image : String) {
        self.image = image
    }
}

class profileImageObjectAPI {
    
    static func GetprofileImage(profileId : Int,completion : @escaping(_ SlideImage : [profileImageObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var images = [profileImageObject]()
               let stringUrl = URL(string: API.URL);
               let param: [String: Any] = [
                   "key":API.key,
                   "username":API.UserName,
                   "lang":lang,
                   "fun" : "get_profile_img",
                   "id" :profileId
               ]
               print(lang)
               AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                   switch response.result
                   {
                   case .success(_):
                       let jsonData = JSON(response.data ?? "")
                       if(jsonData[0] != "error"){
                        print(jsonData)
                           for (_,val) in jsonData{
                            let image = profileImageObject(image: val["url"].string ?? "")
                            images.append(image)
                           }
                           completion(images)
                       }
                   case .failure(let error):
                       print(error);
                   }
               }
    }
}



class OfficObject{
    var name = ""
    var id = ""
    var image = ""
    var phone1 = ""
    var phone2 = ""
    
    init(name : String,id : String ,image : String ,  phone1 : String ,phone2 : String) {
        self.name = name
        self.id = id
        self.image = image
        self.phone1 = phone1
        self.phone2 = phone2
    }
}


class OfficObjectAPI {
    
    static func GetOffics(completion : @escaping(_ SlideImage : [OfficObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var Offics = [OfficObject]()
               let stringUrl = URL(string: API.URL);
               let param: [String: Any] = [
                   "key":API.key,
                   "username":API.UserName,
                   "lang":lang,
                   "fun" : "get_office"
               ]
               
               AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                   switch response.result
                   {
                   case .success(_):
                       let jsonData = JSON(response.data ?? "")
                       if(jsonData[0] != "error"){
                        print(jsonData)
                           for (_,val) in jsonData{
                            let Offic = OfficObject(name: val["name"].string ?? "",
                                                    id: val["id"].string ?? "", image:  val["image"].string ?? "", phone1:  val["phone1"].string ?? "", phone2:  val["phone2"].string ?? "")
                            Offics.append(Offic)
                           }
                           completion(Offics)
                       }
                   case .failure(let error):
                       print(error);
                   }
               }
    }
}




class EstateTypeObjectAPI {
    
    static func GetEstatesByType(EstateType: Int,completion : @escaping(_ SlideImage : [ProfilesHomeObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var Offics = [ProfilesHomeObject]()
        let stringUrl = URL(string: API.URL);
        let param: [String: Any] = [
            "key":API.key,
            "username":API.UserName,
            "lang":lang,
            "fun":"get_estate_by_disp",
            "disp":EstateType
        ]
        
        AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
            switch response.result
            {
            case .success(_):
                let jsonData = JSON(response.data ?? "")
                if(jsonData[0] != "error"){
                    print(jsonData)
                    for (_,val) in jsonData{
                        let Offic = ProfilesHomeObject(id: val["id"].string ?? ""
                                                       , image: val["url"].string ?? ""
                                                       , dis_type: val["type_name"].string ?? ""
                                                       , type_name: val["type_name"].string ?? ""
                                                       , price: val["price"].string ?? ""
                                                       , space: val["space"].string ?? ""
                                                       , views: val["views"].string ?? ""
                                                       , name: val["profile_name"].string ?? "")
                        Offics.append(Offic)
                    }
                    completion(Offics)
                }
            case .failure(let error):
                print(error);
            }
        }
    }
}


class  CityObject {
    var id = ""
    var CityName = ""
    
    init(id : String ,CityName : String) {
        self.id = id
        self.CityName = CityName
    }
}

class CityObjectAPI {
    
    static func GetCitys(country_id : Int,completion : @escaping(_ SlideImage : [CityObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var Citys = [CityObject]()
               let stringUrl = URL(string: API.URL);
               let param: [String: Any] = [
                   "key":API.key,
                   "username":API.UserName,
                   "lang":lang,
                   "fun" : "get_city",
                   "country_id" : country_id
               ]
               
               AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                   switch response.result
                   {
                   case .success(_):
                       let jsonData = JSON(response.data ?? "")
                       if(jsonData[0] != "error"){
                           for (_,val) in jsonData{
                            let City = CityObject(id: val["id"].string ?? "",
                                                      CityName: val["city_name"].string ?? "")
                            Citys.append(City)
                           }
                           completion(Citys)
                       }
                   case .failure(let error):
                       print(error);
                   }
               }
    }
}









class FilterProfilesObjectAPI {
    
    static func GetFilteredProfiles(dis_type :Int ,price_min :Int ,price_max :Int ,room :Int ,space :Int ,city_id :Int ,type_id :Int ,completion : @escaping(_ SlideImage : [ProfilesHomeObject])->()){
        let lang = UserDefaults.standard.integer(forKey: "language")
        var profils = [ProfilesHomeObject]()
               let stringUrl = URL(string: API.URL);
               let param: [String: Any] = [
                   "key":API.key,
                   "username":API.UserName,
                   "lang":lang,
                   "fun" : "get_estate_fliter",
                   "dis_type" : dis_type,
                   "price_min":price_min,
                   "price_max":price_max,
                   "room":room,
                   "space":space,
                   "city_id":city_id,
                   "type_id":type_id
               ]
               
               AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                   switch response.result
                   {
                   case .success(_):
                       let jsonData = JSON(response.data ?? "")
                       if(jsonData[0] != "error"){
                           for (_,val) in jsonData{
                            let profile = ProfilesHomeObject(id: val["id"].string ?? ""
                                                         , image: val["url"].string ?? ""
                                                         , dis_type: val["type_name"].string ?? ""
                                                         , type_name: val["type_name"].string ?? ""
                                                         , price: val["price"].string ?? ""
                                                         , space: val["space"].string ?? ""
                                                         , views: val["views"].string ?? ""
                                                         , name: val["profile_name"].string ?? "")
                            profils.append(profile)
                           }
                           completion(profils)
                       }
                   case .failure(let error):
                       print(error);
                   }
               }
    }
}

