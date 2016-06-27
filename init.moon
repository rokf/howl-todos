
import command from howl

input = () -> -- input function
  lines = {}
  for key, line in pairs(howl.app.editor.buffer.lines)
    m = string.match(line.text, "[--|#|//] TODO")
    if m ~= nil
      table.insert(lines, line)
  s = howl.interact.select_line({ :lines })
  return s.line

handler = (ln) ->
  howl.app.editor.cursor.line = ln.nr
  howl.app.editor.cursor.line_end()

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
