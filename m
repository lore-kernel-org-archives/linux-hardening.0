Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C567426ED2;
	Mon,  2 Mar 2026 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469672; cv=none; b=HwX/HvqiCJu7Fs1/Hu0mY2PHPN0oVwiFIRZbO5qLezk5ZX1UH+KcUq7P+0gQVmwDdM3crsWoWWb/3gUgG9rhBDEmvk38Iwb/N440iXi+WxYAwINoX+cI1aOIdUGDHfn1mf4yy1PcNUb3stz+MjNy4J3iV+ljhZwnk5EZu+vnhBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469672; c=relaxed/simple;
	bh=FcrszWhBlb6nxazGa/lNPzUht2XLW2uAQU9wgUZIfpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qh4wLF4o71LWUvYjGYuLJwkO07a6nTAjD3MbOTpz0QN2Xeoh/RmLKA6KasDGbo2r64vuJCa2E7412UjRW4Qr3mKqm5OjNIxJcixi9kjVglwNJy8mz7ZHoHzn+V+b0AimL+8hffi9tA0IixYpZJd0r21Nrp4iD2P8y0yy5CECO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMkZ7Vng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMkZ7Vng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0CBC4AF09;
	Mon,  2 Mar 2026 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469672;
	bh=FcrszWhBlb6nxazGa/lNPzUht2XLW2uAQU9wgUZIfpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMkZ7VngWXZlXBVT1F0VOQ03Q9QVmHA2OTzH3t4BCeumNHZKTZPLgefAB0iQwDCK1
	 lRWpz66WxCZM9e1NW5J48zViiCcz3z+tD1K0WxqQPXxF7sDOdT8fsLOjd2GN45OzKx
	 dbizHHB3m0SA53gv8GJ1LnrfQbQ2675vTtzISXsih7FwrTUFkqJLO+7PEhnV0eUZzX
	 WK0coozlPM4QGySXThfzTTpVQ0vomcXu+H7D1WC/AcubS6yG6kZsKFbZOWgEWw0r59
	 REiNjm5+D7qgeRv5Eq8uoT1PqYfvtQHBNlIdjB/g1oxh0NdNX9TDRIAAierxKGrQ7j
	 fXx5MzgmcrsXw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KT-000000003Gz-42ow;
	Mon, 02 Mar 2026 17:41:09 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 17/18] docs: kdoc_re: make NestedMatch use KernRe
Date: Mon,  2 Mar 2026 17:41:00 +0100
Message-ID: <cdf900faf0ed8a08f8c6ac1db5a43342968c0739.1772469446.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772469446.git.mchehab+huawei@kernel.org>
References: <cover.1772469446.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Instead of using re_compile, let's create the class with the
regex and use KernRe to keep it cached.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 25 ++++++++++++-------------
 tools/lib/python/kdoc/kdoc_re.py     | 24 +++++++++++++++++-------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 0f90c16cb51a..cd9857906a2b 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -75,17 +75,17 @@ doc_begin_func = KernRe(str(doc_com) +			# initial " * '
 # is allowed.
 #
 struct_nested_prefixes = [
-    (re.compile(r"__cond_acquires\s*\("), ""),
-    (re.compile(r"__cond_releases\s*\("), ""),
-    (re.compile(r"__acquires\s*\("), ""),
-    (re.compile(r"__releases\s*\("), ""),
-    (re.compile(r"__must_hold\s*\("), ""),
-    (re.compile(r"__must_not_hold\s*\("), ""),
-    (re.compile(r"__must_hold_shared\s*\("), ""),
-    (re.compile(r"__cond_acquires_shared\s*\("), ""),
-    (re.compile(r"__acquires_shared\s*\("), ""),
-    (re.compile(r"__releases_shared\s*\("), ""),
-    (re.compile(r'\bSTRUCT_GROUP\('), r'\0'),
+    (NestedMatch(r"__cond_acquires\s*\("), ""),
+    (NestedMatch(r"__cond_releases\s*\("), ""),
+    (NestedMatch(r"__acquires\s*\("), ""),
+    (NestedMatch(r"__releases\s*\("), ""),
+    (NestedMatch(r"__must_hold\s*\("), ""),
+    (NestedMatch(r"__must_not_hold\s*\("), ""),
+    (NestedMatch(r"__must_hold_shared\s*\("), ""),
+    (NestedMatch(r"__cond_acquires_shared\s*\("), ""),
+    (NestedMatch(r"__acquires_shared\s*\("), ""),
+    (NestedMatch(r"__releases_shared\s*\("), ""),
+    (NestedMatch(r'\bSTRUCT_GROUP\('), r'\0'),
 ]
 
 #
@@ -761,9 +761,8 @@ class KernelDoc:
         members = trim_private_members(members)
         members = self.xforms.apply("struct", members)
 
-        nested = NestedMatch()
         for search, sub in struct_nested_prefixes:
-            members = nested.sub(search, sub, members)
+            members = search.sub(search, sub, members)
         #
         # Deal with embedded struct and union members, and drop enums entirely.
         #
diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index ea4f6f3d9e42..085b89a4547c 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -200,7 +200,10 @@ class NestedMatch:
     #
     #   FOO(arg1, arg2, arg3)
 
-    def _search(self, regex, line):
+    def __init__(self, regex):
+        self.regex = KernRe(regex)
+
+    def _search(self, line):
         """
         Finds paired blocks for a regex that ends with a delimiter.
 
@@ -222,7 +225,7 @@ class NestedMatch:
 
         stack = []
 
-        for match_re in regex.finditer(line):
+        for match_re in self.regex.finditer(line):
             start = match_re.start()
             offset = match_re.end()
             string_char = None
@@ -270,7 +273,7 @@ class NestedMatch:
                         yield start, offset, pos + 1
                         break
 
-    def search(self, regex, line):
+    def search(self, line):
         """
         This is similar to re.search:
 
@@ -278,12 +281,12 @@ class NestedMatch:
         returning occurrences only if all delimiters are paired.
         """
 
-        for t in self._search(regex, line):
+        for t in self._search(line):
 
             yield line[t[0]:t[2]]
 
-    def sub(self, regex, sub, line, count=0):
-        r"""
+    def sub(self, sub, line, count=0):
+        """
         This is similar to re.sub:
 
         It matches a regex that it is followed by a delimiter,
@@ -304,7 +307,7 @@ class NestedMatch:
         cur_pos = 0
         n = 0
 
-        for start, end, pos in self._search(regex, line):
+        for start, end, pos in self._search(line):
             out += line[cur_pos:start]
 
             # Value, ignoring start/end delimiters
@@ -331,3 +334,10 @@ class NestedMatch:
         out += line[cur_pos:l]
 
         return out
+
+    def __repr__(self):
+        """
+        Returns a displayable version of the class init.
+        """
+
+        return f'NestedMatch("{self.regex.regex.pattern}")'
-- 
2.52.0

