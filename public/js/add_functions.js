 
// Images

function handleFiles(files) {    
    var preview = document.getElementById("preview");

    for (n = 0; n < preview.childNodes.length; n++) {
        preview.removeChild(preview.childNodes[n]);
    }
    
    for (var i = 0; i < files.length; i++) {
        var file = files[i];
        
        if (!file.type.startsWith('image/')){ continue }
            
        var img = document.createElement("img");
        img.classList.add("img-fluid");
        img.style.maxWidth = "200px"
        img.file = file;

        preview.appendChild(img); // Предполагается, что "preview" это div, в котором будет отображаться содержимое.
            
        var reader = new FileReader();
        reader.onload = (function(aImg) { return function(e) { aImg.src = e.target.result; }; })(img);
        reader.readAsDataURL(file);
    }
}

// Inputs

function ValidateEmail(mail) 
{     
    if(mail==""){
        return (true)
    }
    
    if (/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(mail))
    {
        document.getElementById("email_error").hidden = true;
        return (true)
    }
    
    document.getElementById("email_error").hidden = false;
    return (false)
}