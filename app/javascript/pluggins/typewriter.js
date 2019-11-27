

import Typewriter from 'typewriter-effect/dist/core';


const TypeWriter = () => {

  var el = document.getElementById('typewriter');
  if (el == null) return;

  var typewriter = new Typewriter(el, { loop: true });

  typewriter.typeString('organizes')
      .pauseFor(2500)
      .deleteAll()
      .typeString('tracks')
      .pauseFor(2500)
      .deleteAll()
      .typeString('takes care of')
      .pauseFor(7000)
      .start();
}

export default TypeWriter;
