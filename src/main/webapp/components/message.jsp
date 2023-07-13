
<% String message=(String)session.getAttribute("set");
if(message!=null)
out.println(message);
session.removeAttribute("set");%>