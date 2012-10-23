jQuery(document).ready(function(){
	var val=""
	jQuery('.edit').click(function(){
	val=jQuery(this).attr('id');
		jQuery(this).hide();
		jQuery(this).prev().hide();
		jQuery(this).next().show();
		jQuery(this).next().select();
	});
	
	
	jQuery('input[type="text"]').blur(function() {  
         if (jQuery.trim(this.value) == ''){  
			 this.value = (this.defaultValue ? this.defaultValue : '');  
		 }
		 else{
			 jQuery(this).prev().prev().html(this.value);
		 }
		 
		 jQuery(this).hide();
		 jQuery(this).prev().show();
		 jQuery(this).prev().prev().show();
     });
	  
	  jQuery('input[type="text"]').keypress(function(event) {
		  if (event.keyCode == '13') {
		  
			  if (jQuery.trim(this.value) == ''){  
				 this.value = (this.defaultValue ? this.defaultValue : '');  
			 }
			 else
			 {
				 jQuery(this).prev().prev().html(this.value);
				 				 
				 /*
				 jQuery.post("/slitlamptbs/"+val, { description: this.value },
           function(data) {
             alert("successfully updated " + data);
         });
         */
         
         jQuery.ajax({
          type: 'POST',
          url: "/slitlamptbs/"+val+"/label",
          data: "text_value="+this.value,
          success: function(res){
            jQuery("lbl"+val).html(res);
          },
//          dataType: dataType
        });

			 }
			 
			 jQuery(this).hide();
			 jQuery(this).prev().show();
			 jQuery(this).prev().prev().show();
		  }
	  });
		  
});
