import command from howl
import style from howl.ui
import editor from howl.app

input = () ->
  lines = {}
  for index, line in pairs editor.buffer.lines
    msg = string.match(line.text, "TODO (.+)")
    if msg != nil
      editor.cursor.line = index
      editor.cursor\line_end!
      editor.cursor\left!
      style_at_pos = style.at_pos(editor.buffer,editor.cursor.pos)
      if style_at_pos == "comment"
        table.insert(lines,{index,msg,nr: index,text: msg})
  return howl.interact.select({
    items: lines
    columns: {
      { header: 'Line' },
      { header: 'Description' }
    }
  })

handler = (ln) ->
  editor.cursor.line = ln.selection.nr
  editor.cursor\line_end!

command.register({
  name: "todos"
  description: "TODO-s"
  :input
  :handler
})

unload = () ->
  command.unregister "todos"

return {
  info: {
    author: 'Rok Fajfar',
    description: 'TODO-s bundle'
    license: 'MIT'
  }
  :unload
}
