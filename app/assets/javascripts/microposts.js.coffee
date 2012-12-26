$("#micropost_content").live "keyup keydown", (e) ->
  maxLen = 140
  left = maxLen - $(this).val().length
  $("#char-count").html left
