// Autofill username based on email address during SignUp
const emailEle = document.getElementById("floatingEmail")
emailEle.addEventListener('input', function(){
	let user = emailEle.value.split('@')[0]
	document.getElementById('floatingUsername').value = user
})