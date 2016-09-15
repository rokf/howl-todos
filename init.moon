import command from howl
import config from howl

with config
  .define
    name: 'todo_comment_pattern'
    description: 'regex pattern for comments which the todo bundle can use'
    default: "(--|#|;|//)"
    type_of: 'string'

input = () ->
  lines = {}
  pat = "%s TODO([\\w\\d\\s]+)"\format config.todo_comment_pattern
  print pat
  reg = r pat
  for index, line in pairs howl.app.editor.buffer.lines
    pfx, msg = reg\match line.text
    if pfx ~= nil
      table.insert(lines, {
        index,
        msg,
        nr: index,
        text: msg,
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
  howl.app.editor.cursor\line_end(false)

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
