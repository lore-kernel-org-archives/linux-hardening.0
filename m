Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6654B15C
	for <linux-hardening@vger.kernel.org>; Tue, 19 Dec 2023 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cndmlsTY"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5d0c4ba7081so53583227b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 Dec 2023 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703009410; x=1703614210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5q99le1AaGsVZEd/+OCGExk8m8NTWTf8iBQd3NIkOvU=;
        b=cndmlsTYWlurGLEF6mXhOSharZ9c1Hzl/JqyM8uTL4Bu6EOs39c7/PVHuNj5Ah+XxG
         MN2DC0ixVfDOEWdYpAG4swXUU7SW46hPzWMyUmnndh0ionssW8BsvsQ+ZTd+D5RdDFQA
         rrfowW3sGV088gjUZpi+QURqX65icBzkI76wUl+DnQ81/RSYP9/BiRu5EDFMLkcZYoQ8
         l/R6/JUwjiqnb5qGM9rG8mXR167qj6ajdQ39AErxvZY1oQ7vrQwLYX8Xyxip3QW10NW4
         RT/NAJ7i672gMzH6Q5jYBlVN2ksc7CaS79wR4MYdb/kyD7kQdoGQI7zyA9AdNZ9mhMp8
         iaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009410; x=1703614210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5q99le1AaGsVZEd/+OCGExk8m8NTWTf8iBQd3NIkOvU=;
        b=wjQK2NhxfgEFWVvC2l0XmbNVOVghFZMbkzHSot1zcaprO2ZzCopge01/VdH/xCVYHO
         xlyDEK+pmH/c256lkkNOU+cgUP4OYd/hf7lCVnYLasGNuPVwKPn8fyS4tPxvnqYoExR3
         FHYQsMEfZnoOA4AiXlFAyIvVKQP3tsGUdiBQjufaU+eSA8FMupKsTSUZxSRoxwBgt2o9
         s2DGadjfP+NcjKBeJ1eZkT6CDjz9Hhs0gRa98ENiJVXG0FPMOsVxzSmTSyWTrRKz9sAg
         Hnbn5l0oS4+Jlwxzm3MT/ER8D5dd6CQzB1Fz+dFsEIXgu+G/KTav+nNG0ghqgRF52JOY
         wh0g==
X-Gm-Message-State: AOJu0Yw8cEDeO/vppsT2xlQgZDSHUT+t4T/+YmjUmc4uAcWgV/ae+2h9
	rMzITln+XRhRPyMPAaxM6PGbBUm23AUJ
X-Google-Smtp-Source: AGHT+IEhjyEKPX1b8J6ILSwg1/IAmDPf/6+2bbll0QtMpDR7Zwz7TdruPWzCpa7ZTRleAW91TEBQ5uofRVzE
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:690c:101:b0:5e7:62e:75db with SMTP id
 bd1-20020a05690c010100b005e7062e75dbmr1130156ywb.1.1703009410264; Tue, 19 Dec
 2023 10:10:10 -0800 (PST)
Date: Tue, 19 Dec 2023 18:09:51 +0000
In-Reply-To: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com>
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703009406; l=6137;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=ojERQMahrvSc9Fi/LrhnUSIbNNxrxWKsIbZJzzfv7FA=; b=GmFPmuyyCmcfb3blcy1nA3M57IJ9vlYOb9VLkVBhHV4576pMmWy7NJPZkXcXSitvgrPeEpvFk
 HB/+xee/CDWB4Mi2itdsRMSIAlUPz53cQDNoNmQL822BGx0S7yJFY4w
X-Mailer: b4 0.12.4
Message-ID: <20231219-libstringheader-v4-1-aaeb26495d2f@google.com>
Subject: [PATCH v4 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
From: Tanzir Hasan <tanzirh@google.com>
To: Kees Cook <keescook@chromium.org>, Nick DeSaulniers <nnn@google.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	llvm@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This patch creates wordpart.h and includes it in asm/word-at-a-time.h
for the all architectures. WORD_AT_A_TIME_CONSTANTS depends on kernel.h
because of REPEAT_BYTE. Moving this to another header and including it
where necessary allows us to not include the bloated kernel.h. Making
this implicit dependency on REPEAT_BYTE explicit allows for later
improvements in the lib/string.c inclusion list.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 arch/arm/include/asm/word-at-a-time.h     |  2 +-
 arch/arm64/include/asm/word-at-a-time.h   |  2 +-
 arch/powerpc/include/asm/word-at-a-time.h |  2 +-
 arch/riscv/include/asm/word-at-a-time.h   |  2 +-
 arch/s390/include/asm/word-at-a-time.h    |  2 +-
 arch/sh/include/asm/word-at-a-time.h      |  1 +
 arch/x86/include/asm/word-at-a-time.h     |  1 +
 fs/namei.c                                |  2 +-
 include/asm-generic/word-at-a-time.h      |  2 +-
 include/linux/kernel.h                    |  7 -------
 include/linux/wordpart.h                  | 17 +++++++++++++++++
 11 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index 352ab213520d..e08304996121 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -8,7 +8,7 @@
  * Little-endian word-at-a-time zero byte handling.
  * Heavily based on the x86 algorithm.
  */
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index f3b151ed0d7a..bd8cfbc2b9c3 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -9,7 +9,7 @@
 
 #ifndef __AARCH64EB__
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 30a12d208687..26e4f718a674 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -5,7 +5,7 @@
  * Word-at-a-time interfaces for PowerPC.
  */
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 #include <asm/asm-compat.h>
 #include <asm/extable.h>
 
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 7c086ac6ecd4..94bec2f7ba53 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -9,7 +9,7 @@
 #define _ASM_RISCV_WORD_AT_A_TIME_H
 
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index 2579f1694b82..55e66d9371d6 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 #include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
 
diff --git a/arch/sh/include/asm/word-at-a-time.h b/arch/sh/include/asm/word-at-a-time.h
index 4aa398455b94..663658cea69a 100644
--- a/arch/sh/include/asm/word-at-a-time.h
+++ b/arch/sh/include/asm/word-at-a-time.h
@@ -5,6 +5,7 @@
 #ifdef CONFIG_CPU_BIG_ENDIAN
 # include <asm-generic/word-at-a-time.h>
 #else
+#include <linux/wordpart.h>
 /*
  * Little-endian version cribbed from x86.
  */
diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
index 46b4f1f7f354..c002c864a63e 100644
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -3,6 +3,7 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 /*
  * This is largely generic for little-endian machines, but the
diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..03db8ca3f394 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -17,7 +17,7 @@
 
 #include <linux/init.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
diff --git a/include/asm-generic/word-at-a-time.h b/include/asm-generic/word-at-a-time.h
index 95a1d214108a..6f088b2b0b03 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
 
-#include <linux/kernel.h>
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
index 000000000000..6a5ed5d54ba2
--- /dev/null
+++ b/include/linux/wordpart.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Google LLC <tanzirh@google.com>
+ */
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

