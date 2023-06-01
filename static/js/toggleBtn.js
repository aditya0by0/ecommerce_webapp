// Add click event to each button, the event sets current button as active 
// and removes active class from the rest of the buttons

var allCategoryBtns = document.querySelectorAll(".category-button");

allCategoryBtns.forEach(function(button) {
  button.addEventListener('click', function() {
    
    allCategoryBtns.forEach(function(btn) {
      btn.classList.remove('active');
    });
    window.location.href = "/category/" + this.getAttribute('data-category');
    this.classList.add('active');
  });

});

// Remembers the clicked button and makes it active between routes
var selectedCatg = document.querySelector('.curr-cat').getAttribute('data-currCat');
var selectedButton = document.querySelector('.category-button[data-category="' + selectedCatg + '"]');
if (selectedButton) {
  selectedButton.classList.add('active');
}