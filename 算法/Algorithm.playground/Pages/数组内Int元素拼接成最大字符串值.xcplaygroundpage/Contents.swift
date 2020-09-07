/**
 给定一组非负整数，重新排列它们的顺序使之组成一个最大的整数，输出结果可能非常大，所以你需要返回一个字符串；

 示例 1:
 输入: [10,2]
 输出: 210
 
 示例 2:
 输入: [3,30,34,5,9]
 输出: 9534330
 */

func largestNumber(_ nums:[Int]) -> String {
//    let sort = arr.map{"\($0)"}.sorted(){(lStr, rStr)  -> Bool in
//        return lStr + rStr > rStr + lStr
//    }

    let sort = nums.map{"\($0)"}.sorted(by: {$0 + $1 > $1 + $0})
    let result: String = sort.joined()
    if result.prefix(1) == "0" {
        return "0"
    }
    return result
}

let arr = [3,30,34,5,9]

largestNumber(arr)
