<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Github-Trend</title>
  </head>
  <body>
    <div>
      <h3>Items</h3>
      {{range .Projects}}
      <p>{{.Name}}</p>
      {{end}}
    </div>
  </body>
</html>
