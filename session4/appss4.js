// let todoList = [
//     "Wake up early at 7am",
//     "Go to work at 8am",
//     "Eat 3 meals per day",
// ];

// function displayToDo(){
//     for (let index in todoList){
//         console.log(`${+index + 1}: ${todoList[index]}`)
//     }
// }

// let loop = true;
// while(loop){
//     let n = prompt("Nhập vào từ khóa(C/R/U/D/E): ").toUpperCase();
//     if (n === "C"){
//         let j = prompt("Nhập todo mới bạn muốn thêm vào danh sách: ");
//         todoList.push(j);
//         displayToDo();
//     } else if (n === "R"){
//         displayToDo();
//     } else if (n === "U"){
//         let a = +prompt("Nhập vị trí todo muốn cập nhật nội dung: ");
//         let b = prompt("Nhập nội dung mới bạn muốn thay thế tại vị trí đó:");
//         todoList[a - 1] = b; 
//         displayToDo();
//     } else if (n === "D"){
//         let e = +prompt("Nhập vị trí todo muốn xóa:");
//         todoList.splice(e + 1, 1);
//         displayToDo();
//     } else if (n === "E") {
//         console.log("Good day!");
//         loop = false;
//     }
// }

// Mô phỏng lại chương trình rút tiền ATM

// fakeATM("100k", "12345", "ACB");

// fakeATM("200k", "145", "VPBank");

// fakeATM("500k", "9678", "MBbank");

// function fakeATM(amount, pin, bank){
//     console.log("So sánh mã pin với CSDL", pin);
//     console.log(`Kiểm tra xem còn vao nhiêu tờ: ${amount}`);
//     console.log(`Kiểm tra xem ATM có hỗ trợ thẻ ${bank} hay không ?`);
//     return amount*100;
// }

let arr = [1,4,6,1,2,7,9,3,12];
let n = +prompt("Nhập vào một số nguyên bất kì: ");

function isEqual(arr, int){
    let finalArr = [];
    for (let i = 0; i < arr.length; i++){
        for (let j = i + 1; j < arr.length; j++){
            if (arr[i] + arr[j] === int){
                finalArr.push(arr[i], arr[j]);
            }
        }
        return finalArr;
    }
}

console.log(isEqual(arr, n));

    