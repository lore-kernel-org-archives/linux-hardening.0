Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BDA22258C;
	Thu,  6 Feb 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878016; cv=none; b=mOSqvj1UmGSFaemYbLZr9nDUmHV4Jqf4tF6JDayx3D8z6Kltw4vdRutc1Bv7naHcqCCfwxm18D/gkQNFy0b6J6HHjaqOZtk0fVxSz0NIEQiycOkQ4fyBf++bQPTEz/C+D0ruUYCet7HaDWUe22zdKJM8MKqmAPGyZiBAO1rVhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878016; c=relaxed/simple;
	bh=P1UAjQd1l2dAgqnIpG6GPaB80SIlk338qZkETPRnzWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvxOI6k/FLK7UqO5BDCW3HBSoQZzg3y9rZhgnWglkAkCd6sDErVSABPrURNEQNyKoESCvpNl7n3FTEfTvgPBKmLmWkiRe43TPc9jHdLGG/AU5SfERl7jHNmJlcz3vw2mnIa6u4OE2ci6Fl5mtxbHG3hilZhwxQK5R7ZE9QJ3qMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN85njkj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN85njkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F09C4CEE0;
	Thu,  6 Feb 2025 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738878015;
	bh=P1UAjQd1l2dAgqnIpG6GPaB80SIlk338qZkETPRnzWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hN85njkjddnNpm2GyrEYgAXAA3SqwB9ZUnRKswL0q8gNvzB24+sOAFpMdqTgm+XYe
	 ie2pC7yGbevoQC7t5hCf13UGJ5y7jeVNYrYEhSj/md5rqlmS1tABm148rHuGG+spIe
	 13c0oaQVFZsRUq0S5GQk0klJEhn56RIaj2vI8JRr3v3JTb1SOq2aYJhczs3hpyPVRv
	 WbZzZb8xqAbiUoAy9fByGJNf1EO+RLl+PofYG+dT2M6eMyVYy7s22svwseVKjtvVFS
	 y/OWzbm3AaxRUrNXCJe+MuJB3teNW/IKtvkV3KVJ4C4QL4Hv6nEOujuKpvwcYcMKbl
	 tUoLRj6Hi4tqg==
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
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
Subject: [PATCH v2 1/3] compiler.h: Move C string helpers into C-only kernel section
Date: Thu,  6 Feb 2025 13:40:06 -0800
Message-Id: <20250206214014.3567372-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206213532.it.087-kees@kernel.org>
References: <20250206213532.it.087-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2418; i=kees@kernel.org; h=from:subject; bh=P1UAjQd1l2dAgqnIpG6GPaB80SIlk338qZkETPRnzWI=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlLdcyM51m7PQth3C61trxw1tyCsLU5QuHi/QdFPh6as 21GyOE9HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABMRW83wP4010WhSEJ+A1xb9 tVwftW+1sW/deaS+g4FJhzvx2h3ZQEaGv696LL2/P6tPvB3+eNKOR0qh810rp4ryi0+4ySYaez6 fHwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The C kernel helpers for evaluating C Strings were positioned where they
were visible to assembly inclusion, which was not intended. Move them
into the kernel and C-only area of the header so future changes won't
confuse the assembler.

Fixes: d7a516c6eeae ("compiler.h: Fix undefined BUILD_BUG_ON_ZERO()")
Fixes: 559048d156ff ("string: Check for "nonstring" attribute on strscpy() arguments")
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/compiler.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 240c632c5b95..7af999a131cb 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -214,6 +214,19 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__v;								\
 })
 
+#ifdef __CHECKER__
+#define __BUILD_BUG_ON_ZERO_MSG(e, msg) (0)
+#else /* __CHECKER__ */
+#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
+#endif /* __CHECKER__ */
+
+/* &a[0] degrades to a pointer: a different type from an array */
+#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
+
+/* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
+#define __must_be_cstr(p) \
+	__BUILD_BUG_ON_ZERO_MSG(__annotated(p, nonstring), "must be cstr (NUL-terminated)")
+
 #endif /* __KERNEL__ */
 
 /**
@@ -254,19 +267,6 @@ static inline void *offset_to_ptr(const int *off)
 
 #define __ADDRESSABLE_ASM_STR(sym) __stringify(__ADDRESSABLE_ASM(sym))
 
-#ifdef __CHECKER__
-#define __BUILD_BUG_ON_ZERO_MSG(e, msg) (0)
-#else /* __CHECKER__ */
-#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
-#endif /* __CHECKER__ */
-
-/* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
-
-/* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
-#define __must_be_cstr(p) \
-	__BUILD_BUG_ON_ZERO_MSG(__annotated(p, nonstring), "must be cstr (NUL-terminated)")
-
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.
-- 
2.34.1

