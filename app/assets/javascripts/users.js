AvidTest.User = {

    /**
     * Function to add users
     * send an ajax request to our rails app with user params
     */
    addUser: function() { 
        $('#add_user_form').on('submit', function() {

            form_params = {user: $(this).serializeObject()};
            $('#add_user_form #submit_user').val("Adding ...");

            AvidTest.Common.callAPI("/api/users.json", form_params ,  function(response){

                $.notify("Successfully created user", "success");
            	$('#add_user_form #submit_user').val("Add");
                new_user_html = AvidTest.User.parseUserInfo(response);
                $("#user_list").append(new_user_html);
            })
            return false
        })
    },  

    /**
     * Function to parse UserInfo
     * Populate new user table row.
     */
    parseUserInfo: function(response) {
        name = "<tr><td><a href=/messages/list?user_id=" + response.user.id +">" + response.user.id +"." + response.user.name + "</a></td>";
        gender = "<td>" + response.user.gender + "</td>";
        country = "<td>" + response.user.country + "</td>";
        age = "<td>" + response.user.birth_date + "</td></tr>";

        return name+gender+country+age
    },

    /**
     * Function to open close create form
     * Click to open and close button to close.
     */
    createUserOpenClose: function(){
        $("#create_user").on('click', function(){
            $("#add_user_form").slideDown();
        })

        $("#close_user").on('click', function(){
            $("#add_user_form").slideUp();
        })
        
    },

    /**
     * Function to initualize users javascript methods
     * This is the starting point for all user methods.
     */
     initialize: function(){
        AvidTest.User.addUser();
        AvidTest.User.createUserOpenClose();
     } 

};
