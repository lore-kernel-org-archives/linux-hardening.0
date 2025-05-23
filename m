Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706561F4171;
	Fri, 23 May 2025 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747974465; cv=none; b=KAxzQFsNGa8BVK3ef6gs6a4fPyx5h6xHzvumny30l4gdl8cb1MhztDikCXBJ2VIo4Vui62chQiE7t4w4DmE2nNWMbzB5A+mDygmHqhsUcDFfvD+Jv/4BktR0gH9dlFVqRGlb8iuOw6Ecffao26WIVbrEsdAKNbVOVG9yeb0LjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747974465; c=relaxed/simple;
	bh=lgNiU/m3wYgiNRPskBdobdPyMkNUXLHcj+PUPwYu7p8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fsIGqHCoIjqYO0kJv+yRIcp0QeMKx0JJa8/Fqi0J9oYYekKrDvYNDBBBknXq9s9qQ4bpyYyo0lJFaTsN6XmmTdMJMi/emVLaocvCHkIqBmzS5uBeWV6twineUPp8ow0xTJpHAE7BdTnHvPGsQlZttMOPQeC66a8fxaKgXgrzG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+B/SzNJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+B/SzNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD5BC4CEE9;
	Fri, 23 May 2025 04:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747974464;
	bh=lgNiU/m3wYgiNRPskBdobdPyMkNUXLHcj+PUPwYu7p8=;
	h=From:To:Cc:Subject:Date:From;
	b=T+B/SzNJxphWY2GG9zFVT3cEtSuXG/3fv0dKVNvIPpxej47fxitxDAbfaDYIh7Ek5
	 bBXdQj4UFjzbDc8JnQB7iwIV+ZiXdeTuIIaHHaU0+tZSkcNyVmYn4YomvBt/98wlgC
	 ZuN/gDlxPPlQq10TSci24yv62X/e8SF5XEyhNkLmT2Xhhm0j9xi5QLnLwDrdwALdyt
	 alAOlCFORFDfZCZJ+L8NJ/l9fR+ZLh9GZfwg3EM20T5jHhpO4kzKNiDGdYUApiHPZi
	 pwSQColQQQ2AxWkHF3PpejWIBk8Q7Kdw/+UE6H3hUSsjmlLjMTRbUv+AlCKNhvlD7T
	 d0tQ3J3lx4OCQ==
From: Kees Cook <kees@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] csky: string.h: Provide basic sanity checks for fallback memcpy()
Date: Thu, 22 May 2025 21:27:39 -0700
Message-Id: <20250523042738.work.777-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3446; i=kees@kernel.org; h=from:subject:message-id; bh=lgNiU/m3wYgiNRPskBdobdPyMkNUXLHcj+PUPwYu7p8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6P60PNV3uXLDJVV/Xdc7Jq/s+WN2Okntz3OaO/vaND jWxf06UdZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzkSQjDP1XGzXIqJkknGA5E q0nGRUv+a1hlk71LVdz59nQPk79ajxj+JzY7fPONlzTnKunU7ltaMdfo9abEVdX52d/sVh9vPSz FAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add basic sanity checking for pathological "size" arguments to
memcpy(). Besides the run-time checking benefit, this avoids
GCC trying to be very smart about value range tracking[1] when
CONFIG_PROFILE_ALL_BRANCHES=y but FORTIFY_SOURCE=n.

Additionally avoid duplicate memcpy definitions in page.h.

Link: https://lore.kernel.org/all/202505191117.C094A90F88@keescook/ [1]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202501040747.S3LYfvYq-lkp@intel.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: split this off to csky
 v1: https://lore.kernel.org/lkml/20250520163320.work.924-kees@kernel.org/
Cc: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <linux-csky@vger.kernel.org>
---
 arch/csky/abiv1/inc/abi/string.h | 11 +++++++++++
 arch/csky/abiv2/inc/abi/string.h | 11 +++++++++++
 arch/csky/include/asm/page.h     |  4 +---
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/string.h b/arch/csky/abiv1/inc/abi/string.h
index de50117b904d..9e780877d8ab 100644
--- a/arch/csky/abiv1/inc/abi/string.h
+++ b/arch/csky/abiv1/inc/abi/string.h
@@ -6,6 +6,17 @@
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
 
+#ifndef CONFIG_FORTIFY_SOURCE
+#define memcpy(t, f, n)					\
+	({						\
+		typeof(n) __n = (n);			\
+		/* Skip impossible sizes. */		\
+		if (!(__n < 0 || __n == SIZE_MAX))	\
+			__builtin_memcpy(t, f, __n);	\
+		(t);					\
+	})
+#endif /* !CONFIG_FORTIFY_SOURCE */
+
 #define __HAVE_ARCH_MEMMOVE
 extern void *memmove(void *, const void *, __kernel_size_t);
 
diff --git a/arch/csky/abiv2/inc/abi/string.h b/arch/csky/abiv2/inc/abi/string.h
index f01bad2ac4fb..e66d5d2f7e52 100644
--- a/arch/csky/abiv2/inc/abi/string.h
+++ b/arch/csky/abiv2/inc/abi/string.h
@@ -9,6 +9,17 @@ extern int memcmp(const void *, const void *, __kernel_size_t);
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
 
+#ifndef CONFIG_FORTIFY_SOURCE
+#define memcpy(t, f, n)					\
+	({						\
+		typeof(n) __n = (n);			\
+		/* Skip impossible sizes. */		\
+		if (!(__n < 0 || __n == SIZE_MAX))	\
+			__builtin_memcpy(t, f, __n);	\
+		(t);					\
+	})
+#endif /* !CONFIG_FORTIFY_SOURCE */
+
 #define __HAVE_ARCH_MEMMOVE
 extern void *memmove(void *, const void *, __kernel_size_t);
 
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 4911d0892b71..069971389ce6 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -5,6 +5,7 @@
 
 #include <asm/setup.h>
 #include <asm/cache.h>
+#include <asm/string.h>
 #include <linux/const.h>
 
 #include <vdso/page.h>
@@ -33,9 +34,6 @@
 #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && \
 			(void *)(kaddr) < high_memory)
 
-extern void *memset(void *dest, int c, size_t l);
-extern void *memcpy(void *to, const void *from, size_t l);
-
 #define clear_page(page)	memset((page), 0, PAGE_SIZE)
 #define copy_page(to, from)	memcpy((to), (from), PAGE_SIZE)
 
-- 
2.34.1

