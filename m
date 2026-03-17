Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449337F8CA;
	Tue, 17 Mar 2026 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770988; cv=none; b=Rvz73HpOyqh7tcHx5xKq6UQLc+QKrCn0oG5Lw9TOifzCL82wnl8mSZzIBKnpi/PgumYbYFuUXLujpdl3wpa7AYshTwNsCMe1WZiwoUA6/Y7w2Ry9nb7y8DKcAQtR2hjGzfuoFEOD2jLNqd4/WrpgX/KAeOWnSchZSunv86VeTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770988; c=relaxed/simple;
	bh=iKh3pigxP/quPUOBxGpLOk4xpH0UcU+z50MhBcXBNx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rn6QC3GoQtAgS2z3Nwoj59c++iKvp3xoAU2sSE9eysJz7+wjLt2O1SxxtM8wXNCBcWnwxbOcvyjRwHXdfIi5xY26yDWKWO3CNjl0cNGG+C2ef4lqiNDCsHIdjTmAF54+6JIfrJKcPTsxyEtIMHHcaky8+AlQdWSm3bQvvVTXdHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6gQXVqp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6gQXVqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31AAC4CEF7;
	Tue, 17 Mar 2026 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770988;
	bh=iKh3pigxP/quPUOBxGpLOk4xpH0UcU+z50MhBcXBNx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6gQXVqp6HwGTe/gNzxushF46ipUy7LjRSAMrVFyHocWbwulU2JwaBEXmM3zmFbON
	 HalyB8qNHuNjntW0ZIiS79CvXx1lpAwsqoFB7aAOyozgTfVqGSm4q05FzhKU1Ky2Fh
	 pXcd15LYQ6xHzwzMGWhKqGQzT6ZDKuj2kd1vQhwG70FZPbeaQG1cLhGbunKeUL0trp
	 azDgrXcJuIBxLcaPsExS+n4P4krI2ZQs7qrVQTze3DckHUK/aXnrZjddhU/Gp17YnZ
	 iV0rNWT8XOxKqINzCGwn8QNn5Uou3aT4dx/LdbDDs7KQkVzNpXowD8PwnsUZmgMzLQ
	 LN9QNWYd0NeLw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrS-0000000H5O8-3ks4;
	Tue, 17 Mar 2026 19:09:46 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/22] unittests: test_tokenizer: check if the tokenizer works
Date: Tue, 17 Mar 2026 19:09:28 +0100
Message-ID: <e4b6e880565f40287a69667652adb393879e039b.1773770483.git.mchehab+huawei@kernel.org>
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

Add extra tests to check if the tokenizer is working properly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/unittests/test_tokenizer.py | 108 +++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/tools/unittests/test_tokenizer.py b/tools/unittests/test_tokenizer.py
index 3b1d0b5bd311..5634b4a7283e 100755
--- a/tools/unittests/test_tokenizer.py
+++ b/tools/unittests/test_tokenizer.py
@@ -15,15 +15,118 @@ from unittest.mock import MagicMock
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 sys.path.insert(0, os.path.join(SRC_DIR, "../lib/python"))
 
-from kdoc.c_lex import CTokenizer
+from kdoc.c_lex import CToken, CTokenizer
 from unittest_helper import run_unittest
 
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
+        tuples += [(tok.kind, tok.value, tok.level)]
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
+        # Check if logger is working
+        #
+        if "log_level" in data:
+            with self.assertLogs('kdoc.c_lex', level='ERROR') as cm:
+                tokenizer = CTokenizer(data["source"])
+
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
+            CToken(CToken.ENDSTMT, ";"),
+            CToken(CToken.COMMENT, "// comment"),
+            CToken(CToken.NAME, "float"),
+            CToken(CToken.NAME, "b"),
+            CToken(CToken.OP, "="),
+            CToken(CToken.NUMBER, "1.23"),
+            CToken(CToken.ENDSTMT, ";"),
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
+            CToken(CToken.ENDSTMT, ";", brace_level=1),
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
+            CToken(CToken.ENDSTMT, ";", brace_level=1),
+            CToken(CToken.END, "}"),
+        ],
+    },
+
+    "mismatch_error": {
+        "source": "int a$ = 5;",          # $ is illegal
+        "log_level": "ERROR",
+    },
+}
 
 def make_private_test(name, data):
     """
@@ -314,6 +417,7 @@ TESTS_PRIVATE = {
 #: Dict containing all test groups fror CTokenizer
 TESTS = {
     "TestPublicPrivate": TESTS_PRIVATE,
+    "TestTokenizer": TESTS_TOKENIZER,
 }
 
 def setUp(self):
-- 
2.52.0

