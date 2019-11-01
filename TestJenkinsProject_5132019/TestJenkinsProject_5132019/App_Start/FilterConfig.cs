using System.Web;
using System.Web.Mvc;

namespace TestJenkinsProject_5132019
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
