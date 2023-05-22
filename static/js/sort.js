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
			const priceA = parseInt(a.querySelector(".labelPrice").getAttribute('data-price'));
			const priceB = parseInt(b.querySelector(".labelPrice").getAttribute('data-price'));
			switch (sortBy) {
				case 'plh':
					return priceA - priceB
					break;
				case 'phl':
					return priceB - priceA
					break;
			}

 		}
 		// else if (condition) {
 			
 		// }
	});

	document.querySelector(".proGrid").append(...sortedItems);
}


