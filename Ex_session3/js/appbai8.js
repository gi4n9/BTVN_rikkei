function timPhanTuDocNhat(arr){
    for (let i = 0; i < arr.length; i++){
        for (let j = i + 1; j < arr.length; j++){
            if (arr[j] === arr[i]){
            } else {
                return arr[j];
            }
        }
    }
}

let arr = [1,2,3,1,2,3,4,5,5,6];
console.log(timPhanTuDocNhat(arr));