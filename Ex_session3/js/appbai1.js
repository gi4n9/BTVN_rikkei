let n = +prompt("Nhập số bất kì để tìm tổng: ");

let arr1 = [5, 6, 3, 7, 9];

//mảng con 1 phần tử
// for (let i = 0; i <= arr1.length - 1; i++){
//     let subArr = [];
//     // subArr.push(arr1[i]);
//     for (let j = i; j < i + 1; j++){
//         subArr.push(arr1[j]);
//     }
//     console.log(subArr);
// }

//mảng con 2 phần tử
// for (let i = 0; i <= arr1.length - 2; i++){
//     let subArr = [];
//     for (let j = i; j < i + 2; j++){
//         subArr.push(arr1[j]);
//     }
//     // subArr.push(arr1[i]);
//     // subArr.push(arr1[i+1]);
//     console.log(subArr);
// }

//
for (let k = 1; k <= arr1.length - 1; k++){
    for(let i = 0; i <= arr1.length - k; i++){
        let subArr = [];
        for (let j = i; j < i + k; j++){
            subArr.push(arr1[j]);
        }
        let total = 0;
        for (let index in subArr) {
            total = total + subArr[index];
        }
        if (total === n){
            console.log(subArr);
        }
    }
}
