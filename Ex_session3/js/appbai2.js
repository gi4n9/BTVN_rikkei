let arr = [1, 1, 2, 2, 4, 5, 6, 5, 4, 5];

for (let i = 0; i < arr.length; i++){
    let newArr = [];
    for (let j = i + 1; j < arr.length; j++){
        if(arr[i] === arr[j]){
            newArr.push(arr[i]);
            console.log(newArr);
        }
    }
}