import $ from 'jquery';

const loading = () => {
  // const $modal = $(".modal");
  const modal = document.getElementById("modal");

  $( document ).ajaxStart(function() {
    console.log('opaaaaaa');
  });

  if(modal) {
    $(document).on({
        ajaxStart: function() { 
          console.log('opaa');
          modal.addClass("loading");    },
        ajaxStop: function() { 
          console.log('opa');
          modal.removeClass("loading"); }    
    });
  }
}

export { loading };
