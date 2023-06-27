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
			const priceA = parseFloat(a.querySelector(".labelPrice").getAttribute('data-price'));
			const priceB = parseFloat(b.querySelector(".labelPrice").getAttribute('data-price'));
			switch (sortBy) {
				case 'plh':
					return priceA - priceB
					break;
				case 'phl':
					return priceB - priceA
					break;
			}
		}else if (sortBy =='nwa') {
				const dateA = parseFloat(a.querySelector(".labelDate").getAttribute('data-date'));
				const dateB = parseFloat(b.querySelector(".labelDate").getAttribute('data-date'));
				return dateB - dateA;

 		}
 		// else if (condition) {
 			
 		// }
	});

	document.querySelector(".proGrid").append(...sortedItems);
}


