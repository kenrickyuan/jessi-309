import "bootstrap";
import $ from 'jquery';

import iniDatePicker from "../plugins/datepicker";
import initMultipleChoices from "../pluggins/choices";
import initMultipleGuests from "../pluggins/guests";
import TypeWriter from "../pluggins/typewriter";
// import initSidebar from "../pluggins/sidebar";
// import "../pluggins/sidebarclose";


iniDatePicker();
initMultipleChoices();
initMultipleGuests();
console.log(new TypeWriter());
// initSidebar();
