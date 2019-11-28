import Typewriter from 'typewriter-effect/dist/core';


const WelcomeTypeWriter = () => {

  var el = document.getElementById('text');
  if (el == null) return;

  var typewriter = new Typewriter(el, { loop: true });

  typewriter.typeString("Hey, I'm jessi.")
      .pauseFor(2500)
      .deleteAll()
      .typeString("Looks like you're new here!")
      .pauseFor(2500)
      .deleteAll()
      .typeString('We can start planning amazing experiences as soon as you create your first event!')
      .pauseFor(7000)
      .start();
}

export default WelcomeTypeWriter;
