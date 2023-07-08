// Enable submit rating button only after radio button is clicked

const radioButtons = document.querySelectorAll('input[name="rating"]');
const submitButton = document.getElementById('submit-rating');

// Add click event listener to each radio button
radioButtons.forEach(function(radioButton) {
  radioButton.addEventListener('click', function() {
    // Enable the submit button when a radio button is clicked
    submitButton.disabled = false;
  });
});
