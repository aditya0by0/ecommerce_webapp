// Toggle and validate the inputs of the sellers

var discountInput = document.getElementById('discount');
var offerPriceEle = document.getElementById('offer-price');

var quantityInput = document.getElementById('input-quantity');
var quantityEle = document.getElementById('display-quantity');

var offerForm = document.getElementById('offerForm');
var createOfferBtn = document.getElementById("co-button");

var addQtyBtn = document.getElementById("addQtyBtn")

discountInput.addEventListener('input', validateInputPrice);
quantityInput.addEventListener('input', validateInputQuantity);
offerForm.addEventListener('submit', addOfferPrice2Form);

function validateInputPrice(e) {
  var inputValue = e.target.value;

  if (isNaN(inputValue) || inputValue < 1 || inputValue > 100) {
    e.target.value = ''; 
  }

  if (inputValue.trim() === '') {
    offerPriceEle.style.display = 'none';
    createOfferBtn.disabled = true;
  } else {
    offerPriceEle.style.display = 'block';
    createOfferBtn.disabled = false;
  }

  var priceElement = document.querySelector('p[data-price]');
  var dataPrice = parseInt(priceElement.getAttribute('data-price'));
  var offerPrice = dataPrice - ((dataPrice * inputValue) / 100);
  document.getElementById("offerPriceInt").innerText =  offerPrice;
}

function validateInputQuantity(e) {
  var inputValue = e.target.value;

  quantityEle.value += inputValue;

  if (inputValue.trim() === '') {
    quantityEle.style.display = 'none';
    addQtyBtn.disabled = true;
  } else {
    quantityEle.style.display = 'block';
    addQtyBtn.disabled = false;
  }

  var qtyElement = document.querySelector('p[data-quantity]');
  var dataQty = parseInt(qtyElement.getAttribute('data-quantity'));
  var newQty = dataQty + parseInt(inputValue);
  document.getElementById("new-quantity-val").innerText =  newQty;
}

function addOfferPrice2Form(e){
  e.preventDefault(); 

  offerPrice = document.getElementById("offerPriceInt").innerText;
  document.getElementById('idOfferPrice').value = offerPrice;

  this.submit();
}
