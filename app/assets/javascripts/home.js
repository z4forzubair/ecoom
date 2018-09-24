$('[data-toggle="collapse"]').on('click', function() {
    var $this = $(this),
            $parent = typeof $this.data('parent')!== 'undefined' ? $($this.data('parent')) : undefined;
    if($parent === undefined) { /* Just toggle my  */
        $this.find('.glyphicon').toggleClass('glyphicon-plus glyphicon-minus');
        return true;
    }

    /* Open element will be close if parent !== undefined */
    var currentIcon = $this.find('.glyphicon');
    currentIcon.toggleClass('glyphicon-plus glyphicon-minus');
    $parent.find('.glyphicon').not(currentIcon).removeClass('glyphicon-minus').addClass('glyphicon-plus');

});

function toggle_rev_div(id, btnid){
  hide_show_div(id);
  hide_show_div(btnid);
}

function hide_show_div(id){
  var divelement = document.getElementById(id);
  if(divelement.style.display == 'none')
    divelement.style.display = 'block';
    else {
      divelement.style.display = 'none';
    }
}

function clear_text(id){
  var area_element = document.getElementById(id);
  area_element.val('');
}

$(document).ready(function() {
    $('#add_review').on('click', function() {
      alert('someting')
      $.ajax({
        url: '/reviews/create',
        data: {revcontent: $(this).data('revcontent'), product_id: $(this).data('product_id')},
        action: 'POST',
        dataType: 'HTML',
        success: function(data) {
        console.log(data)
        console.log('its in console');
        var area_element = document.getElementById('revcontent');
        area_element.val('');
        // $('#bugs-show-area').html(data)
      }
    });
  });
});
