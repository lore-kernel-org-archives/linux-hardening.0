Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323D3C7DF7;
	Thu, 12 Mar 2026 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327301; cv=none; b=lb5SbPJRalKEfBAuIL1cRpTBIK+pslvg9D5use39V7EgJ+n5or6L2ddC4coUf3DmNlLfFmEnKgdejRR/SGn0pEc6OcMPrVmEPHrxcV9Bo8e9fMT7CMNCz2alqcvhejxXsmlJqhrRzqlfd2KuhTr1UutN5Fd/avGsQGPtdBAwTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327301; c=relaxed/simple;
	bh=wrSsJhHTVjMzkyHIM704WGK5aVzdfQaMdK96yEOjx2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiYN2oxYfa2yu4AtE7p3skPLHUasePv8nHF9QJ+ewfLZsuYfAfKt6IsPqLqCd6N+qJgEU2dO+V9u/Fo9dgnzVt+56RkwxOy5gRYfevfwc5F7lWavxlCbupdd06GJqSc4hVUsq7S0udyVTlfbrCZpRPdTFnKSfT54ukhE4rM7kG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk1ftoCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk1ftoCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B837C2BCB3;
	Thu, 12 Mar 2026 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327301;
	bh=wrSsJhHTVjMzkyHIM704WGK5aVzdfQaMdK96yEOjx2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pk1ftoCIaNgtwGqloXLXOaFb3jMvDhBevu+6bvxcfhC55QhFWSwgx45pU5ou0PnGo
	 2s3jCpkyXN7k3a5KPwwEB0WIGtbXe4EHteDoEwjkpZFe05XyiU2m/1uWYq6yOwv9S+
	 0+8YyV5RR09f8FlAz6Lp3o+7V8hFjfoDNYh5JUOMy3GPQP9z+Bl6ZLeYmf5RQb+2ld
	 DlJhmc4K8PwbZpBq9bWOCV70CVVcC7gIV5VqLBOZGOyu6pWFjc+wxMfa8RQh5px0Ly
	 QnTHWjxoaF7JeqTan91ORUSEktiunb45gwlWNlCejCOxkQjs8zpavKvpgnV1l3TzvY
	 Lg9qEGJGCt3yw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRD-00000008yA8-1Cws;
	Thu, 12 Mar 2026 15:54:59 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 20/28] docs: xforms_lists: use CMatch for all identifiers
Date: Thu, 12 Mar 2026 15:54:40 +0100
Message-ID: <86cc6a29dc6c3820d27ea1c9464a25bbef7cc000.1773326442.git.mchehab+huawei@kernel.org>
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

CMatch is lexically correct and replaces only identifiers,
which is exactly where macro transformations happen.

Use it to make the output safer and ensure that all arguments
will be parsed the right way, even on complex cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/xforms_lists.py | 159 +++++++++++++-------------
 1 file changed, 79 insertions(+), 80 deletions(-)

diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index 2056572852fd..c3c532c45cdc 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -7,7 +7,8 @@ import re
 from kdoc.kdoc_re import KernRe
 from kdoc.c_lex import CMatch
 
-struct_args_pattern = r'([^,)]+)'
+struct_args_pattern = r"([^,)]+)"
+
 
 class CTransforms:
     """
@@ -18,48 +19,40 @@ class CTransforms:
 
     #: Transforms for structs and unions.
     struct_xforms = [
-        # Strip attributes
-        (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
-        (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
-        (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
-        (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
-        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ' '),
-        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ' '),
-        (KernRe(r'\s*__packed\s*', re.S), ' '),
-        (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
-        (KernRe(r'\s*__private', re.S), ' '),
-        (KernRe(r'\s*__rcu', re.S), ' '),
-        (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
-        (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
-        (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
-        (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
-        r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
-        (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),
-        r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
-        (KernRe(r'DECLARE_BITMAP\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
-                re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
-        (KernRe(r'DECLARE_HASHTABLE\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
-                re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
-        (KernRe(r'DECLARE_KFIFO\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern +
-                r',\s*' + struct_args_pattern + r'\)', re.S), r'\2 *\1'),
-        (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + struct_args_pattern + r',\s*' +
-                struct_args_pattern + r'\)', re.S), r'\2 *\1'),
-        (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + struct_args_pattern + r',\s*' +
-                struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
-        (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
-        (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
-        (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
-
-        (CMatch(r"__cond_acquires"), ""),
-        (CMatch(r"__cond_releases"), ""),
-        (CMatch(r"__acquires"), ""),
-        (CMatch(r"__releases"), ""),
-        (CMatch(r"__must_hold"), ""),
-        (CMatch(r"__must_not_hold"), ""),
-        (CMatch(r"__must_hold_shared"), ""),
-        (CMatch(r"__cond_acquires_shared"), ""),
-        (CMatch(r"__acquires_shared"), ""),
-        (CMatch(r"__releases_shared"), ""),
+        (CMatch("__attribute__"), ""),
+        (CMatch("__aligned"), ""),
+        (CMatch("__counted_by"), ""),
+        (CMatch("__counted_by_(le|be)"), ""),
+        (CMatch("__guarded_by"), ""),
+        (CMatch("__pt_guarded_by"), ""),
+        (CMatch("__packed"), ""),
+        (CMatch("CRYPTO_MINALIGN_ATTR"), ""),
+        (CMatch("__private"), ""),
+        (CMatch("__rcu"), ""),
+        (CMatch("____cacheline_aligned_in_smp"), ""),
+        (CMatch("____cacheline_aligned"), ""),
+        (CMatch("__cacheline_group_(?:begin|end)"), ""),
+        (CMatch("__ETHTOOL_DECLARE_LINK_MODE_MASK"), r"DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)"),
+        (CMatch("DECLARE_PHY_INTERFACE_MASK",),r"DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)"),
+        (CMatch("DECLARE_BITMAP"), r"unsigned long \1[BITS_TO_LONGS(\2)]"),
+        (CMatch("DECLARE_HASHTABLE"), r"unsigned long \1[1 << ((\2) - 1)]"),
+        (CMatch("DECLARE_KFIFO"), r"\2 *\1"),
+        (CMatch("DECLARE_KFIFO_PTR"), r"\2 *\1"),
+        (CMatch("(?:__)?DECLARE_FLEX_ARRAY"), r"\1 \2[]"),
+        (CMatch("DEFINE_DMA_UNMAP_ADDR"), r"dma_addr_t \1"),
+        (CMatch("DEFINE_DMA_UNMAP_LEN"), r"__u32 \1"),
+        (CMatch("VIRTIO_DECLARE_FEATURES"), r"union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }"),
+        (CMatch("__cond_acquires"), ""),
+        (CMatch("__cond_releases"), ""),
+        (CMatch("__acquires"), ""),
+        (CMatch("__releases"), ""),
+        (CMatch("__must_hold"), ""),
+        (CMatch("__must_not_hold"), ""),
+        (CMatch("__must_hold_shared"), ""),
+        (CMatch("__cond_acquires_shared"), ""),
+        (CMatch("__acquires_shared"), ""),
+        (CMatch("__releases_shared"), ""),
+        (CMatch("__attribute__"), ""),
 
         #
         # Macro __struct_group() creates an union with an anonymous
@@ -67,51 +60,57 @@ class CTransforms:
         # need one of those at kernel-doc, as we won't be documenting the same
         # members twice.
         #
-        (CMatch('struct_group'), r'struct { \2+ };'),
-        (CMatch('struct_group_attr'), r'struct { \3+ };'),
-        (CMatch('struct_group_tagged'), r'struct { \3+ };'),
-        (CMatch('__struct_group'), r'struct { \4+ };'),
-
+        (CMatch("struct_group"), r"struct { \2+ };"),
+        (CMatch("struct_group_attr"), r"struct { \3+ };"),
+        (CMatch("struct_group_tagged"), r"struct { \3+ };"),
+        (CMatch("__struct_group"), r"struct { \4+ };"),
     ]
 
     #: Transforms for function prototypes.
     function_xforms = [
-        (KernRe(r"^static +"), ""),
-        (KernRe(r"^extern +"), ""),
-        (KernRe(r"^asmlinkage +"), ""),
-        (KernRe(r"^inline +"), ""),
-        (KernRe(r"^__inline__ +"), ""),
-        (KernRe(r"^__inline +"), ""),
-        (KernRe(r"^__always_inline +"), ""),
-        (KernRe(r"^noinline +"), ""),
-        (KernRe(r"^__FORTIFY_INLINE +"), ""),
-        (KernRe(r"__init +"), ""),
-        (KernRe(r"__init_or_module +"), ""),
-        (KernRe(r"__exit +"), ""),
-        (KernRe(r"__deprecated +"), ""),
-        (KernRe(r"__flatten +"), ""),
-        (KernRe(r"__meminit +"), ""),
-        (KernRe(r"__must_check +"), ""),
-        (KernRe(r"__weak +"), ""),
-        (KernRe(r"__sched +"), ""),
-        (KernRe(r"_noprof"), ""),
-        (KernRe(r"__always_unused *"), ""),
-        (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
-        (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
-        (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
-        (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
-        (KernRe(r"__no_context_analysis\s*"), ""),
-        (KernRe(r"__attribute_const__ +"), ""),
-        (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
+        (CMatch("static"), ""),
+        (CMatch("extern"), ""),
+        (CMatch("asmlinkage"), ""),
+        (CMatch("inline"), ""),
+        (CMatch("__inline__"), ""),
+        (CMatch("__inline"), ""),
+        (CMatch("__always_inline"), ""),
+        (CMatch("noinline"), ""),
+        (CMatch("__FORTIFY_INLINE"), ""),
+        (CMatch("__init"), ""),
+        (CMatch("__init_or_module"), ""),
+        (CMatch("__exit"), ""),
+        (CMatch("__deprecated"), ""),
+        (CMatch("__flatten"), ""),
+        (CMatch("__meminit"), ""),
+        (CMatch("__must_check"), ""),
+        (CMatch("__weak"), ""),
+        (CMatch("__sched"), ""),
+        (CMatch("__always_unused"), ""),
+        (CMatch("__printf"), ""),
+        (CMatch("__(?:re)?alloc_size"), ""),
+        (CMatch("__diagnose_as"), ""),
+        (CMatch("DECL_BUCKET_PARAMS"), r"\1, \2"),
+        (CMatch("__no_context_analysis"), ""),
+        (CMatch("__attribute_const__"), ""),
+        (CMatch("__attribute__"), ""),
+
+        #
+        # HACK: this is similar to process_export() hack. It is meant to
+        # drop _noproof from function name. See for instance:
+        # ahash_request_alloc kernel-doc declaration at include/crypto/hash.h.
+        #
+        (KernRe("_noprof"), ""),
     ]
 
     #: Transforms for variable prototypes.
     var_xforms = [
-        (KernRe(r"__read_mostly"), ""),
-        (KernRe(r"__ro_after_init"), ""),
-        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
-        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
-        (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
+        (CMatch("__read_mostly"), ""),
+        (CMatch("__ro_after_init"), ""),
+        (CMatch("__guarded_by"), ""),
+        (CMatch("__pt_guarded_by"), ""),
+        (CMatch("LIST_HEAD"), r"struct list_head \1"),
+
         (KernRe(r"(?://.*)$"), ""),
         (KernRe(r"(?:/\*.*\*/)"), ""),
         (KernRe(r";$"), ""),
-- 
2.52.0

