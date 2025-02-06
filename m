Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6722257E;
	Thu,  6 Feb 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878016; cv=none; b=uX76Wc9sFy91OyZM80moMdq/sjx+JPcMea6aX1ibNAdK/GDRkIz50bBtah8vV98hgB7993qTXdNWAT2daqYGcOAgPOv55VMkgYL41JE28JalV38kHe/PFh3EP8m66bxafNPtYnedi8Km3a1TquU9mDHvRaCQrxpqgM4Upb2bkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878016; c=relaxed/simple;
	bh=wTdFK+jD3ufoM9me7Aq67Q7K2Pigcx8UjpsokDHiCaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+mChNBYGwRFCVLvzxF8kTmpJK6FjQI74u1RuUh9OPkTkUWsjttoCa4L2h1EOr0dI5PUQ5LNVQ5Lgns8f29J5J3GdXP8OHqq5avTyMfC64uqkLNvU0sFSBt2kXz+9mWzwKOVnlowdSv39RGYbaxz8dpXHiqV6/AchgQtt4y1Sxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbXKBghm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbXKBghm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAADC4CEE2;
	Thu,  6 Feb 2025 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738878015;
	bh=wTdFK+jD3ufoM9me7Aq67Q7K2Pigcx8UjpsokDHiCaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbXKBghm+qbdMvdw81r1lsnZLIoDZl8D5Ii0/7Ks9Ft7sv9wrx5YNaS3tXDq/hgty
	 YC8Q6ZNAECMZyV4azX7Wzp29v86FyQMo32FpJgDBu1/5sh+yRKcO8wq+KAuKmKKNy3
	 dt0up2hJSh+3VEakg4g7mGt4oJKZTW7HTfvG+29mX64AI0ykndFEpR8UYGfjcn7qMo
	 3T5mtQ8thZkaV//3LGyPhIaDal8XkRhx5KdAaWLYDrUrSmrpaujJbbuoEPOKg+x4QM
	 go+gcLzMuU1f+bEy0zErvdtqk8emodnViMk5eSH9WBjl4+H9aIwP74gCt2m/qj/9hS
	 1y+aipVkvP/Hw==
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 2/3] compiler.h: Introduce __must_be_byte_array()
Date: Thu,  6 Feb 2025 13:40:07 -0800
Message-Id: <20250206214014.3567372-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206213532.it.087-kees@kernel.org>
References: <20250206213532.it.087-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=kees@kernel.org; h=from:subject; bh=wTdFK+jD3ufoM9me7Aq67Q7K2Pigcx8UjpsokDHiCaY=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlLdcxPHFATtbyYF3NuprAdb95Vu1gHraUPeL/+bW/PN /hRaSLSUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJF0MYb/3vperxI6WJZ9PXBA lY1Lm2fTFsZFcT/LkgRXeOXJn9BfxshwqHpWs83Oo+9mMDPZxkx8kPvnAv8s2ytbUg5FSEj7pIY wAgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for adding stricter type checking to the str/mem*()
helpers, provide a way to check that a variable is a byte array
via __must_be_byte_array().

Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/compiler.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7af999a131cb..1c0688319435 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -221,7 +221,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #endif /* __CHECKER__ */
 
 /* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
+#define __is_array(a)		(!__same_type((a), &(a)[0]))
+#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
+							"must be array")
+
+#define __is_byte_array(a)	(__is_array(a) && sizeof((a)[0]) == 1)
+#define __must_be_byte_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_byte_array(a), \
+							"must be byte array")
 
 /* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
 #define __must_be_cstr(p) \
-- 
2.34.1

