let g = 4

const addaNewButton = () => {
  console.log(g)
  const guest = `<label for='${g}'>Guest ${g}</label>` +
    `<input name="guests[]" type="text" id="guest${g}"/>`;
  g += 1
  const guestForm = document.getElementById("guests");

  guestForm.insertAdjacentHTML('beforeend', guest);
}

const initMultipleGuests = () => {
  const addGuestBtn = document.querySelector('.add-guest-btn');
  if (addGuestBtn == null) return;
  addGuestBtn.addEventListener('click', addaNewButton);
}

export default initMultipleGuests;
