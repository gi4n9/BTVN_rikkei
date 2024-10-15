let str = "hello";

let input = prompt("Nhập vào 1 chuỗi ký tự:");

function isCreated(str, input){
    let arr = [false, false, false];
    for (let i = 0; i < str.length; i++){
        for (let j = 0; j < input.length; j++){
            if(str[i] === input[j]){
                arr[j] = true;
            }
        }
    }
}

console.log(isCreated(str, input));