 
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

function validateEmail(mail) 
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

function fill_residence_adr() {
    document.getElementById("candidate_residence_city").value       = document.getElementById("candidate_registration_city").value
    document.getElementById("candidate_residence_street").value     = document.getElementById("candidate_registration_street").value
    document.getElementById("candidate_rresidence_house").value     = document.getElementById("candidate_registration_house").value
    document.getElementById("candidate_residence_apartment").value  = document.getElementById("candidate_registration_apartment").value

    return (false) // Стандартная обработка
}

// Tables

function add_relatives_table_new_row(){
    tableBody = document.getElementById("relatives_rows")
   
    var count = tableBody.childNodes.length;

    rowElement = document.createElement("tr")
    rowElement.innerHTML = 
        '<td><select class="form-control" type="text" id="relatives[' + String(count-1) + ']type" name="relatives_' + String(count-1) + '[type]"></select></td>' +
        '<td><input class="form-control" type="text" id="relatives[' + String(count-1)  + ']name" name="relatives_' + String(count-1)  + '[name]"></input></td>' +
        '<td><input class="form-control" type="text" id="relatives[' + String(count-1)  + ']date" name="relatives_' + String(count-1)  + '[date]"></input></td>' +
        '<td><input class="form-control" type="text" id="relatives[' + String(count-1)  + ']job"  name="relatives_' + String(count-1)  + '[job]"></input></td>' +
        '<td><input class="form-control" type="text" id="relatives[' + String(count-1)  + ']adr"  name="relatives_' + String(count-1)  + '[adr]"></input></td>';

    opts = "жена,муж,сын,дочь,мать,отец,брат,сестра".split(",");
    for (var ind in opts){
        rowElement.childNodes[0].childNodes[0].innerHTML = rowElement.childNodes[0].innerHTML + '<option>' + opts[ind] + '</option>';
    } 
    
    tableBody.appendChild(rowElement);

    return (false)
}