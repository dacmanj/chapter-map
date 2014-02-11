#ajax call to show flash messages when they are transmitted in the header
#this code assumes the following
# 1) you're using twitter-bootstrap (although it will work if you don't)
# 2) you've got a div with the id flash_message somewhere in your html code

$ -> 
  console.log "ajaxFlashLoading..."
  flash_msg_event = (event, request) ->
    console.log request
    console.log request.responseHTML
    msg = request.getResponseHeader("X-Message")
    console.log "test #{msg}"
    if msg.length > 0
      alert_type = 'alert-success'
      alert_type = 'alert-danger' unless request.getResponseHeader("X-Message-Type").match("error") is null
      $("#flash-message").html("
                  <div class='alert " + alert_type + "'>
                    <button type='button' class='close' data-dismiss='alert'>&times;</button>
                    #{msg}
                  </div>").show()
    #delete the flash message (if it was there before) when an ajax request returns no flash message
    else 
      $("#flash-message").html("").hide()
    hideflash = -> $("#flash-message").fadeOut()
    setTimeout hideflash, 5000
    true

  $(document).on "ajaxComplete", flash_msg_event