// Sorting for the Products based on given criteria

// Event Delegation
document.querySelector('.sort-list').addEventListener('click', function(e){
	const target = e.target
	if (target.matches('li')) {
		sort(target.getAttribute('id'))
	}	
})

// To sort by products by given criteria
function sort(sortBy){
	const gridItems = document.querySelectorAll(".proCard");
	const sortedItems = Array.from(gridItems).sort(function(a,b){
		
		const isPremiumSellerA = a.querySelector(".isPremiumSeller") !== null;
    const isPremiumSellerB = b.querySelector(".isPremiumSeller") !== null;

		if (sortBy == 'plh' || sortBy == 'phl'){
			// Sort by the price of the product based on given criteria
			const priceA = parseFloat(a.querySelector(".labelPrice").getAttribute('data-price'));
			const priceB = parseFloat(b.querySelector(".labelPrice").getAttribute('data-price'));
			
			if (priceA === priceB) {
        // Sort by premium seller if prices are the same
        if (isPremiumSellerA && !isPremiumSellerB) {
            return -1; // Move product A up
        } else if (!isPremiumSellerA && isPremiumSellerB) {
            return 1; // Move product B up
        }
      }	

			switch (sortBy) {
				case 'plh': // Price Low to High
					return priceA - priceB
					break;
				case 'phl': // Price High to Low
					return priceB - priceA
					break;
			}

		}else if (sortBy =='nwa') {
			// Sort by the date - new products at the top
			const dateA = parseFloat(a.querySelector(".labelDate").getAttribute('data-date'));
			const dateB = parseFloat(b.querySelector(".labelDate").getAttribute('data-date'));
			
			if (dateA === dateB) {
        // Sort by premium seller if dates are the same
        if (isPremiumSellerA && !isPremiumSellerB) {
            return -1; // Move product A up
        } else if (!isPremiumSellerA && isPremiumSellerB) {
            return 1; // Move product B up
        }
      }

			return dateB - dateA;

 		}else if (sortBy == 'discount') {	
 			// Sory by discount - High Discount at the Top
 			const discountA = parseInt(a.querySelector(".labelDiscount").getAttribute('data-discount'));
			const discountB = parseInt(b.querySelector(".labelDiscount").getAttribute('data-discount'));
			
			if (discountA === discountB) {
        // Sort by premium seller if prices are the same
        if (isPremiumSellerA && !isPremiumSellerB) {
          return -1; // Move product A up
        } else if (!isPremiumSellerA && isPremiumSellerB) {
          return 1; // Move product B up
        }
      }

			return discountB - discountA;
 		}
	});

	document.querySelector(".proGrid").append(...sortedItems);
}

// Function to be called when the page is loaded
function onPageLoad() {
    // Sort by "discount" as the default sort
    sort("discount");
}

// Event listener for the page load event
window.addEventListener("load", onPageLoad);


