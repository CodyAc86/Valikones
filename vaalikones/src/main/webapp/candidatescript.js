function sendData() {
    //Create a new Javascript object
    var ehdokkaat = new Object();
    ehdokkaat.etunimi = document.getElementById("Etunimi").value;
    ehdokkaat.sukunimi = document.getElementById("Sukunimi").value;
// convert value to a JavaScript Object Notation
    var json = JSON.stringify(ehdokkaat);
    var xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
// convert JSON string into Object
            var returned = JSON.parse(this.responseText);

            console.log(returned);
            if (returned.ehdokasId > 0) {
                location.reload();
                return;
            }
        }

    };

    xhttp.open("POST", "./rest/candidateService/login", true);
    xhttp.setRequestHeader("Content-Type", "application/json");
    //xhttp.setRequestHeader("Accept","application/json");
    xhttp.send(json);


}

function sendAns(form) {
	console.log(form);
	var newVal = form.querySelector('input[name="vastaus"]:checked').value,
	oldVal=form.querySelector('input[name=old]').value,
	qId=form.querySelector('input[name=qId]').value,
	uId=form.querySelector('input[name=uId]').value;     // creating a new obj
	console.log(newVal, oldVal);
	if(newVal !== oldVal){
		var json = JSON.stringify({vastaus:newVal,vastauksetPK:{kysymysId:qId,ehdokasId:uId}});// creation of class with ans converted to json
		
		   var xhttp = new XMLHttpRequest();

		    xhttp.onreadystatechange = function () {
		        if (this.readyState == 4 && this.status == 200) {

		            var returned = JSON.parse(this.responseText);

		            console.log(returned);
		            location.reload();
		        }
		        
		    };
		    alert("Answer changed successfully");
		    xhttp.open("POST", "./rest/candidateService/save", true);
		    xhttp.setRequestHeader("Content-Type", "application/json");
		    //xhttp.setRequestHeader("Accept","application/json");
		    xhttp.send(json);
	}
	
	
	
}


