

import Typewriter from 'typewriter-effect/dist/core';


const TypeWriter = () => {

  var el = document.getElementById('typewriter');
  if (el == null) return;

  var typewriter = new Typewriter(el, { loop: true });

  typewriter.typeString('Plan')
      .pauseFor(2500)
      .deleteAll()
      .typeString('Organize')
      .pauseFor(2500)
      .deleteAll()
      .typeString('Track')
      .pauseFor(2500)
      .start();
}

export default TypeWriter;
