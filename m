Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D193C7E0F;
	Thu, 12 Mar 2026 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327302; cv=none; b=OAP4otGjwWgdyTzVpjT5lN2XTMuZMCItyLLsZoi2a3r8coj9sKCx7aoVzmQb1qPN/PZLU3vdz8plGz62AmhaFdhYAPzrgqL8Z1ZVW/Hoj/FqtWl+417wEB9p12bmD4w10Bk1rIt4XFh0bsBhb2WQCUM01V629r/3DSch2Gq1BJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327302; c=relaxed/simple;
	bh=Ivzj5p0x4Q8l2OC2OB+jBO38HqdWt02WQNEVEu6ZxqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZGhL2ZJ8Mz/496C9uaYLEOnF2m/ylh1MmNCYTeeJr1vSN3n7OwSqUUY6KRzcRFg2JtHcFo2eJwb6ZHkxLAftTNoiA+UaEEc3sJ5+2X1+JzJ6UQQ3vavWZDaT5Yz3HKZnrpt0z0+3YKXkVamu5zBT5evZSFyMDg1hAtu1+xy9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn6yDNRd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn6yDNRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36F6C2BC86;
	Thu, 12 Mar 2026 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327301;
	bh=Ivzj5p0x4Q8l2OC2OB+jBO38HqdWt02WQNEVEu6ZxqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fn6yDNRdaEmsepdqPlD19wZLeauGChAFOYIS+lec2GcBign+9CzJTISdYyfa92X6P
	 yBCyjzE77fZLQi9JocRz/wdPYwfOy9ynLvn/Qcxy2kYP+UrIlrQUA+8YlyMtxKRNjB
	 21Kkq96KDrEYBH3kg+8wZK7HmvjnrcCtxJzTht8n8Zxydr4r2Xvho9k0QFealpJSvO
	 b5lOWUDse+k5bRIVDzqsC7KWRGr5BOPQMdg1lahXarcrK0HTqlzkPZwpi0OXEKRMWm
	 /L+dJ4pwti6Js8bTGh8ss/qHpeJLl1SXLzIgIn5l4yNsvdVAnCPXhqEcgz5yclDDHy
	 9HZJzMFF+uJYg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRE-00000008yFM-0IeP;
	Thu, 12 Mar 2026 15:55:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/28] docs: unittests: add and adjust tests to check for errors
Date: Thu, 12 Mar 2026 15:54:44 +0100
Message-ID: <c7614bdb4edb48d1d4f50e6fddfbb247281c0ad9.1773326442.git.mchehab+huawei@kernel.org>
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

Test the errors that are rised and the ones that are logged.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py    |  2 +-
 tools/unittests/test_cmatch.py    | 15 ++++++++++++++-
 tools/unittests/test_tokenizer.py | 11 ++++++-----
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index 596510bb4e95..8beac59166fc 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -194,7 +194,7 @@ class CTokenizer():
             value = match.group()
 
             if kind == CToken.MISMATCH:
-                log.error(f"Unexpected token '{value}' on {pos}:\n\t{source}")
+                log.error(f"Unexpected token '{value}' on pos {pos}:\n\t'{source}'")
             elif kind == CToken.BEGIN:
                 if value == '(':
                     paren_level += 1
diff --git a/tools/unittests/test_cmatch.py b/tools/unittests/test_cmatch.py
index f6ccd2a942f1..3fbc5d3bc244 100755
--- a/tools/unittests/test_cmatch.py
+++ b/tools/unittests/test_cmatch.py
@@ -288,6 +288,19 @@ class TestSubSimple(TestCaseDiff):
 
         self.assertLogicallyEqual(result, "int foo;")
 
+    def test_rise_early_greedy(self):
+        line = f"{self.MACRO}(a, b, c, d);"
+        sub = r"\1, \2+, \3"
+
+        with self.assertRaises(ValueError):
+            result = self.matcher.sub(sub, line)
+
+    def test_rise_multiple_greedy(self):
+        line = f"{self.MACRO}(a, b, c, d);"
+        sub = r"\1, \2+, \3+"
+
+        with self.assertRaises(ValueError):
+            result = self.matcher.sub(sub, line)
 
 #
 # Test replacements with slashrefs
@@ -539,7 +552,7 @@ class TestSubWithLocalXforms(TestCaseDiff):
         self.assertLogicallyEqual(result, expected)
 
     def test_raw_struct_group_tagged(self):
-        """
+        r"""
         Test cxl_regs with struct_group_tagged patterns from drivers/cxl/cxl.h.
 
         NOTE:
diff --git a/tools/unittests/test_tokenizer.py b/tools/unittests/test_tokenizer.py
index 3081f27a7786..6a0bd49df72e 100755
--- a/tools/unittests/test_tokenizer.py
+++ b/tools/unittests/test_tokenizer.py
@@ -44,11 +44,12 @@ def make_tokenizer_test(name, data):
         """In-lined lambda-like function to run the test"""
 
         #
-        # Check if exceptions are properly handled
+        # Check if logger is working
         #
-        if "raises" in data:
-            with self.assertRaises(data["raises"]):
-                CTokenizer(data["source"])
+        if "log_level" in data:
+            with self.assertLogs('kdoc.c_lex', level='ERROR') as cm:
+                tokenizer = CTokenizer(data["source"])
+
             return
 
         #
@@ -123,7 +124,7 @@ TESTS_TOKENIZER = {
 
     "mismatch_error": {
         "source": "int a$ = 5;",          # $ is illegal
-        "raises": RuntimeError,
+        "log_level": "ERROR",
     },
 }
 
-- 
2.52.0

