import "bootstrap";
import $ from 'jquery';

// import "../plugins/easteregg";
// import "../plugins/datepicker"
// import "../plugins/choices";
// import "../plugins/guests";
// import "../plugins/typewriter";
// import "../plugins/sidebar";
// import "../plugins/sidebarclose";
import "../plugins/clipboard";


import iniDatePicker from "../plugins/datepicker";
import initMultipleChoices from "../plugins/choices";
import initMultipleGuests from "../plugins/guests";
import TypeWriter from "../plugins/typewriter";
import WelcomeTypeWriter from "../plugins/typewriter_welcome"
// import initSidebar from "../plugins/sidebar";
// import "../plugins/sidebarclose";


iniDatePicker();
initMultipleChoices();
initMultipleGuests();
console.log(new TypeWriter());
console.log(new WelcomeTypeWriter());
// initSidebar();
