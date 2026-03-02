Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486842669A;
	Mon,  2 Mar 2026 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469671; cv=none; b=sZaJASJwTRwGEp3wxmKEycbCUWDB5hoeREIvTBV/YQRNPPnIVYiv/QIYTB50zl1g712WcC318SPMZS7Ay5FCdUN72XX3uU9kVXq3FfrS3CEKMrdmMjojgsSpFVPZACUffJ3XnL/Ux4q+ltM5H9CcxHK66h0sq1N6vXqGqAOEq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469671; c=relaxed/simple;
	bh=Pg1w6h3oi09pGfE7ZeyRQdHpAcI21wEKTI+1Owlib1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQ86hu7CXX78MPdblnuRPcSLM1OpPyQDNlma3v2NfVd6Nhgf65c5LdzgodCjaxUdX9l88TfUKZ8aYi40ys4qEg6KdD4bWHDCBFAJ50ME80eEH8DxxsePtiAEzUx9V/EG9FBH/8Dg42TNnEnPgrl6U/HOUWPQI3mx1Ian/pT5eo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJzH6I4K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJzH6I4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07BCC19423;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469671;
	bh=Pg1w6h3oi09pGfE7ZeyRQdHpAcI21wEKTI+1Owlib1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJzH6I4K60Z7qHWMaoM3bGBRHPE+Ue73dpmFCrOCx0mNr8ohxsUQNrA2+siBkNKNN
	 NXwEzarqiFpS89GTGh6eQKO/pzp+pprnuWJBwnEe7ZIHrV12BQd66zSUWktBKO8hTX
	 yDJqUnKIhBeC1RaYFEHoou+rpAxCub4QiJCP3EkUx9JXQLIAUM8KDxH+0tSwSI6XcT
	 g1EdmYdGaQh/ja3+O2+gNx9MV+eozNjII10t4sZJd8EogcTkse3x1NiOLKsbWo5EJn
	 FSpRoBd3uZp90ZHekkOdsquzDlVuzd6MFAoXDKOhWsQuFsJAfN6A1RXgsGcrWw9kIB
	 GsKhS6qnfbDnA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KT-000000003Am-00Xd;
	Mon, 02 Mar 2026 17:41:09 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Kees Cook <kees@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 12/18] docs: kdoc_parser: move transform lists to a separate file
Date: Mon,  2 Mar 2026 17:40:55 +0100
Message-ID: <ccd74b7589e1fff340a74bf8ed16a974532cb54f.1772469446.git.mchehab+huawei@kernel.org>
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

Over the time, most of the changes at kernel-doc are related
to maintaining a list of transforms to convert macros into pure
C code.

Place such transforms on a separate module, to cleanup the
parser module.

There is an advantage on that: QEMU also uses our own kernel-doc,
but the xforms list there is different. By placing it on a
separate module, we can minimize the differences and make it
easier to keep QEMU in sync with Kernel upstream.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 Documentation/tools/kdoc_parser.rst   |   8 ++
 tools/lib/python/kdoc/kdoc_files.py   |   3 +-
 tools/lib/python/kdoc/kdoc_parser.py  | 145 +-----------------------
 tools/lib/python/kdoc/xforms_lists.py | 153 ++++++++++++++++++++++++++
 4 files changed, 168 insertions(+), 141 deletions(-)
 create mode 100644 tools/lib/python/kdoc/xforms_lists.py

diff --git a/Documentation/tools/kdoc_parser.rst b/Documentation/tools/kdoc_parser.rst
index 03ee54a1b1cc..55b202173195 100644
--- a/Documentation/tools/kdoc_parser.rst
+++ b/Documentation/tools/kdoc_parser.rst
@@ -4,6 +4,14 @@
 Kernel-doc parser stage
 =======================
 
+C replacement rules used by the parser
+======================================
+
+.. automodule:: lib.python.kdoc.xforms_lists
+   :members:
+   :show-inheritance:
+   :undoc-members:
+
 File handler classes
 ====================
 
diff --git a/tools/lib/python/kdoc/kdoc_files.py b/tools/lib/python/kdoc/kdoc_files.py
index 022487ea2cc6..33618c6abec2 100644
--- a/tools/lib/python/kdoc/kdoc_files.py
+++ b/tools/lib/python/kdoc/kdoc_files.py
@@ -15,6 +15,7 @@ import os
 import re
 
 from kdoc.kdoc_parser import KernelDoc
+from kdoc.xforms_lists import CTransforms
 from kdoc.kdoc_output import OutputFormat
 
 
@@ -117,7 +118,7 @@ class KernelFiles():
         if fname in self.files:
             return
 
-        doc = KernelDoc(self.config, fname)
+        doc = KernelDoc(self.config, fname, CTransforms())
         export_table, entries = doc.parse_kdoc()
 
         self.export_table[fname] = export_table
diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 917e4528bfbf..d7daf658e9d2 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -69,89 +69,6 @@ doc_begin_func = KernRe(str(doc_com) +			# initial " * '
                         r'(?:[-:].*)?$',		# description (not captured)
                         cache = False)
 
-#
-# Here begins a long set of transformations to turn structure member prefixes
-# and macro invocations into something we can parse and generate kdoc for.
-#
-struct_args_pattern = r'([^,)]+)'
-
-struct_xforms = [
-    # Strip attributes
-    (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
-    (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
-    (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
-    (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
-    (KernRe(r'\s*__packed\s*', re.S), ' '),
-    (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
-    (KernRe(r'\s*__private', re.S), ' '),
-    (KernRe(r'\s*__rcu', re.S), ' '),
-    (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
-    (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
-    (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
-    #
-    # Unwrap struct_group macros based on this definition:
-    # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
-    # which has variants like: struct_group(NAME, MEMBERS...)
-    # Only MEMBERS arguments require documentation.
-    #
-    # Parsing them happens on two steps:
-    #
-    # 1. drop struct group arguments that aren't at MEMBERS,
-    #    storing them as STRUCT_GROUP(MEMBERS)
-    #
-    # 2. remove STRUCT_GROUP() ancillary macro.
-    #
-    # The original logic used to remove STRUCT_GROUP() using an
-    # advanced regex:
-    #
-    #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
-    #
-    # with two patterns that are incompatible with
-    # Python re module, as it has:
-    #
-    #   - a recursive pattern: (?1)
-    #   - an atomic grouping: (?>...)
-    #
-    # I tried a simpler version: but it didn't work either:
-    #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
-    #
-    # As it doesn't properly match the end parenthesis on some cases.
-    #
-    # So, a better solution was crafted: there's now a NestedMatch
-    # class that ensures that delimiters after a search are properly
-    # matched. So, the implementation to drop STRUCT_GROUP() will be
-    # handled in separate.
-    #
-    (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
-    (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
-    (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
-    (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
-    #
-    # Replace macros
-    #
-    # TODO: use NestedMatch for FOO($1, $2, ...) matches
-    #
-    # it is better to also move those to the NestedMatch logic,
-    # to ensure that parentheses will be properly matched.
-    #
-    (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
-     r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
-    (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),
-     r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
-    (KernRe(r'DECLARE_BITMAP\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
-            re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
-    (KernRe(r'DECLARE_HASHTABLE\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
-            re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
-    (KernRe(r'DECLARE_KFIFO\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern +
-            r',\s*' + struct_args_pattern + r'\)', re.S), r'\2 *\1'),
-    (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + struct_args_pattern + r',\s*' +
-            struct_args_pattern + r'\)', re.S), r'\2 *\1'),
-    (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + struct_args_pattern + r',\s*' +
-            struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
-    (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
-    (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
-    (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
-]
 #
 # Regexes here are guaranteed to have the end delimiter matching
 # the start delimiter. Yet, right now, only one replace group
@@ -161,62 +78,10 @@ struct_nested_prefixes = [
     (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
 ]
 
-#
-# Transforms for function prototypes
-#
-function_xforms = [
-    (KernRe(r"^static +"), ""),
-    (KernRe(r"^extern +"), ""),
-    (KernRe(r"^asmlinkage +"), ""),
-    (KernRe(r"^inline +"), ""),
-    (KernRe(r"^__inline__ +"), ""),
-    (KernRe(r"^__inline +"), ""),
-    (KernRe(r"^__always_inline +"), ""),
-    (KernRe(r"^noinline +"), ""),
-    (KernRe(r"^__FORTIFY_INLINE +"), ""),
-    (KernRe(r"__init +"), ""),
-    (KernRe(r"__init_or_module +"), ""),
-    (KernRe(r"__exit +"), ""),
-    (KernRe(r"__deprecated +"), ""),
-    (KernRe(r"__flatten +"), ""),
-    (KernRe(r"__meminit +"), ""),
-    (KernRe(r"__must_check +"), ""),
-    (KernRe(r"__weak +"), ""),
-    (KernRe(r"__sched +"), ""),
-    (KernRe(r"_noprof"), ""),
-    (KernRe(r"__always_unused *"), ""),
-    (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
-    (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
-    (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
-    (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
-    (KernRe(r"__attribute_const__ +"), ""),
-    (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
-]
-
-#
-# Transforms for variable prototypes
-#
-var_xforms = [
-    (KernRe(r"__read_mostly"), ""),
-    (KernRe(r"__ro_after_init"), ""),
-    (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
-    (KernRe(r"(?://.*)$"), ""),
-    (KernRe(r"(?:/\*.*\*/)"), ""),
-    (KernRe(r";$"), ""),
-]
-
 #
 # Ancillary functions
 #
 
-def apply_transforms(xforms, text):
-    """
-    Apply a set of transforms to a block of text.
-    """
-    for search, subst in xforms:
-        text = search.sub(subst, text)
-    return text
-
 multi_space = KernRe(r'\s\s+')
 def trim_whitespace(s):
     """
@@ -395,11 +260,12 @@ class KernelDoc:
     #: String to write when a parameter is not described.
     undescribed = "-- undescribed --"
 
-    def __init__(self, config, fname):
+    def __init__(self, config, fname, xforms):
         """Initialize internal variables"""
 
         self.fname = fname
         self.config = config
+        self.xforms = xforms
 
         # Initial state for the state machines
         self.state = state.NORMAL
@@ -883,7 +749,7 @@ class KernelDoc:
         # Go through the list of members applying all of our transformations.
         #
         members = trim_private_members(members)
-        members = apply_transforms(struct_xforms, members)
+        members = self.xforms.apply("struct", members)
 
         nested = NestedMatch()
         for search, sub in struct_nested_prefixes:
@@ -1009,8 +875,7 @@ class KernelDoc:
         # Drop comments and macros to have a pure C prototype
         #
         if not declaration_name:
-            for r, sub in var_xforms:
-                proto = r.sub(sub, proto)
+            proto = self.xforms.apply("var", proto)
 
         proto = proto.rstrip()
 
@@ -1091,7 +956,7 @@ class KernelDoc:
             #
             # Apply the initial transformations.
             #
-            prototype = apply_transforms(function_xforms, prototype)
+            prototype = self.xforms.apply("func", prototype)
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
new file mode 100644
index 000000000000..e6e0302e5dd0
--- /dev/null
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -0,0 +1,153 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2026: Mauro Carvalho Chehab <mchehab@kernel.org>.
+
+import re
+
+from kdoc.kdoc_re import KernRe
+
+struct_args_pattern = r'([^,)]+)'
+
+class CTransforms:
+    """
+    Data class containing a long set of transformations to turn
+    structure member prefixes, and macro invocations and variables
+    into something we can parse and generate kdoc for.
+    """
+
+    #: Transforms for structs and unions.
+    struct_xforms = [
+        # Strip attributes
+        (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
+        (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
+        (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
+        (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
+        (KernRe(r'\s*__packed\s*', re.S), ' '),
+        (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
+        (KernRe(r'\s*__private', re.S), ' '),
+        (KernRe(r'\s*__rcu', re.S), ' '),
+        (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
+        (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
+        (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
+        #
+        # Unwrap struct_group macros based on this definition:
+        # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
+        # which has variants like: struct_group(NAME, MEMBERS...)
+        # Only MEMBERS arguments require documentation.
+        #
+        # Parsing them happens on two steps:
+        #
+        # 1. drop struct group arguments that aren't at MEMBERS,
+        #    storing them as STRUCT_GROUP(MEMBERS)
+        #
+        # 2. remove STRUCT_GROUP() ancillary macro.
+        #
+        # The original logic used to remove STRUCT_GROUP() using an
+        # advanced regex:
+        #
+        #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
+        #
+        # with two patterns that are incompatible with
+        # Python re module, as it has:
+        #
+        #   - a recursive pattern: (?1)
+        #   - an atomic grouping: (?>...)
+        #
+        # I tried a simpler version: but it didn't work either:
+        #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
+        #
+        # As it doesn't properly match the end parenthesis on some cases.
+        #
+        # So, a better solution was crafted: there's now a NestedMatch
+        # class that ensures that delimiters after a search are properly
+        # matched. So, the implementation to drop STRUCT_GROUP() will be
+        # handled in separate.
+        #
+        (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
+        (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
+        (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
+        (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
+        #
+        # Replace macros
+        #
+        # TODO: use NestedMatch for FOO($1, $2, ...) matches
+        #
+        # it is better to also move those to the NestedMatch logic,
+        # to ensure that parentheses will be properly matched.
+        #
+        (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
+        r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+        (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),
+        r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+        (KernRe(r'DECLARE_BITMAP\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
+                re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+        (KernRe(r'DECLARE_HASHTABLE\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
+                re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
+        (KernRe(r'DECLARE_KFIFO\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern +
+                r',\s*' + struct_args_pattern + r'\)', re.S), r'\2 *\1'),
+        (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + struct_args_pattern + r',\s*' +
+                struct_args_pattern + r'\)', re.S), r'\2 *\1'),
+        (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + struct_args_pattern + r',\s*' +
+                struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
+        (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
+        (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
+        (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
+    ]
+
+    #: Transforms for function prototypes.
+    function_xforms = [
+        (KernRe(r"^static +"), ""),
+        (KernRe(r"^extern +"), ""),
+        (KernRe(r"^asmlinkage +"), ""),
+        (KernRe(r"^inline +"), ""),
+        (KernRe(r"^__inline__ +"), ""),
+        (KernRe(r"^__inline +"), ""),
+        (KernRe(r"^__always_inline +"), ""),
+        (KernRe(r"^noinline +"), ""),
+        (KernRe(r"^__FORTIFY_INLINE +"), ""),
+        (KernRe(r"__init +"), ""),
+        (KernRe(r"__init_or_module +"), ""),
+        (KernRe(r"__exit +"), ""),
+        (KernRe(r"__deprecated +"), ""),
+        (KernRe(r"__flatten +"), ""),
+        (KernRe(r"__meminit +"), ""),
+        (KernRe(r"__must_check +"), ""),
+        (KernRe(r"__weak +"), ""),
+        (KernRe(r"__sched +"), ""),
+        (KernRe(r"_noprof"), ""),
+        (KernRe(r"__always_unused *"), ""),
+        (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
+        (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
+        (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
+        (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
+        (KernRe(r"__attribute_const__ +"), ""),
+        (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
+    ]
+
+    #: Transforms for variable prototypes.
+    var_xforms = [
+        (KernRe(r"__read_mostly"), ""),
+        (KernRe(r"__ro_after_init"), ""),
+        (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
+        (KernRe(r"(?://.*)$"), ""),
+        (KernRe(r"(?:/\*.*\*/)"), ""),
+        (KernRe(r";$"), ""),
+    ]
+
+    #: Transforms main dictionary used at apply_transforms().
+    xforms = {
+        "struct": struct_xforms,
+        "func": function_xforms,
+        "var": var_xforms,
+    }
+
+    def apply(self, xforms_type, text):
+        """
+        Apply a set of transforms to a block of text.
+        """
+        if xforms_type not in self.xforms:
+            return text
+
+        for search, subst in self.xforms[xforms_type]:
+            text = search.sub(subst, text)
+        return text
-- 
2.52.0

