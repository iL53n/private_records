
// On Document load events: input masks

$(function(){

    // Phone mask
    $("#candidate_phone").mask("+375 (99) 999-99-99")
    
    // Image content
    imageElement = document.getElementById("image")
    if (imageElement && imageElement.files.length > 0){
        handleFiles(imageElement.files)
    }

    // Fill tables candidate's data
    contentElement = document.getElementById('relatives_content')
    if (contentElement){ fill_relatives_content(contentElement) }

    contentElement = document.getElementById('education_content')
    if (contentElement){ fill_education_content(contentElement) }

    contentElement = document.getElementById('extra_content')
    if (contentElement){ fill_extra_content(contentElement) }

    contentElement = document.getElementById('language_content')
    if (contentElement){ fill_language_content(contentElement) }
    
    contentElement = document.getElementById('experience_content')
    if (contentElement){fill_experience_content(contentElement)} 

    contentElement = document.getElementById('reccomenders_content')
    if (contentElement){ fill_reccomenders_content(contentElement) }

    // Delete button
    $(document).on("click", ".delete", function(){
        $(this).parents("tr").remove();
    });
});  
