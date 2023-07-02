var quantityInput = document.getElementById('input-quantity');
var maxQuantity = parseInt(document.querySelector('.quantity')
						  		   .getAttribute("data-quantity"));

var buyBtn = document.getElementById("buyBtn");
var a2cBtn = document.getElementById("a2cBtn");
var chatBtn = document.getElementById("chatBtn");

var validationError = document.getElementById('validationError');

quantityInput.addEventListener('input', validateInputQuantity);

// Validate Input Quantity
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
}

// Enable Chat with Seller button if user is signed in
function get_user_signed_var(userSigned){
  if (userSigned){
    chatBtn.disabled = false;
  }else{
    chatBtn.disabled = true;
  }
}



