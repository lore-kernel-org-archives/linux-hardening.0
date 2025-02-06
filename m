Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4919ADB0;
	Thu,  6 Feb 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865494; cv=none; b=k5NDr7lH6/mVgcBfOwM+mEJmcZBFexqgoO5B9O3hYYhMM6RvpsokuevGs6QeF+Ll5s7XUhz3lN4gDj+l/TEofoMQGnWEpmlCf1yYk01ddF8+EW641CSXXeHfjxsE4LmXAYMZPP99KFKB4QRWJDMQJ3sc/sct48YB9HzeOPHrsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865494; c=relaxed/simple;
	bh=HPvFfUBydyi8hNJ/KZN7Ew2hJ0umQS6wowFoOrda14s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R1wU2b8ILfMaqZ2C2Dl/9iKVac/V9CQ6OWhmuLRkskkRjfXgOPmzNgYvxdPdujy0F5Bp9ULqrbP6gu80ZkiYJJ5lNOrt02JLRCBdYPqnfWe9ApU2KrOzDg87hOjLosZbdYlmfx0/SZIQnvTGg76ykyItvGbu0vB25NNjk7qgVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ6bYnF3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ6bYnF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED62C4AF0B;
	Thu,  6 Feb 2025 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738865493;
	bh=HPvFfUBydyi8hNJ/KZN7Ew2hJ0umQS6wowFoOrda14s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJ6bYnF3MA511vzkCs/j+C+CGkjxVQLiJERqM6oCzKMaFTKxunvO/XCRwAI4fvJsl
	 IGjGs06oWTV4gpDrDWB+SrRZxX1SNXTC6PU9GFYNBKOn2i2g1AuG6DfhDaOdz73bqR
	 9MGzjuQnJqCJ4sn238/34GX2bBrrlvtUi/quXRcuzAa0FGriXJPDArNDR07pO3WP0C
	 F7t7zJ9PVJOV02htfV7fjImpngzwJaf26c8VlLWGjpCRRgOQANhqopHSl1PN3rKrEy
	 04HViZMSeXUk/jhtuqW4edD/qY/7gt9J2xuxXiuNW/amPNqEbzdwvMpb68zhBGP6VX
	 IUChdpFTSNpJA==
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andy Shevchenko <andy@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/3] compiler.h: Introduce __must_be_char_array()
Date: Thu,  6 Feb 2025 10:11:29 -0800
Message-Id: <20250206181133.3450635-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206175216.work.225-kees@kernel.org>
References: <20250206175216.work.225-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=kees@kernel.org; h=from:subject; bh=HPvFfUBydyi8hNJ/KZN7Ew2hJ0umQS6wowFoOrda14s=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlLfgeqLhVK3791gfLfUqGPD99MO3Cu5en3bs65v1mML rZwuydldpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEykZS7Df5dGyeBryS9Mr8w9 36Obznv8SPDf/d4SxlvkeQsXvOqoesrwh4PnRMuqQwXWlhsuFs0tX8SgP9P30qFWpcAn/7Wv+7x cxgkA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for adding stricter type checking to the str/mem*()
helpers, provide a way to check that a variable is a character array
via __must_be_char_array().

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/compiler.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7af999a131cb..a577fe0b1f8a 100644
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
+#define __is_char_array(a)	(__is_array(a) && sizeof((a)[0]) == 1)
+#define __must_be_char_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_char_array(a), \
+							"must be byte array")
 
 /* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
 #define __must_be_cstr(p) \
-- 
2.34.1

