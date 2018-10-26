//
//  PieViewController.swift
//  Bill
//
//  Created by fcn on 2018/10/24.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit
import Charts
import SnapKit


class PieViewController: UIViewController {
    
    /// 支出 or 收入
    var isOut: Bool!
    /// 数据
    var chartDatas: [ChartGroup]!
    

    @IBOutlet weak var pieChartView: PieChartView!
    
    
    var months = [String]()
    var unitsSold = [Double]()
    var pieTitle = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pieTitle = isOut ? "支出占比" : "收入占比"
        
        
        for item in chartDatas {
            months.append(item.categoryName)
            unitsSold.append(isOut ? Double(item.allOut) : Double(item.allIn))
        }
    

        pieChartView.backgroundColor = UIColor(red: 230/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        //基本样式
        pieChartView.delegate = self
        // 设置数据
        setChart(dataPoints: months, values: unitsSold)

    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let entry = PieChartDataEntry(value: values[i], label: "\(dataPoints[i])") //设置数据 title和对应的值
            dataEntries.append(entry)
        }
        let pichartDataSet = PieChartDataSet(values: dataEntries, label: pieTitle) //设置表示
        //设置饼状图字体配置
        setPieChartDataSetConfig(pichartDataSet: pichartDataSet)
        let pieChartData = PieChartData(dataSet: pichartDataSet)
        //设置饼状图字体样式
        setPieChartDataConfig(pieChartData: pieChartData)
        pieChartView.data = pieChartData //将配置及数据添加到表中
        //设置饼状图样式
        setDrawHoleState()
        var colors: [UIColor] = []
        for _ in 0..<dataPoints.count {
            colors.append(UIColor.randomColor)
        }
        pichartDataSet.colors = colors//设置区块颜色
    }

    //设置饼状图字体配置
    func setPieChartDataSetConfig(pichartDataSet: PieChartDataSet){
        pichartDataSet.sliceSpace = 0 //相邻区块之间的间距
        pichartDataSet.selectionShift = 8 //选中区块时, 放大的半径
        pichartDataSet.xValuePosition = .insideSlice //名称位置
        pichartDataSet.yValuePosition = .outsideSlice //数据位置
        //数据与区块之间的用于指示的折线样式
        pichartDataSet.valueLinePart1OffsetPercentage = 0.85 //折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
        pichartDataSet.valueLinePart1Length = 0.5 //折线中第一段长度占比
        pichartDataSet.valueLinePart2Length = 0.4 //折线中第二段长度最大占比
        pichartDataSet.valueLineWidth = 1 //折线的粗细
        pichartDataSet.valueLineColor = UIColor.gray //折线颜色
    }
    
    //设置饼状图字体样式
    func setPieChartDataConfig(pieChartData: PieChartData){
        pieChartData.setValueFormatter(DigitValueFormatter())//设置百分比
        pieChartData.setValueTextColor(UIColor.gray) //字体颜色为白色
        pieChartData.setValueFont(UIFont.systemFont(ofSize: 10))//字体大小
    }
    
    
    //设置饼状图中心文本
    func setDrawHoleState(){
        ///饼状图距离边缘的间隙
        pieChartView.setExtraOffsets(left: 30, top: 0, right: 30, bottom: 0)
        //拖拽饼状图后是否有惯性效果
        pieChartView.dragDecelerationEnabled = true
        //是否显示区块文本
        pieChartView.drawSlicesUnderHoleEnabled = true
        //是否根据所提供的数据, 将显示数据转换为百分比格式
        pieChartView.usePercentValuesEnabled = true
        
        // 设置饼状图描述
        pieChartView.chartDescription?.text = pieTitle
        pieChartView.chartDescription?.font = UIFont.systemFont(ofSize: 10)
        pieChartView.chartDescription?.textColor = UIColor.gray
        
        // 设置饼状图图例样式
        pieChartView.legend.maxSizePercent = 1 //图例在饼状图中的大小占比, 这会影响图例的宽高
        pieChartView.legend.formToTextSpace = 5 //文本间隔
        pieChartView.legend.font = UIFont.systemFont(ofSize: 10) //字体大小
        pieChartView.legend.textColor = UIColor.gray //字体颜色
        pieChartView.legend.verticalAlignment = .bottom //图例在饼状图中的位置
        pieChartView.legend.form = .circle //图示样式: 方形、线条、圆形
        pieChartView.legend.formSize = 12 //图示大小
        pieChartView.legend.orientation = .horizontal
        pieChartView.legend.horizontalAlignment = .center
        
        //        pieChartView.centerText = "平均库龄" //饼状图中心的文本
        ////饼状图中心的富文本文本
        let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: CGFloat(15.0))]
        let centerTextAttribute = NSAttributedString(string: pieTitle, attributes: attributes)
        pieChartView.centerAttributedText = centerTextAttribute
        
        
        
        /*
         ///设置饼状图中心的文本
         if pieChartView.isDrawHoleEnabled {
         ///设置饼状图中间的空心样式
         pieChartView.drawHoleEnabled = true //饼状图是否是空心
         pieChartView.holeRadiusPercent = 0.5 //空心半径占比
         pieChartView.holeColor = UIColor.clear //空心颜色
         pieChartView.transparentCircleRadiusPercent = 0.52 //半透明空心半径占比
         pieChartView.transparentCircleColor = UIColor(r: 210, g: 145, b: 165, 0.3) //半透明空心的颜色
         pieChartView.drawCenterTextEnabled = true //是否显示中间文字
         //普通文本
         //pieChartView.centerText = "平均库龄"
         //富文本
         let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(15.0)), NSForegroundColorAttributeName: UIColor.red]
         let centerTextAttribute = NSAttributedString(string: "平均库龄", attributes: attributes)
         pieChartView.centerAttributedText = centerTextAttribute
         }
         */
        
        pieChartView.setNeedsDisplay()
    }



}


//pieChartData.setValueFormatter(DigitValueFormatter() //设置百分比
//转化为带%
class DigitValueFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let valueWithoutDecimalPart = String(format: "%.2f%%", value)
        return valueWithoutDecimalPart
    }
    

}

extension PieViewController: ChartViewDelegate {
    
    
    //MARK: -- ChartViewDelegate
    
    //点击空白地区
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    
    //点击饼状图上的事件
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let al = UIAlertController.init(title: nil, message: "点击的是：\(months[Int(highlight.x)])  值为： \(highlight.y)", preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "知道了", style: .cancel, handler: nil)
        al.addAction(cancel)
        self.present(al, animated: true, completion: nil)
    }

    
}















