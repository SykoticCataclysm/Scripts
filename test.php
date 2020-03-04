<?php
  if ($_POST["secret"] == "frmFREG4tjgw04$£TO")
  {
    if ($_POST["content"])
    {
      $opts = array('http' =>
        array(
            'method'  => 'POST',
            'header'  => 'Content-type: application/x-www-form-urlencoded',
            'content' => $_POST["content"]
          )
      );
      $context = stream_context_create($opts);
      $result = file_get_contents('https://discordapp.com/api/webhooks/684813751299604650/-eEpQJ1npyPxrSwf49e2m3yUAS0ygmOCXYaVOKslCd0JJ2lLr2tE9Jn0SHkrG32U5cyz', false, $context);
    }
  }
?>
