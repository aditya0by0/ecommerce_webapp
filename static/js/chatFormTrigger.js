// Submits a form when message has been sent for chating
function submitForm(pid, uid, uname=null) {
  var form = document.createElement('form');
  form.method = 'POST';
  form.action = '/chat/sellerChatPage';

  var pidInput = document.createElement('input');
  pidInput.type = 'hidden';
  pidInput.name = 'pid';
  pidInput.value = pid;

  var uidInput = document.createElement('input');
  uidInput.type = 'hidden';
  uidInput.name = 'uid';
  uidInput.value = uid;

  var unameInput = document.createElement('input');
  unameInput.type = 'hidden';
  unameInput.name = 'username';
  unameInput.value = uname;

  form.appendChild(pidInput);
  form.appendChild(uidInput);
  form.appendChild(unameInput);

  document.body.appendChild(form);
  form.submit();
}