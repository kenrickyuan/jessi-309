let n = 4

const addNewButton = () => {
  console.log(n)
  const question = `<label for='${n}'>Option${n}</label>` +
    `<input name="choices[]" type="text" id="${n}"/>`;
  n += 1
  const formElement = document.getElementById("choices");

  formElement.insertAdjacentHTML('beforeend', question);
}

const initMultipleChoices = () => {


  const addChoiceBtn = document.querySelector('.add-choice-btn');

  addChoiceBtn.addEventListener('click', addNewButton);
}

export default initMultipleChoices;

