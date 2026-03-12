Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8D3ACF1A;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299553; cv=none; b=o55g4NZT46Lf+Nz9EhqZHHhWPgMJApHYDhIS2K5WSJeM4VvM58vZwBmeyUfxgjMEEJxYTS2KOFTzUICpDtB7i3Ww6vdfyQkBmb7sTlypOf8Pq66Bauf9oxU/Dne8Yv3Sq0RYDb1R9SXfb2kU18PDR+kK7Az7QhWLmZ0sWMqEUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299553; c=relaxed/simple;
	bh=itfvAha849vueKehFwP19BJZ38xmpRLLjqZpZ/9bymI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmVSBb1z4EVn44i/7XpSRlvbe2C9Evl/p1v6XqnFtLXKHuj6kNoaiK4O0aZb4jfUs3Q4oovNWy2gv2Z+wtdAGConLr6yok0WTllAncNlZvbwgigRDdL6XNsgA8RFZ2aBpaffF4whqWZG5GmFuh57irVS1RE5m92pTlUtkcsl1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJrl74lv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJrl74lv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B9CC2BCB5;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=itfvAha849vueKehFwP19BJZ38xmpRLLjqZpZ/9bymI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJrl74lv4heo+wRfbFh751Z6W0/21tyRzKKNUEPVgx5zR/bRqM+3AYZvTpygYU8do
	 JCzbQd5NHbx5fwi4iM6WA2qEkhtdaiNqRPNJtYwIDAkNB/ETsHgr5Zz9h6Qn9WeQSf
	 3dNuiUlbGX5sQAdBuPyY7dHMqSZogXncEM4cl2cuyHfzRGnmYWXLibZoYpmjIKEHgd
	 Yri0SVVQ9rAruHdA10k2hssykhajamOgK/ZMVQWQe5fYat02m5PZ8x5Rgu6tVM7ZIw
	 3KhHTvmbYjEXTtZgs1udKZ8fJ7+1M+bDETEpRc5emBSl51LGaH6wCoMpOMQqJF4I9J
	 qWhQs6yw53lTg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077gn-2ZCv;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 12/20] tools: unittests: add tests for CMatch
Date: Thu, 12 Mar 2026 08:12:20 +0100
Message-ID: <6724c26ededd3232f778e68f55ca915e5ea35d27.1773297828.git.mchehab+huawei@kernel.org>
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

The CMatch logic is complex enough to justify tests to ensure
that it is doing its job.

Add unittests to check the functionality provided by CMatch
by replicating expected patterns.

The CMatch class handles with complex macros. Add an unittest
to check if its doing the right thing and detect eventual regressions
as we improve its code.

The initial version was generated using gpt-oss:latest LLM
on my local GPU, as LLMs aren't bad transforming patterns
into unittests.

Yet, the curent version contains only the skeleton of what
LLM produced, as I ended higly changing its content to be
more representative and to have real case scenarios.

The kdoc_xforms test suite contains 3 test groups. Two of
them tests the basic functionality of CMatch to
replace patterns.

The last one (TestRealUsecases) contains real code snippets
from the Kernel with some cleanups to better fit in 80 columns
and uses the same transforms as kernel-doc, thus allowing
to test the logic used inside kdoc_parser to transform
functions, structs and variable patterns.

Its output is like this:

        $ tools/unittests/kdoc_xforms.py
        Ran 25 tests in 0.003s

        OK
	test_cmatch:
	    TestSearch:
	        test_search_acquires_multiple:      OK
	        test_search_acquires_nested_paren:  OK
	        test_search_acquires_simple:        OK
	        test_search_must_hold:              OK
	        test_search_must_hold_shared:       OK
	        test_search_no_false_positive:      OK
	        test_search_no_function:            OK
	        test_search_no_macro_remains:       OK

        Ran 8 tests

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/unittests/test_cmatch.py | 95 ++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100755 tools/unittests/test_cmatch.py

diff --git a/tools/unittests/test_cmatch.py b/tools/unittests/test_cmatch.py
new file mode 100755
index 000000000000..53b25aa4dc4a
--- /dev/null
+++ b/tools/unittests/test_cmatch.py
@@ -0,0 +1,95 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2026: Mauro Carvalho Chehab <mchehab@kernel.org>.
+#
+# pylint: disable=C0413,R0904
+
+
+"""
+Unit tests for kernel-doc CMatch.
+"""
+
+import os
+import re
+import sys
+import unittest
+
+
+# Import Python modules
+
+SRC_DIR = os.path.dirname(os.path.realpath(__file__))
+sys.path.insert(0, os.path.join(SRC_DIR, "../lib/python"))
+
+from kdoc.c_lex import CMatch
+from kdoc.xforms_lists import CTransforms
+from unittest_helper import run_unittest
+
+#
+# Override unittest.TestCase to better compare diffs ignoring whitespaces
+#
+class TestCaseDiff(unittest.TestCase):
+    """
+    Disable maximum limit on diffs and add a method to better
+    handle diffs with whitespace differences.
+    """
+
+    @classmethod
+    def setUpClass(cls):
+        """Ensure that there won't be limit for diffs"""
+        cls.maxDiff = None
+
+
+#
+# Tests doing with different macros
+#
+
+class TestSearch(TestCaseDiff):
+    """
+    Test search mechanism
+    """
+
+    def test_search_acquires_simple(self):
+        line = "__acquires(ctx) foo();"
+        result = ", ".join(CMatch("__acquires").search(line))
+        self.assertEqual(result, "__acquires(ctx)")
+
+    def test_search_acquires_multiple(self):
+        line = "__acquires(ctx) __acquires(other) bar();"
+        result = ", ".join(CMatch("__acquires").search(line))
+        self.assertEqual(result, "__acquires(ctx), __acquires(other)")
+
+    def test_search_acquires_nested_paren(self):
+        line = "__acquires((ctx1, ctx2)) baz();"
+        result = ", ".join(CMatch("__acquires").search(line))
+        self.assertEqual(result, "__acquires((ctx1, ctx2))")
+
+    def test_search_must_hold(self):
+        line = "__must_hold(&lock) do_something();"
+        result = ", ".join(CMatch("__must_hold").search(line))
+        self.assertEqual(result, "__must_hold(&lock)")
+
+    def test_search_must_hold_shared(self):
+        line = "__must_hold_shared(RCU) other();"
+        result = ", ".join(CMatch("__must_hold_shared").search(line))
+        self.assertEqual(result, "__must_hold_shared(RCU)")
+
+    def test_search_no_false_positive(self):
+        line = "call__acquires(foo);  // should stay intact"
+        result = ", ".join(CMatch(r"\b__acquires").search(line))
+        self.assertEqual(result, "")
+
+    def test_search_no_macro_remains(self):
+        line = "do_something_else();"
+        result = ", ".join(CMatch("__acquires").search(line))
+        self.assertEqual(result, "")
+
+    def test_search_no_function(self):
+        line = "something"
+        result = ", ".join(CMatch(line).search(line))
+        self.assertEqual(result, "")
+
+#
+# Run all tests
+#
+if __name__ == "__main__":
+    run_unittest(__file__)
-- 
2.53.0

