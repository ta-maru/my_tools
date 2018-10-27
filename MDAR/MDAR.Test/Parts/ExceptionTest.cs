using MDAR.Commons.Parts;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MDAR.Test.Parts
{
    [TestClass]
    public class ExceptionTest
    {
        [TestMethod]
        public void MessageAll()
        {
            var actual1 = new ApplicationException("AppErr");
            var actual2 = new ApplicationException("AppErr", new Exception("Err"));

            Assert.AreEqual("AppErr", actual1.MessageAll());
            Assert.AreEqual("AppErr => Err", actual2.MessageAll());
        }
    }
}
