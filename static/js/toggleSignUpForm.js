// To display business address input only if 'Login/Signup as Seller' 
// checkbox is clicked 
function toggleInputRequired() {
  var sellerCheckbox = document.getElementById("seller");
  var addressInput = document.getElementById("divAddress");
  
  if (sellerCheckbox.checked) {
    addressInput.style.display = "block";
    addressInput.setAttribute("required", "");
  } else {
    addressInput.style.display = "none";
    addressInput.removeAttribute("required");
  }
}


// To enable the toggle functionality even when refreshed, redirected 
// or clicked on back button
window.addEventListener('load', function() {  
  toggleInputRequired();
});
