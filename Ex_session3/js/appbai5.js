function timPhanTuChung(arr1, arr2, arr3){
    let arr = [];
    for (let i = 0; i < arr1.length; i++){
        for (let j = 0; j < arr2.length; j++){
            for(let k = 0; k < arr3.length; k++){
                if (arr1[i] === arr2[j] && arr2[j] === arr3[k]){
                    arr.push(arr1[i]);
                }
            }
        }
    }
    return arr;
}

let arr1 = [1,2,3,4,5,6];
let arr2 = [-3,-1,0,1,5,6];
let arr3 = [1,5,6,7];
console.log(timPhanTuChung(arr1, arr2, arr3));