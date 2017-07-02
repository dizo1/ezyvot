$('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15, // Creates a dropdown of 15 years to control year
    format: 'dd-mm-yyyy' });
    

$(document).on('ready page:change', function() {
  Waves.displayEffect(); // Initialize buttons wave effects
 $(".button-collapse").sideNav(); // Initialize collapse button
});

function set_time_zone_offset() {
    var current_time = new Date();
    $.cookie('time_zone', current_time.getTimezoneOffset());
}
