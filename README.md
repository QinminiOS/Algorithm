# Algorithm

给你一个嵌套的 NSArray 数据，实现一个迭代器类，该类提供一个 next() 方法，可以依次的取出这个 NSArray 中的数据。

比如 NSArray 如果是 [[1,2,3],4,5,[6,[7,8,[9,10,[[[[[11]]]]]]]],12,[13]]， 则最终应该输出：1, 4, 3, 6, 5, 1, 0 。