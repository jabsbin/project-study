const btnJikwon = document.querySelector("#btnjikwon");
const btnOne = document.querySelector("#btnOne");
const btnBuser = document.querySelector("#btnBuser");
const btnBuserPart = document.querySelector("#btnBuserPart")

const jikwonno = document.querySelector("#jikwonno");
const buserno = document.querySelector("#buserno");

const msg = document.querySelector("#msg");
const thead = document.querySelector("#thead");
const tbody = document.querySelector("#tbody");

function setMsg(text){
    msg.textContent = text;
}

function clearTable(){
    thead.innerHTML = "";
    tbody.innerHTML = "";
}

function makeTable(rows){
    clearTable();
    
    if(!rows || rows.length === 0){
        setMsg("자료 없음");
        return;
    }

    let header = "<tr>";
    Object.keys(rows[0]).forEach(key => {
        header += "<th>" + key + "</th>";
    });
    header += "</tr>";
    thead.innerHTML = header;

    rows.forEach(r => {
        let tr = "<tr>";
        Object.values(r).forEach(v => {
            tr += "<td>" + v + "</td>";
        });
        tr += "</tr>";
        tbody.innerHTML += tr;
    });
}

// 전체 직원
async function loadJikwon(){
    const res = await fetch("/acorn/jikwon");
    const mydata = await res.json();
    makeTable(mydata.data);

    setMsg("전체 직원 조회 완료");
}

// 전체 1명
async function loadOne(){
    const no = jikwonno.value;
    // const res = await fetch("/acorn/jikwon/" + no);
    const res = await fetch("/acorn/jikwon/" + no,{
        method:"GET"
    });
    const mydataOne = await res.json();
    makeTable([mydataOne.data]);

    setMsg("직원 1명 조회 완료");
}

// 전체 부서
async function loadbuser(){
    const res = await fetch("/acorn/buser");
    const mydata = await res.json();
    makeTable(mydata.data);

    setMsg("전체 부서 조회 완료");
}

// 특정 부서 직원
async function loadbuserPart(){
    const num = buserno.value;
    // const res = await fetch("/acorn/buser/" + no);
    const res = await fetch("/acorn/buser/" + num,{
        method:"GET"
    });
    const mydata = await res.json();
    makeTable(mydata.data);

    setMsg("특정 부서 직원 조회 완료");
}

btnJikwon.onclick = loadJikwon;
btnOne.onclick = loadOne;
btnBuser.onclick = loadbuser;
btnBuserPart.onclick = loadbuserPart;
