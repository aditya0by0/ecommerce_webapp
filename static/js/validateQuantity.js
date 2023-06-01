var quantityInput = document.getElementById('input-quantity');
var maxQuantity = parseInt(document.querySelector('.quantity')
						  		   .getAttribute("data-quantity"));

var buyBtn = document.getElementById("buyBtn");
var a2cBtn = document.getElementById("a2cBtn");

var validationError = document.getElementById('validationError');

quantityInput.addEventListener('input', validateInputQuantity);


function validateInputQuantity(e) {
  var inputValue = e.target.value;

  if (inputValue.trim() == '' ) {
    buyBtn.disabled = true;
    a2cBtn.disabled = true;
  } else {
  	if (inputValue > maxQuantity || inputValue <= 0) {
  		validationError.style.display = 'inline';
  	}else{
	    buyBtn.disabled = false;
	    a2cBtn.disabled = false;
	    validationError.style.display = 'none';
  	}
  }

  // if (inputValue > 10) {
  //   validationError.style.display = 'block';
  // } else {
  //   validationError.style.display = 'none';
  // }

  
}