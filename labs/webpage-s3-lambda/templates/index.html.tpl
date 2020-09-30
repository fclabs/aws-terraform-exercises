<html>
<script>

function myFunction() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
        document.getElementById("my-name").innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", "${api_endpoint}", true);
    xhttp.send();

}

</script>
<body><div align="center"><br><br><br><br>
<h1>Hello <span id="my-name"> to my Page</span></h1>
<button onclick="myFunction()">Reveal yourself</button><br>
</body>
</html>