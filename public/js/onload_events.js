
// On Document load events: input masks

$(function(){
    $("#candidate_phone").mask("+375 (99) 999-99-99")
    add_experience_table_row()
    
    imageElement = document.getElementById("image")

    if (imageElement && imageElement.files.length > 0){
        handleFiles(imageElement.files)
    }

    contentElement = document.getElementById('relatives_content')
    if (contentElement){ fill_relatives_content(contentElement) }

    contentElement = document.getElementById('education_content')
    if (contentElement){ fill_education_content(contentElement) }

    contentElement = document.getElementById('extra_content')
    if (contentElement){ fill_extra_content(contentElement) }
});  
