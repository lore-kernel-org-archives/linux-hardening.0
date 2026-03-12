Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6313C6A22;
	Thu, 12 Mar 2026 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327300; cv=none; b=QKHImFeGcW3hU5aISTtF9ZTz60RDeDKhGofU/ZDv+ZtVzcijyG1xBti1AJRuq1iHGSGjRtwQaDoNm7D4ZZx+0k810qrCuH/Ft+e6Stso3Nyu690xVOf6eoQDwQ0y98/k2pAaaxw/hb6cPA5ZmjAsgha7CyfBbmMMz303opLZgO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327300; c=relaxed/simple;
	bh=fTBYVejQ5or901ad6djW/bFIacxU0cRuaVuoUbZVtDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo82qZ36UNi0IdaXrNJ/mRG4Pr3+kY9PPGfhwT6AcckcClX4WB2BsH0VpzcBUGneyMbt60zs2F5NpRKIuK3yHtttFecSLIrNXnCzJ2vqKDhVby5gpajSkscdGYxnVTpJqEPEPT66XnrB22bmMkASQgDMT7aevYk+3D6e01W0Ze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edB6SUlV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edB6SUlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7416BC2BC9E;
	Thu, 12 Mar 2026 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327300;
	bh=fTBYVejQ5or901ad6djW/bFIacxU0cRuaVuoUbZVtDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edB6SUlV050F4GHara9DQgi1gLFKsXB3m6blB4OWYEHBwE3MhhriHbOxbedWwcwhh
	 nt/C2vkLa6vnH9hh4gtlh5GzrHp4QKQ1VnsWmdVQOjOdNqdECyARvNwkeQ87rMosKc
	 svv1Qqc8aOENpUd2vMie49Ulgg1OwUU6wv4gX7eQj2QTZfCZk7GlEtVgHenddzuW8N
	 Jk0XDVUexpXgbJfcFnX0K+Qzi2uNiZA2cKzSVpXd0u9OuoXKF8nymKXTlxG5VB1BUT
	 e7YMhEoAX/STZ/xD4bptLNIGRn7CUaXNyVZiY/cRePgYMdItVDc0jl8CkZvS1mr3lD
	 0ja/aPJ7y7Vpw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRC-00000008y6Q-2v98;
	Thu, 12 Mar 2026 15:54:58 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 17/28] docs: xforms_lists: handle struct_group directly
Date: Thu, 12 Mar 2026 15:54:37 +0100
Message-ID: <732fdf506327ffc183213e22ed618fb2e05e3fd1.1773326442.git.mchehab+huawei@kernel.org>
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

