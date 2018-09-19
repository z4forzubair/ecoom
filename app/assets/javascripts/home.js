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

function toggle_rev_div(id){
  var divelement = document.getElementById(id);
  if(divelement.style.display == 'none')
    divelement.style.display = 'block';
    else {
      divelement.style.display = 'none';
    }
}


$(document).ready(function() {
    $('#add_review').on('click', function() {
      $.ajax({
        url: '/reviews/create',
        data: {revcontent: $(this).data('revcontent'), product_id: $(this).data('product_id')},
        action: 'POST',
        dataType: 'HTML',
        success: function(data) {
        console.log(data)
        // $('#bugs-show-area').html(data)
      }
    });
  });
});
