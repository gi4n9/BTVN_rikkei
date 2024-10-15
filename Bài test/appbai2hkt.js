// let string = "this is A Test";
// let lowerCase = string.toLowerCase();

// console.log(lowerCase);

// let newString = lowerCase.split(" ");
// console.log(newString);

// let arr = "";


// console.log(arr);

// let arr = ["one", "two", "three", "one", "one", "four", "five", "four", "five", "five"];

// function XoaPhanTuTrung(arr){
//     for(let i = 0; i < arr.length; i++){
//         for( let j = 1; j < arr.length; j++){
//             if(arr[j] === arr[i]){
//                 return arr.splice(j, 1);
//             }
//         }
//     }    
// }

// console.log(XoaPhanTuTrung(arr));

// let arr = [1, 4, 2, 3, 5];

// for (let i = 0; i < arr.length; i++){
//     let minIndex = 0;
//     for(let j = 1; j < arr.length; j++){
//         if (arr[j] > arr[minIndex]){
//         minIndex = j;
//         } else {
//             let x = arr[j];
//             arr[j] = arr[minIndex];
//             arr[minIndex] = x;
//         }
//     }
// }

// console.log(arr);


// let arr = ["Nguyễn Văn A", "Trần Thị B", "Lê Văn C"];

// let loop = true; 
// while(loop){
//     let n = prompt("Nhập vào C/R/U/D hoặc E để thoát: ");
//     if(n === "C"){
//         let j = prompt("Nhập tên nhân viên mới bạn muốn thêm vào danh sách: ");
//         arr.push(j);
//         console.log(arr);
//     } else if (n === "R"){
//         console.log(arr);
//     } else if (n === "U"){
//         let a = +prompt("Nhập vị trí nhân viên bạn muốn thay đổi: ");
//         let b = prompt("Nhập nội dung mới bạn muốn thay thế tại vị trí đó:");
//         arr[a - 1] = b;
//         console.log(arr);
//     } else if (n === "D"){
//         let c = +promt("Nhập vị trí tên nhân viên muốn xóa:");
//         arr.splice(c + 1, 1);
//         console.log(arr);
//     } else if (n === "E"){
//         loop = false;
//     }
// }


let n = prompt("Nhập vào ngày tháng năm(dd/mm/yyyy): ");
console.log(n);
let result = n.split("/");


if (result[1] === "01" || result[1] === "03" || result[1] === "05" || result[1] === "07" || result[1] === "08" || result[1] === "10" || result[1] === "12" && result[0] > "31" || result[0] < "01"){
    alert("Nhập sai định dạng, xin vui lòng nhập lại");
} else if (result[1] === "02" && result[0] > "29" || result[0] < "01" && result[2] % 4 === 0){
    alert("Nhập sai định dạng, xin vui lòng nhập lại");
} else if (result[1] === "04" || result[1] === "06" || result[1] === "09" || result[1] === "11" && result[0] > "30" || result[0] < "1"){
    alert("Nhập sai định dạng, xin vui lòng nhập lại");
} else if (result[0] < "01" && result[0] > "31"){
    alert("Nhập sai định dạng, xin vui lòng nhập lại");
}



