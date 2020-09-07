
import Foundation

/**
 堆可视为  “以数组方式存储的一棵完全二叉树”

 堆又分为最大堆和最小堆， 最大堆就是对于整个二叉树中的每一个节点都满足：节点的键值比其左右子节点的键值都要大，对应的最小堆则是：节点的键值比其左右子节点的键值都要小
 
 对于一个存储最大堆的数组arr（长度为size）， 根节点arr[0]是所有节点中键值最大，将arr[0]和arr[size-1]的值交换，然后将除去arr[size-1]后的size-1个节点作为一个独立的二叉树，但是此时的这课新的树由于前面交换arr[0]和arr[size-1]的原因需要重新调整为堆。

 堆排序就是不断交换和调整的过程。所以我们先要解决两个问题:
 1.如何调整为最大堆（或者最小堆）
 2.如何由一个无序的输入数组生成一个堆

 */

func HeapSort(_ arr:inout Array<Int>) {
    //1.构建大顶堆
    for i in (0...(arr.count/2-1)).reversed(){
        //从第一个非叶子结点从下至上，从右至左调整结构
        adjustHeap(arr: &arr, i: i, length: arr.count)
    }
    //2.调整堆结构+交换堆顶元素与末尾元素
    for j in  (1...(arr.count-1)).reversed(){
        arr.swapAt(0, j)//将堆顶元素与末尾元素进行交换
        adjustHeap(arr: &arr, i: 0, length: j)//重新对堆进行调整
    }
}

/**
 * 调整大顶堆（仅是调整过程，建立在大顶堆已构建的基础上）
 */
func adjustHeap(arr:inout Array<Int>,i:Int,length:Int){
    var i = i;
    let temp = arr[i];//先取出当前元素i
    var k=2*i+1
    while k<length {//从i结点的左子结点开始，也就是2i+1处开始
        if(k+1<length && arr[k]<arr[k+1]){//如果左子结点小于右子结点，k指向右子结点
            k+=1;
        }
        if(arr[k] > temp){//如果子节点大于父节点，将子节点值赋给父节点（不用进行交换）
            arr[i] = arr[k];
            i = k;
        }else{
            break;
        }
        k=k*2+1
    }
    arr[i] = temp;//将temp值放到最终的位置
}

var arr = [12,6,5,3,2,100,10]
HeapSort(&arr)


/**
 归并排序
 
 首先我们将需要排序的序列进行拆分，拆分成足够小的数组。也就是拆分的数组中只有一个元素。无序数组拆分的所有数组因为其中只含有一个元素，所以都是有序的。我们就可以对这些有序的小数组进行合并了。
 将拆分的多个有序数组调用第一部分实现的mergeArray()函数进行两两合并，合并后的新数组仍然是有序的。我们再次对这些合并产生的数组进行两两合并，直到所有被拆分的数组有重新被合并成一个大数组位置。这个重新合并生成的数组就是有序的，也就是归并排序所产生的有序序列。
 
 */

func mergeSort(_ array: [Int]) -> [Int] {
    return mergeSortPrivate(array)
}

private func mergeSortPrivate(_ array: [Int]) -> [Int] {
    if array.count <= 1 {return array}
    
    let tmpArr = array
    let count = array.count
    let middle = (count - 1) / 2

    let leftArr = mergeSortPrivate(Array(tmpArr[0...middle]))
    let rightArr = mergeSortPrivate(Array(tmpArr[middle+1...count-1]))
    return merge(leftArr, rightArr)
}

private func merge(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
    var tmpArr = [Int]()
    var j = 0;
    var k = 0;
    while j < arr1.count && k < arr2.count {
        if arr1[j] <= arr2[k] {
            tmpArr.append(arr1[j])
            j += 1
        } else {
            tmpArr.append(arr2[k])
            k += 1
        }
    }
    
    if j == arr1.count {
        tmpArr += arr2[k..<arr2.count]
    } else {
        tmpArr += arr1[j..<arr1.count]
    }
    
    return tmpArr
}

var arr1 = [12,6,5,3,2,100,10]
mergeSort(arr1)

