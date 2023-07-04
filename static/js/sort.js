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
		
		if (sortBy == 'plh' || sortBy == 'phl'){
			// Sort by the price of the product
			const priceA = parseFloat(a.querySelector(".labelPrice").getAttribute('data-price'));
			const priceB = parseFloat(b.querySelector(".labelPrice").getAttribute('data-price'));
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
			return dateB - dateA;

 		}else if (sortBy == 'discount') {
 			// Sory by discount - High Discount at the Top
 			const priceA = parseInt(a.querySelector(".labelDiscount").getAttribute('data-discount'));
			const priceB = parseInt(b.querySelector(".labelDiscount").getAttribute('data-discount'));
			return priceB - priceA;
 		}
	});

	document.querySelector(".proGrid").append(...sortedItems);
}


