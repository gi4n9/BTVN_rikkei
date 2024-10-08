function timSoNhoNhat(arr){
    let soDuong = [];
    for (let i = 0; i < arr.length; i++){
        if(arr[i] > 0){
            soDuong.push(arr[i]);
        }
    }
    console.log(soDuong);

    let j = 1;
    while(true){
        let check = false;
        for (let i = 0; i < soDuong.length; i++){
            if(j === soDuong[i]){
                check = true;
                break;
            }
        }
        if(!check){
            return j;
        } else {
            j++;
        }

    }
}

let arr = [1, 2, 5, 7, -9, -1];
console.log(timSoNhoNhat(arr));  