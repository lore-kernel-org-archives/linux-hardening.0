Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F43BD638;
	Thu, 12 Mar 2026 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327300; cv=none; b=dYkmTpMMZ2HUtKTNBAPDe0QCdT68LtgR5QVFN++y0JdCd9XtNM0/Gyl7gK6/Hl3x2EmMXZCL4XVYCQR5Qt/DVwmRmb0jteGxjXscMXfQOy33gREqJ2IzcyjZYHC3cJ5gfZGZXRp5njowl8rpZDEa+rD2P6UDE4xmbXunZRn+3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327300; c=relaxed/simple;
	bh=EY9AfgDGU0mksVrXJ3N/EicUXh9pcg8Dz+yFEsPHERA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jN14GzjUyuV+dArqd+Hla4OV5hn+mNWxkWEMlUXn5liO6qqsicdP6hYzD9Q8Rmf5T5bhPDOo+QqA4gMPthNmPymQXFNmvh0wTVnKOwhV3iQ4qWBsJG42+AucUqgfjbnJ3J3JgQXq1uu5xvJ49sYcW0Uurks9vSZgLMQHbMwBNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6lOgThh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6lOgThh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F48C2BC87;
	Thu, 12 Mar 2026 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327299;
	bh=EY9AfgDGU0mksVrXJ3N/EicUXh9pcg8Dz+yFEsPHERA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6lOgThhba2sr8eKWSV81IVkbcC4R/hiWzeG6pWRDXWcdOeCw3Ae05PviLzCueVRm
	 khspUjzVAeMms8+AEU1nFROyJ9VdWHoQX7XCoV0mNsCRJDgsEw3h4cNTbJ8kb/jHYc
	 AqCrcg/zLQIazkE24MI5Y7WsFA1eBpcTlfquwosMSa+1TTX/ig/w0ND3I71m+/SdVC
	 pR6aKimsKFBMp0CLutj5gWRg5pZG1hEYYpuA1lKtxVG1qHZnmoQ1yhD8fZw0hXLTs5
	 KM7GwFMF5G9fUWZT2INWql3xsHux6TwqoxMtiIPUgNupWMm8/21C1S37FOMuKD0TRb
	 19P3dLpcAq01g==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRB-00000008y07-2xQL;
	Thu, 12 Mar 2026 15:54:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/28] tools: unittests: add tests for CMatch
Date: Thu, 12 Mar 2026 15:54:32 +0100
Message-ID: <6724c26ededd3232f778e68f55ca915e5ea35d27.1773326442.git.mchehab+huawei@kernel.org>
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
2.52.0

