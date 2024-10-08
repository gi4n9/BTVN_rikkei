function sapXepMangSoNguyen(arr){
    let arrLeft =[];
    let arrRight = [];
    for(let i = 0; i < arr.length; i++){
        if(arr[i] % 2 === 0){
            arrLeft.push(arr[i]);
        } else {
            arrRight.push(arr[i]);
        }
    }
    arrLeft.sort(function(a,b){
        return a - b;
    });
    console.log("Sau khi sap xep(trai):", arrLeft);
    console.log("Sau khi sap xep(phai)", arrRight);
    for(let i = 0; i < arrRight.length; i++){
        arrLeft.push(arrRight[i]);
    }
    return arrLeft;
}

let arr = [1, 3, 2, 3, 6, 7, 10, 8, 9];
console.log(sapXepMangSoNguyen(arr))
