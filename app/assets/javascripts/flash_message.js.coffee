#ajax call to show flash messages when they are transmitted in the header
#this code assumes the following
# 1) you're using twitter-bootstrap (although it will work if you don't)
# 2) you've got a div with the id flash_message somewhere in your html code

console.log "ajaxFlashLoading..."
$ -> 
  $(document).ajaxComplete (event, request) ->
    msg = request.getResponseHeader("X-Message")
    alert_type = 'alert-success'
    alert_type = 'alert-danger' unless request.getResponseHeader("X-Message-Type").indexOf("error") is -1
    $("#flash-message").html("
                <div class='alert " + alert_type + "'>
                  <button type='button' class='close' data-dismiss='alert'>&times;</button>
                  #{msg}
                </div>
").show() if msg
    #delete the flash message (if it was there before) when an ajax request returns no flash message
    $("#flash-message").html("") unless msg
    hideflash = -> $("#flash-message").fadeOut()
    setTimeout hideflash, 5000

  true