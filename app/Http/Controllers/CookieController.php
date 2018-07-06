<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CookieController extends Controller
{

  public function updateUrl()
  {
    if(@simplexml_load_file($_POST['url'])){
      $type = mb_substr($_POST['url'], -3);
      if($type=='rss' | $type=='rdf'){
        setcookie("url", $_POST['url'], time()+1800);
        header('Location: http://localhost:8000');
        exit();
      }else{
        setcookie("url", '', time()+1800);
        header('Location: http://localhost:8000');
        exit();
      }
    }else{
      setcookie("url", '', time()+1800);
      header('Location: http://localhost:8000');
      exit();
    }
  }

  public function getUrl()
  {
    return $_COOKIE['url'];
  }

}
