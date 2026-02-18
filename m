Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332933F8A0;
	Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409609; cv=none; b=t5hQkWc56aY0i2fVD0zXwjYCcEbrGou3sHstKtehXKL3Z58mkuR99k4hZZ8AyR+5SwbTSHoTfXR1GwyLgnsd0/LKdr/1ApeFICp8ChyK/OFJAZP/GLGxXvYBQQszzS3igQeUWi9sOFwL1UIq1ELaH1b7+3Iy9ZqmRE0W+VG90wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409609; c=relaxed/simple;
	bh=nnw4ho1Olbx2RNuzp7w4U3GO/hs4rZPbQud6YRRjsxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNfO6Gy+/6yN+EXYXB0hZnrGdRO6d9UWNResN73fo5ZO50MpALA7WV6IZmU8kY0r54QOibxcRJ+dcI7aOo7Br12weWAj7LVEyMMay4wP0r0pyfy47Up9gdeJ8jsax98NFnBE2thZQyNxl2/Qek1RwMQNzrCX6X9UUtVAGToXHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AK77plCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AK77plCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37E0C19425;
	Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409609;
	bh=nnw4ho1Olbx2RNuzp7w4U3GO/hs4rZPbQud6YRRjsxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AK77plCta9vdDWs0GEdINAHrUCAngMqf6VZJyUomLt0co3NpFjHCzl8X/SOBb+kzj
	 gu/QhDCEDIuY1g5GiD0hd9noakpnLqeTu2GPBMn7DZuYs+6D22tucysb8NImprYMCH
	 b4qrA+1YNUKgx902q1T82wzYYT6nAjNgTflIP5AHqiMTjKYWLrEun7jeyytDvLmgQ5
	 /6BrJcks8501xdmWQLiSGmRyYBNgehet/QEVblPoJs0myVj2wKBaLtHjcsoul7o0j0
	 Bg87zgXi1/JU1nEYSrf0y9csToMd2D2Z1TVLayclgl5PmesyY3Azvcbee+edpWi2Vy
	 +A/86Otj5WHTA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYi-00000000Ltl-00lG;
	Wed, 18 Feb 2026 11:13:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH 29/38] docs: xforms_lists.py: use CFuntion to handle all function macros
Date: Wed, 18 Feb 2026 11:12:59 +0100
Message-ID: <b5785eaa2531a115b4afc1aa42502459d14ab9b2.1771408406.git.mchehab+huawei@kernel.org>
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

The new CFunction class handles better macros, as it works the same
way C compilers do, handling delimiters tha right way.

This allows removing complex regular expressions, placing instead
just a simple one with the name(s) of the functions to be replaced.

Doing a before/after check using "kernel-doc -man ." shows only
cosmetic changes (whitespaces, mostly).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/xforms_lists.py | 71 ++++++++++++---------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index 2e7b470c4e65..6455850fee2d 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -17,51 +17,38 @@ class CTransforms:
 
     #: Transforms for structs and unions.
     struct_xforms = [
-        # Strip attributes
-        (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
-        (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
-        (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
-        (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
-        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ' '),
-        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ' '),
+        (CFunction("__attribute__"), ' '),
+        (CFunction('__aligned'), ' '),
+        (CFunction('__counted_by'), ' '),
+        (CFunction('__counted_by_(le|be)'), ' '),
+        (CFunction('__guarded_by'), ' '),
+        (CFunction('__pt_guarded_by'), ' '),
+
         (KernRe(r'\s*__packed\s*', re.S), ' '),
         (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
         (KernRe(r'\s*__private', re.S), ' '),
         (KernRe(r'\s*__rcu', re.S), ' '),
         (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
         (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
-        (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
+
+        (CFunction('__cacheline_group_(begin|end)'), ''),
 
         (CFunction('struct_group'), r'\2'),
         (CFunction('struct_group_attr'), r'\3'),
         (CFunction('struct_group_tagged'), r'struct \1 \2; \3'),
         (CFunction('__struct_group'), r'\4'),
 
-        #
-        # Replace macros
-        #
-        # TODO: use CFunction on all FOO($1, $2, ...) matches
-        #
-        # it is better to also move those to the CFunction logic,
-        # to ensure that parentheses will be properly matched.
-        #
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
+        (CFunction('__ETHTOOL_DECLARE_LINK_MODE_MASK'), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+        (CFunction('DECLARE_PHY_INTERFACE_MASK',), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+        (CFunction('DECLARE_BITMAP'), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+
+        (CFunction('DECLARE_HASHTABLE'), r'unsigned long \1[1 << ((\2) - 1)]'),
+        (CFunction('DECLARE_KFIFO'), r'\2 *\1'),
+        (CFunction('DECLARE_KFIFO_PTR'), r'\2 *\1'),
+        (CFunction('(?:__)?DECLARE_FLEX_ARRAY'), r'\1 \2[]'),
+        (CFunction('DEFINE_DMA_UNMAP_ADDR'), r'dma_addr_t \1'),
+        (CFunction('DEFINE_DMA_UNMAP_LEN'), r'__u32 \1'),
+        (CFunction('VIRTIO_DECLARE_FEATURES'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
     ]
 
     #: Transforms for function prototypes.
@@ -86,12 +73,14 @@ class CTransforms:
         (KernRe(r"__sched +"), ""),
         (KernRe(r"_noprof"), ""),
         (KernRe(r"__always_unused *"), ""),
-        (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
-        (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
-        (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
-        (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
         (KernRe(r"__no_context_analysis\s*"), ""),
         (KernRe(r"__attribute_const__ +"), ""),
+
+        (CFunction('__printf'), ""),
+        (CFunction('__(?:re)?alloc_size'), ""),
+        (CFunction("__diagnose_as"), ""),
+        (CFunction("DECL_BUCKET_PARAMS"), r"\1, \2"),
+
         (CFunction("__cond_acquires"), ""),
         (CFunction("__cond_releases"), ""),
         (CFunction("__acquires"), ""),
@@ -109,9 +98,11 @@ class CTransforms:
     var_xforms = [
         (KernRe(r"__read_mostly"), ""),
         (KernRe(r"__ro_after_init"), ""),
-        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
-        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
-        (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
+
+        (CFunction('__guarded_by'), ""),
+        (CFunction('__pt_guarded_by'), ""),
+        (CFunction("LIST_HEAD"), r"struct list_head \1"),
+
         (KernRe(r"(?://.*)$"), ""),
         (KernRe(r"(?:/\*.*\*/)"), ""),
         (KernRe(r";$"), ""),
-- 
2.52.0

