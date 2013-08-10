#ajax call to show flash messages when they are transmitted in the header
#this code assumes the following
# 1) you're using twitter-bootstrap (although it will work if you don't)
# 2) you've got a div with the id flash_hook somewhere in your html code

console.log "ajaxFlashLoading..."

$(document).ajaxComplete (event, request) ->
  msg = request.getResponseHeader("X-Message")
  alert_type = 'alert-success'
  alert_type = 'alert-error' unless request.getResponseHeader("X-Message-Type").indexOf("error") is -1
  $("#flash_hook").replaceWith("<div id='flash_hook'>
  		<p>&nbsp;</p>
          <div class='row'>
            <div class='span10 offset1'>
              <div class='alert " + alert_type + "'>
                <button type='button' class='close' data-dismiss='alert'>&times;</button>
                " + msg + "
              </div>
            </div>
          </div>
         </div>") if msg
  #delete the flash message (if it was there before) when an ajax request returns no flash message
  $("#flash_hook").replaceWith("<div id='flash_hook'></div>") unless msg