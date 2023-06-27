var inputEle = document.getElementById("idInputTxt");
var sendBtn = document.getElementById("sendBtn");

inputEle.addEventListener('input', validateInput);
sendBtn.addEventListener('click', validateInput);

function validateInput(){
    var inputValue = inputEle.value;
    if (inputValue.trim() === ''){  
      sendBtn.disabled = true;
    }else {
      sendBtn.disabled = false;
  }
}