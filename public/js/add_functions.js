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
        '<td><input class="form-control" type="date" id="relatives_' + String(count-1)  + '_date" name="relatives[' + String(count-1)  + '][date]"></input></td>' +
        '<td><input class="form-control" type="text" id="relatives_' + String(count-1)  + '_job"  name="relatives[' + String(count-1)  + '][job]"></input></td>' +
        '<td><input class="form-control" type="text" id="relatives_' + String(count-1)  + '_adr"  name="relatives[' + String(count-1)  + '][adr]"></input></td>' +
        '<td><a class="delete" title="Удалить" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a></td>';

    opts = "Жена,Муж,Сын,Дочь,Мать,Отец,Брат,Сестра".split(",");
    for (var ind in opts){
        rowElement.childNodes[0].childNodes[0].innerHTML = rowElement.childNodes[0].innerHTML + '<option>' + opts[ind] + '</option>';
    }

    tableBody.appendChild(rowElement);

    return (false)
}

function add_education_table_new_row(position_type=""){
    tableBody = document.getElementById("education_rows")

    var count = tableBody.childNodes.length;

    rowElement = document.createElement("tr")

    if (position_type == "worker"){
        rowElement.innerHTML =
        '<td><input class="form-control" type="number" id="education_' + String(count-1)  + '_begin" name="education[' + String(count-1)  + '][begin]"></input></td>' +
        '<td><input class="form-control" type="number" id="education_' + String(count-1)  + '_end" name="education[' + String(count-1)    + '][end]"></input></td>' +
        '<td><input class="form-control" type="text" id="education_' + String(count-1)  + '_inst" name="education[' + String(count-1)   + '][inst]"></input></td>' +
        '<td><input class="form-control" type="text" id="education_' + String(count-1)  + '_spec"  name="education[' + String(count-1)  + '][spec]"></input></td>' +
        '<td><a class="delete" title="Удалить" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a></td>';
    }else{
        rowElement.innerHTML =
        '<td><input class="form-control" type="number" id="education_' + String(count-1)  + '_begin" name="education[' + String(count-1)  + '][begin]"></input></td>' +
        '<td><input class="form-control" type="number" id="education_' + String(count-1)  + '_end" name="education[' + String(count-1)    + '][end]"></input></td>' +
        '<td><input class="form-control" type="text" id="education_' + String(count-1)  + '_inst" name="education[' + String(count-1)   + '][inst]"></input></td>' +
        '<td><input class="form-control" type="text" id="education_' + String(count-1)  + '_spec"  name="education[' + String(count-1)  + '][spec]"></input></td>' +
        '<td><select class="form-control" type="text" id="education_' + String(count-1) + '_form"  name="education[' + String(count-1)  + '][form]"></select></td>' +
        '<td><a class="delete" title="Удалить" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a></td>';

        opts = "Очная,Заочная,Вечерняя,Удаленная".split(",");

        for (var ind in opts){
            rowElement.childNodes[4].childNodes[0].innerHTML = rowElement.childNodes[4].innerHTML + '<option>' + opts[ind] + '</option>';
        }
    }

    tableBody.appendChild(rowElement);

    return (false)
}

function add_extra_table_new_row(position_type=""){
    tableBody = document.getElementById("extra_rows")

    var count = tableBody.childNodes.length;

    rowElement = document.createElement("tr")

    if (position_type == "worker"){
        rowElement.innerHTML =
        '<td><input class="form-control" type="number" id="extra_' + String(count-1)  + '_year" name="extra[' + String(count-1)  + '][year]"></input></td>' +
        '<td><input class="form-control" type="text" id="extra_' + String(count-1)  + '_inst" name="extra[' + String(count-1)    + '][inst]"></input></td>' +
        '<td><input class="form-control" type="text" id="extra_' + String(count-1)  + '_name" name="extra[' + String(count-1)    + '][name]"></input></td>' +
        '<td><input class="form-control" type="text" id="extra_' + String(count-1)  + '_spec" name="extra[' + String(count-1)    + '][spec]"></input></td>' +
        '<td><a class="delete" title="Удалить" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a></td>';
    }else{
        rowElement.innerHTML =
        '<td><input class="form-control" type="number" id="extra_' + String(count-1)  + '_year" name="extra[' + String(count-1)       + '][year]"></input></td>' +
        '<td><input class="form-control" type="text" id="extra_' + String(count-1)  + '_inst" name="extra[' + String(count-1)         + '][inst]"></input></td>' +
        '<td><input class="form-control" type="text" id="extra_' + String(count-1)  + '_name" name="extra[' + String(count-1)         + '][name]"></input></td>' +
        '<td><input class="form-control" type="number" id="extra_' + String(count-1)  + '_duration" name="extra[' + String(count-1)   + '][duration]"></input></td>' +
        '<td><a class="delete" title="Удалить" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a></td>';
    }

    tableBody.appendChild(rowElement);

    return (false)
}

function add_language_table_new_row(){
    tableBody = document.getElementById("language_rows");

    var count = tableBody.childNodes.length;

    rowElement = document.createElement("tr");
    rowElement.innerHTML =
        '<td><input class="form-control" type="text" id="language_'                   
            + String(count-1)  + '_name" name="language['     
            + String(count-1) + '][name]" ></input></td>' +
        '<td><input class="form-control" type="number" min="1" max="5" id="language_' 
            + String(count-1)  + '_orally" name="language['   
            + String(count-1) + '][orally]" onblur="this.value = Math.min(5, Math.max(this.value, 1))"></input></td>'+
        '<td><input class="form-control" type="number" min="1" max="5" id="language_' 
            + String(count-1)  + '_writing" name="language['  
            + String(count-1) + '][writing]" onblur="this.value = Math.min(5, Math.max(this.value, 1))"></input></td>'+
        '<td><a class="delete" title="Удалить" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a></td>';

    tableBody.appendChild(rowElement);

    return (false)
}

function add_experience_table_row(position_type=""){
    tableBody = document.getElementById("experience_fields");

    if (tableBody){
        var count = tableBody.childNodes.length;

        count = count / 6;

        tableBody.appendChild(document.createElement("br"));

        rowElement = document.createElement("div");
        rowElement.classList.add("form-row");

        rowElement.innerHTML =
            '<div class="form-group col-md-3">' +
            '   <label for="expieience' + String(count) + 'Name">Название организации(' + String(count + 1) + ')</label>' +
            '</div>' +
            '<div class="form-group col-md-9">' +
            '   <input class="form-control" type="text" id="experience_' + String(count) + '_name" name="experience[' + String(count) + '][name]">' +
            '</div>';

        tableBody.appendChild(rowElement);

        rowElement = document.createElement("div");
        rowElement.classList.add("form-row");

        if (position_type == "worker"){
            rowElement.innerHTML =
                '<div class="form-group col-md-3">' +
                '   <label for="expieience' + String(count) + 'PeriodStart">Месяц и год поступления</label>' +
                '</div>' +
                '<div class="form-group col-md-3">' +
                '   <input class="form-control" type="date" id="experience_' + String(count) + '_period_start" name="experience['+ String(count) + '][period_start]">' +
                '</div>' +
                '<div class="form-group col-md-3">' +
                '   <label for="expieience' + String(count) + 'PeriodFinish">Месяц и год ухода</label>' +
                '</div>' +
                '<div class="form-group col-md-3">' +
                '   <input class="form-control" type="date" id="experience_' + String(count) + '_period_finish" name="experience['+ String(count) + '][period_finish]">' +
                '</div>' +
                '';
        }else{
            rowElement.innerHTML =
                '<div class="form-group col-md-3">' +
                '   <label for="expieience' + String(count) + 'Period">Период работы</label>' +
                '</div>' +
                '<div class="form-group col-md-4">' +
                '   <input class="form-control" type="text" id="experience_' + String(count) + '_period" name="experience['+ String(count) + '][period]">' +
                '</div>' +
                '<div class="form-group col-md-1">' +
                '   <label for="expieience' + String(count) + 'Workers">сотруд-\nников</label>' +
                '</div>' +
                '<div class="form-group col-md-1">' +
                '   <input class="form-control" type="text" id="experience_' + String(count) + '_workers" name="experience['+ String(count) + '][workers]">' +
                '</div>' +
                '<div class="form-group col-md-1">' +
                '   <label for="expieience' + String(count) + 'Subords">подчи-\nненных</label>' +
                '</div>' +
                '<div class="form-group col-md-1">' +
                '   <input class="form-control" type="text" id="experience_' + String(count) + '_subords" name="experience['+ String(count) + '][subords]">' +
                '</div>' +
                '';
        }

        tableBody.appendChild(rowElement);

        rowElement = document.createElement("div");
        rowElement.classList.add("form-row");

        if (position_type == "worker"){
            rowElement.innerHTML =
                '<div class="form-group col-md-3">' +
                '   <label for="expieience' + String(count) + 'Pos">Должность</label>' +
                '</div>' +
                '<div class="form-group col-md-9">' +
                '   <input class="form-control" type="text" id="experience_' + String(count) + '_pos" name="experience['+ String(count) + '][pos]">' +
                '</div>' +
                '';
        }else{
            rowElement.innerHTML =
                '<div class="form-group col-md-3">' +
                '   <label for="expieience' + String(count) + 'Field">Сфера деятельности</label>' +
                '</div>' +
                '<div class="form-group col-md-3">' +
                '   <input class="form-control" type="text" id="experience_' + String(count) + '_field" name="experience['+ String(count) + '][field]">' +
                '</div>' +
                '<div class="form-group col-md-2">' +
                '   <label for="expieience' + String(count) + 'Pos">Должность</label>' +
                '</div>' +
                '<div class="form-group col-md-4">' +
                '   <input class="form-control" type="text" id="experience_' + String(count) + '_pos" name="experience['+ String(count) + '][pos]">' +
                '</div>' +
                '';
        }
                
        tableBody.appendChild(rowElement);

        rowElement = document.createElement("div");
        rowElement.classList.add("form-row");
        
        if (position_type == "worker"){
            rowElement.innerHTML =
                '<div class="form-group col-md-3">' +
                '   <label for="expieience' + String(count) + 'Dism">Причины увольнения</label>' +
                '</div>' +
                '<div class="form-group col-md-9">' +
                '   <input class="form-control" type="text" id="experience_' + String(count) + '_dism" name="experience['+ String(count) + '][dism]">' +
                '</div>' +
                '';
        }else{
            rowElement.innerHTML =
                '<div class="form-group col-md-3">' +
                '   <label for="expieience' + String(count) + 'Cond">Зарплата</label>' +
                '</div>' +
                '<div class="form-group col-md-3">' +
                '   <input class="form-control" type="number" id="experience_' + String(count) + '_cond" name="experience['+ String(count) + '][cond]">' +
                '</div>' +
                '<div class="form-group col-md-2">' +
                '   <label for="expieience' + String(count) + 'Dism">Причины увольнения</label>' +
                '</div>' +
                '<div class="form-group col-md-4">' +
                '   <input class="form-control" type="text" id="experience_' + String(count) + '_dism" name="experience['+ String(count) + '][dism]">' +
                '</div>' +
                '';
        }

        tableBody.appendChild(rowElement);

        rowElement = document.createElement("div");
        rowElement.classList.add("form-row");
        rowElement.innerHTML =
            '<div class="form-group col-md-12">' +
            '<label for="expieience' + String(count) + 'Duties">Основные должностные обязанности:</label>' +
            '<textarea class="form-control" type="text" id="experience_' + String(count) + '_duties" name="experience['+ String(count) + '][duties]"></textarea>' +
            '</div>'
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
        '<td><input class="form-control" type="text" id="reccomenders_' + String(count-1)  + '_phone"  name="reccomenders['   + String(count-1)  + '][phone]"></input></td>'+
        '<td><a class="delete" title="Удалить" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a></td>';

    tableBody.appendChild(rowElement);

    $("#reccomenders_" + String(count-1) + "_phone").mask("+375 (99) 999-99-99");

    return (false)
}

// Fill tables

function fill_relatives_content(contentElement){
    tableContent = JSON.parse(contentElement.innerHTML)

    if (tableContent == null){
        return
    }

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

function fill_education_content(contentElement, position_type){
    tableContent = JSON.parse(contentElement.innerHTML)

    if (tableContent == null){
        return
    }

    rowsElement = document.getElementById("education_rows")

    for (i=0;i<tableContent.length; i++){
        rowData = tableContent[i]

        add_education_table_new_row(position_type)

        rowElement = rowsElement.childNodes[rowsElement.childNodes.length-1]
        typeOptions = rowElement.childNodes[4].childNodes[0]

        if (position_type != "worker") {
            for (n=0;n<typeOptions.childNodes.length-1;n++){
                option = typeOptions.childNodes[n]
                option.selected = (option.value == rowData["form"])
            }
        }

        rowElement.childNodes[0].childNodes[0].value = rowData["begin"]
        rowElement.childNodes[1].childNodes[0].value = rowData["end"]
        rowElement.childNodes[2].childNodes[0].value = rowData["inst"]
        rowElement.childNodes[3].childNodes[0].value = rowData["spec"]
    }
}

function fill_extra_content(contentElement, position_type){
    tableContent = JSON.parse(contentElement.innerHTML)

    if (tableContent == null){
        return
    }

    rowsElement = document.getElementById("extra_rows")

    for (i=0;i<tableContent.length; i++){
        rowData = tableContent[i]

        add_extra_table_new_row(position_type)

        rowElement = rowsElement.childNodes[rowsElement.childNodes.length-1]

        rowElement.childNodes[0].childNodes[0].value = rowData["year"]
        rowElement.childNodes[1].childNodes[0].value = rowData["inst"]
        rowElement.childNodes[2].childNodes[0].value = rowData["name"]
        rowElement.childNodes[3].childNodes[0].value = rowData["duration"]

        if (position_type == "worker") {
            rowElement.childNodes[3].childNodes[0].value = rowData["spec"]
        }
    }
}

function fill_language_content(contentElement){
    tableContent = JSON.parse(contentElement.innerHTML)

    if (tableContent == null){
        return
    }

    rowsElement = document.getElementById("language_rows")

    for (i=0;i<tableContent.length; i++){
        add_language_table_new_row()

        rowData = tableContent[i]

        rowElement = rowsElement.childNodes[rowsElement.childNodes.length-1]

        rowElement.childNodes[0].childNodes[0].value = rowData["name"]
        rowElement.childNodes[1].childNodes[0].value = rowData["orally"]
        rowElement.childNodes[2].childNodes[0].value = rowData["writing"]
    }
}

function fill_reccomenders_content(contentElement){
    tableContent = JSON.parse(contentElement.innerHTML)

    if (tableContent == null){
        return
    }

    rowsElement = document.getElementById("reccomenders_rows")

    for (i=0;i<tableContent.length; i++){
        add_reccomenders_table_row()

        rowData = tableContent[i]

        rowElement = rowsElement.childNodes[rowsElement.childNodes.length-1]

        rowElement.childNodes[0].childNodes[0].value = rowData["name"]
        rowElement.childNodes[1].childNodes[0].value = rowData["job"]
        rowElement.childNodes[2].childNodes[0].value = rowData["position"]
        rowElement.childNodes[3].childNodes[0].value = rowData["phone"]
    }
}

function fill_experience_content(contentElement, position_type){
    tableContent = JSON.parse(contentElement.innerHTML)

    if (tableContent == null){
        return
    }

    rowsElement = document.getElementById("experience_fields")

    if (tableContent.length == 0){
        add_experience_table_row(position_type)
    }

    for (i=0;i<tableContent.length; i++){
        add_experience_table_row(position_type)

        rowData = tableContent[i]

        rowsElement.childNodes[rowsElement.childNodes.length-5].childNodes[1].childNodes[1].value = rowData["name"]

        if (position_type == "worker") {
            rowsElement.childNodes[rowsElement.childNodes.length-4].childNodes[1].childNodes[1].value = rowData["period_start"]
            rowsElement.childNodes[rowsElement.childNodes.length-4].childNodes[3].childNodes[1].value = rowData["period_finish"]
            rowsElement.childNodes[rowsElement.childNodes.length-3].childNodes[1].childNodes[1].value = rowData["pos"]
            rowsElement.childNodes[rowsElement.childNodes.length-2].childNodes[1].childNodes[1].value = rowData["dism"]
        }else{
            rowsElement.childNodes[rowsElement.childNodes.length-4].childNodes[1].childNodes[1].value = rowData["period"]
            rowsElement.childNodes[rowsElement.childNodes.length-4].childNodes[3].childNodes[1].value = rowData["workers"]
            rowsElement.childNodes[rowsElement.childNodes.length-4].childNodes[5].childNodes[1].value = rowData["subords"]
            rowsElement.childNodes[rowsElement.childNodes.length-3].childNodes[1].childNodes[1].value = rowData["field"]
            rowsElement.childNodes[rowsElement.childNodes.length-2].childNodes[1].childNodes[1].value = rowData["cond"]
            rowsElement.childNodes[rowsElement.childNodes.length-3].childNodes[3].childNodes[1].value = rowData["pos"]
            rowsElement.childNodes[rowsElement.childNodes.length-2].childNodes[3].childNodes[1].value = rowData["dism"]
        }
        rowsElement.childNodes[rowsElement.childNodes.length-1].childNodes[0].childNodes[1].value = rowData["duties"]
    }
}

// Write Candidate

function  deactive_candidate(){
    document.getElementById("candidate_active").value = "false"
    return (true)
}