function handleFiles(files) {    
    var preview = document.getElementById("preview");

    for (n = 0; n < preview.childNodes.length; n++) {
        preview.removeChild(preview.childNodes[n]);
    }
    
    for (var i = 0; i < files.length; i++) {
        var file = files[i];
        
        if (!file.type.startsWith('image/')){ continue }
            
        var img = document.createElement("img");
        img.classList.add("obj");
        img.file = file;

        preview.appendChild(img); // Предполагается, что "preview" это div, в котором будет отображаться содержимое.
            
        var reader = new FileReader();
        reader.onload = (function(aImg) { return function(e) { aImg.src = e.target.result; }; })(img);
        reader.readAsDataURL(file);
    }
}