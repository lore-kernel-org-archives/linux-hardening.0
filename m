Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252A3F7AB6;
	Tue, 17 Mar 2026 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770988; cv=none; b=A0wcERhg2REZcvHmn+mlzZMOYcQoOFDl1pmv6fiLJFIVPbPj3jx2S3ILcY5e60rA1SyxoC5FvtYOdMQgnrCokTWVHiGO5eM2ws++ueEJp0mGs6u+cQp3ye00WmO8pQhTF2ywMQtufu4eGZ6yF6aUnmnvPfeEzaufjcBv8sBLId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770988; c=relaxed/simple;
	bh=LlO8G0kmdnWIAU5jvxuyWy2ICYFHWQfkFHgsDP9agHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDe+a8FIhf579mW/gjFl7V97H+YPAftc1CNeYWJ8yamWCC9HW3+WPBo+zWmztSNWdqJZE2Xhhv6r1viLbN7eX+Y0ytuODL+ecWHLi81sVzyaUy3XY8lMOXh8UWz9nLGGueEHN3Li9odMO+KaJcAhrj706XoO7Fs6t7PJpvsuaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCKlRDzm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCKlRDzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70276C2BCB0;
	Tue, 17 Mar 2026 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770988;
	bh=LlO8G0kmdnWIAU5jvxuyWy2ICYFHWQfkFHgsDP9agHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCKlRDzmCOQeI8wuBXD9T81ZF0k6Zk0ub0YSz0r3aG0Kp+JU0Q6nl71hmqD5i7McL
	 iPKIHfMbrxiz9K3OYso5+Bc1sCNbH4bCuLFIhZccAgeO3NuvTSchsTEC5U0OqH/zUw
	 Jl0WQ7HUO3b4tuQPcrP4uv61biE1X/eYbSfwHt/X6GOathuYYZRfOvtk9/M1wsB33r
	 ntUBlSaAZ45ppHTGWvMZoTXUlLk8Ha3eFcvBU/bshIBTFNR9fMKHIY51qnZT/xRlMw
	 RaT7FKdC10WK6pxQJb0rPunTrUspfbAxdXOGgny2kAbRpPziFImcOpmLnPuhOGrEyM
	 OgcPobTvea6JQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrS-0000000H5Mu-2wZd;
	Tue, 17 Mar 2026 19:09:46 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/22] unittests: test_private: modify it to use CTokenizer directly
Date: Tue, 17 Mar 2026 19:09:27 +0100
Message-ID: <66e6320a4d5ad9730c1c0ceea79b5021e90c66c6.1773770483.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773770483.git.mchehab+huawei@kernel.org>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Change the logic to use the tokenizer directly. This allows
adding more unit tests to check the validty of the tokenizer
itself.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-ID: <2672257233ff73a9464c09b50924be51e25d4f59.1773074166.git.mchehab+huawei@kernel.org>
---
 .../{test_private.py => test_tokenizer.py}    | 75 +++++++++++++------
 1 file changed, 51 insertions(+), 24 deletions(-)
 rename tools/unittests/{test_private.py => test_tokenizer.py} (85%)

diff --git a/tools/unittests/test_private.py b/tools/unittests/test_tokenizer.py
similarity index 85%
rename from tools/unittests/test_private.py
rename to tools/unittests/test_tokenizer.py
index eae245ae8a12..3b1d0b5bd311 100755
--- a/tools/unittests/test_private.py
+++ b/tools/unittests/test_tokenizer.py
@@ -15,20 +15,43 @@ from unittest.mock import MagicMock
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 sys.path.insert(0, os.path.join(SRC_DIR, "../lib/python"))
 
-from kdoc.kdoc_parser import trim_private_members
+from kdoc.c_lex import CTokenizer
 from unittest_helper import run_unittest
 
+
 #
 # List of tests.
 #
 # The code will dynamically generate one test for each key on this dictionary.
 #
 
+def make_private_test(name, data):
+    """
+    Create a test named ``name`` using parameters given by ``data`` dict.
+    """
+
+    def test(self):
+        """In-lined lambda-like function to run the test"""
+        tokens = CTokenizer(data["source"])
+        result = str(tokens)
+
+        #
+        # Avoid whitespace false positives
+        #
+        result = re.sub(r"\s++", " ", result).strip()
+        expected = re.sub(r"\s++", " ", data["trimmed"]).strip()
+
+        msg = f"failed when parsing this source:\n{data['source']}"
+        self.assertEqual(result, expected, msg=msg)
+
+    return test
+
 #: Tests to check if CTokenizer is handling properly public/private comments.
 TESTS_PRIVATE = {
     #
     # Simplest case: no private. Ensure that trimming won't affect struct
     #
+    "__run__": make_private_test,
     "no private": {
         "source": """
             struct foo {
@@ -288,41 +311,45 @@ TESTS_PRIVATE = {
     },
 }
 
+#: Dict containing all test groups fror CTokenizer
+TESTS = {
+    "TestPublicPrivate": TESTS_PRIVATE,
+}
 
-class TestPublicPrivate(unittest.TestCase):
-    """
-    Main test class. Populated dynamically at runtime.
-    """
+def setUp(self):
+    self.maxDiff = None
 
-    def setUp(self):
-        self.maxDiff = None
+def build_test_class(group_name, table):
+    """
+    Dynamically creates a class instance using type() as a generator
+    for a new class derivated from unittest.TestCase.
 
-    def add_test(cls, name, source, trimmed):
-        """
-        Dynamically add a test to the class
-        """
-        def test(cls):
-            result = trim_private_members(source)
+    We're opting to do it inside a function to avoid the risk of
+    changing the globals() dictionary.
+    """
 
-            result = re.sub(r"\s++", " ", result).strip()
-            expected = re.sub(r"\s++", " ", trimmed).strip()
+    class_dict = {
+        "setUp": setUp
+    }
 
-            msg = f"failed when parsing this source:\n" + source
+    run = table["__run__"]
 
-            cls.assertEqual(result, expected, msg=msg)
+    for test_name, data in table.items():
+        if test_name == "__run__":
+            continue
 
-        test.__name__ = f'test {name}'
+        class_dict[f"test_{test_name}"] = run(test_name, data)
 
-        setattr(TestPublicPrivate, test.__name__, test)
+    cls = type(group_name, (unittest.TestCase,), class_dict)
 
+    return cls.__name__, cls
 
 #
-# Populate TestPublicPrivate class
+# Create classes and add them to the global dictionary
 #
-test_class = TestPublicPrivate()
-for name, test in TESTS_PRIVATE.items():
-    test_class.add_test(name, test["source"], test["trimmed"])
-
+for group, table in TESTS.items():
+    t = build_test_class(group, table)
+    globals()[t[0]] = t[1]
 
 #
 # main
-- 
2.52.0

