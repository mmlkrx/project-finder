$(function(){
  var faye = new Faye.Client('http://localhost:9292/faye')
  faye.subscribe('/messages/'+parseInt(<%= @project.id %>),function(data){
    alert(data)
  });
});