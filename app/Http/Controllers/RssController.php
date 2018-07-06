<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class RssController extends Controller
{
  private $url = null;
  private $baseUrl = 'https://note.mu/notemag/m/m57787022cedc/rss';

  public function __construct()
  {
    // $_COOKIE['url'] = $this->baseUrl;
    if(isset($_COOKIE['url'])) $this->url = $_COOKIE['url'];
    else $this->url = $this->baseUrl;
    // $this->url = $this->baseUrl;
  }

  public function showList()
  {
    $data      = $this->getRss($this->url);
    $site_name = $this->getSiteName($this->url);
    return view('top', ['data'=>$data, 'site_name'=>$site_name]);
  }

  public function getRss($url)
  {
    $type = mb_substr($url, -3);
    $data=null;
    if($type=='rss')
    {
      $rss = simplexml_load_file($url);
      foreach($rss->channel->item as $item)
      {
        $array_data=null;
        $array_data=array(
          'title'=>$item->title,
          'date'=>date("Y年 n月 j日", strtotime($item->pubDate)),
          'link'=>$item->link,
          'description'=>strip_tags($item->description)
        );
        $data[] = $array_data;
      }
    }
    else if($type=='rdf')
    {
      $rdf = simplexml_load_file($url);
      foreach($rdf->item as $item)
      {
        $array_data=null;
        $array_data=array(
          'title'=>$item->title,
          'date'=>date("Y年 n月 j日", strtotime($item->pubDate)),
          'link'=>$item->link,
          'description'=>strip_tags($item->description)
        );
        $data[] = $array_data;
      }
    }
    return $data;
  }
  
  public function oneShow($num)
  {
    $data = $this->getOneRss($this->url, $num);
    $site_name = $this->getSiteName($this->url);
    return view('one', ['data'=>$data, 'site_name'=>$site_name]);
  }

  public function getOneRss($url, $num)
  {
    $data = $this->getRss($url);
    return $data[$num];
  }

  public function getSiteName($url)
  {
    $rss = simplexml_load_file($url);
    $site_name = $rss->channel->title;
    return $site_name;
  }
}
