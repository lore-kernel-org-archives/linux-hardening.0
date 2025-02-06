Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9C1993B1;
	Thu,  6 Feb 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865494; cv=none; b=ghzEfWO/d4gJD1D3RQqeUNksI9sICX0ti1qzbGIstMfro4UARiiQvEvP5itlMjVxDdZJOFdl2KGXrmdZRX1vj2fe+J0AW736DsP+MaJQN4PMz9QjinUeQtUG8uEvU/xGfk9/jy24E7om83hImAromBtje81eHwfibXqXx/GZyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865494; c=relaxed/simple;
	bh=rxjiRXlnBU5/6YXKyAHnzpq4xMXmOTNG1gjd5WFVALw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2AExMGiIaOxyuTZ6dmBjMYmPBkYDw/JXNM6CRe/PMzm1d5Tv/ZdgRxJyHZdosVdN5My5134SXLlDDNSWhTuE0e6vQioxZ0mQ1sGBwPXe8l7dZ9NmKJZwpw3GteuQL5c4H4Y86/TqV4pnv8OpBhTPXmEzAuxQGVmDPd13N16VJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwbva86v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwbva86v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD532C4CEDD;
	Thu,  6 Feb 2025 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738865493;
	bh=rxjiRXlnBU5/6YXKyAHnzpq4xMXmOTNG1gjd5WFVALw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jwbva86vrk99nVtp1FqhL1r0eIAQXeZ9yI4NKu24dsVN8+M26Jtjo+sDMGxws7MMF
	 Bzr4CJv6auE52k2xTmAbhQA7j3aYugYZJX16ZMqyhoRcKQ6Rwa6kvuOCF5rllZE9TW
	 Z3n9v8YYN1HSTwhbLbH2JeEVYE8norlzDDNDBgsojqvvhB74HLFs9hylogmbLYVX0T
	 7KZNtMpSshrZNGjON4IqDTBH/B454KDvrD51Jz+4YuK8kj2AQhP9xv0uuKCk2OV7nE
	 8aXG6qm+x66WeZ7eFTatD5FyntgFISLdIWzHI4QpclGgFTHx5Ez4H/E7cizl7kmFwk
	 mqjXh87FixztA==
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
Subject: [PATCH 1/3] compiler.h: Move C string helpers into C-only kernel section
Date: Thu,  6 Feb 2025 10:11:28 -0800
Message-Id: <20250206181133.3450635-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206175216.work.225-kees@kernel.org>
References: <20250206175216.work.225-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2302; i=kees@kernel.org; h=from:subject; bh=rxjiRXlnBU5/6YXKyAHnzpq4xMXmOTNG1gjd5WFVALw=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlLfgfyLy/WD93qO62wfGHQmpWrH0isyjcu85aWuvNFR S+uwkuho5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJV4YwMfx9L7F6yacGplfxi Xno2KeKGt57VJhf2MhTyPHffzqd5nJHhpeXO3gnXbkhP3Bn3y8tqTlKAfzYDT/+kXxISya1lBuX cAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The C kernel helpers for evaluating C Strings were placed outside of the
assembly ifdef. Move them to the correct place so future changes won't
confuse the assembler.

Fixes: d7a516c6eeae ("compiler.h: Fix undefined BUILD_BUG_ON_ZERO()")
Fixes: 559048d156ff ("string: Check for "nonstring" attribute on strscpy() arguments")
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

