let students = [
    "Nguyễn Văn A",
    "Lê Văn B",
    "Trần Thị C"
];

let n = students.length

//1.READ

//Read one 
// console.log(`${students[0]} ơi alo alo`);

//Read all
// for ( let i = 0; i < n; i++){
//     console.log(students[i]);
// }

//cú pháp thay thế dùng để duyệt qua từng phần tử có trong mảng(theo chiều xuôi)

//for...of
// for (let student of students){
//     console.log(`student: ${student} is going to fail`);
// }

//for...in
// for (let index in students){
//     console.log(+index + 1, students[index])
// }

//2.CREATE(Thêm đầu, thêm cuối, thêm vào vị trí bất kì)

//.unshift(element)
// students.unshift("Trần Thị L");
// console.log(students);

//.push(element)
// students.push("Hà Viết H");
// console.log(students);

//.splice(element)-->thêm vào vị trí bất kì -------> .splice(index, number, new_element_1, new_element_2,.....)
// students.splice(1, 0, "Nguyễn Thị K", "Tang Minh G");
// console.log(students);

//3.UPDATE
//array[index] = new_value;
// students[1] = "Nguyễn Thị Ph";
// console.log(students);

//4.DELETE(Xóa đầu tiên, xoa cuối, xóa tại vị trí bất kì)

//.shift() ------------> Xoa dau
// students.shift(students[0]);
// console.log(students);

//.pop() --------------> Xoa cuoi
// students.pop(students[2]);
// console.log(students);

//.splice()
//.splice(index, number)------------> index: vi tri muon xoa, number: so phan tu muon xoa.
// students.splice(2,1);
// console.log(students);
