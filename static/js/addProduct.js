// If category is selected from dropdown then disable new category option
document.getElementById('category').addEventListener('change', function() {
  var newCategoryInput = document.getElementById('new-category');
  newCategoryInput.disabled = this.value !== '';
});

// Validate Form Inputs
function validateForm() {
  var productNameInput = document.getElementById('pname');
  var productName = productNameInput.value.trim();
  var pdescriptionInput = document.getElementById('pdescription');
  var pdescription = productNameInput.value.trim();

  if (productName === '') {
    alert('Please enter a valid product name.');
    return false; 
  }

  if (/^\s*$/.test(productName)) {
    alert('Product name cannot be just spaces.');
    return false; 
  }

  if (pdescription === '') {
    alert('Please enter a valid Product description ');
    return false;
  }

  if (/^\s*$/.test(pdescription)) {
    alert('Product description cannot be just spaces.');
    return false; 
  }

  return true;
}
