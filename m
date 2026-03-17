Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1AF3F99C3;
	Tue, 17 Mar 2026 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770990; cv=none; b=p2kTFOH0ch2sddSYpteC9hQArJVzMoQb6Pa1A9+vVu9zyBb2U1lk4+i2rlQZa/yl+q0EOXwrPcu7KZjdHVJy+MDsMIv6oD6qOqSfSl7qlmuvi/Y1xIO1xcO/fdrRk4y4s3aAs1jlekMSRC0shNludE6NHNlmQ4zDyCTHEMXwkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770990; c=relaxed/simple;
	bh=fTBYVejQ5or901ad6djW/bFIacxU0cRuaVuoUbZVtDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBa500VhLkAcNWqC3UHwAhXc9a9rKf7Vy1dLnlaYOvv5Lp4U+AH8ugRtVAp2y5bsAFmNNVLZibz29Xf4/W16WQ+o5YVkdcmhZNbSXg9QURD3poQ/ar7sTNcqsGW20uLAxMKTBBUpEH/MYIWB5PHhZgPf40veIigjjd2EfulDQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQT96pK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQT96pK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40735C2BCB0;
	Tue, 17 Mar 2026 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770990;
	bh=fTBYVejQ5or901ad6djW/bFIacxU0cRuaVuoUbZVtDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQT96pK0CBh9M+ERLc/QFVhs1sdIl/G0lmjFlYURq5Xv+cvC/ZSD7VMMdqtL+ffby
	 lgG9GCBZwMsQn0EO28eW9NQ9Godk0ko5reazzlxLE74y6DC4D2KBEqq5jgaSXcwki9
	 db1pWDxp3gQ6VpU8ku3DfOp1ioKzkR18wYpYvlAWShlUmLKo/hbp9ubMLLXue0E1Ye
	 QyVndsMCxBdlahqjKqv9dY0Lg6PQHWHO/YoPlqFJAMwyaaAuXtqqItP73jSKRksKDM
	 1wZo0XlZ6xHrM95pEfK/fPwo4v2+uCCaGT/z2IwXwheP+u8uwq4A8vCAt0Ak5WnwHM
	 Y7SbVW+LOcNwQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrU-0000000H5Xy-27c5;
	Tue, 17 Mar 2026 19:09:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 16/22] docs: xforms_lists: handle struct_group directly
Date: Tue, 17 Mar 2026 19:09:36 +0100
Message-ID: <da7f879d90e3ffbc1f47771522f212a60df1fab6.1773770483.git.mchehab+huawei@kernel.org>
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
2.52.0

