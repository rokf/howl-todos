
import command from howl

input = () -> -- input function
  lines = {}
  for index, line in pairs(howl.app.editor.buffer.lines)
    m = string.match(line.text, "%s*TODO (.+)")
    if m ~= nil
      table.insert(lines, {
        index,
        m,
        nr: index,
        text: m,
      })
  return howl.interact.select({
    items: lines
    columns: {
      { header: 'Line' },
      { header: 'Description'}
    }
  })

handler = (ln) ->
  howl.app.editor.cursor.line = ln.selection.nr
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
