//
//  ViewController.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 장민석 on 2021/11/24.
//  Copyright © 2021 장민석. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire

class HomeVC: BaseVC, UISearchBarDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    var keyboardDismissTabGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
    
    //MARK: - override method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("HomeVC - viewDIdLoad() called")
        
        // ui 설정
        self.config()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("HomeVC - viewDidAppear() called")
        self.searchBar.becomeFirstResponder() // 포커싱 주기
    }
    
    // 화면이 넘어가기 전에 준비한다
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HomeVC - prepare() called / segue.identifier : \(segue.identifier)")
        
        switch segue.identifier {
        case SEGUE_ID.USER_LIST_VC:
            // 다음 화면의 뷰컨트롤러를 가져온다.
            let nextVC = segue.destination as! UserListVC
            
            guard let userInputValue = self.searchBar.text else { return }
            
            nextVC.vcTitle = userInputValue + " 🙍🏻‍♂️"
            
        case SEGUE_ID.PHOTO_COLLECTION_VC:
        // 다음 화면의 뷰컨트롤러를 가져온다.
        let nextVC = segue.destination as! PhotoCollectionVC
        
        guard let userInputValue = self.searchBar.text else { return }
        
        nextVC.vcTitle = userInputValue + " 🏞"
            
        default:
            print("defalut")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC - viewWillAppear() called")
        // 키보드 올라가는 이벤트를 받는 처리
        // 키보드 노티 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("HomeVC - viewWillDisappear() called")
        // 키보드 노티 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - fileprivate methods
    
    fileprivate func config() {
        // ui 설정
        self.searchButton.layer.cornerRadius = 10
        
        self.searchBar.searchBarStyle = .minimal
        
        self.searchBar.delegate = self
        
        self.keyboardDismissTabGesture.delegate = self
        
        // 제스처 추가하기
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
    
    }
    
    fileprivate func pushVC() {
        var segueId : String = ""
        
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            print("사진 화면으로 이동")
            segueId = "gotoPhotoCollectionVC"
        case 1:
            print("사용자 화면으로 이동")
            segueId = "gotoUserListVC"
        default:
            print("defalut")
            segueId = "gotoPhotoCollectionVC"
        }
        
        // 화면이동
        self.performSegue(withIdentifier: segueId, sender: self)
    }
    // 푸시되는지 실험하는 주석입니다. 삭제 바랍니다. 
    @objc func keyboardWillShowHandle(notification: NSNotification){
        print("HomeVC - keyboardWillShow() called")
        // 키보드 사이즈 가져오기
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            print("keyboardSize.height: \(keyboardSize.height)")
            print("searchButton.frame.origin.y : \(searchButton.frame.origin.y)")
            
            if(keyboardSize.height < searchButton.frame.origin.y){
                print("키보드가 버튼을 덮었다.")
                let distance = keyboardSize.height - searchButton.frame.origin.y
                print("이만큼 덮엇다. distance : \(distance)")
                self.view.frame.origin.y = distance + searchButton.frame.height
            }
        }
        
        
    }
    
    @objc func keyboardWillHide() {
        print("HomeVC - keyboardWillHide() called")
        self.view.frame.origin.y = 0
    }
    
    //MARK: - IBAction methods
    
    
    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
        print("HomeVC - onSearchButtonClicked() called / Selectedindex : \(searchFilterSegment.selectedSegmentIndex)")
        
//        let url = API.BASE_URL + "search/photos"
//
          guard let userInput = self.searchBar.text else { return }
//
//        // 키, 밸류 형식의 딕셔너리
//        let queryParam = ["query" : userInput, "client_id" : API.CLIENT_ID ]
//
//        AF.request(url, method: .get, parameters: queryParam).responseJSON(completionHandler: {
//            response in debugPrint(response)
//        })
        
        var urlToCall : URLRequestConvertible?
        
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            //urlToCall = MySearchRouter.searchPhotos(term: userInput)
            
            MyAlamofireManager
                .shared
                .getPhotos(searchTerm: userInput, completion: { [weak self] result in
                                                            // 클로저 arc
                                                            // automatic reference count
                                                            // 자동 메모리사용수 계산
                                                            // stack, heap 메모리 영역
                                                            // class, closure 등이 사용
                                                            // weak self
                                                            // self 는 메모리 카운트를 증가
                                                            // weak self 를 통해 메모리를 가지고 있는 것을 방지
                                                            // 다음과 같이 self.메소드등 self 를 사용해야 하는 경우 weak self 로 메모리에 계속 잡아 두고 있는 것을 방지
                
                    guard let self = self else { return }
                    
                switch result {
                case .success(let fetchedPhotos) :
                    print("HomeVC - getPhotos.success - fetchedPhotos.count - \(fetchedPhotos.count)")
                case .failure(let error) :
                    print("HomeVC - getPhotos.failure - error : \(error.rawValue)")
                    self.view.makeToast(error.rawValue, duration: 1.0, position: .center)
                }
            })
        case 1:
            urlToCall = MySearchRouter.searchUsers(term: userInput)
        default:
            print("defalut")
        }
        
//        if let urlConvertible = urlToCall {
//            MyAlamofireManager
//                .shared
//                .session
//                .request(urlConvertible)
//                .validate(statusCode: 200..<401)
//                .responseJSON(completionHandler: {
//                response in
//                    print("HomeVC - response : \(response)")
//                    print("HomeVC - response.error : \(response.error)")
//            })
//        }
        
        
        
        
        
        // 화면으로 이동
        //pushVC()
    }
    @IBAction func searchFilterValueChanged(_ sender: UISegmentedControl) {
     //   print("HomeVC - searchFilterValueChanged() called / index : \(sender.selectedSegmentIndex)")
        
        var searchBarTitle = ""
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            searchBarTitle = "사진 키워드"
        case 1:
            searchBarTitle = "사용자 이름"
        default:
            searchBarTitle = "사진 키워드"
        }
        
        self.searchBar.placeholder = searchBarTitle + " 입력"
        
        self.searchBar.becomeFirstResponder() //포커싱 주기
        // 포거싱 해제 self.searchBar.resignFirstResponder()
    }
    
    //MARK: - UISearchBar Delegate methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("HomeVC - searchBarSearchButtonClicked() ")
        
        guard let userInputString = searchBar.text else { return }
        
        if userInputString.isEmpty {
            self.view.makeToast("📣 검색 키워드를 입력해주세요.", duration: 1.0, position: .center)
        } else {
            pushVC()
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print("HomeVC - searchBar textDidChange() searchText: \(searchText)")
        
        // 사용자가 입력한 값이 없을때
        if (searchText.isEmpty) {
            self.searchButton.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                // 포커싱 해제
                searchBar.resignFirstResponder()
                
            })
        } else{
            self.searchButton.isHidden = false
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let inputTextCount = searchBar.text?.appending(text).count ?? 0
        
        print("shouldChangeTextIn : \(inputTextCount)")
        
        if (inputTextCount >= 12) {
            self.view.makeToast("📢 12자 까지만 입력가능합니다.", duration: 1.0, position: .center)
        }
        
//        if inputTextCount <= 12 {
//            return true
//        } else{
//            return false
//        }
        
        return inputTextCount <= 12
    }
    
    //MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("HomeVC - gestureRecognizer shouldReceive() called")
        
        // 터치로 들어온 뷰가 이놈이면
        if (touch.view?.isDescendant(of: searchFilterSegment) == true) {
            print("세그먼트가 터치되었다.")
            return false
        } else if (touch.view?.isDescendant(of: searchBar) == true) {
            print("서치바가 터치되었다.")
            return false
        } else {
            view.endEditing(true)
            print("화면이 터치되었다.")
            return true
        }
    
    }
    
    
}

