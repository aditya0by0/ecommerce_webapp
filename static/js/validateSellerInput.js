// Toggle and validate the inputs of the sellers

var discountInput = document.getElementById('discount');
var offerPriceEle = document.getElementById('offer-price');

var quantityInput = document.getElementById('input-quantity');
var quantityEle = document.getElementById('display-quantity');

var offerForm = document.getElementById('offerForm');
var createOfferBtn = document.getElementById("co-button");
var editOfferBtn = document.getElementById("edit-button");
var fileInput = document.getElementById("fileInput");

var addQtyBtn = document.getElementById("addQtyBtn")

discountInput.addEventListener('input', validateInputPrice);
fileInput.addEventListener('change', validateInputPrice);
quantityInput.addEventListener('input', validateInputQuantity);
offerForm.addEventListener('submit', addOfferPrice2Form);

function validateInputPrice(e) {
  var inputValue = discountInput.value;
  var isFileUploaded = fileInput.files.length > 0;

  if (isNaN(inputValue) || inputValue < 1 || inputValue > 100) {
    discountInput.value = ''; 
  }

  inputVal = inputValue.trim()
  if (inputVal === '') {
    offerPriceEle.style.display = 'none';
  } else {
    offerPriceEle.style.display = 'block';
  }

  if (inputVal === '' || !isFileUploaded) {
    createOfferBtn.disabled = true;
  } else if(inputVal !== '' && isFileUploaded) {
    createOfferBtn.disabled = false;
  }

  var priceElement = document.querySelector('p[data-price]');
  var dataPrice = parseFloat(priceElement.getAttribute('data-price'));
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
