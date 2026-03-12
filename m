Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9AF358389;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299553; cv=none; b=amQEU19erHRzwB3qXJoc0z0VVhI3BTFIm64o3/2SBRZyA9kTscvluAeZw+iK/oaN2gsJCEv3CZiMRGU5zgHDbCjLRQ2Mqw+NTNW4CsVmTj1/Si+gfFk84yE92sdt4KCF6GKmA1U5tM5bMb6AHwQgTQQyJJuC3PnwBcZ+g67hxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299553; c=relaxed/simple;
	bh=PBAIltyp/3ki4zWgumnkgvMbL5HEay2TKxHmsD6xLjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BP9n4s7tXn1igx6FRF8d2RtzS7+F0D6viHmDZtmBP/qET2Mui1FNPj+2MGTFEcGl/zYsMHYA34Y4Gi/ijnbzIpiLGu9f5ZhplWH60KyLJoKZ4k7se7sTP6Fp/0j/GhpQEIbiNqlbucDmzgqS/rUCJdtXqj01UnNb1SRcxXouLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f56AkCuL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f56AkCuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55455C2BC87;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=PBAIltyp/3ki4zWgumnkgvMbL5HEay2TKxHmsD6xLjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f56AkCuLttQwji7AenyaHJwygBufbLaJkHjnk3UTnr6cJa2OCYNR424ZrLvFZG661
	 cG4BZ5F2kLLxwAHPfIYiN0i5l+uiWho1+GVSHwKzT774ZKFUuyCJYpxF2bHbThsf/q
	 E/IfFN856SABMjR8eGQkQzQaUg7ILvqGA+ZcEyhXwWmoQiRGyguoSnjL8fyxgkJTLR
	 OdBEz+uY7jF+9mUrYBggGVmusKHBHwmr9ijrbXwWGdAkqTIcwRW8a6z5bCVpAtpkG8
	 64cPWU0hl4Xx56XLnZvfCI5MUFIVTBEYlQtNk1Dm6q5exKIiM1/dyZaiIN+Kk4JSJB
	 mmIoh6jRcNZyQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077ga-2Dsr;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 09/20] unittests: test_tokenizer: check if the tokenizer works
Date: Thu, 12 Mar 2026 08:12:17 +0100
Message-ID: <6afe36c248f0f9280ce0ed456d878a1f718794a5.1773297828.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773297828.git.mchehab+huawei@kernel.org>
References: <cover.1773297828.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Add extra tests to check if the tokenizer is working properly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py    |   4 +-
 tools/unittests/test_tokenizer.py | 109 +++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index a104c29b63fb..38f70e836eb8 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -58,8 +58,8 @@ class CToken():
 
         return CToken.MISMATCH
 
-    def __init__(self, kind, value, pos,
-                 brace_level, paren_level, bracket_level):
+    def __init__(self, kind, value=None, pos=0,
+                 brace_level=0, paren_level=0, bracket_level=0):
         self.kind = kind
         self.value = value
         self.pos = pos
diff --git a/tools/unittests/test_tokenizer.py b/tools/unittests/test_tokenizer.py
index da0f2c4c9e21..efb1d1687811 100755
--- a/tools/unittests/test_tokenizer.py
+++ b/tools/unittests/test_tokenizer.py
@@ -15,16 +15,118 @@ from unittest.mock import MagicMock
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 sys.path.insert(0, os.path.join(SRC_DIR, "../lib/python"))
 
-from kdoc.kdoc_re import CTokenizer
+from kdoc.c_lex import CToken, CTokenizer
 from unittest_helper import run_unittest
 
-
-
 #
 # List of tests.
 #
 # The code will dynamically generate one test for each key on this dictionary.
 #
+def tokens_to_list(tokens):
+    tuples = []
+
+    for tok in tokens:
+        if tok.kind == CToken.SPACE:
+            continue
+
+        tuples += [(tok.kind, tok.value,
+                    tok.brace_level, tok.paren_level, tok.bracket_level)]
+
+    return tuples
+
+
+def make_tokenizer_test(name, data):
+    """
+    Create a test named ``name`` using parameters given by ``data`` dict.
+    """
+
+    def test(self):
+        """In-lined lambda-like function to run the test"""
+
+        #
+        # Check if exceptions are properly handled
+        #
+        if "raises" in data:
+            with self.assertRaises(data["raises"]):
+                CTokenizer(data["source"])
+            return
+
+        #
+        # Check if tokenizer is producing expected results
+        #
+        tokens = CTokenizer(data["source"]).tokens
+
+        result = tokens_to_list(tokens)
+        expected = tokens_to_list(data["expected"])
+
+        self.assertEqual(result, expected, msg=f"{name}")
+
+    return test
+
+#: Tokenizer tests.
+TESTS_TOKENIZER = {
+    "__run__": make_tokenizer_test,
+
+    "basic_tokens": {
+        "source": """
+            int a; // comment
+            float b = 1.23;
+        """,
+        "expected": [
+            CToken(CToken.NAME, "int"),
+            CToken(CToken.NAME, "a"),
+            CToken(CToken.PUNC, ";"),
+            CToken(CToken.COMMENT, "// comment"),
+            CToken(CToken.NAME, "float"),
+            CToken(CToken.NAME, "b"),
+            CToken(CToken.OP, "="),
+            CToken(CToken.NUMBER, "1.23"),
+            CToken(CToken.PUNC, ";"),
+        ],
+    },
+
+    "depth_counters": {
+        "source": """
+            struct X {
+                int arr[10];
+                func(a[0], (b + c));
+            }
+        """,
+        "expected": [
+            CToken(CToken.STRUCT, "struct"),
+            CToken(CToken.NAME, "X"),
+            CToken(CToken.BEGIN, "{", brace_level=1),
+
+            CToken(CToken.NAME, "int", brace_level=1),
+            CToken(CToken.NAME, "arr", brace_level=1),
+            CToken(CToken.BEGIN, "[", brace_level=1, bracket_level=1),
+            CToken(CToken.NUMBER, "10", brace_level=1, bracket_level=1),
+            CToken(CToken.END, "]", brace_level=1),
+            CToken(CToken.PUNC, ";", brace_level=1),
+            CToken(CToken.NAME, "func", brace_level=1),
+            CToken(CToken.BEGIN, "(", brace_level=1, paren_level=1),
+            CToken(CToken.NAME, "a", brace_level=1, paren_level=1),
+            CToken(CToken.BEGIN, "[", brace_level=1, paren_level=1, bracket_level=1),
+            CToken(CToken.NUMBER, "0", brace_level=1, paren_level=1, bracket_level=1),
+            CToken(CToken.END, "]", brace_level=1, paren_level=1),
+            CToken(CToken.PUNC, ",", brace_level=1, paren_level=1),
+            CToken(CToken.BEGIN, "(", brace_level=1, paren_level=2),
+            CToken(CToken.NAME, "b", brace_level=1, paren_level=2),
+            CToken(CToken.OP, "+", brace_level=1, paren_level=2),
+            CToken(CToken.NAME, "c", brace_level=1, paren_level=2),
+            CToken(CToken.END, ")", brace_level=1, paren_level=1),
+            CToken(CToken.END, ")", brace_level=1),
+            CToken(CToken.PUNC, ";", brace_level=1),
+            CToken(CToken.END, "}"),
+        ],
+    },
+
+    "mismatch_error": {
+        "source": "int a$ = 5;",          # $ is illegal
+        "raises": RuntimeError,
+    },
+}
 
 def make_private_test(name, data):
     """
@@ -315,6 +417,7 @@ TESTS_PRIVATE = {
 #: Dict containing all test groups fror CTokenizer
 TESTS = {
     "TestPublicPrivate": TESTS_PRIVATE,
+    "TestTokenizer": TESTS_TOKENIZER,
 }
 
 def setUp(self):
-- 
2.53.0

