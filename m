Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012B5D49C
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923514; cv=none; b=YrCY/6WYDAkhWYC8ezIQ6QuNpV944yhRn73xYARRIGLltq9T98DXV9NQIO+xNsbLdQyuNKWb5MeLDSvAKt6CyJUU6P2gue6S4lwTK70tN0vAWBZEJQAKym28VN3HxxIJeeJYqNUg37VtfB3uAUKZIomWTn0/d+nOlhFtrVfGtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923514; c=relaxed/simple;
	bh=VWiq2FOmAhYjvTFVuJsVVTmsLD+Tnb2HxXwGKlfTSIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGkLqxYS4pw2M5PiztmoLGTRq2L1B7lZuY+0d2G0u0+RMwiV1LP6gi2nK1BKAPmG+9UVfzKwwBGmDhgecd+23V4YobsLZRuuWsHpP6R/rEt4sUkVuEAaSWgwwiPjn4Z2Zny8xlct5tcSmWzN1zXtVE3FZMGOTsSZSklR3n2eJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GSJ759Xu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GSJ759Xu"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1580212a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 07:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707923512; x=1708528312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5sNZFr8z9VEp4WVx32gOwAtbq3+vupIHe5X9JYQqqc=;
        b=GSJ759Xuuu6QZ4HdikGvNl4BJtJs5PESdAGsug6L2D8gL75tuqxThERuVlw3jv4S6V
         hSAAv1UoCZzfC5NXqhgQtpbjHUqfv8MkYtfB4n3mSHjU+LmC8bEZipnKcSpjslsnsEQ8
         e9vnOEitzZ1awpFWq4Ib4MMTDSsbJUo6tPLAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923512; x=1708528312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5sNZFr8z9VEp4WVx32gOwAtbq3+vupIHe5X9JYQqqc=;
        b=O3jF2UQZAV/vAV91uWpI34GTie3JE1My7YTUtUXzv1Ffm5Bhb1Qe/b7blbZMqkQ1uQ
         WldSOF3fXdZozeWzb3371vO1AWRlPa7zt8Y4f3PEglG6cVmo7nRL9pHbfdRupILAk6ds
         gHWKOvYDdOR4zB1uWhL+6tB21hdVIBXy9vjP//M5g20qHKNh+oZv7EtFSmPV5Zu/x5zw
         AUPrTitXI1IQcvz/zTUvuvrqsNyU2+RDexwO/8wwNQ0+Hg7YoBVfu+eqAg7G0mai+38o
         XqVc9TR+jyW4wVA7LospMh0FmR5h19rsjamgUnkmwRE83cA6gG0c3/dTcICUAVSaKNVS
         2XKA==
X-Forwarded-Encrypted: i=1; AJvYcCXmWIFNWYIbxCUJm6PBTc0qJmOlIVVCdjwfbCj37cnCjsPdO3wmfyTYBs/ZZcb1CMeRjxm7YH6wcuBf1wqveT+i/xbh2Rk+IbKO+QeWo8Y8
X-Gm-Message-State: AOJu0YxKof78gE7VaXFYAxPg2BGntQxLjVr5LOxE9SojWkx6G/Wjucd9
	krTIw1phbw1KaRgHDhmOxczioEWZk6x2iqBEt90FexPe+vMlatHG9/Dm+xkTrw==
X-Google-Smtp-Source: AGHT+IGw/2iJFSNB+XBsDL0tTAZQGHLwT4xBO7JRp6ZPaklZpgbNnJvX1X54WiydiYxAB7rEkh2t9w==
X-Received: by 2002:a17:90b:4b8e:b0:298:bc6a:784f with SMTP id lr14-20020a17090b4b8e00b00298bc6a784fmr2863835pjb.20.1707923511687;
        Wed, 14 Feb 2024 07:11:51 -0800 (PST)
Received: from localhost (56.72.82.34.bc.googleusercontent.com. [34.82.72.56])
        by smtp.gmail.com with UTF8SMTPSA id sc7-20020a17090b510700b00296fcb4e668sm1524496pjb.25.2024.02.14.07.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:11:51 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	=David.Laight@aculab.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v9 5/5] selftest mm/mseal read-only elf memory segment
Date: Wed, 14 Feb 2024 15:11:29 +0000
Message-ID: <20240214151130.616240-6-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240214151130.616240-1-jeffxu@chromium.org>
References: <20240214151130.616240-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Sealing read-only of elf mapping so it can't be changed by mprotect.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/.gitignore |   1 +
 tools/testing/selftests/mm/Makefile   |   1 +
 tools/testing/selftests/mm/seal_elf.c | 183 ++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/mm/seal_elf.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 76474c51c786..eff280b17a6e 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -47,3 +47,4 @@ mkdirty
 va_high_addr_switch
 hugetlb_fault_after_madv
 mseal_test
+seal_elf
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index ba36a5c2b1fc..a0a12626cd19 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -60,6 +60,7 @@ TEST_GEN_FILES += mrelease_test
 TEST_GEN_FILES += mremap_dontunmap
 TEST_GEN_FILES += mremap_test
 TEST_GEN_FILES += mseal_test
+TEST_GEN_FILES += seal_elf
 TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += pagemap_ioctl
 TEST_GEN_FILES += thuge-gen
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
new file mode 100644
index 000000000000..61a2f1c94e02
--- /dev/null
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/mman.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <stdbool.h>
+#include "../kselftest.h"
+#include <syscall.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <fcntl.h>
+#include <assert.h>
+#include <sys/ioctl.h>
+#include <sys/vfs.h>
+#include <sys/stat.h>
+
+/*
+ * need those definition for manually build using gcc.
+ * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 seal_elf.c -o seal_elf
+ */
+#define FAIL_TEST_IF_FALSE(c) do {\
+		if (!(c)) {\
+			ksft_test_result_fail("%s, line:%d\n", __func__, __LINE__);\
+			goto test_end;\
+		} \
+	} \
+	while (0)
+
+#define SKIP_TEST_IF_FALSE(c) do {\
+		if (!(c)) {\
+			ksft_test_result_skip("%s, line:%d\n", __func__, __LINE__);\
+			goto test_end;\
+		} \
+	} \
+	while (0)
+
+
+#define TEST_END_CHECK() {\
+		ksft_test_result_pass("%s\n", __func__);\
+		return;\
+test_end:\
+		return;\
+}
+
+#ifndef u64
+#define u64 unsigned long long
+#endif
+
+/*
+ * define sys_xyx to call syscall directly.
+ */
+static int sys_mseal(void *start, size_t len)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_mseal, start, len, 0);
+	return sret;
+}
+
+static void *sys_mmap(void *addr, unsigned long len, unsigned long prot,
+	unsigned long flags, unsigned long fd, unsigned long offset)
+{
+	void *sret;
+
+	errno = 0;
+	sret = (void *) syscall(__NR_mmap, addr, len, prot,
+		flags, fd, offset);
+	return sret;
+}
+
+inline int sys_mprotect(void *ptr, size_t size, unsigned long prot)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_mprotect, ptr, size, prot);
+	return sret;
+}
+
+static bool seal_support(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+
+	ptr = sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (ptr == (void *) -1)
+		return false;
+
+	ret = sys_mseal(ptr, page_size);
+	if (ret < 0)
+		return false;
+
+	return true;
+}
+
+const char somestr[4096] = {"READONLY"};
+
+static void test_seal_elf(void)
+{
+	int ret;
+	FILE *maps;
+	char line[512];
+	int size = 0;
+	uintptr_t  addr_start, addr_end;
+	char prot[5];
+	char filename[256];
+	unsigned long page_size = getpagesize();
+	unsigned long long ptr = (unsigned long long) somestr;
+	char *somestr2 = (char *)somestr;
+
+	/*
+	 * Modify the protection of readonly somestr
+	 */
+	if (((unsigned long long)ptr % page_size) != 0)
+		ptr = (unsigned long long)ptr & ~(page_size - 1);
+
+	ksft_print_msg("somestr = %s\n", somestr);
+	ksft_print_msg("change protection to rw\n");
+	ret = sys_mprotect((void *)ptr, page_size, PROT_READ|PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+	*somestr2 = 'A';
+	ksft_print_msg("somestr is modified to: %s\n", somestr);
+	ret = sys_mprotect((void *)ptr, page_size, PROT_READ);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	maps = fopen("/proc/self/maps", "r");
+	FAIL_TEST_IF_FALSE(maps);
+
+	/*
+	 * apply sealing to elf binary
+	 */
+	while (fgets(line, sizeof(line), maps)) {
+		if (sscanf(line, "%lx-%lx %4s %*x %*x:%*x %*u %255[^\n]",
+			&addr_start, &addr_end, &prot, &filename) == 4) {
+			if (strlen(filename)) {
+				/*
+				 * seal the mapping if read only.
+				 */
+				if (strstr(prot, "r-")) {
+					ret = sys_mseal((void *)addr_start, addr_end - addr_start);
+					FAIL_TEST_IF_FALSE(!ret);
+					ksft_print_msg("sealed: %lx-%lx %s %s\n",
+						addr_start, addr_end, prot, filename);
+					if ((uintptr_t) somestr >= addr_start &&
+						(uintptr_t) somestr <= addr_end)
+						ksft_print_msg("mapping for somestr found\n");
+				}
+			}
+		}
+	}
+	fclose(maps);
+
+	ret = sys_mprotect((void *)ptr, page_size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(ret < 0);
+	ksft_print_msg("somestr is sealed, mprotect is rejected\n");
+
+	TEST_END_CHECK();
+}
+
+int main(int argc, char **argv)
+{
+	bool test_seal = seal_support();
+
+	ksft_print_header();
+	ksft_print_msg("pid=%d\n", getpid());
+
+	if (!test_seal)
+		ksft_exit_skip("sealing not supported, check CONFIG_64BIT\n");
+
+	ksft_set_plan(1);
+
+	test_seal_elf();
+
+	ksft_finished();
+	return 0;
+}
-- 
2.43.0.687.g38aa6559b0-goog

