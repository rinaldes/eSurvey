var DraggablePortlet = function () {

  return {
    //main function to initiate the module
    init: function (url) {

      if (!jQuery().sortable) {
        return;
      }

      $(".draggable-wrapper").sortable({
        connectWith: ".draggable",
        items: ".draggable",
        opacity: 0.8,
        coneHelperSize: true,
        placeholder: 'sortable-box-placeholder round-all',
        forcePlaceholderSize: true,
        tolerance: "pointer",
        update: function(event, ui) {
          $.ajax({
            type:'POST',
            url: url,
            data:{
              str_id: ui.item.attr("id"),
              index: ui.item.index() + 1
            },
            success:function(data){}
          });
        }
      });

      $(".draggable").disableSelection();

    }

  };

}();