
import Foundation

/** 快速排序的灵魂
 当一个问题可以被分成一些相同的子问题时，我们就可以使用递归来操作；
 快排就是通过递归的方式将问题规模逐渐减小；
 */


/**
 快速排序
 通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行。
 时间：O(n²)
 空间：O(logn)
 */
func quickSort(_ array: inout [Int]) {
    func quickSort(left:Int, right:Int) {
        guard left < right else { return }
        var i = left + 1, j = left
        let key = array[left]
        while i <= right {
            if array[i] < key {
                j += 1
                array.swapAt(i, j)
            }
            i += 1
        }
        array.swapAt(left, j)
        
        quickSort(left: j + 1, right: right)
        quickSort(left: left, right: j - 1)
    }
    quickSort(left: 0, right: array.count - 1)
}


print("快速排序:")
var arr = [12,6,5,3,2,100,10]
quickSort(&arr)


/**
 随机快排
 */
func quickSort1(_ array: inout [Int]) {
    func quickSort(left:Int, right:Int) {
        guard left < right else { return }
        let randomIndex = Int.random(in: left...right)
        array.swapAt(left, randomIndex)
        var i = left + 1,j = left
        let key = array[left]
        while i <= right {
            if array[i] < key {
                j += 1
                array.swapAt(i, j)
            }
            i += 1
        }
        array.swapAt(left, j)
        quickSort(left: j + 1, right: right)
        quickSort(left: left, right: j - 1)
    }
    quickSort(left: 0, right: array.count - 1)
}

print("随机快排:")
var arr1 = [12,6,5,3,2,100,10]
quickSort1(&arr1)


/**
 双路快排
 */
func quickSort2(_ array: inout [Int]) {
    func quickSort(left:Int, right:Int) {
        guard left < right else { return }
        let randomIndex = Int.random(in: left...right)
        array.swapAt(left, randomIndex)
        var l = left + 1, r = right
        let key = array[left]
        while true {
            while l <= r && array[l] < key {
                l += 1
            }
            while l < r && key < array[r]{
                r -= 1
            }
            if l > r { break }
            array.swapAt(l, r)
            l += 1
            r -= 1
        }
        array.swapAt(r, left)
        quickSort(left: r + 1, right: right)
        quickSort(left: left, right: r - 1)
    }
    quickSort(left: 0, right: array.count - 1)
}

print("双路快排:")
var arr2 = [12,6,5,3,2,100,10]
quickSort2(&arr2)


/**
 三路快排
 */
func quickSort3(_ array: inout [Int]) {
    func quickSort(left:Int, right:Int) {
        guard left < right else { return }
        let randomIndex = Int.random(in: left...right)
        array.swapAt(left, randomIndex)
        var lt = left, gt = right
        var i = left + 1
        let key = array[left]
        while i <= gt {
            if array[i] == key {
                i += 1
            }else if array[i] < key{
                array.swapAt(i, lt + 1)
                lt += 1
                i += 1
            }else {
                array.swapAt(i, gt)
                gt -= 1
            }
        }
        array.swapAt(left, lt)
        quickSort(left: gt + 1, right: right)
        quickSort(left: left, right: lt - 1)
    }
    quickSort(left: 0, right: array.count - 1)
}

print("三路快排:")
var arr3 = [12,6,5,3,2,100,10]
quickSort3(&arr3)



