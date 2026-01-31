Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374BE358D04;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=a9KNBOnKRSBRmMBlXBIEQU9Ij7w26wIflF8+BvFex0MkKGHoROA0OyMk6MMwMbtVkas5JWyRCISnph/l2mrGaeEVAPDkPZPG+8IMxpRMai89oB36lLzTeSUL18dFBK2+RIOiq2t1UJr32aS85t8Iqg7hVjM/sFboP+YlVOuU6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=4M1YK6ZJUo4rGAubeAeexggWDOfAzOxlq3GsBbCweOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efhSUbnfry5FLFXR2Ps+ylhIFaHQ9mEo2MLA6377tIa0yWpr81FNYxAafAaBV1sMaIZUAYsQtMS32WJg8IR2aoAJeDC4+Q7oNnzxrg+isPdx8agg2QGyVU+FLXR0CGRBx80P8KyVPfsE7VjsE9wcqpY9KPWBkYtYB/FkN72RH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGAySrqK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGAySrqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB7EC4AF09;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=4M1YK6ZJUo4rGAubeAeexggWDOfAzOxlq3GsBbCweOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGAySrqK+FUoVyvfESY+zPPzry/nIvZYIBTGlQVoAUsUni7DbNWAyr4MVctd06Saa
	 7mx6c57UyhnrBfZuCKDWBaX3Fxr/yVqUq5UgvCdBASa4py9n8B3XegPb9WPjWKSbDn
	 ynMejjIx8CcRJE8ZMF5e6xcW/l3nZHATpMiiyV/BTYgtkPZ9W3D2NtL8eIfRESqHf3
	 j5wlPU3it89qGDFzG8yq0ASR1iXdPkJ6bB9HlCdJg+R17JglELBEfl/F0/Fx/xsr+e
	 4k3ou29LSiC3kwpZvA8sj4RLErf/1JarLl2nvF5s1D88tl+eqFW4RcgVp+uf5Dm9+f
	 v857d/YNoMptg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVky-3UDo;
	Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 19/41] docs: kdoc_re: make NestedMatch use KernRe
Date: Sat, 31 Jan 2026 15:24:53 +0100
Message-ID: <c75c6e6a367e4305105cac64e0162118581d329f.1769867953.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
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
 tools/lib/python/kdoc/kdoc_parser.py | 55 ++++++++--------------------
 tools/lib/python/kdoc/kdoc_re.py     | 22 ++++++++---
 2 files changed, 32 insertions(+), 45 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 4d52a00acfad..3a5614106af7 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -153,32 +153,7 @@ struct_xforms = [
     (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
     (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
     (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
-]
-#
-# Struct regexes here are guaranteed to have the end delimiter matching
-# the start delimiter. Yet, right now, only one replace group
-# is allowed.
-#
-struct_nested_prefixes = [
-    (re.compile(r'\bSTRUCT_GROUP\('), r'\0'),
-]
-
-#
-# Function Regexes here are guaranteed to have the end delimiter matching
-# the start delimiter.
-#
-function_nested_prefixes = [
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
-    (re.compile(r"__attribute__\s*\("), ""),
+    (NestedMatch(r'\bSTRUCT_GROUP\('), r'\0'),
 ]
 
 #
@@ -210,6 +185,17 @@ function_xforms = [
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
     (KernRe(r"__no_context_analysis\s*"), ""),
     (KernRe(r"__attribute_const__ +"), ""),
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
+    (NestedMatch(r"__attribute__\s*\("), ""),
 ]
 
 #
@@ -230,7 +216,6 @@ var_xforms = [
 # Ancillary functions
 #
 
-
 multi_space = KernRe(r'\s\s+')
 def trim_whitespace(s):
     """
@@ -424,8 +409,6 @@ class KernelDoc:
         # Place all potential outputs into an array
         self.entries = []
 
-        self.nested = NestedMatch()
-
         #
         # We need Python 3.7 for its "dicts remember the insertion
         # order" guarantee
@@ -523,14 +506,11 @@ class KernelDoc:
         # State flags
         self.state = state.NORMAL
 
-    def apply_transforms(self, regex_xforms, nested_xforms, text):
+    def apply_transforms(self, xforms, text):
         """Apply a set of transforms to a block of text."""
-        for search, subst in regex_xforms:
+        for search, subst in xforms:
             text = search.sub(subst, text)
 
-        for search, sub in nested_xforms:
-            text = self.nested.sub(search, sub, text)
-
         return text.strip()
 
     def push_parameter(self, ln, decl_type, param, dtype,
@@ -909,8 +889,7 @@ class KernelDoc:
         # Go through the list of members applying all of our transformations.
         #
         members = trim_private_members(members)
-        members = self.apply_transforms(struct_xforms, struct_nested_prefixes,
-                                        members)
+        members = self.apply_transforms(struct_xforms, members)
 
         #
         # Deal with embedded struct and union members, and drop enums entirely.
@@ -1125,9 +1104,7 @@ class KernelDoc:
             #
             # Apply the initial transformations.
             #
-            prototype = self.apply_transforms(function_xforms,
-                                              function_nested_prefixes,
-                                              prototype)
+            prototype = self.apply_transforms(function_xforms, prototype)
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 8933e1a62776..e34d55c25680 100644
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
 
@@ -278,11 +281,11 @@ class NestedMatch:
         returning occurrences only if all delimiters are paired.
         """
 
-        for t in self._search(regex, line):
+        for t in self._search(line):
 
             yield line[t[0]:t[2]]
 
-    def sub(self, regex, sub, line, count=0):
+    def sub(self, sub, line, count=0):
         """
         This is similar to re.sub:
 
@@ -301,7 +304,7 @@ class NestedMatch:
         cur_pos = 0
         n = 0
 
-        for start, end, pos in self._search(regex, line):
+        for start, end, pos in self._search(line):
             out += line[cur_pos:start]
 
             # Value, ignoring start/end delimiters
@@ -328,3 +331,10 @@ class NestedMatch:
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

