Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2ED350286;
	Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409610; cv=none; b=WyvkmYPnkAe8/sYAbNrd8fS9TDq1k4c1DPJWB2/rYFWa+fmeqPyDCUZcSiqHuK0S9kJmrgZbXTKz4z45r+OSpZHw8cOIg2X8exCSb6b+kBQyRcTeB4TV6Hr8OC7du8q7pdVtXiDi2DbnyL2O8lpQragtaww/9qQQzV7p3cR9CX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409610; c=relaxed/simple;
	bh=vr6braZddKgoYGrWnqS65Mye11jx/ixo713d+HFrhJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ve0M5gRqu1e4X/QLdNZ+ij88kHLkYCbl0RdhuMB83w+ZB+kJgCLhfsIXhCgztt2oII+uYFnvI4ASiBOrm5UKdMCyS+NPerzChD2FiUmn+q/Gsbt4StGzRzCXXZnK9QKzc3cNfPvArM3EzeH8/cpoex6RPECmfniCzRxEXndQ3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWlB+dWv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWlB+dWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE58C19423;
	Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409610;
	bh=vr6braZddKgoYGrWnqS65Mye11jx/ixo713d+HFrhJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWlB+dWvLoWppC8mBA0qmB5c3nDT2/AmirhXcP6cEGn2a7M25H9Gv7RhoYoSCVB5f
	 9rfe/g4ukmPFLVwz/QyYY/GZ8bChfo+tUv+oMVDLbOYDgP99PE70F8qLv1hDc1TDZ7
	 UzJnBBUTlZKsT7YiTlypFluMvPTfRLnhoSQhWUpVu35+hhLeBmEgIrxU2Sxb/TcPSv
	 oxoqwpEeQSK11Hg4ko+Nedd+HTPVu8NbsPMzVMinYu8c3vSYxCK7+qctBqB0vjOxRl
	 314TDJCd6Rg9mvBwpfnMK5BBtOCdXMohntcGgJYwXhBp83SuKHjVkldBduyq6KIOYQ
	 Nv++eFu1SYyJA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYi-00000000Lw8-3n8u;
	Wed, 18 Feb 2026 11:13:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 31/38] docs: kdoc_re: Fix NestedMatch.sub() which causes PDF builds to break
Date: Wed, 18 Feb 2026 11:13:01 +0100
Message-ID: <f025e8ed3b01e193977b56df128694c1d2aaeb43.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Having a "\digit"  inside a docstring with normal strings causes
PDF output to break, as it will add a weird character inside the
string. It should be using a raw string instead.

Yet, having r"\0" won't solve, as this would be converted in
Sphinx as "0". So, this has to be inside a pre formatted text.

That's said, the comment itself is probably not the best one.

Rewrite the entire comment to properly document each parameter
and add a "delim" parameter that will be passed to the
ancillary function.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/63e99049-cc72-4156-83af-414fdde34312@gmail.com/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 44af43aa1e93..f67ebe86c458 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -323,22 +323,28 @@ class NestedMatch:
 
         return args
 
-    def sub(self, sub, line, count=0):
-        """
-        This is similar to re.sub:
+    def sub(self, sub, line, delim=",", count=0):
+        r"""
+        Perform a regex‑based replacement on ``line`` for all matches with
+        the ``self.regex`` pattern. It uses the following parameters:
 
-        It matches a regex that it is followed by a delimiter,
-        replacing occurrences only if all delimiters are paired.
+        ``sub``
+            Replacement string that may contain placeholders in the form
+            ``\{digit}``, where  ``digit`` is an integer referring to the regex
+            capture group number.
 
-        if the sub argument contains::
+            ``\{0}`` is a special case that expands to the entire matched text.
 
-            r'\0'
+        ``line``
+            The string to operate on.
 
-        it will work just like re: it places there the matched paired data
-        with the delimiter stripped.
+        ``delim``
+            The delimiter used by identify the placeholder groups
+            (defaults to ",").
 
-        If count is different than zero, it will replace at most count
-        items.
+        ``count``
+            Maximum number of replacements per match.  If 0 or omitted,
+            all matches are replaced.
         """
         out = ""
 
@@ -358,7 +364,7 @@ class NestedMatch:
             # replace arguments
             new_sub = sub
             if "\\" in sub:
-                args = self._split_args(value)
+                args = self._split_args(value, delim=delim)
 
                 new_sub = re.sub(r'\\(\d+)',
                                  lambda m: args[int(m.group(1))], new_sub)
-- 
2.52.0

