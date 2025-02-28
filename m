Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14779230BD8;
	Fri, 28 Feb 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772239; cv=none; b=sd7eW9l7Efc6zAQEn01y0FiHAVZLNbMtUmyIAj1a94j99Nhg2dm28oz0O2kCfc8mtEGn7Rr5vrz+9Wkh3+KWfoot1Nc/GxsQSlrpbwitj5QFJ/ND6OH7zBEMG/3veX56MvMEN1N61kcFMP/zTyRtjkJicvy/pYC1aqU2R5Z7NIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772239; c=relaxed/simple;
	bh=1oTYdMLj5IJV7VGpD5+wlKsa4biWQMpU+M06wbYFhIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y8AXO9DVvqSGDw3Cv+GwPvjuLDX+fRAt2iDxdVbS4XwT4VLtdl/RgkNd0JFEE29imn/0mB2kX52OnEoQvcJUAP4bEnRwjh/Skhq1YwPiN7XhaTFhLOlXcUaJjqkR7MlRR6myuu26/ajToG/7AqhpQ352ycI0Ugy49Ot++WkGWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNSV9REg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNSV9REg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E60EC4CEE9;
	Fri, 28 Feb 2025 19:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740772238;
	bh=1oTYdMLj5IJV7VGpD5+wlKsa4biWQMpU+M06wbYFhIo=;
	h=From:To:Cc:Subject:Date:From;
	b=NNSV9REg9Bw7j6BcHsc5c96iIjmxtrvK6/O2TY92s+YnhYOZMX6JJLeWl3DbsX68o
	 UG8qnu3QSMo6d9pxOGANjJzTooD/H9tBE+O6wfpecwg7EaOPdqAW6aR4vrC1VoCbZC
	 jCo0CWla8MGYYgPRDhvM823n5pThGNMYYa+h4g0CA4eNAyDLgJs6ehaX0AZ9AnzK3y
	 U7MyhzEsGnshu9St8I9bSQTosUNq8exGX+6Y4ex5G936mgiOpQZ7hi0KRFDsVjuiN/
	 YWgkBSfb39zwG6MA+V83XX2RDr03GfSffShQVgccKmmhCcXNmkKBRxk3Okx0/srYxY
	 FTfYYFx1e2OAg==
From: Kees Cook <kees@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mel Gorman <mgorman@techsingularity.net>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-hardening@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] uaccess: Introduce ucopysize.h
Date: Fri, 28 Feb 2025 11:50:23 -0800
Message-Id: <20250228195019.work.296-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6926; i=kees@kernel.org; h=from:subject:message-id; bh=1oTYdMLj5IJV7VGpD5+wlKsa4biWQMpU+M06wbYFhIo=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmHhOstV3qUHGmv73j1crmKgRWbgnLetzi2rXx7u1a87 nrVXC3aUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJGmBIbfbIK7/dvEfL4GFXF3 Mq7XCf9oESi4/Z3u46Ov7mxxCAg+x8iwzro/V9/fT3zNm8O1HJ+DOGYV+tXZV7qxuAiIzVx6qIM bAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The object size sanity checking macros that uaccess.h and uio.h use
have been living in thread_info.h for historical reasons. Needing to
use jump labels for these checks, however, introduces a header include
loop under certain conditions. The dependencies for the object checking
macros are very limited, but they are used by separate header files,
so introduce a new header that can be used directly by uaccess.h and
uio.h. As a result, this also means thread_info.h (which is rather large)
and be removed from those headers.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502281153.TG2XK5SI-lkp@intel.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
I'll carry this in the hardening tree since the usercopy hardening changes
depend on it...

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-hardening@vger.kernel.org
---
 MAINTAINERS                 |  1 +
 include/linux/thread_info.h | 48 -------------------------------
 include/linux/uaccess.h     |  2 +-
 include/linux/ucopysize.h   | 56 +++++++++++++++++++++++++++++++++++++
 include/linux/uio.h         |  2 +-
 mm/usercopy.c               |  2 +-
 6 files changed, 60 insertions(+), 51 deletions(-)
 create mode 100644 include/linux/ucopysize.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..a1900962ced9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12586,6 +12586,7 @@ F:	Documentation/ABI/testing/sysfs-kernel-warn_count
 F:	arch/*/configs/hardening.config
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
+F:	include/linux/ucopysize.h
 F:	kernel/configs/hardening.config
 F:	lib/usercopy_kunit.c
 F:	mm/usercopy.c
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index cf2446c9c30d..dd925d84fa46 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -217,54 +217,6 @@ static inline int arch_within_stack_frames(const void * const stack,
 }
 #endif
 
-#ifdef CONFIG_HARDENED_USERCOPY
-extern void __check_object_size(const void *ptr, unsigned long n,
-					bool to_user);
-
-static __always_inline void check_object_size(const void *ptr, unsigned long n,
-					      bool to_user)
-{
-	if (!__builtin_constant_p(n))
-		__check_object_size(ptr, n, to_user);
-}
-#else
-static inline void check_object_size(const void *ptr, unsigned long n,
-				     bool to_user)
-{ }
-#endif /* CONFIG_HARDENED_USERCOPY */
-
-extern void __compiletime_error("copy source size is too small")
-__bad_copy_from(void);
-extern void __compiletime_error("copy destination size is too small")
-__bad_copy_to(void);
-
-void __copy_overflow(int size, unsigned long count);
-
-static inline void copy_overflow(int size, unsigned long count)
-{
-	if (IS_ENABLED(CONFIG_BUG))
-		__copy_overflow(size, count);
-}
-
-static __always_inline __must_check bool
-check_copy_size(const void *addr, size_t bytes, bool is_source)
-{
-	int sz = __builtin_object_size(addr, 0);
-	if (unlikely(sz >= 0 && sz < bytes)) {
-		if (!__builtin_constant_p(bytes))
-			copy_overflow(sz, bytes);
-		else if (is_source)
-			__bad_copy_from();
-		else
-			__bad_copy_to();
-		return false;
-	}
-	if (WARN_ON_ONCE(bytes > INT_MAX))
-		return false;
-	check_object_size(addr, bytes, is_source);
-	return true;
-}
-
 #ifndef arch_setup_new_exec
 static inline void arch_setup_new_exec(void) { }
 #endif
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index e9c702c1908d..7c06f4795670 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -7,7 +7,7 @@
 #include <linux/minmax.h>
 #include <linux/nospec.h>
 #include <linux/sched.h>
-#include <linux/thread_info.h>
+#include <linux/ucopysize.h>
 
 #include <asm/uaccess.h>
 
diff --git a/include/linux/ucopysize.h b/include/linux/ucopysize.h
new file mode 100644
index 000000000000..b3e1b875d565
--- /dev/null
+++ b/include/linux/ucopysize.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Perform sanity checking for object sizes for uaccess.h and uio.h. */
+#ifndef __LINUX_UCOPYSIZE_H__
+#define __LINUX_UCOPYSIZE_H__
+
+#include <linux/bug.h>
+
+#ifdef CONFIG_HARDENED_USERCOPY
+extern void __check_object_size(const void *ptr, unsigned long n,
+					bool to_user);
+
+static __always_inline void check_object_size(const void *ptr, unsigned long n,
+					      bool to_user)
+{
+	if (!__builtin_constant_p(n))
+		__check_object_size(ptr, n, to_user);
+}
+#else
+static inline void check_object_size(const void *ptr, unsigned long n,
+				     bool to_user)
+{ }
+#endif /* CONFIG_HARDENED_USERCOPY */
+
+extern void __compiletime_error("copy source size is too small")
+__bad_copy_from(void);
+extern void __compiletime_error("copy destination size is too small")
+__bad_copy_to(void);
+
+void __copy_overflow(int size, unsigned long count);
+
+static inline void copy_overflow(int size, unsigned long count)
+{
+	if (IS_ENABLED(CONFIG_BUG))
+		__copy_overflow(size, count);
+}
+
+static __always_inline __must_check bool
+check_copy_size(const void *addr, size_t bytes, bool is_source)
+{
+	int sz = __builtin_object_size(addr, 0);
+	if (unlikely(sz >= 0 && sz < bytes)) {
+		if (!__builtin_constant_p(bytes))
+			copy_overflow(sz, bytes);
+		else if (is_source)
+			__bad_copy_from();
+		else
+			__bad_copy_to();
+		return false;
+	}
+	if (WARN_ON_ONCE(bytes > INT_MAX))
+		return false;
+	check_object_size(addr, bytes, is_source);
+	return true;
+}
+
+#endif /* __LINUX_UCOPYSIZE_H__ */
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 8ada84e85447..49ece9e1888f 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -6,8 +6,8 @@
 #define __LINUX_UIO_H
 
 #include <linux/kernel.h>
-#include <linux/thread_info.h>
 #include <linux/mm_types.h>
+#include <linux/ucopysize.h>
 #include <uapi/linux/uio.h>
 
 struct page;
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 83c164aba6e0..16d63bd010af 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -17,7 +17,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
-#include <linux/thread_info.h>
+#include <linux/ucopysize.h>
 #include <linux/vmalloc.h>
 #include <linux/atomic.h>
 #include <linux/jump_label.h>
-- 
2.34.1

