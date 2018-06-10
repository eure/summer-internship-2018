<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Github-Trend</title>
  </head>
  <body>
    <div>
      <h3>Items</h3>
      <ol class="trending-repos">
      {{range $i, $v := .Projects}}
        <li class="repo">
          <a href="/detail/?repo={{$v.Name}}" class="detail-link">{{$v.Name}}</a>
        </li>
      {{end}}
      </ol>
    </div>
  </body>
</html>
