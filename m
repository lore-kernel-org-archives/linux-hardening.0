Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1927AC48;
	Tue, 20 May 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758806; cv=none; b=JTGVxzSz2K3QgWs7wFK6JetN9TxG9+uHewt7lHB+zOrjluyF19RTDS0GI8Gg+laRfwAlZePeF8uN/1fDksVNzCeUqKbN2Uc3/Mn+4IVrbVk4h6XCgBYlh7a/gHph5Mza6fDb/4jbbBeVia5ktHbWYiyJk0WFyd8tbLHYHyUwCp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758806; c=relaxed/simple;
	bh=OoBKYnWkbMa37dGf3bqGJtv+2nUTHc/3tPjJKv4bdY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JJN9bKO/uUPsu/1NxAO5gYAvpFteY+jYX0NbijdBdAxb4IHzpjYF0Do09E+PZZLi71bbBBXQ/Z20qCEQ2LL7QI56dB/VGV1t6XOU4i+VbYpOK8box7mF2TVqeufpPq30s78MuvcfHOXeYA8pFpjVwnxW9FBIi227gL808HwxFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxjnUpwn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxjnUpwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B56C4AF09;
	Tue, 20 May 2025 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747758805;
	bh=OoBKYnWkbMa37dGf3bqGJtv+2nUTHc/3tPjJKv4bdY0=;
	h=From:To:Cc:Subject:Date:From;
	b=pxjnUpwnKBf+DRwmV71oty7jHzV1SVlOQRNDf0Kodrk7PFP9KkcT6SXTVcpmAM7jl
	 47yAuD6MydcRwWqPkF08DINdyvacqXKfmDq7jGLmVQjhlmUxNTl+W0/LksQJ8ba/Wg
	 Z8QAR0oTpi4OP/0fwVFb1OPaHB0cfdWIqAW6wdnq8z1RAIWi70TMf0YxBAN2I90xjf
	 HtQ/XV3AkqJMEimUFd4i/Aj2iW+ruRVrN8rrgjBYRoLrhjtFKS+G8t6T0TtLdnYnB0
	 PVs1i8TZBIavM/zt1y98NWyRGVkWifDeOsE9VB8HwwBOfPwK02cyAxg5srfcabH8lW
	 RjR6twozEajOg==
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] string.h: Provide basic sanity checks for fallback memcpy()
Date: Tue, 20 May 2025 09:33:21 -0700
Message-Id: <20250520163320.work.924-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3060; i=kees@kernel.org; h=from:subject:message-id; bh=OoBKYnWkbMa37dGf3bqGJtv+2nUTHc/3tPjJKv4bdY0=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk66y6u7Zd4NnED78GrbDemRwrdibVzeblyAY+hNMvbe WLG3+U4O0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACbifY+R4f7sU2vr5tSZzbsh WH5sz6983f5NQpfP2lis7lnH/nkznyrD//qt3E7HuXdv7Amy/G648vrm8KV71a9V/JmlrsPp/X9 lCAcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Instead of defining memcpy() in terms of __builtin_memcpy() deep
in arch/x86/include/asm/string_32.h, notice that it is needed up in
the general string.h, as done with other common C String APIs. This
allows us to add basic sanity checking for pathological "size"
arguments to memcpy(). Besides the run-time checking benefit, this
avoids GCC trying to be very smart about value range tracking[1] when
CONFIG_PROFILE_ALL_BRANCHES=y but FORTIFY_SOURCE=n.

Link: https://lore.kernel.org/all/202505191117.C094A90F88@keescook/ [1]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202501040747.S3LYfvYq-lkp@intel.com/
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/all/e3754f69-1dea-4542-8de0-a567a14fb95b@infradead.org/
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: <linux-hardening@vger.kernel.org>
---
 arch/x86/include/asm/string_32.h |  6 ------
 include/linux/string.h           | 13 +++++++++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 32c0d981a82a..fad9566f43a6 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -145,12 +145,6 @@ static __always_inline void *__constant_memcpy(void *to, const void *from,
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, size_t);
 
-#ifndef CONFIG_FORTIFY_SOURCE
-
-#define memcpy(t, f, n) __builtin_memcpy(t, f, n)
-
-#endif /* !CONFIG_FORTIFY_SOURCE */
-
 #define __HAVE_ARCH_MEMMOVE
 void *memmove(void *dest, const void *src, size_t n);
 
diff --git a/include/linux/string.h b/include/linux/string.h
index 01621ad0f598..a1f8fdcf8482 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -4,6 +4,7 @@
 
 #include <linux/args.h>
 #include <linux/array_size.h>
+#include <linux/bug.h>
 #include <linux/cleanup.h>	/* for DEFINE_FREE() */
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
@@ -390,7 +391,19 @@ static inline const char *kbasename(const char *path)
 
 #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
 #include <linux/fortify-string.h>
+#else
+/* Basic sanity checking even without FORTIFY_SOURCE */
+# ifndef __HAVE_ARCH_MEMCPY
+#  define memcpy(t, f, n)					\
+	do {							\
+		typeof(n) __n = (n);				\
+		/* Skip impossible sizes. */			\
+		if (!WARN_ON(__n < 0 || __n == SIZE_MAX))	\
+			__builtin_memcpy(t, f, __n);		\
+	} while (0)
+# endif
 #endif
+
 #ifndef unsafe_memcpy
 #define unsafe_memcpy(dst, src, bytes, justification)		\
 	memcpy(dst, src, bytes)
-- 
2.34.1

