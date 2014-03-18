#ajax call to show flash messages when they are transmitted in the header
#this code assumes the following
# 1) you're using twitter-bootstrap (although it will work if you don't)
# 2) you've got a div with the id flash_message somewhere in your html code

$ -> 
  console.log "ajaxFlashLoading..." if console?
  flash_msg_event = (event, request) ->
    if console?
      console.log "ajax request"
      console.log request
    msg = decodeURIComponent(request.getResponseHeader("X-Message")) || ""
    msg_type = request.getResponseHeader("X-Message-Type") || ""
    if msg?.length and msg_type?.length
      console.log "Flash Message: #{msg}"
      alert_type = 'alert-success'
      alert_type = 'alert-danger' unless (request.getResponseHeader("X-Message-Type") || "").match("error") is null
      console.log "Flash Message Type: #{alert_type}"
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

  file_upload_event = (e,r) ->
    result = confirm("Are you sure?")
    e.preventDefault()
    return result

  $(document).on "ajaxComplete", flash_msg_event
  
  