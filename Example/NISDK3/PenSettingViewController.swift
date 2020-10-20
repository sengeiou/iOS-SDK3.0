//
//  PenSettingViewController.swift
//  NISDK3_Example
//
//  Created by NeoLAB on 2020/04/07.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import NISDK3

class PenSettingViewController: UIViewController {

    static func instance() -> PenSettingViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PenSettingViewController") as! PenSettingViewController
        return vc
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var penStatus: PenSettingStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PenHelper.shared.penSettingDelegate = { [weak self] (status) in
            self?.penStatus = status
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        PenHelper.shared.pen?.requestPenSettingInfo()
    }
    
    func cellValueHidden(cell:PenSettinghCell,switchHidden:Bool,settingValueHidden:Bool){
        cell.OnOffSwitch.isHidden = switchHidden
        cell.settingValue.isHidden = settingValueHidden
    }
    
    func deselectTable(){
        DispatchQueue.main.async {
            if let index = self.tableView.indexPathForSelectedRow{
                self.tableView.deselectRow(at: index, animated: true)
            }
        }
    }
    
    @IBAction func onOffSwitchBtnClicked(_ sender: UISwitch) {
        let tag = sender.tag
        if tag == 1{
            if sender.isOn{
                sender.isOn = true
                PenHelper.shared.pen?.requestSetPenBeep(OnOff.On)
            }else{
                sender.isOn = false
                PenHelper.shared.pen?.requestSetPenBeep(OnOff.Off)
            }
        }else if tag == 2{
            if sender.isOn{
                sender.isOn = true
                PenHelper.shared.pen?.requestSetPenAutoPowerOn(OnOff.On)
            }else{
                sender.isOn = false
                PenHelper.shared.pen?.requestSetPenAutoPowerOn(OnOff.Off)
            }
        }else if tag == 3{
            if sender.isOn{
                sender.isOn = true
                PenHelper.shared.pen?.requestSetPenCapOff(OnOff.On)
            }else{
                sender.isOn = false
                PenHelper.shared.pen?.requestSetPenCapOff(OnOff.Off)
            }
        }else if tag == 4{
            if sender.isOn{
                sender.isOn = true
                PenHelper.shared.pen?.requestSetPenHover(OnOff.On)
            }else{
                sender.isOn = false
                PenHelper.shared.pen?.requestSetPenHover(OnOff.Off)
            }
        }else if tag == 5{
            if sender.isOn{
                sender.isOn = true
                PenHelper.shared.pen?.requestSetPenOfflineSave(OnOff.On)
            }else{
                sender.isOn = false
                PenHelper.shared.pen?.requestSetPenOfflineSave(OnOff.Off)
            }
        }else if tag == 6{
//            벌크모드 앤 디스크모드 없음????
        }else if tag == 7{
//            다운로드 샘플링??????
        }
    }
}

extension PenSettingViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "PenSettinghCell", for: indexPath) as! PenSettinghCell
        if row == 0{
            cell.SettingName.text = "펜 이름"
            cell.settingValue.text = "\(penStatus?.localName ?? "NeoLab Pen")"
            cellValueHidden(cell: cell, switchHidden: true, settingValueHidden: false)
        }else if row == 1{
            cell.SettingName.text = "펜 자동꺼짐 시간"
            cell.settingValue.text = "\(penStatus?.autoPwrOffTime ?? UInt16(10))분 ▼"
            cellValueHidden(cell: cell, switchHidden: true, settingValueHidden: false)
        }else if row == 2{
            cell.SettingName.text = "비밀번호 시도 횟수"
            cell.settingValue.text = "\(penStatus?.retryCnt ?? UInt8(0)) / \(penStatus?.maxRetryCnt ?? UInt8(10))"
            cellValueHidden(cell: cell, switchHidden: true, settingValueHidden: false)
        }else if row == 3{
            cell.SettingName.text = "배터리 충전도"
            cell.settingValue.text = "\(penStatus?.battLevel ?? UInt8(0))%"
            cellValueHidden(cell: cell, switchHidden: true, settingValueHidden: false)
        }else if row == 4{
            cell.SettingName.text = "사용중인 메모리"
            cell.settingValue.text = "\(penStatus?.memoryUsed ?? UInt8(0))%"
            cellValueHidden(cell: cell, switchHidden: true, settingValueHidden: false)
        }else if row == 5{
            cell.SettingName.text = "펜 알림 소리"
            cell.OnOffSwitch.isOn = penStatus?.beepOnOff == OnOff.On ? true : false
            cell.OnOffSwitch.tag = 1
            cellValueHidden(cell: cell, switchHidden: false, settingValueHidden: true)
        }else if row == 6{
            cell.SettingName.text = "펜 자동 전원"
            cell.OnOffSwitch.isOn = penStatus?.usePenTipOnOff == OnOff.On ? true : false
            cell.OnOffSwitch.tag = 2
            cellValueHidden(cell: cell, switchHidden: false, settingValueHidden: true)
        }else if row == 7{
            cell.SettingName.text = "펜 뚜껑"
            cell.OnOffSwitch.isOn = penStatus?.usePenCapOff == OnOff.On ? true : false
            cell.OnOffSwitch.tag = 3
            cellValueHidden(cell: cell, switchHidden: false, settingValueHidden: true)
        }else if row == 8{
            cell.SettingName.text = "펜 호버"
            cell.OnOffSwitch.isOn = penStatus?.useHover == OnOff.On ? true : false
            cell.OnOffSwitch.tag = 4
            cellValueHidden(cell: cell, switchHidden: false, settingValueHidden: true)
        }else if row == 9{
            cell.SettingName.text = "펜 비밀번호 설정"
            cell.settingValue.text = "▼"
            cellValueHidden(cell: cell, switchHidden: true, settingValueHidden: false)
        }else if row == 10{
            cell.SettingName.text = "펜 오프라인 데이터"
            cell.settingValue.text = "▼"
            cellValueHidden(cell: cell, switchHidden: true, settingValueHidden: false)
        }else if row == 11{
            cell.SettingName.text = "펜 펌웨어 업데이트"
            cell.settingValue.text = "▼"
            cellValueHidden(cell: cell, switchHidden: true, settingValueHidden: false)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            let vc = PenPickerViewController.instance()
            vc.settingOpt = SettingOption.shutdownTime
            vc.penStatus = self.penStatus
            present(vc, animated: true, completion: nil)
        }else if indexPath.row == 9{
            alert()
        }else if indexPath.row == 10{
            let vc = PenOfflineNoteViewController.instance()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 11{
            let vc = PenFWUpdateViewController.instance()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        deselectTable()
    }
    
    func alert(){
        let alertController = UIAlertController(title: "비밀번호 변경", message: "비밀번호는 4자리 입니다.", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            _ = alertController.textFields![1] as UITextField
            PenHelper.shared.pen?.requestSetPassword(firstTextField.text!)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
        
        saveAction.isEnabled = false

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "비밀번호 입력"
            textField.keyboardType = .numberPad
            textField.isSecureTextEntry = true
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "비밀번호 재입력"
            textField.keyboardType = .numberPad
            textField.isSecureTextEntry = true
            
        }

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object:alertController.textFields?[0],queue: OperationQueue.main) { (notification) -> Void in
            let pw1 = alertController.textFields?[0].text
            let pw2 = alertController.textFields![1].text
            saveAction.isEnabled = self.isPassword(pw1: pw1 ?? "", pw2: pw2 ?? "")
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object:alertController.textFields?[1],queue: OperationQueue.main) { (notification) -> Void in
            let pw2 = alertController.textFields?[1].text
            let pw1 = alertController.textFields?[0].text
            saveAction.isEnabled = self.isPassword(pw1: pw1 ?? "", pw2: pw2 ?? "")
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    func isPassword(pw1:String,pw2:String) -> Bool {
        if pw1.count != 4 || pw2.count != 4{
            return false
        }
        if pw1 == pw2{
            return true
        }
        return false
    }
}


//MARK: - PenSettinghCell
class PenSettinghCell: UITableViewCell {
    
    @IBOutlet weak var settingValue: UILabel!
    @IBOutlet weak var OnOffSwitch: UISwitch!
    @IBOutlet weak var SettingName:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}