Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05343AD50A;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299554; cv=none; b=JH/9KkTrnUvU5ScuwCmOrQW2583oj2oVHhAaoBd7c7oC1QGyOke68pBt+zxuKD3OPPVSvUpc7z5/k9Qkw/CyUkVtOgGjGcsUaJ5AbtH82aR9TlltWGoTBwjfbLVhV3rbCZZM/9lxVqCHNbyMCKkxp/lBeG/pEa5tpv4Gz7cKl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299554; c=relaxed/simple;
	bh=lfMdLsY4UUVbT4YZ8MjdKmp981RdmGtRwfnQ6yFTZLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiok3LeqTk5ZSuQlDk6jOZzqektyg5v3dO+QnDut4RYjUsJRQw5BCRH4esWoTUSQ252+SWmX8tIkzfJHkG/SG9Ly3ARqUzmkhOR5BovagG6300s4Tx42BoWW2KEcw/ZRILx48J6m8mZWddsf0+OlrI67+0re7DgQE1UR+gHy6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1VcblTy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1VcblTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760D5C2BCB8;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=lfMdLsY4UUVbT4YZ8MjdKmp981RdmGtRwfnQ6yFTZLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1VcblTyC48yx9a5iP049td4c9IN5TbKgp78zOdDdr+e4aID5hiWnOMcbgFKOy0q5
	 QTL0YhLKIJ69KdF4PU5DDAx7LV50f4r7ZzqOtARe2s3dJu0J7ohmeJBNCOR07ZQk5W
	 e1FxItXvp0mQji9wA6K3GtRsUA4Rs0h0xLmAyOws3AN5qSk0GYAzI7UHALYMzIhz4h
	 tSlGVWO3wwNp3xZwsqlC9spx0w/JC+cdBeemQ1279KJCOzacjoQzN8a5q4KdcZzL7X
	 F0YoB5zW5LlZiDHwxp3G8Tn5yj9HDM5+KK0yYFwJOGGf8EzVnwWtGm2oOHnQ31u13N
	 uLiMj1oqGOteg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077hR-399Q;
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
Subject: [PATCH v2 17/20] docs: xforms_lists: handle struct_group directly
Date: Thu, 12 Mar 2026 08:12:25 +0100
Message-ID: <732fdf506327ffc183213e22ed618fb2e05e3fd1.1773297828.git.mchehab+huawei@kernel.org>
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

The previous logic was handling struct_group on two steps.
Remove the previous approach, as CMatch can do it the right
way on a single step.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/xforms_lists.py | 53 +++------------------------
 1 file changed, 6 insertions(+), 47 deletions(-)

diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index 7fa7f52cec7b..98632c50a146 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -32,52 +32,6 @@ class CTransforms:
         (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
         (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
         (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
-        #
-        # Unwrap struct_group macros based on this definition:
-        # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
-        # which has variants like: struct_group(NAME, MEMBERS...)
-        # Only MEMBERS arguments require documentation.
-        #
-        # Parsing them happens on two steps:
-        #
-        # 1. drop struct group arguments that aren't at MEMBERS,
-        #    storing them as STRUCT_GROUP(MEMBERS)
-        #
-        # 2. remove STRUCT_GROUP() ancillary macro.
-        #
-        # The original logic used to remove STRUCT_GROUP() using an
-        # advanced regex:
-        #
-        #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
-        #
-        # with two patterns that are incompatible with
-        # Python re module, as it has:
-        #
-        #   - a recursive pattern: (?1)
-        #   - an atomic grouping: (?>...)
-        #
-        # I tried a simpler version: but it didn't work either:
-        #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
-        #
-        # As it doesn't properly match the end parenthesis on some cases.
-        #
-        # So, a better solution was crafted: there's now a CMatch
-        # class that ensures that delimiters after a search are properly
-        # matched. So, the implementation to drop STRUCT_GROUP() will be
-        # handled in separate.
-        #
-        (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
-        (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
-        (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
-        (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
-        #
-        # Replace macros
-        #
-        # TODO: use CMatch for FOO($1, $2, ...) matches
-        #
-        # it is better to also move those to the CMatch logic,
-        # to ensure that parentheses will be properly matched.
-        #
         (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
         r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
         (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),
@@ -106,7 +60,12 @@ class CTransforms:
         (CMatch(r"__cond_acquires_shared"), ""),
         (CMatch(r"__acquires_shared"), ""),
         (CMatch(r"__releases_shared"), ""),
-        (CMatch(r"STRUCT_GROUP"), r'\0'),
+
+        (CMatch('struct_group'), r'\2'),
+        (CMatch('struct_group_attr'), r'\3'),
+        (CMatch('struct_group_tagged'), r'struct \1 \2; \3'),
+        (CMatch('__struct_group'), r'\4'),
+
     ]
 
     #: Transforms for function prototypes.
-- 
2.53.0

