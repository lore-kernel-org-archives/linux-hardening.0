Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF143C65FF;
	Thu, 12 Mar 2026 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327300; cv=none; b=ueQqe54dQbE3+pbrQdMJvb2ZiSHQLY0hqyfNYkeohbvgvg0Aw0uGzb38H67eE4Wmyc57toSRr7P0xBBx4Iyec0z/6YcrMOdztaIUo4qT2DSQfP8crrui5Tdxe+4pPJDvO/l0bCZ/+ZF61udOhf3001vk6A/68Ca78z3RTjDX6N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327300; c=relaxed/simple;
	bh=+cEqHBF3A2eDI0UFdrAwJkJULXKI0XvqLjdcjyyS0pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ue9mnugkBJ9YN30fLdQtX95bjDDOG7iaRY3l+9+U+fnAisXpDCDeUUTW1m3JX3GMtfwgqkx7yu+N3krmXy+YGmpqXb3njyW7P3sdNEGMAVxihAGDA6nCrK01gjpRYd56xd24OK1LXqaQLqRMypZz5dwPp65jeTQnZWa6biITeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ4YVPiQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ4YVPiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C432C2BC86;
	Thu, 12 Mar 2026 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327300;
	bh=+cEqHBF3A2eDI0UFdrAwJkJULXKI0XvqLjdcjyyS0pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJ4YVPiQNar9+ABqGlMQb05ChiwkCWY0fc+TVBe1EGXv/DaloVeniOLSPOmZBjmed
	 ggt6v7bOh+6iHLY5YfD0c1NLQRf4gir1rZmSrs/PGFWs3K/h65OPwBGzwRpUoRM4um
	 jj5wY8YmUcajPAXpjFFyCv5cLIS6NHLP8l1z4FRUbWjRLURx3f8D37z0eLXHE3dwzT
	 WWZUerkXKBr8CIkkOuRnumrUQcIXEZsSMI4A1/7yCmo1cqCZYx/jzp8aifvcUlxXA0
	 w0v8AtnKO57s7vx3E1hW/8K/04J8ho81leh0jETHM09YIwEzQGrfKAOVw3pn5ur/hV
	 IR79qg9/wujIA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRC-00000008y3t-1Gvw;
	Thu, 12 Mar 2026 15:54:58 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 15/28] docs: kdoc: replace NestedMatch with CMatch
Date: Thu, 12 Mar 2026 15:54:35 +0100
Message-ID: <6b21b7653ceaa4d20d62c651fa205cbe94401df1.1773326442.git.mchehab+huawei@kernel.org>
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
2.52.0

