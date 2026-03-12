Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A43AD533;
	Thu, 12 Mar 2026 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299554; cv=none; b=LvRIXTteIgiayG5nngQ49kC/Z8CkCHKH5CtylpDGCw6zhWrXL+e1nUsU1cpYwimRjdfzVFu8rv1Hz24ZjAouGd58Bsg6EbYCz16EX6MFYfPYmWwdRbjXHRFiLSiLFsVyfKsu+v1WH+Cy43Cw6nn+QyJcX/SEhc9wvg/6MARfYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299554; c=relaxed/simple;
	bh=VgpdCURNXribzlBJhLz5siGjBHNFlZu1TMJYSSZaQ28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgCZnztRVs1iFty+wcf8vvf6uNCNfmFhNZiZvGdn9FpHAW7IGfnp8gah+SWi4iPlIiuFxE0PTQBJ83SRpjnZM1guFwEDsoLNx8LKykzBDwHF0KxoC1fMGkzyJk6/z6o2B/1+FP3ijYRywkNiKniZDc+yTG5UY1IT0bR2uOVoKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlhxQubG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlhxQubG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964E3C2BD05;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=VgpdCURNXribzlBJhLz5siGjBHNFlZu1TMJYSSZaQ28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlhxQubGEyCAqY4x/wuIED1hepP7i9MBpBPwqvemO6sYA3kjaULCAiYmlSbb3dYHl
	 7NHuHKwhRy17nvtVnMqijtrgNErG5vgs7u84iTuVq8zVToGl2pD8UGAo9cprSQQet4
	 7PUoqs3RtBp392CsSc7RCcIbeM4NZCCK2en95r7L2Klw16gkxMxkU50ZUKSvRwi8ZW
	 arDx6GjhIK8HACzJLPAtQynr66STkrD/E/S/eKaIezMfcyb7H0aB7UPZr9JLgLp0Pi
	 i/8bVLmHP2tsZPchHzfvSEODq7XBo82NUkv8jrLef1dgKWdTzqsIOw6Z+Svm7oZjlO
	 II+jcnpgUKQrw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077hd-3V1B;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 20/20] docs: xforms_lists: use CMatch for all identifiers
Date: Thu, 12 Mar 2026 08:12:28 +0100
Message-ID: <716c6dfa1d5d50c92ca14e9ecbd1ed9ebd07f052.1773297828.git.mchehab+huawei@kernel.org>
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

CMatch is lexically correct and replaces only identifiers,
which is exactly where macro transformations happen.

Use it to make the output safer and ensure that all arguments
will be parsed the right way, even on complex cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/xforms_lists.py | 151 +++++++++++++-------------
 1 file changed, 78 insertions(+), 73 deletions(-)

diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index 2056572852fd..ebb4bf485c3a 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -18,48 +18,46 @@ class CTransforms:
 
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
+        (CMatch("__attribute__"), ""),
+        (CMatch('__aligned'), ""),
+        (CMatch('__counted_by'), ""),
+        (CMatch('__counted_by_(le|be)'), ""),
+        (CMatch('__guarded_by'), ""),
+        (CMatch('__pt_guarded_by'), ""),
 
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
+        (CMatch('__packed'), ""),
+        (CMatch('CRYPTO_MINALIGN_ATTR'), ""),
+        (CMatch('__private'), ""),
+        (CMatch('__rcu'), ""),
+        (CMatch('____cacheline_aligned_in_smp'), ""),
+        (CMatch('____cacheline_aligned'), ""),
+
+        (CMatch('__cacheline_group_(?:begin|end)'), ""),
+        (CMatch('__ETHTOOL_DECLARE_LINK_MODE_MASK'),
+                r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+        (CMatch('DECLARE_PHY_INTERFACE_MASK',),
+                r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+        (CMatch('DECLARE_BITMAP'), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+
+        (CMatch('DECLARE_HASHTABLE'), r'unsigned long \1[1 << ((\2) - 1)]'),
+        (CMatch('DECLARE_KFIFO'), r'\2 *\1'),
+        (CMatch('DECLARE_KFIFO_PTR'), r'\2 *\1'),
+        (CMatch('(?:__)?DECLARE_FLEX_ARRAY'), r'\1 \2[]'),
+        (CMatch('DEFINE_DMA_UNMAP_ADDR'), r'dma_addr_t \1'),
+        (CMatch('DEFINE_DMA_UNMAP_LEN'), r'__u32 \1'),
+        (CMatch('VIRTIO_DECLARE_FEATURES'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
+
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
@@ -71,47 +69,54 @@ class CTransforms:
         (CMatch('struct_group_attr'), r'struct { \3+ };'),
         (CMatch('struct_group_tagged'), r'struct { \3+ };'),
         (CMatch('__struct_group'), r'struct { \4+ };'),
-
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
+        (CMatch(r"static"), ""),
+        (CMatch(r"extern"), ""),
+        (CMatch(r"asmlinkage"), ""),
+        (CMatch(r"inline"), ""),
+        (CMatch(r"__inline__"), ""),
+        (CMatch(r"__inline"), ""),
+        (CMatch(r"__always_inline"), ""),
+        (CMatch(r"noinline"), ""),
+        (CMatch(r"__FORTIFY_INLINE"), ""),
+        (CMatch(r"__init"), ""),
+        (CMatch(r"__init_or_module"), ""),
+        (CMatch(r"__exit"), ""),
+        (CMatch(r"__deprecated"), ""),
+        (CMatch(r"__flatten"), ""),
+        (CMatch(r"__meminit"), ""),
+        (CMatch(r"__must_check"), ""),
+        (CMatch(r"__weak"), ""),
+        (CMatch(r"__sched"), ""),
+
+        #
+        # HACK: this is similar to process_export() hack. It is meant to
+        # drop _noproof from function name. See for instance:
+        # ahash_request_alloc kernel-doc declaration at include/crypto/hash.h.
+        #
         (KernRe(r"_noprof"), ""),
-        (KernRe(r"__always_unused *"), ""),
-        (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
-        (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
-        (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
-        (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
-        (KernRe(r"__no_context_analysis\s*"), ""),
-        (KernRe(r"__attribute_const__ +"), ""),
-        (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
+
+        (CMatch(r"__always_unused"), ""),
+        (CMatch('__printf'), ""),
+        (CMatch('__(?:re)?alloc_size'), ""),
+        (CMatch("__diagnose_as"), ""),
+        (CMatch("DECL_BUCKET_PARAMS"), r"\1, \2"),
+        (CMatch(r"__no_context_analysis"), ""),
+        (CMatch(r"__attribute_const__"), ""),
+        (CMatch("__attribute__"), ""),
     ]
 
     #: Transforms for variable prototypes.
     var_xforms = [
-        (KernRe(r"__read_mostly"), ""),
-        (KernRe(r"__ro_after_init"), ""),
-        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
-        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
-        (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
+        (CMatch(r"__read_mostly"), ""),
+        (CMatch(r"__ro_after_init"), ""),
+        (CMatch('__guarded_by'), ""),
+        (CMatch('__pt_guarded_by'), ""),
+        (CMatch("LIST_HEAD"), r"struct list_head \1"),
+
         (KernRe(r"(?://.*)$"), ""),
         (KernRe(r"(?:/\*.*\*/)"), ""),
         (KernRe(r";$"), ""),
-- 
2.53.0

