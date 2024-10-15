function sliceMang(str){
    let arr = [];
    for (let i = 0; i < str.length; i++){
        for (let j = i + 1; j <= str.length; j++){
            arr.push(str.slice(i,j));
        }
    }
    return arr;
}

let input = "abcd";
let result = sliceMang(input);
console.log(result);