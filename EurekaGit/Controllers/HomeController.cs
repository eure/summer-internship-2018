using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EurekaGit.Models;
using AngleSharp.Parser.Html;
using System.Net.Http;
using AngleSharp.Dom.Html;

namespace EurekaGit.Controllers
{
	public class HomeController : Controller
	{
		public ActionResult Index()
		{
			ViewBag.Trends = Downloader.GetRepositories().ToList();

			return View();
		}
	}
}