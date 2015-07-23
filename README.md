# HTTP redirection PoC

This Rack app can test how if your browser handles HTTP redirections.

When clicking on different buttons, you will either:
* be sent to `/detector` that displays what HTTP verb was used to request it
* be sent to `/redirector` that redirects you to `/detector` with the HTTP code passed as parameter

If you click on a button saying "POST" and that you end up on a page saying "GET", then your browser in actually not handling redirections properly :confused:

## How to run

```
$ bundle install
$ rackup
```

Then go to `http://localhost:9292`
