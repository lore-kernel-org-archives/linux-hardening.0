Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E250255
	for <linux-hardening@vger.kernel.org>; Tue, 26 Dec 2023 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jH+DIUcj"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e8996ead39so81997377b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 Dec 2023 10:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703613650; x=1704218450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zRl3IvQBK/S8r0wMAY81Jjlb+fSoxXp/kN5gJ/doMRc=;
        b=jH+DIUcjmAFsYlTqQ5L8izcIDoMWM3Z1fM5HpqQQ5USLhDXh863nQ33Op1EwVGvs0V
         heiPNSVwogU0XKA7IATn0SqnkLrj5tKZBfTEt+HUqLk/ayZbMmHZuQpo8K2KLWja4E5P
         +kXlwzV4kvbJoYsG49YmJKqlc4fmxfgqYs9jQVTiJsEyg5vLhGHZ4vXOQPBPkn8ROza9
         6LGkukiPNqBi7x+qtBAhkwuwxJvp+IfgfKFHORnY4UrHrQVF+LWkw2xJeEz8uIqHPhyp
         FBiPmMCfdB9lpXmO4oAYUWiXHkwQN6tcQFzl0URcojeB1C9r8Ma2esU9e5cfriKjp+s5
         LAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703613650; x=1704218450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRl3IvQBK/S8r0wMAY81Jjlb+fSoxXp/kN5gJ/doMRc=;
        b=KwGBmIyq+VqGonezOl8dVf5NID9UPeIBOPqMX8lPTjAPdwLfriHuKmTJQVOUoWz02M
         nVQM2gKKwfklcIqeWWW92NpUFUlTZ2Ape0Os+cluCAQA8KRS68MABkymfbc0yy1V+X/x
         bTA6YD5a8sTAoeV9ICNmqU8LjC/HGfQk/r4JFtJPngZEsa78hFtcHdNjjnmdapxR+kmG
         cLPSt+RuTU4muu+mqyhhvunsIoG8zX1HpZNxfj3+49zqBnDyuVN62XLUceBFGpA8zusc
         LHAyGgReGSo0leY9fI6DZtfQsAkvtwIy9Pk7U4aaMwJ9E8SNpY7vHCc6JoeGjNu9r5zE
         wG6Q==
X-Gm-Message-State: AOJu0YyQojSs534j8G2ZPI3nACR6tg4v8eWSPQ6X3UKK5RyI40dBC7Q7
	3/avQw/7/xFD6pijNLgGNoH19ZrlVX7l5GcUxho=
X-Google-Smtp-Source: AGHT+IFRPUKj51WecaqI4THLAuvY5XiRmjq7J5vmGoW3BOStZVw2cSXzhLAT58EK9vhe2LUl55MdwfThsnfj
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:690c:368c:b0:5d3:8857:b78e with SMTP
 id fu12-20020a05690c368c00b005d38857b78emr3998773ywb.10.1703613650634; Tue,
 26 Dec 2023 10:00:50 -0800 (PST)
Date: Tue, 26 Dec 2023 18:00:00 +0000
In-Reply-To: <20231226-libstringheader-v6-0-80aa08c7652c@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231226-libstringheader-v6-0-80aa08c7652c@google.com>
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703613647; l=6769;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=hIYeBjXsSax2iHEZlDh3Xt19cOiTxbSkrynkTtDAKho=; b=1b4ZUQXbUSIDZ1hxa5E5zrunUIoOIn1VeJ8hz3PiqfvblTOESIGkFCuK0H3AONFcHdMQUnTM+
 vFtTl8nVvYcAvcAO5K3/jd6Mrp97rLOHO9ZBPfMblEBk+13qCWDnvkP
X-Mailer: b4 0.12.4
Message-ID: <20231226-libstringheader-v6-1-80aa08c7652c@google.com>
Subject: [PATCH v6 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
From: Tanzir Hasan <tanzirh@google.com>
To: Kees Cook <keescook@chromium.org>, Nick Desaulniers <nnn@google.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This patch creates wordpart.h and includes it in asm/word-at-a-time.h
for all architectures. WORD_AT_A_TIME_CONSTANTS depends on kernel.h
because of REPEAT_BYTE. Moving this to another header and including it
where necessary allows us to not include the bloated kernel.h. Making
this implicit dependency on REPEAT_BYTE explicit allows for later
improvements in the lib/string.c inclusion list.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 arch/arm/include/asm/word-at-a-time.h     |  3 ++-
 arch/arm64/include/asm/word-at-a-time.h   |  3 ++-
 arch/powerpc/include/asm/word-at-a-time.h |  4 ++--
 arch/riscv/include/asm/word-at-a-time.h   |  3 ++-
 arch/s390/include/asm/word-at-a-time.h    |  3 ++-
 arch/sh/include/asm/word-at-a-time.h      |  2 ++
 arch/x86/include/asm/word-at-a-time.h     |  3 ++-
 arch/x86/kvm/mmu/mmu.c                    |  1 +
 fs/namei.c                                |  2 +-
 include/asm-generic/word-at-a-time.h      |  3 ++-
 include/linux/kernel.h                    |  7 -------
 include/linux/wordpart.h                  | 14 ++++++++++++++
 12 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index 352ab213520d..f9a3897b06e7 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -8,7 +8,8 @@
  * Little-endian word-at-a-time zero byte handling.
  * Heavily based on the x86 algorithm.
  */
-#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index f3b151ed0d7a..14251abee23c 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -9,7 +9,8 @@
 
 #ifndef __AARCH64EB__
 
-#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 30a12d208687..54653a863414 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -4,8 +4,8 @@
 /*
  * Word-at-a-time interfaces for PowerPC.
  */
-
-#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/wordpart.h>
 #include <asm/asm-compat.h>
 #include <asm/extable.h>
 
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 7c086ac6ecd4..fae33cc04f8d 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -9,7 +9,8 @@
 #define _ASM_RISCV_WORD_AT_A_TIME_H
 
 
-#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index 2579f1694b82..203acd6e431b 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -2,7 +2,8 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
 
-#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/wordpart.h>
 #include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
 
diff --git a/arch/sh/include/asm/word-at-a-time.h b/arch/sh/include/asm/word-at-a-time.h
index 4aa398455b94..95100ce128d6 100644
--- a/arch/sh/include/asm/word-at-a-time.h
+++ b/arch/sh/include/asm/word-at-a-time.h
@@ -5,6 +5,8 @@
 #ifdef CONFIG_CPU_BIG_ENDIAN
 # include <asm-generic/word-at-a-time.h>
 #else
+#include <linux/bitops.h>
+#include <linux/wordpart.h>
 /*
  * Little-endian version cribbed from x86.
  */
diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
index 46b4f1f7f354..e8d7d4941c4c 100644
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -2,7 +2,8 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
 
-#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/wordpart.h>
 
 /*
  * This is largely generic for little-endian machines, but the
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c57e181bba21..75d0f6b11a48 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -47,6 +47,7 @@
 #include <linux/kern_levels.h>
 #include <linux/kstrtox.h>
 #include <linux/kthread.h>
+#include <linux/wordpart.h>
 
 #include <asm/page.h>
 #include <asm/memtype.h>
diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..189ea53ad635 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -17,8 +17,8 @@
 
 #include <linux/init.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/wordpart.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
 #include <linux/namei.h>
diff --git a/include/asm-generic/word-at-a-time.h b/include/asm-generic/word-at-a-time.h
index 95a1d214108a..ef3f841c6625 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -2,7 +2,8 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
 
-#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/wordpart.h>
 #include <asm/byteorder.h>
 
 #ifdef __BIG_ENDIAN
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d9ad21058eed..162660af5b7d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -39,13 +39,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-/**
- * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
- * @x: value to repeat
- *
- * NOTE: @x is not checked for > 0xff; larger values produce odd results.
- */
-#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
 /* generic data direction definitions */
 #define READ			0
diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
new file mode 100644
index 000000000000..43c1a8ae5152
--- /dev/null
+++ b/include/linux/wordpart.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_WORDPART_H
+#define _LINUX_WORDPART_H
+/**
+ * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
+ * @x: value to repeat
+ *
+ * NOTE: @x is not checked for > 0xff; larger values produce odd results.
+ */
+#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
+
+#endif // _LINUX_WORDPART_H
+

-- 
2.43.0.472.g3155946c3a-goog

