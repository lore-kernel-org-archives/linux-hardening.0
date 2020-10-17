Return-Path: <SRS0=Tg6c=DY=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC75C433E7
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 19:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21472207EA
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 19:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rw/pi6RL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439596AbgJQTsm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Oct 2020 15:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439594AbgJQTsm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Oct 2020 15:48:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DCCC061755;
        Sat, 17 Oct 2020 12:48:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a4so6468150lji.12;
        Sat, 17 Oct 2020 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cegU7lWKKHjc/OI81eLoaa0b8R0vGwDdxHJB+PphqZ0=;
        b=rw/pi6RL9GmKAq6Lc7J/Nc8rDzvRABVIcecByO+zNfikHH0pG19RrOFjjX5QlgB1cs
         BGPFn86p7iR/sAOx2wpiUlgCW3UpMd3hrTobbpOdNCjkp3rnIqz/K2pTUOSHkpK8nHwZ
         CU3S/jy3eDMHOg94YTaGVEY/klA587446ndEtXwcT2R+MUVzPSSb8PAllUVjJlTWlyYl
         CXl2PPWge83ozCDfVeKktnQFx4BA/RxRoBCQCJNGA7Z81OKAGAkM6NzVILPY7PtcSmLF
         4AWss/krx4OPs39uZKitgYK9JYQlyfL0I9cUcY4m0q4IY3CisYFkDSx6m2zRiS6QnT7Y
         E4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cegU7lWKKHjc/OI81eLoaa0b8R0vGwDdxHJB+PphqZ0=;
        b=UuKWpwM00w+DBaGUYGsQxLZ8pEdEfWv+SH4pUTaU5AbgT/oQVveqgcK8ADKbIuF70h
         Ia4mwSvDkjEX9MgoyO542tTxS6TQWa9vYpmzIdRBRgNwVcV+MzLXg7alRCOUaDeMWDzR
         20PHn6bQC1cK85O1l0+echrdeJ408Ce57z414A3FDgdreAr0Cx76nV3HJBE92v1Je69p
         amnquPCJWr3HIUavk/fZ2vFdhoPXc/0v8y4nyMTH9bI3nH/8IqQYnHoYmV7BTS/E/XBx
         3pqplYPcwle3OcHlXf6mTsXZ6Q8k6dKd88+L+aM2KqDFiyqsaKTl3Xh3Jj4h4qpyoqly
         Dkhg==
X-Gm-Message-State: AOAM5327jYwX2yM1BE3ROtGHN22kDYu7saIN7l6Hcr6NATj83ugr4W2o
        tCDwQ60p9lwe2Sm/PHwtske2RptJkkM=
X-Google-Smtp-Source: ABdhPJyer14sZVv5JTcqzQnp6grw8SEoLVn6y/eVW9iPZXNs8hfeutHoqWtToJBN0T6W7kG3bRxPTw==
X-Received: by 2002:a2e:9652:: with SMTP id z18mr3705582ljh.410.1602964097509;
        Sat, 17 Oct 2020 12:48:17 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id f25sm2351009ljk.57.2020.10.17.12.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 12:48:16 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v3] mm: Optional full ASLR for mmap() and mremap()
Date:   Sat, 17 Oct 2020 22:47:59 +0300
Message-Id: <20201017194759.59449-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
enables full randomization of memory mappings created with mmap(NULL,
...). With 2, the base of the VMA used for such mappings is random,
but the mappings are created in predictable places within the VMA and
in sequential order. With 3, new VMAs are created to fully randomize
the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
even if not necessary.

The method is to randomize the new address without considering
VMAs. If the address fails checks because of overlap with the stack
area (or in case of mremap(), overlap with the old mapping), the
operation is retried a few times before falling back to old method.

On 32 bit systems this may cause problems due to increased VM
fragmentation if the address space gets crowded.

On all systems, it will reduce performance and increase memory
usage due to less efficient use of page tables and inability to
merge adjacent VMAs with compatible attributes.

In this example, with value of 2, ld.so.cache, libc, an anonymous mmap
and locale-archive are located close to each other:
$ strace /bin/sync
...
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=189096, ...}) = 0
mmap(NULL, 189096, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7d9c1e7f2000
...
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0n\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1839792, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7d9c1e7f0000
mmap(NULL, 1852680, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7d9c1e62b000
...
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=5642592, ...}) = 0
mmap(NULL, 5642592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7d9c1e0c9000

With 3, they are located in unrelated addresses:
$ echo 3 > /proc/sys/kernel/randomize_va_space
$ strace /bin/sync
...
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=189096, ...}) = 0
mmap(NULL, 189096, PROT_READ, MAP_PRIVATE, 3, 0) = 0xeda4fbea000
...
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0n\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1839792, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb8fb9c1d000
mmap(NULL, 1852680, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xaabd8598000
...
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=5642592, ...}) = 0
mmap(NULL, 5642592, PROT_READ, MAP_PRIVATE, 3, 0) = 0xbe351ab8000

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
v2: also randomize mremap(..., MREMAP_MAYMOVE)
v3: avoid stack area and retry in case of bad random address
---
 Documentation/admin-guide/hw-vuln/spectre.rst |  6 ++--
 Documentation/admin-guide/sysctl/kernel.rst   | 15 +++++++++
 init/Kconfig                                  |  2 +-
 mm/internal.h                                 |  8 +++++
 mm/mmap.c                                     | 32 +++++++++++++------
 mm/mremap.c                                   | 26 +++++++++++++++
 6 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index e05e581af5cf..9ea250522077 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -254,7 +254,7 @@ Spectre variant 2
    left by the previous process will also be cleared.
 
    User programs should use address space randomization to make attacks
-   more difficult (Set /proc/sys/kernel/randomize_va_space = 1 or 2).
+   more difficult (Set /proc/sys/kernel/randomize_va_space = 1, 2 or 3).
 
 3. A virtualized guest attacking the host
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -499,8 +499,8 @@ Spectre variant 2
    more overhead and run slower.
 
    User programs should use address space randomization
-   (/proc/sys/kernel/randomize_va_space = 1 or 2) to make attacks more
-   difficult.
+   (/proc/sys/kernel/randomize_va_space = 1, 2 or 3) to make attacks
+   more difficult.
 
 3. VM mitigation
 ^^^^^^^^^^^^^^^^
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d4b32cc32bb7..bc3bb74d544d 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1060,6 +1060,21 @@ that support this feature.
     Systems with ancient and/or broken binaries should be configured
     with ``CONFIG_COMPAT_BRK`` enabled, which excludes the heap from process
     address space randomization.
+
+3   Additionally enable full randomization of memory mappings created
+    with mmap(NULL, ...). With 2, the base of the VMA used for such
+    mappings is random, but the mappings are created in predictable
+    places within the VMA and in sequential order. With 3, new VMAs
+    are created to fully randomize the mappings. Also mremap(...,
+    MREMAP_MAYMOVE) will move the mappings even if not necessary.
+
+    On 32 bit systems this may cause problems due to increased VM
+    fragmentation if the address space gets crowded.
+
+    On all systems, it will reduce performance and increase memory
+    usage due to less efficient use of page tables and inability to
+    merge adjacent VMAs with compatible attributes.
+
 ==  ===========================================================================
 
 
diff --git a/init/Kconfig b/init/Kconfig
index d6a0b31b13dc..c5ea2e694f6a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1859,7 +1859,7 @@ config COMPAT_BRK
 	  also breaks ancient binaries (including anything libc5 based).
 	  This option changes the bootup default to heap randomization
 	  disabled, and can be overridden at runtime by setting
-	  /proc/sys/kernel/randomize_va_space to 2.
+	  /proc/sys/kernel/randomize_va_space to 2 or 3.
 
 	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
 
diff --git a/mm/internal.h b/mm/internal.h
index 10c677655912..382abfcc9ea3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -620,4 +620,12 @@ struct migration_target_control {
 	gfp_t gfp_mask;
 };
 
+#ifndef arch_get_mmap_end
+#define arch_get_mmap_end(addr)	(TASK_SIZE)
+#endif
+
+#ifndef arch_get_mmap_base
+#define arch_get_mmap_base(addr, base) (base)
+#endif
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 40248d84ad5f..2340f8a0978c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/elf-randomize.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -73,6 +74,8 @@ const int mmap_rnd_compat_bits_max = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX;
 int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 #endif
 
+#define MAX_RANDOM_MMAP_RETRIES			5
+
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
@@ -206,7 +209,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 #ifdef CONFIG_COMPAT_BRK
 	/*
 	 * CONFIG_COMPAT_BRK can still be overridden by setting
-	 * randomize_va_space to 2, which will still cause mm->start_brk
+	 * randomize_va_space to >= 2, which will still cause mm->start_brk
 	 * to be arbitrarily shifted
 	 */
 	if (current->brk_randomized)
@@ -1407,6 +1410,25 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
+	/* Pick a random address even outside current VMAs? */
+	if (!addr && randomize_va_space >= 3) {
+		int i = MAX_RANDOM_MMAP_RETRIES;
+		unsigned long max_addr = arch_get_mmap_base(addr, mm->mmap_base);
+
+		do {
+			/* Try a few times to find a free area */
+			addr = arch_mmap_rnd();
+			if (addr >= max_addr)
+				continue;
+			addr = get_unmapped_area(file, addr, len, pgoff, flags);
+			if (!IS_ERR_VALUE(addr))
+				break;
+		} while (--i >= 0);
+
+		if (IS_ERR_VALUE(addr))
+			addr = 0;
+	}
+
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
@@ -2095,14 +2117,6 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 	return addr;
 }
 
-#ifndef arch_get_mmap_end
-#define arch_get_mmap_end(addr)	(TASK_SIZE)
-#endif
-
-#ifndef arch_get_mmap_base
-#define arch_get_mmap_base(addr, base) (base)
-#endif
-
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.
  *
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f75..12f61c4b9d3a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -24,12 +24,15 @@
 #include <linux/uaccess.h>
 #include <linux/mm-arch-hooks.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/elf-randomize.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
 #include "internal.h"
 
+#define MAX_RANDOM_MREMAP_RETRIES		5
+
 static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
@@ -720,6 +723,29 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	if ((flags & MREMAP_MAYMOVE) && randomize_va_space >= 3) {
+		/*
+		 * Caller is happy with a different address, so let's
+		 * move even if not necessary!
+		 */
+		int i = MAX_RANDOM_MREMAP_RETRIES;
+		unsigned long max_addr = arch_get_mmap_base(addr, mm->mmap_base);
+
+		do {
+			/* Try a few times to find a free area */
+			new_addr = arch_mmap_rnd();
+			if (new_addr >= max_addr)
+				continue;
+			ret = mremap_to(addr, old_len, new_addr, new_len,
+					&locked, flags, &uf, &uf_unmap_early,
+					&uf_unmap);
+			if (!IS_ERR_VALUE(ret))
+				goto out;
+		} while (--i >= 0);
+
+		new_addr = addr;
+	}
+
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-- 
2.28.0

