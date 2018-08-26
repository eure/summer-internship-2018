using EurekaGit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EurekaGit.Controllers
{
    public class DetailsController : Controller
    {
        // GET: Details
        public ActionResult Index(string owner, string name)
        {
			ViewBag.Owner = owner;
			ViewBag.Name = name;
			var k = new Tuple<string, string>(owner, name);
			if (Downloader.IsOld) Downloader.GetRepositories();
			foreach (var repo in Repository.Parsed)
			{
				if (repo.Owner == owner && repo.Name == name) ViewBag.Repository = repo;
			}
            return View();
        }
    }
}