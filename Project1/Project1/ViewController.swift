//
//  ViewController.swift
//  Project1
//
//  Created by sookim on 2021/06/23.
//

import UIKit

class ViewController: UITableViewController {
    
    // viewDidLoad에서만 사용하면 뷰가로드 될때 찾은 item들이 사라지니까 변수 지정
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm: FileManager = FileManager.default // 파일시스템으로 작업할 수 있게 해주는 타입
        let path: String = Bundle.main.resourcePath! // 앱번들의 리소스경로 검색
        let items = try! fm.contentsOfDirectory(atPath: path) // 지정된 디렉토리의 단순 검색을 수행하고 포함된 항목의 경로를 반환합니다. -> 디렉토리 중 리소스 경로만 찾아서 배열로 반환
        
        for item in items {
            // 리소스파일 중 nssl로 시작하는 파일만 검색
            if item.hasPrefix("nssl") {
                pictures.append(item) // 배열에 이미지파일 추가
            }
        }
        
        print(pictures)
    }

    // 테이블뷰 행의 개수를 지정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    // 행에 들어갈 셀의 내용을 입력
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
}

