# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
page.replace_html("order", render(@order))

page[:current_item].visual_effect :fade if @line_item.quantity < 1

page[:current_item].visual_effect :highlight,
                                  :startcolor => "#cc0000",
                                  :endcolor => "#114411" 