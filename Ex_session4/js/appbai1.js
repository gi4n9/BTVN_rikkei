let arr = [1,4,6,1,2,7,9,3,12];
let n = +prompt("Nhập vào một số nguyên bất kì: ");

function isEqual(arr, int){
    for (let i = 0; i < arr.length; i++){
        for (let j = i + 1; j < arr.length; j++){
            if (arr[i] + arr[j] === int){
                return [arr[i], arr[j]];
            }
        }
    }
}

console.log(isEqual(arr, n));