//
//  AfterSessionReportController.swift
//  DhyanaGenric
//
//  Created by AVANTARI on 16/12/17.
//  Copyright © 2017 AVANTARI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var radarChartView   = RadarChartView()
    let activities       = ["Mindfulness","Relaxation", "Breathing"]
    
    var showReports      = true
//    var breathingScore   = Double()
//    var relaxationScore  = Double()
//    var mindfulnessScore = Double()
        var breathingScore   = 40.0
        var relaxationScore  = 25.0
        var mindfulnessScore = 90.6

    
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var refreshLabel: UILabel!
    
    @IBOutlet weak var scoreLabelAndImageContainerView: UIView!
    @IBOutlet weak var noDhyanaMessageLabel: UILabel!
    @IBOutlet weak var uploadingStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(addLabelsToChart(_:)), name: Notification.Name(Config.report_datapoints), object: nil)
        if showReports{
            //uploadingStatusLabel.text = "Syncing data..."
            noDhyanaMessageLabel.alpha = 0.0
            //SyncUserData.shared.uploadDataCallback = uploadDataCallback
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                self.formatRadarChartData()
                self.createView()
            })
        }else{
            print("Reports are not available for this session.")
            scoreLabelAndImageContainerView.alpha = 0.0
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func uploadDataCallback(success: Bool){
        if success{
            print("AfterSessionReportController upload callback: Completed.")
            DispatchQueue.main.async {
                self.uploadingStatusLabel.text = "Swipe when done"
            }
            
        }else{
            print("AfterSessionReportController upload callback: Failure.")
            DispatchQueue.main.async {
                self.uploadingStatusLabel.text = "Swipe when done"
                
            }
        }
    }
    
   
    
    func showAnimate()
    {
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 1.0, animations: {
            self.view.alpha = 1.0
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.3, animations: {
            //self.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        })
    }
    
    func initialMindfullHighlight(){
        // print("\(String(describing: UserDefaults.standard.value(forKey: Config.mindfull_report_datapoints)))")
        if let touchPoints = UserDefaults.standard.value(forKey: Config.mindfull_report_datapoints) as? [[String: Double]]
            
        {
            print(touchPoints[3]["y"]!-15/2)
            print(touchPoints[3]["x"]!-15/2)
            let rect           = CGRect(x: touchPoints[3]["x"]!-15/2, y: touchPoints[3]["y"]!-15/2, width: 15, height: 15)
            self.dot.frame     = rect
            self.dot.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: [], animations: {
                self.dot.transform = .identity
                self.dot.alpha     = 0.5
                self.dot.alpha     = 1.0
            }, completion: { (sucess) in
                return
            })
            let circlePath                      = UIBezierPath(arcCenter: CGPoint(x: touchPoints[3]["x"]!,y: touchPoints[3]["y"]!), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 10), clockwise: true)
            self.mindFillShapeLayer.path        = circlePath.cgPath
            self.mindFillShapeLayer.fillColor   = UIColor.clear.cgColor
            self.mindFillShapeLayer.strokeColor = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1).cgColor
            self.mindFillShapeLayer.lineWidth   = 1.0
            self.chartView.layer.addSublayer(self.mindFillShapeLayer)
        }
    }
    
    var  isFirstTouch = true
    
    @objc func addLabelsToChart(_ notification: Notification){
        DispatchQueue.main.async {
            
            if let touchPoints = UserDefaults.standard.value(forKey: Config.mindfull_report_datapoints) as? [[String: Double]]{
                
                if self.isFirstTouch{
                    self.initialMindfullHighlight()
                    self.isFirstTouch = false
                }
                
                let dynamicLabel: UILabel     = UILabel()
                dynamicLabel.frame            = CGRect(x: touchPoints[3]["x"]! - 100 / 2 , y: touchPoints[3]["y"]! - 50 , width: 120, height: 50)
                dynamicLabel.backgroundColor  = UIColor.clear
                dynamicLabel.textColor        = UIColor.white
                dynamicLabel.textAlignment    = NSTextAlignment.center
                dynamicLabel.text             = "Mindfulness"
                dynamicLabel.font             = UIFont(name: "AvenirNext-Regular",size: 18)
                self.chartView.addSubview(dynamicLabel)
                
                let dynamicLabel2: UILabel    = UILabel()
                dynamicLabel2.frame           = CGRect(x: touchPoints[4]["x"]! - 98 , y: touchPoints[4]["y"]! , width: 120, height: 50)
                dynamicLabel2.backgroundColor = UIColor.clear
                dynamicLabel2.textColor       = UIColor.white
                dynamicLabel2.textAlignment   = NSTextAlignment.right
                dynamicLabel2.text            = "Relaxation"
                dynamicLabel2.font            = UIFont(name: "AvenirNext-Regular",size: 18)
                self.chartView.addSubview(dynamicLabel2)
                
                let dynamicLabel3: UILabel    = UILabel()
                dynamicLabel3.frame           = CGRect(x: touchPoints[5]["x"]! - 25 , y: touchPoints[5]["y"]! , width: 120, height: 50)
                dynamicLabel3.backgroundColor = UIColor.clear
                dynamicLabel3.textColor       = UIColor.white
                dynamicLabel3.textAlignment   = NSTextAlignment.left
                dynamicLabel3.text            = "Breathing"
                dynamicLabel3.font            = UIFont(name: "AvenirNext-Regular",size: 18)
                self.chartView.addSubview(dynamicLabel3)
            }
        }
    }
    func createRadarChart(_ frame : CGRect) -> RadarChartView {
        let radarChartView = RadarChartView(frame: frame)
        return radarChartView
    }
    
    var dot:UIView!
    var relaxtionDot:UIView!
    var breathingDot:UIView!
    
    func createView(){
        if mindfulnessScore == -1 || mindfulnessScore.isNaN{
            refreshLabel.text  = "N/A"
        }else{
            refreshLabel.text = String.init(format: "%d %%", Int(round(mindfulnessScore)))
        }
        
        dot                             = UIView(frame: CGRect(x:0, y:0, width: 15, height: 15))
        dot.layer.cornerRadius          = dot.bounds.width * 0.5
        dot.clipsToBounds               = true
        dot.backgroundColor             = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1.0)
        dot.alpha                       = 0.0
        self.chartView.addSubview(dot)
        
        relaxtionDot                    = UIView(frame: CGRect(x:0, y:0, width: 15, height: 15))
        relaxtionDot.layer.cornerRadius = dot.bounds.width * 0.5
        relaxtionDot.clipsToBounds      = true
        relaxtionDot.backgroundColor    = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1.0)
        relaxtionDot.alpha              = 0.0
        self.chartView.addSubview(relaxtionDot)
        
        breathingDot                    = UIView(frame: CGRect(x:0, y:0, width: 15, height: 15))
        breathingDot.layer.cornerRadius = dot.bounds.width * 0.5
        breathingDot.clipsToBounds      = true
        breathingDot.backgroundColor    = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1.0)
        breathingDot.alpha              = 0.0
        self.chartView.addSubview(breathingDot)
        
        
    }
    
    var dataPoints:[GraphDataPoints] = [GraphDataPoints]()
    func formatRadarChartData(){
        
        radarChartView                        = createRadarChart(chartView.bounds)
        radarChartView.webLineWidth           = 1
        radarChartView.innerWebLineWidth      = 1
        radarChartView.webColor               = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1)
        radarChartView.innerWebColor          = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1)
        radarChartView.webAlpha               = 1
        radarChartView.chartDescription?.text = ""//Removing Description Label
        radarChartView.legend.enabled         = false//legend disable
        let xAxis                             = radarChartView.xAxis
        xAxis.labelFont                       = UIFont(name: "AvenirNext-Regular", size: 3)!
        //        xAxis.wordWrapEnabled = false
        xAxis.xOffset                         = 0
        xAxis.yOffset                         = 0
        xAxis.drawLabelsEnabled               = true
        xAxis.valueFormatter                  = self as IAxisValueFormatter
        xAxis.labelTextColor                  = .clear
        
        let yAxis                             = radarChartView.yAxis
        yAxis.labelFont                       = .systemFont(ofSize: 9, weight: .light)
        yAxis.labelCount                      = 1
        yAxis.forceLabelsEnabled              = true
        yAxis.drawLabelsEnabled               = false
        yAxis.axisMinimum                     = 0
        yAxis.axisMaximum                     = 100
        //yAxis.axisMaximum = Double(chartView.frame.width - 2)
        //        yAxis.drawLabelsEnabled = false
        
        let l                                 = radarChartView.legend
        l.horizontalAlignment                 = .center
        l.verticalAlignment                   = .top
        l.orientation                         = .horizontal
        l.drawInside                          = false
        l.font                                = .systemFont(ofSize: 10, weight: .light)
        l.xEntrySpace                         = 10
        l.yEntrySpace                         = 3
        l.textColor                           = .white
        //chartView.legend = l
        
        //dataPoints.append(GraphDataPoints(mindfulness: mindfulnessScore, breathing: breathingScore, relaxation: relaxationScore, sessionDate: "\(Date())"))
        print(mindfulnessScore,breathingScore,relaxationScore)
        self.setChartData(mindfulness: mindfulnessScore, breathing: breathingScore, relaxation: relaxationScore)
        
        radarChartView.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutBack)
        
        chartView.addSubview(radarChartView)
    }
    
    var radarEntries:[[RadarChartDataEntry]] = [[RadarChartDataEntry]]()
    
    func setChartData(mindfulness: Double,breathing: Double,relaxation: Double) {
        var entries2:[RadarChartDataEntry] = [RadarChartDataEntry]()
        
        entries2.append(RadarChartDataEntry(value: Double(mindfulness)))
        entries2.append(RadarChartDataEntry(value: Double(relaxation)))
        entries2.append(RadarChartDataEntry(value: Double(breathing)))
        radarEntries.append(entries2)
        
        let set1                           = RadarChartDataSet(values: entries2, label: "Last Week")
        set1.setColor(UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1))
        set1.fillColor                     = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1)
        set1.drawFilledEnabled             = true
        set1.fillAlpha                     = 0.7
        set1.lineWidth                     = 0
        set1.drawHighlightCircleEnabled    = false
        set1.setDrawHighlightIndicators(false)
        
        let data                           = RadarChartData(dataSets: [set1])
        data.setValueFont(.systemFont(ofSize: 8, weight: .light))
        data.setDrawValues(false)
        //    data.setValueTextColor(UIColor.red)
        radarChartView.data                = data
    }
    var mindFillShapeLayer = CAShapeLayer()
    var breathingShapeLayer = CAShapeLayer()
    var relaxationShapeLayer = CAShapeLayer()
    
    // TouchToGetPositions
    var touchCount = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = event?.allTouches?.first {
            let loc:CGPoint = touch.location(in: self.chartView)
            
            if let touchPoints = UserDefaults.standard.value(forKey: Config.mindfull_report_datapoints) as? [[String: Double]]{
                let distance1 = distance(from: CGPoint.init(x: CGFloat((touchPoints[3]["x"])!), y: CGFloat((touchPoints[3]["y"])!)), to: CGPoint.init(x: loc.x, y: loc.y))
                let distance2 = distance(from: CGPoint.init(x: CGFloat((touchPoints[4]["x"])!), y: CGFloat((touchPoints[4]["y"])!)), to: CGPoint.init(x: loc.x, y: loc.y))
                let distance3 = distance(from: CGPoint.init(x: CGFloat((touchPoints[5]["x"])!), y: CGFloat((touchPoints[5]["y"])!)), to: CGPoint.init(x: loc.x, y: loc.y))
                
                if distance1 < 80 {
                    
                    if touchCount == 1{
                        return
                    }
                    touchCount = 1
                    
                    if mindfulnessScore == -1 ||  mindfulnessScore.isNaN{
                        refreshLabel.text = "N/A"
                    }else{
                        refreshLabel.text = String.init(format: "%d %%", Int(round(mindfulnessScore)))
                    }
                    
                    
                    self.breathingShapeLayer.strokeColor = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 0.0).cgColor
                    self.relaxationShapeLayer.strokeColor = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 0.0).cgColor
                    
                    
                    let rect = CGRect(x: touchPoints[3]["x"]!-15/2, y: touchPoints[3]["y"]!-15/2, width: 15, height: 15)
                    
                    dot.frame                             = rect
                    relaxtionDot.frame                    = rect
                    breathingDot.frame                    = rect
                    
                    dot.transform                         = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: [], animations: {
                        self.dot.transform = .identity
                        self.dot.alpha     = 0.5
                        self.dot.alpha     = 1.0
                    }, completion: { (sucess) in
                        return
                    })
                    breathingDot.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                        self.breathingDot.transform = .identity
                        self.breathingDot.alpha     = 0.5
                        self.breathingDot.alpha     = 0.0
                    }, completion: { (sucess) in
                        return
                    })
                    relaxtionDot.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                        self.relaxtionDot.transform = .identity
                        self.relaxtionDot.alpha     = 0.5
                        self.relaxtionDot.alpha     = 0.0
                    }, completion: { (sucess) in
                        return
                    })
                    
                    
                    
                    let circlePath                 = UIBezierPath(arcCenter: CGPoint(x: touchPoints[3]["x"]!,y: touchPoints[3]["y"]!), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 10), clockwise: true)
                    mindFillShapeLayer.path        = circlePath.cgPath
                    mindFillShapeLayer.fillColor   = UIColor.clear.cgColor
                    mindFillShapeLayer.strokeColor = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1).cgColor
                    mindFillShapeLayer.lineWidth   = 1.0
                    chartView.layer.addSublayer(mindFillShapeLayer)
                }
                
                if distance2 < 80{
                    
                    if touchCount == 2{
                        return
                    }
                    touchCount = 2
                    if relaxationScore == -1 || relaxationScore.isNaN{
                        refreshLabel.text = "N/A"
                    }else{
                        refreshLabel.text = String.init(format: "%d %%", Int(round(relaxationScore)))
                    }
                    
                    self.mindFillShapeLayer.strokeColor = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 0.0).cgColor
                    self.breathingShapeLayer.strokeColor = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 0.0).cgColor
                    
                    let rect = CGRect(x: touchPoints[4]["x"]!-15/2, y: touchPoints[4]["y"]!-15/2, width: 15, height: 15)
                    
                    dot.frame                             = rect
                    relaxtionDot.frame                    = rect
                    breathingDot.frame                    = rect
                    
                    dot.transform                         = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                        self.dot.transform = .identity
                        self.dot.alpha     = 0.5
                        self.dot.alpha     = 0.0
                    }, completion: { (sucess) in
                        return
                    })
                    breathingDot.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                        self.breathingDot.transform = .identity
                        self.breathingDot.alpha     = 0.5
                        self.breathingDot.alpha     = 0.0
                    }, completion: { (sucess) in
                        return
                    })
                    relaxtionDot.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                        self.relaxtionDot.transform = .identity
                        self.relaxtionDot.alpha     = 0.5
                        self.relaxtionDot.alpha     = 1.0
                    }, completion: { (sucess) in
                        return
                    })
                    
                    
                    let circlePath                   = UIBezierPath(arcCenter: CGPoint(x: touchPoints[4]["x"]!,y: touchPoints[4]["y"]!), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 10), clockwise: true)
                    
                    relaxationShapeLayer.path        = circlePath.cgPath
                    relaxationShapeLayer.fillColor   = UIColor.clear.cgColor
                    relaxationShapeLayer.strokeColor = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1).cgColor
                    relaxationShapeLayer.lineWidth   = 1.0
                    chartView.layer.addSublayer(relaxationShapeLayer)
                    
                }
                if distance3 < 80{
                    
                    if touchCount == 3{
                        return
                    }
                    touchCount = 3
                    
                    if breathingScore == -1 || breathingScore.isNaN{
                        refreshLabel.text = "N/A"
                    }else{
                        refreshLabel.text = String.init(format: "%d %%", Int(round(breathingScore)))
                    }
                    
                    self.mindFillShapeLayer.strokeColor = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 0.0).cgColor
                    self.relaxationShapeLayer.strokeColor = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 0.0).cgColor
                    
                    let rect = CGRect(x: touchPoints[5]["x"]!-15/2, y: touchPoints[5]["y"]!-15/2, width: 15, height: 15)
                    
                    dot.frame = rect
                    relaxtionDot.frame                   = rect
                    breathingDot.frame                   = rect
                    dot.transform                        = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: [], animations: {
                        self.dot.transform = .identity
                        self.dot.alpha     = 0.5
                        self.dot.alpha     = 0.0
                    }, completion: { (sucess) in
                        return
                    })
                    breathingDot.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: [], animations: {
                        self.breathingDot.transform = .identity
                        self.breathingDot.alpha     = 0.5
                        self.breathingDot.alpha     = 1.0
                    }, completion: { (sucess) in
                        return
                    })
                    relaxtionDot.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: [], animations: {
                        self.relaxtionDot.transform = .identity
                        self.relaxtionDot.alpha     = 0.5
                        self.relaxtionDot.alpha     = 0.0
                    }, completion: { (sucess) in
                        return
                    })
                    
                    
                    let circlePath                  = UIBezierPath(arcCenter: CGPoint(x: touchPoints[5]["x"]!,y: touchPoints[5]["y"]!), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 10), clockwise: true)
                    breathingShapeLayer.path        = circlePath.cgPath
                    breathingShapeLayer.fillColor   = UIColor.clear.cgColor
                    breathingShapeLayer.strokeColor = UIColor(red: 65/255, green: 254/255, blue: 245/255, alpha: 1).cgColor
                    breathingShapeLayer.lineWidth   = 1.0
                    chartView.layer.addSublayer(breathingShapeLayer)
                }
            }
            
        }
        
    }
    
    func distance(from: CGPoint, to: CGPoint) -> CGFloat {
        let xDistance = from.x - to.x
        let yDistance = from.y - to.y
        return sqrt(xDistance * xDistance + yDistance * yDistance)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return activities[Int(value) % activities.count]
    }
}

