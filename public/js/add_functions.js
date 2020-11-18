// Images

function handleFiles(files) {    
    var preview = document.getElementById("preview");

    preview.innerHTML = ""
    
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
    tableBody = document.getElementById("language_rows");
   
    var count = tableBody.childNodes.length;

    rowElement = document.createElement("tr");
    rowElement.innerHTML = 
        '<td><input class="form-control" type="text" id="language_'                   + String(count-1)  + '_name" name="language['     + String(count-1) + '][name]"></input></td>' +
        '<td><input class="form-control" type="number" min="1" max="5" id="language_' + String(count-1)  + '_orally" name="language['   + String(count-1) + '][orally]"></input></td>'+
        '<td><input class="form-control" type="number" min="1" max="5" id="language_' + String(count-1)  + '_writing" name="language['  + String(count-1) + '][writing]"></input></td>';
    
    tableBody.appendChild(rowElement);

    return (false)
}

function add_experience_table_row(){
    tableBody = document.getElementById("experience_fields");

    if (tableBody){
        var count = tableBody.childNodes.length;

        count = count - 1;
        count = count / 5;

        tableBody.appendChild(document.createElement("br"));

        rowElement = document.createElement("div");
        rowElement.classList.add("form-row");
        rowElement.innerHTML = 
            '<div class="form-group col-md-2">' +
            '   <label for="expieience' + String(count) + 'Name">Название организации(' + String(count+1) + ')</label>' +
            '</div>' +                
            '<div class="form-group col-md-4">' +
            '   <input class="form-control" type="text" id="experience_>' + String(count) + '_name" name="experience['+ String(count) + '][name]">' +
            '</div>' +
            '<div class="form-group col-md-1">' +
            '   <label for="expieience' + String(count) + 'Period">период работы</label>' +
            '</div>' +  
            '<div class="form-group col-md-1">' +
            '   <input class="form-control" type="text" id="experience_>' + String(count) + '_period" name="experience['+ String(count) + '][period]">' +
            '</div>' +
            '<div class="form-group col-md-1">' +
            '   <label for="expieience' + String(count) + 'Workers">сотруд-\nников</label>' +
            '</div>' +  
            '<div class="form-group col-md-1">' +
            '   <input class="form-control" type="number" id="experience_>' + String(count) + '_workers" name="experience['+ String(count) + '][workers]">' +
            '</div>' +
            '<div class="form-group col-md-1">' +
            '   <label for="expieience' + String(count) + 'Subords">подчи-\nненных</label>' +
            '</div>' +  
            '<div class="form-group col-md-1">' +
            '   <input class="form-control" type="number" id="experience_>' + String(count) + '_subords" name="experience['+ String(count) + '][subords]">' +
            '</div>' +
            '';    
        tableBody.appendChild(rowElement);

        rowElement = document.createElement("div");
        rowElement.classList.add("form-row");
        rowElement.innerHTML = 
            '<div class="form-group col-md-2">' +
            '   <label for="expieience' + String(count) + 'Field">Сфера деятельности</label>' +
            '</div>' +                
            '<div class="form-group col-md-4">' +
            '   <input class="form-control" type="text" id="experience_>' + String(count) + '_field" name="experience['+ String(count) + '][field]">' +
            '</div>' +
            '<div class="form-group col-md-2">' +
            '   <label for="expieience' + String(count) + 'Pos">Должность</label>' +
            '</div>' +                
            '<div class="form-group col-md-4">' +
            '   <input class="form-control" type="text" id="experience_>' + String(count) + '_pos" name="experience['+ String(count) + '][pos]">' +
            '</div>' +
            '';    
        tableBody.appendChild(rowElement);

        rowElement = document.createElement("div");
        rowElement.classList.add("form-row");
        rowElement.innerHTML = 
            '<div class="form-group col-md-2">' +
            '   <label for="expieience' + String(count) + 'Cond">Зарплата</label>' +
            '</div>' +                
            '<div class="form-group col-md-4">' +
            '   <input class="form-control" type="text" id="experience_>' + String(count) + '_cond" name="experience['+ String(count) + '][cond]">' +
            '</div>' +
            '<div class="form-group col-md-2">' +
            '   <label for="expieience' + String(count) + 'Dism">Причины увольнения</label>' +
            '</div>' +                
            '<div class="form-group col-md-4">' +
            '   <input class="form-control" type="text" id="experience_>' + String(count) + '_dism" name="experience['+ String(count) + '][dism]">' +
            '</div>' +
            '';    
        tableBody.appendChild(rowElement);

        rowElement = document.createElement("div");
        rowElement.classList.add("form-row");
        rowElement.innerHTML = 
            '<label for="expieience' + String(count) + 'Duties">Основные должностные обязанности:</label>' +
            '<textarea class="form-control" type="text" id="experience_>' + String(count) + '_duties" name="experience['+ String(count) + '][duties]"></textarea>' +
            '<br />';    
        tableBody.appendChild(rowElement);

    }

    return (false)
}

function add_reccomenders_table_row(){
    tableBody = document.getElementById("reccomenders_rows");
    
    var count = tableBody.childNodes.length;

    rowElement = document.createElement("tr")
    rowElement.innerHTML = 
        '<td><input class="form-control" type="text" id="reccomenders_' + String(count-1)  + '_name" name="reccomenders['     + String(count-1)  + '][name]"></input></td>' +
        '<td><input class="form-control" type="text" id="reccomenders_' + String(count-1)  + '_job" name="reccomenders['      + String(count-1)  + '][job]"></input></td>' +
        '<td><input class="form-control" type="text" id="reccomenders_' + String(count-1)  + '_position" name="reccomenders[' + String(count-1)  + '][position]"></input></td>' +
        '<td><input class="form-control" type="text" id="reccomenders_' + String(count-1)  + '_phone"  name="reccomenders['   + String(count-1)  + '][phone]"></input></td>';

    tableBody.appendChild(rowElement);
        
    $("#reccomenders_" + String(count-1) + "_phone").mask("+375 (99) 999-99-99");
    
    return (false)
}

// Fill tables

function fill_relatives_content(contentElement){
    tableContent = JSON.parse(contentElement.innerHTML)

    rowsElement = document.getElementById("relatives_rows")

    for (i=0;i<tableContent.length; i++){
        add_relatives_table_new_row()

        rowData = tableContent[i]
        
        rowElement = rowsElement.childNodes[rowsElement.childNodes.length-1]
        typeOptions = rowElement.childNodes[0].childNodes[0] 

        for (n=0;n<typeOptions.childNodes.length-1;n++){
            option = typeOptions.childNodes[n]
            option.selected = (option.value == rowData["type"])  
        }
            
        rowElement.childNodes[1].childNodes[0].value = rowData["name"]
        rowElement.childNodes[2].childNodes[0].value = rowData["date"]
        rowElement.childNodes[3].childNodes[0].value = rowData["job"]
        rowElement.childNodes[4].childNodes[0].value = rowData["adr"]
    }
}
