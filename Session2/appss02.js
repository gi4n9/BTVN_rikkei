
//bai1

//a
// let n = prompt("Nhập vào n: ");
// let i;let a = 0;
// for ( i = 0; i <= n ; i = i + 1){
//     console.log(i);
//     a = a + i;
// }

// console.log("Kết quả bài 1(a): ", a);

//b
// let n = prompt("Nhập vào n: ");
// let i;let a = 0;
// for ( i = 0; i <= n ; i = i + 1){
//     console.log(i);
//     a += i*i;
// }
// console.log("Kết quả bài 1(b): ", a);

//c
// let n = prompt("Nhập vào n: ");
// let i;let a = 1;
// for ( i = 1; i <= n; i = i + 1){
//     console.log(i);
//     a += 1/((n-1)*n);
// }
// console.log("Kết quả bài 1(c): ", a);

//bai2
//a
// let n = prompt("Nhập vào n: ");
// let i;let a = 0;
// for ( i = 1; i <= n; i = i + 1){
//     console.log(i);
// }
// console.log("Kết quả bài 2(a) ");

//b
// let n = prompt("Nhập vào n: ");
// let i;let a = 0;
// for ( i = 1; i <= n; i = i + 1){
//     if( i % 3 == 0 && i % 5 == 0){
//         console.log("FizzBuzz");
//     } else if ( i % 5 == 0 ) {
//         console.log("Buzz");
//     } else if ( i % 3 == 0 ) { 
//         console.log("Fizz");
//     } else {
//         console.log(i);
//     }
// }
// console.log("Kết quả bài 2(b) ");

//bai3
// let sum = 0;
// let n = 30;
// for (let i = 1; i <= n; i++){
//     sum = sum + i*5;
// }
// console.log(sum);

// let a = 1;
// let b = 1;
// let c =  


let result = 50;
let loop = true;
while(loop == true){
    let i = prompt("Nhập vào số: ");
    if ( i > result){
        console.log("Too big");
    } else if ( i < result ){
        console.log("too small");
    } else { 
        console.log("bingo")
        // loop = false;
        break;
    }
}

