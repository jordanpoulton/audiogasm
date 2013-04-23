$(function() {
  $( ".date_input input" ).datepicker();
  $( "#format" ).change(function() {
      $( ".date_input input" ).datepicker( "option", "dateFormat", $( this ).val() );
    });
  });
});


