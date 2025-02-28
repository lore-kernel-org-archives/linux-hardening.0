Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578BF1F4C83;
	Fri, 28 Feb 2025 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764501; cv=none; b=OcqafcBqqV4auJNgS0jxXd/T+d6BzVMVhvj6bCOR/zMN+a9dqrMbzaqaeGx1n6FEQPygNiqXgORKXwzbjem9bZ53YlmztvAQ+2QE0rGq3dqxaDO61DgyWUQTq9gN0FWjqS390GbE0SH24MIcODbAOgbFn1qaGKzTdMBRE9JjH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764501; c=relaxed/simple;
	bh=LfJTVv81rgrDxdAduGKQ5P6oTcbMEPC4C5fHHQtKh7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uD3ty5x+w0f7nn+aP2cQA23D9EG17ig/ZugAQYdcPn9regMg5BpjLXqtnJUJYGju1OITrrEEfnm6L4M1DgtH0dpsxrgABEGpsme45VoS4YpigAMklf4JzivkBPWmrJMYGag9GFkOWLo5Bil4kBd+N//gpwG03pg+0E4qDr73tD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFXYM04B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFXYM04B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47CFC4CED6;
	Fri, 28 Feb 2025 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740764499;
	bh=LfJTVv81rgrDxdAduGKQ5P6oTcbMEPC4C5fHHQtKh7U=;
	h=From:To:Cc:Subject:Date:From;
	b=TFXYM04Bbdyi3s5W3E0wy7Vi8xbcN7UcM3XfURa/W9APAqjCIeTxpLrqyzaV4alZg
	 YvpyOFcJ30bZdNVfiggfR4orKSwkb5mH9ApHUBAVE/aOd3as6dmtTN5iJBnj7tciKa
	 oZgDkoY7ZDIc5gIuAkdfOVyXUBM+eZN10XJPDkxTQweoRDEppHKKLHASM0xo0Zpwfc
	 W2xLvRMg1od2MZz8UItcV51YAOE75moPPPW1K3RPVC9aTXblTrEUttTH4fy675FWyg
	 N+dwXRq+wJMV3hWLkihYmYFjfE1Mq6ewbB/CI/WYUGMGUc+0pdZSdyz/9k/KjnjVJo
	 EO4iZWekQIOhA==
From: Kees Cook <kees@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Kees Cook <kees@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Kelley <mhklinux@outlook.com>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] compiler.h: Introduce __must_be_noncstr()
Date: Fri, 28 Feb 2025 09:41:34 -0800
Message-Id: <20250228174130.it.875-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3318; i=kees@kernel.org; h=from:subject:message-id; bh=LfJTVv81rgrDxdAduGKQ5P6oTcbMEPC4C5fHHQtKh7U=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkHv/o9VVzifPOBpa5oitITnsiQjWw93XfX/nG21Nr6s MJZY4dyRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERObWJk2N6SLP74ZuKKBeG+ jxrEbDL1jl0/enqFbZFr85G1S0Ksmhj+8E1eZ9wo6J+Tc+dl8ZuN++bunzGt7/jmFtfuk/d0s/k 9GQE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for adding more type checking to the memtostr/strtomem*()
helpers, introduce the ability to check for the "nonstring" attribute.
This is the reverse of what was added to strscpy*() in commit 559048d156ff
("string: Check for "nonstring" attribute on strscpy() arguments").

Note that __annotated() must be explicitly tested for, as GCC added
__builtin_has_attribute() after it added the "nonstring" attribute. Do
so here to avoid the !__annotated() test triggering build failures
when __builtin_has_attribute() was missing but __nonstring was defined.
(I've opted to squash this fix into this patch so we don't end up with
a possible bisection target that would leave the kernel unbuildable.)

Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reported-by: Michael Kelley <mhklinux@outlook.com>
Closes: https://lore.kernel.org/all/adbe8dd1-a725-4811-ae7e-76fe770cf096@linux.vnet.ibm.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/compiler.h       | 18 +++++++++++++++++-
 include/linux/compiler_types.h |  9 ++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 200fd3c5bc70..d5201464c5e6 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -206,9 +206,25 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __must_be_byte_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_byte_array(a), \
 							"must be byte array")
 
+/*
+ * If the "nonstring" attribute isn't available, we have to return true
+ * so the __must_*() checks pass when "nonstring" isn't supported.
+ */
+#if __has_attribute(__nonstring__) && defined(__annotated)
+#define __is_cstr(a)		(!__annotated(a, nonstring))
+#define __is_noncstr(a)		(__annotated(a, nonstring))
+#else
+#define __is_cstr(a)		(true)
+#define __is_noncstr(a)		(true)
+#endif
+
 /* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
 #define __must_be_cstr(p) \
-	__BUILD_BUG_ON_ZERO_MSG(__annotated(p, nonstring), "must be cstr (NUL-terminated)")
+	__BUILD_BUG_ON_ZERO_MSG(!__is_cstr(p), \
+				"must be C-string (NUL-terminated)")
+#define __must_be_noncstr(p) \
+	__BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
+				"must be non-C-string (not NUL-terminated)")
 
 #endif /* __KERNEL__ */
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 981cc3d7e3aa..f59393464ea7 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -446,11 +446,14 @@ struct ftrace_likely_data {
 #define __member_size(p)	__builtin_object_size(p, 1)
 #endif
 
-/* Determine if an attribute has been applied to a variable. */
+/*
+ * Determine if an attribute has been applied to a variable.
+ * Using __annotated needs to check for __annotated being available,
+ * or negative tests may fail when annotation cannot be checked. For
+ * example, see the definition of __is_cstr().
+ */
 #if __has_builtin(__builtin_has_attribute)
 #define __annotated(var, attr)	__builtin_has_attribute(var, attr)
-#else
-#define __annotated(var, attr)	(false)
 #endif
 
 /*
-- 
2.34.1

