Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC883AD504;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299553; cv=none; b=DhLmKyL+Z5CvhxXuDLR5xMEZWkx/Dvowky/l6+AIwN6kt7FCVDHgHbuXcWVSrbxeuOUvbpeDtGndB9aBdxmPNoM0S7VyTLYECg0M3KlqWf3qJgbxeSKXH8rgczlXMUbRmTerROsMMMGt3d4VO4DRdQCioNE6qZJmsGVAbcoSaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299553; c=relaxed/simple;
	bh=R3MxZBF5LN8l5MLvY90olqXjlgo8oaUuezo5dZ4V5RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uogxD3/gwUKZyTsfO/SQhtIcIUkrWxpOjxMcKdz4Yg2p6vozfR1ODDZJi/xoTTNon5T/3PgOEN8eGm1+TclPMuSvsLY9CGLU3loDHbkyBOrV3YrJEcRnO1vHcPADFHum0HTo3YYrRDxzDf5h+r6SWaf7FxQst4hppX8l3bMn86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAczf86K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAczf86K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBC5C4AF0C;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=R3MxZBF5LN8l5MLvY90olqXjlgo8oaUuezo5dZ4V5RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CAczf86KiCXLWoDaYcGyXt39zqEz+ltMZE7GRr3GMSIo4uKI2JYZlcRut2jAFkTDu
	 eqzmAsNH6B7YmhQ5VQWRHGId7S0IpI325imkLBhu02+fEtkPpX1oatpSm9zoDOewSM
	 VByf/cyG+crUgHWuFFtNlM2fYKCya29LQDrVvRCqknqwXb4EJk1dL2AAxihTeB6r3I
	 x+MOwUFPSXX8ZmLtRcak0Q8kWtyMrTZrxivdfli/6n3yuxnXnYyJs9mFLBGE61owo8
	 lbRRIMx3uusFrvmZNYXnc4s+b7q+GQgPtHmdlAkQfgLpFCpTj9Jk3HvTIPn7QPcv3h
	 7Gy7TBzaG8Hmw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077hI-2v25;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 15/20] docs: kdoc: replace NestedMatch with CMatch
Date: Thu, 12 Mar 2026 08:12:23 +0100
Message-ID: <6b21b7653ceaa4d20d62c651fa205cbe94401df1.1773297828.git.mchehab+huawei@kernel.org>
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
index e804e61b09c0..0da95b090a34 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -13,7 +13,7 @@ import sys
 import re
 from pprint import pformat
 
-from kdoc.kdoc_re import NestedMatch, KernRe
+from kdoc.kdoc_re import KernRe
 from kdoc.c_lex import CTokenizer
 from kdoc.kdoc_item import KdocItem
 
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
2.53.0

