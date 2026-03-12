Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16BF38644E;
	Thu, 12 Mar 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327298; cv=none; b=tUCMq8xfTWR6Q6qXp3Y/dqEvFM/ZFzkV9Q8lqmfPBKGwDl7gZnt383C+aBWE9miUD27IR/fLN1euxxQNJZixgS4G4imJERd23JeNJbnQDnFyjhuGEIIeSdCJaEKy0Wjnnk9IBNeaTht9ld4m61UzmvQAo05tnN4ywl0fGS/Judg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327298; c=relaxed/simple;
	bh=PN21ro6+xB/n6kAhkQ1VdDFAJ9yebb68KbPqP0I8PD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOYSSeZ2VEdCNDyrUDffII9zTa34YrymYSzf7G2CDqOM2qhSqqvb/Pv18zbyd8yOUoA4xEGdDxjfglsFckN2HzeITynObmLQEVRJH0n//21us/cxzaPqm0bKdclox/t0IQnNrmTmx/RP13gIxhDs2r0SueNyCp5I1MdBZaSgqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxviCkZs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxviCkZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2A5C4CEF7;
	Thu, 12 Mar 2026 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327298;
	bh=PN21ro6+xB/n6kAhkQ1VdDFAJ9yebb68KbPqP0I8PD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxviCkZsPU3FF5fkDt5ldBapsbk2IWXoj0n9s/3zQPaU3khh8ClIPKaYFPp2P7CYG
	 0SMyLQk/9p426Z4MKODFU9VGbJuzX7oNRlgVv4O3tuxsT+AUbiVOmbnao+q/MyLIIx
	 ag2gLwb7mxBU3OlBrj7o4oG8xypvhhTCI/w/83qBslLJtHgwXPZzDKPVBTd22Z7n5j
	 oYpPOff2g2x/hXEmZ6+Ae/p10HYtbx5ukixK2WwT41MrGrdBxCVpXYDjzi7pBYwT6I
	 PLwKS6wW4cIZkqplg/9xhrgqTtG8YvA5JkUWR2LNtLngw6z3/KebtCy+jghNlrWuVD
	 BYrR02PKxpWLQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRA-00000008xus-3jXz;
	Thu, 12 Mar 2026 15:54:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/28] unittests: test_private: modify it to use CTokenizer directly
Date: Thu, 12 Mar 2026 15:54:28 +0100
Message-ID: <eeb01b2c5e7f6f67a4864f0361a1ba7ad58e3747.1773326442.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773326442.git.mchehab+huawei@kernel.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
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
 .../{test_private.py => test_tokenizer.py}    | 76 +++++++++++++------
 1 file changed, 52 insertions(+), 24 deletions(-)
 rename tools/unittests/{test_private.py => test_tokenizer.py} (85%)

diff --git a/tools/unittests/test_private.py b/tools/unittests/test_tokenizer.py
similarity index 85%
rename from tools/unittests/test_private.py
rename to tools/unittests/test_tokenizer.py
index eae245ae8a12..da0f2c4c9e21 100755
--- a/tools/unittests/test_private.py
+++ b/tools/unittests/test_tokenizer.py
@@ -15,20 +15,44 @@ from unittest.mock import MagicMock
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 sys.path.insert(0, os.path.join(SRC_DIR, "../lib/python"))
 
-from kdoc.kdoc_parser import trim_private_members
+from kdoc.kdoc_re import CTokenizer
 from unittest_helper import run_unittest
 
+
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
@@ -288,41 +312,45 @@ TESTS_PRIVATE = {
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

