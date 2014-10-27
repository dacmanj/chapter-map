$ ->
  $(document).on "click", ".chapter-mailing-address-toggle", (event) ->
    listing = $(event.target).parent()
    $(".chapter-street, .chapter-zip",listing).show()
    $(event.target).hide()