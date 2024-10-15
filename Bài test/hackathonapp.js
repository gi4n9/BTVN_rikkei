let string = "program";
let n = string.length;

let arr = "";
console.log("TEST")
for (let i = n - 1; i > 0; i--){
    arr += string[i];
}

console.log(arr);