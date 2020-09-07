
import Foundation

/**冒泡排序
 比较相邻元素，a>b，就把a通过交换位置往后挪
 时间：O(n²)
 空间：O(1)
 */
func bubbleSort(_ array: inout [Int]) {
    if array.isEmpty { return }
    let count = array.count
    for i in 0..<count {
        //内部这些遍历，相当于每次选出一个最值扔到一头去
        for j in 0..<(count - 1 - i) {
            if array[j] > array[j + 1] {
                print(array)//打印
                //交换方法1
//                let temp = arr[j]
//                arr[j] = arr[j + 1]
//                arr[j + 1] = temp
            
                //交换方法2
//                (arr[j], arr[j + 1]) = (arr[j + 1], arr[j])
                
                //交换方法3
                array.swapAt(j, j + 1)
            }
        }
    }
}

print("冒泡排序:")
var arr = [12,6,5,3,2,100,10]
bubbleSort(&arr)



/**插入排序
 取出无序数列中第一个值，插入到有序数列中相应的位置。插入过程也是不断比较和交换的过程。
 时间：O(n²)
 空间：O(1)
 */
func insertionSort(_ array: inout [Int]) {
    if array.isEmpty { return }
    let count = array.count
    for i in 1..<count {
        var preIndex = i - 1
        let currentValue = array[i]
        while preIndex >= 0 && currentValue < array[preIndex] {
            print(array)//打印
            array.swapAt(preIndex + 1, preIndex)
            preIndex -= 1
        }
        array[preIndex + 1] = currentValue
        print(array)//打印
    }
}

print("插入排序:")
var arr2 = [12,6,5,3,2,100,10]
insertionSort(&arr2)




/**选择排序
 不断从无序序列中选择最小的值放入到有序序列的最后的位置；
 从现有的无序序列中找出那个最小的值，然后与无序序列的第一个值进行交换，然后缩小无序序列的范围即可；
 时间：O(n²)
 空间：O(1)
 */
func selectionSort(_ array: inout [Int]) {
    if array.isEmpty { return }
    let count = array.count
    for i in 0..<count {
        var minIndex = i
        for j in (i+1)..<count {
            if array[j] < array[minIndex] {
                minIndex = j
            }
        }
        print(array)//打印
        array.swapAt(i, minIndex)
    }
}

print("选择排序:")
var arr1 = [12,6,5,3,2,100,10]
selectionSort(&arr1)

