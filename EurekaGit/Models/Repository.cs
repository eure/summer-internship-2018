using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AngleSharp.Dom.Html;
using AngleSharp.Dom;
using System.Net.Http;
using AngleSharp.Parser.Html;

namespace EurekaGit.Models
{
	public static class Downloader
	{
		public static readonly string URL = "https://github.com/trending";
		static readonly string Path = @"D:\mywork\git\summer-internship-2018\trending.html";
		static readonly TimeSpan Interval = new TimeSpan(1, 0, 0);
		public static bool IsOld => !File.Exists(Path) || DateTime.Now - File.GetLastWriteTime(Path) >= Interval;
		public static string Get()
		{
			if (IsOld)
			{
				using (var sw = new StreamWriter(Path))
				using (var client = new HttpClient())
				using (var stream = client.GetStreamAsync(new Uri(URL)).Result)
				using (var sr = new StreamReader(stream))
					sw.Write(sr.ReadToEnd());
			}
			return File.ReadAllText(Path);
		}
		public static IEnumerable<Repository> GetRepositories()
		{
			var parser = new HtmlParser();
			var doc = parser.Parse(Get());
			var trends = new List<Repository>();
			foreach (var repo in doc.QuerySelectorAll("li[class='col-12 d-block width-full py-4 border-bottom']"))
				yield return Repository.Parse(repo);
		}
	}
	public class LanguageInfo
	{
		public string Color;
		public string Name;
	}
	public class Repository : IEquatable<Repository>
	{
		public static HashSet<Repository> Parsed = new HashSet<Repository>();
		public string Owner;
		public string Name;
		public string Description;
		public LanguageInfo Language;
		public int TotalStars;
		public int StarsToday;
		public int ForkedCount;
		public List<string> Contributors;
		public static Repository Parse(IElement elem)
		{
			var repo = new Repository();
			var title = elem.QuerySelector("div[class='d-inline-block col-9 mb-1']").TextContent.Replace(" ", "");
			var titles = title.Split('/');
			repo.Owner = titles[0].Trim();
			repo.Name = titles[1].Trim();

			repo.Description = elem.QuerySelector("div[class='py-1']").TextContent;

			var info = elem.QuerySelector("div[class='f6 text-gray mt-2']");

			var today = info.QuerySelector("span[class='d-inline-block float-sm-right']").TextContent;
			repo.StarsToday = int.Parse(today.Substring(0, today.IndexOf("stars today")).Trim().Replace(",", ""));

			if (info.Children[0].ClassName == "d-inline-block mr-3")
			{
				var lang = info.Children[0];
				var langcol = lang.QuerySelector("span[class='repo-language-color ml-0']").GetAttribute("style");
				var ind = langcol.IndexOf('#');
				var language = new LanguageInfo();
				language.Color = langcol.Substring(ind, langcol.IndexOf(';') - ind);
				language.Name = lang.QuerySelector("span[itemprop='programmingLanguage']").TextContent.Trim(); ;
				repo.Language = language;
			}
			else repo.Language = null;

			var stats = info.QuerySelectorAll("a[class='muted-link d-inline-block mr-3']");
			repo.TotalStars = int.Parse(stats[0].TextContent.Trim().Replace(",", ""));
			repo.ForkedCount = int.Parse(stats[1].TextContent.Trim().Replace(",", ""));

			var imgs = info.Children[repo.Language != null ? 3 : 2].QuerySelectorAll("a[class='d-inline-block']");
			repo.Contributors = imgs.Select(elm => elm.GetAttribute("href").Substring(1)).ToList();

			var k = new Tuple<string, string>(repo.Owner, repo.Name);
			Parsed.Add(repo);

			return repo;
		}
		public bool Equals(Repository other) => Owner == other.Owner && Name == other.Name;
		public override int GetHashCode() => Owner.GetHashCode() ^ Name.GetHashCode();
	}
}