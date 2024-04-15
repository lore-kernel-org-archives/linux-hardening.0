Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B182890
	for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198943; cv=none; b=SjlwUrII1nRkaAIznY1QqvH0HNFRYD3/Z2Lx+WHzi9oX7W7tqJZmzuLG3HjwTNiThk5xUL20ZiYYqlVkCYOkiFY6k105WIYZLzr1pw80bvU9UmJijK0TGGXtJ3Bftc8c5UeV5kSeyuXy4Go01uwIQLMbhyscn5dcMdOQTuWwjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198943; c=relaxed/simple;
	bh=tEqZvV3FTwNDGdXGDfu5US6D8OLXShAXUJ74HD0l3yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBqDDhmeliGYDzb1TGGcV2rt+ZWx9CWvhe9xF/UEZtMbGwGDqb6sqh1Tzp4f/DxafY/355ok3ICRiQCoeMB0O48juOMhyHvoRjDUQc3YGk6tfiSv6b2m9IEU8KQET72tVfIrKdO4nFyXJOlqFWhsyw4sy9ZOQhTK9Bjy7eCkrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KWWw0XX+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KWWw0XX+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed11782727so2900601b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713198941; x=1713803741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJHOXE7W4iXMxi8stv8aQLFD0obJISw2P5aysbaDa0s=;
        b=KWWw0XX+uRhxngnEB1gxEnR00m+vN8V9cxoyzeZ0ePPrVk+Yh9u3YLJrlE+Y+jPisW
         uDJ1fvHE9KwRd9r1qgESRWqbyIBgfzfUoPeYN0xhDV5NMuYxHjFiN94VfVbQIRoduUN2
         vseEgNBAC9pRk0e4510/tOMcTcPpmCGAcOjsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198941; x=1713803741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJHOXE7W4iXMxi8stv8aQLFD0obJISw2P5aysbaDa0s=;
        b=tCTRGYfWSK9Q4FAS4X4V28OwpWnDt+6WVbip/A0gJMZRg0T2yihbB2oOMm9DqrVG2/
         oYyPG8C1q2Fvm++shgSgmATeS4u7JcLTPcD2jxlbeOjnWnUgJTI97SLLU5B8PzuYyrAo
         fiB5KgcymvnJGpoxy+mT3gYIVAAinc9QlkzzXoqYNjtvbYpZoZSzR3WjtDhRIr/d4c40
         TyKBFDIRf18fdLaZ+618kVri+niNmjOZi8HidQH2KMo8LeJ+TYKtK4GOS+xXvdqxhDqv
         5RQbKEG9FhAj9BYmCFjxvkYNclKrEQ1xS4wGff75pwNNXJafvKY1Un/ttACLq+hJeTKH
         JlhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi7FJIg7EFODC/dheoFGOW5tGdifC0nVZWrkwdP5F36P6pMwlLmffnf1IStOFgCjC8n7dpemWwfNYQm4kDcnyQgBwdzc7I9oVWAQ8Q+wDd
X-Gm-Message-State: AOJu0YxignHK8G8y36YjnbGWhDDyGQ4U5YMDsLvplKPsht2WidY/syF2
	xCH7XUhpDYF4TGN+51DGynJ0fZkUYg9/vvLZVNgc39zgz0XpTrNyjXUI/cX85Q==
X-Google-Smtp-Source: AGHT+IGpxBiXitUV65X12uO9kCt9yTS7pqi2G5lLyGKRXo70DVpYj0l9hUD2hNlk3bYPsgQK0YTsXQ==
X-Received: by 2002:a05:6a21:151a:b0:1a9:b3e9:a62c with SMTP id nq26-20020a056a21151a00b001a9b3e9a62cmr8978922pzb.48.1713198941478;
        Mon, 15 Apr 2024 09:35:41 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id b13-20020a630c0d000000b005dc4da2121fsm7213902pgl.6.2024.04.15.09.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 09:35:40 -0700 (PDT)
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
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v10 5/5] selftest mm/mseal read-only elf memory segment
Date: Mon, 15 Apr 2024 16:35:24 +0000
Message-ID: <20240415163527.626541-6-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240415163527.626541-1-jeffxu@chromium.org>
References: <20240415163527.626541-1-jeffxu@chromium.org>
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
index 98eaa4590f11..0b9ab987601c 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -48,3 +48,4 @@ va_high_addr_switch
 hugetlb_fault_after_madv
 hugetlb_madv_vs_map
 mseal_test
+seal_elf
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 95d10fe1b3c1..02392c426759 100644
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
2.44.0.683.g7961c838ac-goog

