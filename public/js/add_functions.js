 
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
        '<td><select class="form-control" type="text" id="relatives_' + String(count-1) + '_type" name="relatives[' + String(count-1) + '][type]"></select></td>' +
        '<td><input class="form-control" type="text" id="relatives_' + String(count-1)  + '_name" name="relatives[' + String(count-1)  + '][name]"></input></td>' +
        '<td><input class="form-control" type="text" id="relatives_' + String(count-1)  + '_date" name="relatives[' + String(count-1)  + '][date]"></input></td>' +
        '<td><input class="form-control" type="text" id="relatives_' + String(count-1)  + '_job"  name="relatives[' + String(count-1)  + '][job]"></input></td>' +
        '<td><input class="form-control" type="text" id="relatives_' + String(count-1)  + '_adr"  name="relatives[' + String(count-1)  + '][adr]"></input></td>';

    opts = "жена,муж,сын,дочь,мать,отец,брат,сестра".split(",");
    for (var ind in opts){
        rowElement.childNodes[0].childNodes[0].innerHTML = rowElement.childNodes[0].innerHTML + '<option>' + opts[ind] + '</option>';
    } 
    
    tableBody.appendChild(rowElement);

    return (false)
}

function add_education_table_new_row(){
    tableBody = document.getElementById("education_rows")
   
    var count = tableBody.childNodes.length;

    rowElement = document.createElement("tr")
    rowElement.innerHTML = 
        '<td><input class="form-control" type="number" id="education_' + String(count-1)  + '_begin" name="education[' + String(count-1)  + '][begin]"></input></td>' +
        '<td><input class="form-control" type="number" id="education_' + String(count-1)  + '_end" name="education[' + String(count-1)    + '][end]"></input></td>' +
        '<td><input class="form-control" type="text" id="education_' + String(count-1)  + '_inst" name="education[' + String(count-1)   + '][inst]"></input></td>' +
        '<td><input class="form-control" type="text" id="education_' + String(count-1)  + '_spec"  name="education[' + String(count-1)  + '][spec]"></input></td>' +
        '<td><select class="form-control" type="text" id="education_' + String(count-1) + '_form"  name="education[' + String(count-1)  + '][form]"></select></td>';

    opts = "очная,заочная,вечерняя,удаленная".split(",");

    for (var ind in opts){
        rowElement.childNodes[4].childNodes[0].innerHTML = rowElement.childNodes[4].innerHTML + '<option>' + opts[ind] + '</option>';
    }
    
    tableBody.appendChild(rowElement);

    return (false)
}

function add_extra_table_new_row(){
    tableBody = document.getElementById("extra_rows")
   
    var count = tableBody.childNodes.length;

    rowElement = document.createElement("tr")
    rowElement.innerHTML = 
        '<td><input class="form-control" type="number" id="extra_rows_' + String(count-1)  + '_year" name="extra_rows[' + String(count-1)         + '][year]"></input></td>' +
        '<td><input class="form-control" type="text" id="extra_rows_' + String(count-1)  + '_inst" name="extra_rows[' + String(count-1)         + '][inst]"></input></td>' +
        '<td><input class="form-control" type="text" id="extra_rows_' + String(count-1)  + '_name" name="extra_rows[' + String(count-1)         + '][name]"></input></td>' +
        '<td><input class="form-control" type="number" id="extra_rows_' + String(count-1)  + '_duration" name="extra_rows[' + String(count-1)    + '][duration]"></input></td>';
    
    tableBody.appendChild(rowElement);

    return (false)
}

function add_language_table_new_row(){
    tableBody = document.getElementById("language_rows")
   
    var count = tableBody.childNodes.length;

    rowElement = document.createElement("tr")
    rowElement.innerHTML = 
        '<td><input class="form-control" type="text" id="language_' + String(count-1)    + '_name" name="language[' + String(count-1)      + '][name]"></input></td>' +
        '<td><input class="form-control" type="number" id="language_' + String(count-1)  + '_orally" name="language[' + String(count-1)    + '][orally]"></input></td>'+
        '<td><input class="form-control" type="number" id="language_' + String(count-1)  + '_writing" name="language[' + String(count-1)   + '][writing]"></input></td>';
    
    tableBody.appendChild(rowElement);

    return (false)
}
