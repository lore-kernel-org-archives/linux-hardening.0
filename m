Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94D3F87F6;
	Tue, 17 Mar 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770990; cv=none; b=tXwG8YBBPwiDMAS+IRs6nyMl3u1DnZNoCgQjO03WmgpqYPDeiNbKauDCx91d+0RBVNlLXG29MvUuQ8rovpC5EcNL3V6BaquBVWAop936WOEks8wlSlGaUI2Ftv24a1pppny9r+AyLCaSLJm7lvAvqPhsDuheEU9xToTO6+iyGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770990; c=relaxed/simple;
	bh=lK8UHC4LZ0vQiDiDgYHCZuZXU1iZUv+O+RKaBZwhkQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBMU1mIaW5j6ubY/fZg/0RaSDpVkMX+HNpDtbN3OcPogaim5w/3P1b7sEUv5sqlYfE1g72xvb51Mp2CW1Wcf+0XlqJh1tOTosgeVmgOrBNLz71CIFYNLtHBUriFFDBMszjWasN/8uoVM4eN+5gLz0aZ4FSfvy0bDpg4tjDiesQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfM3ACRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfM3ACRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E80C2BCB2;
	Tue, 17 Mar 2026 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770989;
	bh=lK8UHC4LZ0vQiDiDgYHCZuZXU1iZUv+O+RKaBZwhkQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfM3ACRCVmxhLzJW7DiWBlvdJS/j/sxMQqT9sltfIINN8O9LZNDVYPadW76DyLNPV
	 GwQHUJ8nHOXc6IqisiRDMFpAI76YZybDoEJRK0BQ8rb5pZ+IC7QlpaFzVB00GzMmOe
	 RwUxtZOw0qm+InnDKo3ewRHBeDhra5EGoJg+xpVGS95RLM9DTEPXwiCf+HItdaKYaB
	 j00aMTqE8ErVTnqWRw4SVF4YgoUyXLU8XNM7NBAUSzzLK5DmmW6HvZgMptbz9R4RSJ
	 S0xTzc1AjME0/V4YA5MVuDNngaf00utFefkL/xhsRc2mD8g5fd+2u7zGMopNW9rpWR
	 7hZ/N/WVoHyFQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrU-0000000H5VS-0RCf;
	Tue, 17 Mar 2026 19:09:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 14/22] docs: kdoc: replace NestedMatch with CMatch
Date: Tue, 17 Mar 2026 19:09:34 +0100
Message-ID: <900bff66f8093402999f9fe055fbfa3fa33a8d8b.1773770483.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773770483.git.mchehab+huawei@kernel.org>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Our previous approach to solve nested structs were to use
NestedMatch. It works well, but adding support to parse delimiters
is very complex.

Instead, use CMatch, which uses a C tokenizer, making the code more
reliable and simpler.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py  |  2 +-
 tools/lib/python/kdoc/xforms_lists.py | 31 ++++++++++++++-------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 62d8030cf532..efd58c88ff31 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -14,7 +14,7 @@ import re
 from pprint import pformat
 
 from kdoc.c_lex import CTokenizer
-from kdoc.kdoc_re import NestedMatch, KernRe
+from kdoc.kdoc_re import KernRe
 from kdoc.kdoc_item import KdocItem
 
 #
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index c07cbe1e6349..7fa7f52cec7b 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -4,7 +4,8 @@
 
 import re
 
-from kdoc.kdoc_re import KernRe, NestedMatch
+from kdoc.kdoc_re import KernRe
+from kdoc.c_lex import CMatch
 
 struct_args_pattern = r'([^,)]+)'
 
@@ -60,7 +61,7 @@ class CTransforms:
         #
         # As it doesn't properly match the end parenthesis on some cases.
         #
-        # So, a better solution was crafted: there's now a NestedMatch
+        # So, a better solution was crafted: there's now a CMatch
         # class that ensures that delimiters after a search are properly
         # matched. So, the implementation to drop STRUCT_GROUP() will be
         # handled in separate.
@@ -72,9 +73,9 @@ class CTransforms:
         #
         # Replace macros
         #
-        # TODO: use NestedMatch for FOO($1, $2, ...) matches
+        # TODO: use CMatch for FOO($1, $2, ...) matches
         #
-        # it is better to also move those to the NestedMatch logic,
+        # it is better to also move those to the CMatch logic,
         # to ensure that parentheses will be properly matched.
         #
         (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
@@ -95,17 +96,17 @@ class CTransforms:
         (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
         (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
 
-        (NestedMatch(r"__cond_acquires\s*\("), ""),
-        (NestedMatch(r"__cond_releases\s*\("), ""),
-        (NestedMatch(r"__acquires\s*\("), ""),
-        (NestedMatch(r"__releases\s*\("), ""),
-        (NestedMatch(r"__must_hold\s*\("), ""),
-        (NestedMatch(r"__must_not_hold\s*\("), ""),
-        (NestedMatch(r"__must_hold_shared\s*\("), ""),
-        (NestedMatch(r"__cond_acquires_shared\s*\("), ""),
-        (NestedMatch(r"__acquires_shared\s*\("), ""),
-        (NestedMatch(r"__releases_shared\s*\("), ""),
-        (NestedMatch(r'\bSTRUCT_GROUP\('), r'\0'),
+        (CMatch(r"__cond_acquires"), ""),
+        (CMatch(r"__cond_releases"), ""),
+        (CMatch(r"__acquires"), ""),
+        (CMatch(r"__releases"), ""),
+        (CMatch(r"__must_hold"), ""),
+        (CMatch(r"__must_not_hold"), ""),
+        (CMatch(r"__must_hold_shared"), ""),
+        (CMatch(r"__cond_acquires_shared"), ""),
+        (CMatch(r"__acquires_shared"), ""),
+        (CMatch(r"__releases_shared"), ""),
+        (CMatch(r"STRUCT_GROUP"), r'\0'),
     ]
 
     #: Transforms for function prototypes.
-- 
2.52.0

