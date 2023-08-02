//
//  ViewController.swift
//  Users
//
//  Created by Edgar Sargsyan on 20.07.23.


// API 2020 KAlendar



import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    struct Holiday {
        let countries: [String]
        let countryCode: String
        let date: String
        let fixed: Bool
        let global: Bool
        let launchYear: Int?
        let localName: String
        let name: String
        let type: String
        
        var description: String {
            return """
            countries: \(countries)
            countryCode: \(countryCode)
            date: \(date)
            fixed: \(fixed)
            global: \(global)
            launchYear: \(launchYear ?? 0)
            localName: \(localName)
            name: \(name)
            type: \(type)
            """
        }
    }
    
    var data = [Holiday]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRecuest()
    }
    
    private func makeRecuest() {
        let request = URLRequest(url: URL(string: "https://date.nager.at/api/v2/publicholidays/2020/US")!)
        
        // Асинхронный запрос с URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка при выполнении запроса: \(error)")
                return
            }
            
            guard let data = data else {
                print("Получены пустые данные")
                return
            }
            
            do {
                // JSON-парсинг данных, получаем массив holidays с информацией о праздниках
                if let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    var holidays: [Holiday] = []

                    for json in jsonArray {
                        let countries = json["countries"] as? [String] ?? []
                        let countryCode = json["countryCode"] as? String ?? ""
                        let date = json["date"] as? String ?? ""
                        let fixed = json["fixed"] as? Bool ?? false
                        let global = json["global"] as? Bool ?? false
                        let launchYear = json["launchYear"] as? Int
                        let localName = json["localName"] as? String ?? ""
                        let name = json["name"] as? String ?? ""
                        let type = json["type"] as? String ?? ""

                        let holiday = Holiday(countries: countries, countryCode: countryCode, date: date, fixed: fixed, global: global, launchYear: launchYear, localName: localName, name: name, type: type)
                        holidays.append(holiday)
                    }

                    DispatchQueue.main.async {
                        self.data = holidays
                        self.tableview.reloadData()
                    }
                }
            } catch {
                print("Ошибка при разборе данных: \(error)")
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].localName
       

        return cell
    }


// nn
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
    
    
    vc.testResult = data[indexPath.row].date
    
    navigationController?.pushViewController(vc, animated: true)
    
}
}

