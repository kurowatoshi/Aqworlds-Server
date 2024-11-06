<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<title>Atheros - Game</title>
	<!-- MDB icon -->
	<link rel="icon" href="favicon.png" type="image/x-icon">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
	<!-- Google Fonts Roboto -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<!-- Material Design Bootstrap -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css"
		integrity="sha512-RO38pBRxYH3SoOprtPTD86JFOclM51/XTIdEPh5j8sj4tp8jmQIx26twG52UaLi//hQldfrh7e51WzP9wuP32Q=="
		crossorigin="anonymous" />
	<!-- Toastr css -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">

	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js" type="text/javascript">
	</script>
	<style>
		body {
			background-color: #000000;
		}

		.special-bg {
			background: #000;
		}

		.center-block {
			display: table;
			margin: 0 auto;
		}

	</style>
</head>

<body>

	<!-- Start your project here-->
	<div class="center-block" style="margin-top: 3%;">
		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="960"
			height="550">
			<param name="movie" value="<?= base_url("gamefiles/{$swf}") ?>" />
			<param name="quality" value="high" />
			<param name="flashvars" value="showLogo=true&specAd=&Landing=true&refID=&campaign=&strSourceID=LandTestB" />
			<param name="wmode" value="opaque" />
			<param name="AllowScriptAccess" value="always" />
			<embed src="<?= base_url("gamefiles/{$swf}") ?>" quality="high" wmode="opaque" Landing="true"
				pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"
				type="application/x-shockwave-flash" width="960" height="550" allowscriptaccess="always">
			</embed>
		</object>
	</div>

	<div class="container">
		<div class="text-center" style="display:block;margin:auto;width:99%;padding:10px;">
			<div class="btn-group">
				<a class="btn btn-success px-5" href="<?= base_url() ?>" target="_blank">Home</a>
				<button class="btn btn-danger waves-effect px-5" data-toggle="modal"
					data-target="#registerModal">Register</button>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="registerModalLabel">Register</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="registerForm">
						<div class="form-group">
							<label for="username">Username</label>
							<input type="text" class="form-control" id="username" name="username" required>
						</div>
						<div class="form-group">
							<label for="password">Password</label>
							<input type="password" class="form-control" id="password" name="password" required>
						</div>
						<div class="form-group">
							<label for="email">Email</label>
							<input type="email" class="form-control" id="email" name="email" required>
						</div>
						<div class="form-group">
							<label for="gender">Gender</label>
							<select class="form-control" id="gender" name="gender">
                                <option value="M">Male</option>
                                <option value="F">Female</option>
                            </select>
						</div>
						<div class="form-group">
							<label for="classes">Classes</label>
							<select class="form-control" id="classes" name="classes">
                                <option value="2">Alpha Pirate</option>
                            </select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary" onclick="submitForm()">Register</button>
					<!-- Additional buttons if needed -->
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal -->

	<!-- End your project here-->

	<!-- Bootstrap tooltips -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous">
	</script>
	<!-- Bootstrap core JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous">
	</script>

    <script>
        function submitForm() {
            var formData = $('#registerForm').serialize()
            
            $.ajax({
                url: `${window.location.origin}/api/register/now`,
                method: 'POST',
                data: formData,
                success: function(response) {
                    if (response.bSuccess == 1) {
                        toastr.success(response.sMsg)
                        $('#registerModal').modal('hide')
                        $('#registerForm')[0].reset()
                    } else
                        toastr.error(response.sMsg, 'Registration Failed!')
                },
                error: function(xhr, textStatus, errorThrown) {
                    if (xhr.status === 400) {
                        var errorResponse = JSON.parse(xhr.responseText)
                        toastr.error(errorResponse.sMsg, 'Registration Failed!')
                    } else {
                        console.error('An error occurred:', errorThrown)
                    }
                }
            })
        }
    </script>
</body>

</html>
