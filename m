Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A40C7EE22
	for <linux-hardening@archiver.kernel.org>; Mon, 15 May 2023 13:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbjEONG5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 May 2023 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242117AbjEONGl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 May 2023 09:06:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189301FCD
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 06:06:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643557840e4so13788735b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684155964; x=1686747964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzO3EawE44DmDL2RDFGxHbI+J47AsuGzE5x/fc5YRSs=;
        b=aGoNmDGsHMZQ2NOQ2cue8xdiDDbXfg574ntCOr0fKPPQnkqDRL5arkUu7ldufymOVe
         Kl+GAd6kpscPyyPa/VvDhi1rUnMulpN6nJ9nZiuxlqk2PqDpSvyS5zAzBXhi3NPW7QWr
         NxYWJh5ESLSGl12CHkobqGMOZZiaCmA0HqP1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155964; x=1686747964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzO3EawE44DmDL2RDFGxHbI+J47AsuGzE5x/fc5YRSs=;
        b=gpKi+8PdRwW8DJnOBIybup8mL4WSjNpqOj+y/oNkZmeEE0rf7oNDoTDmFPuzBki1M9
         8uj2p2A3DgL960y50BOSnwLib5UWRxJiGJnaW2du3FknATVeBQBwivdYF8Pe6WNOC2Ci
         z+xAE8kDlFx7r1VdoLWSlQA8tV/4pVmea6Ge9gPOZs0o1X6sj80kS7plc4IWCHsx1fmM
         qkh0MIujSNRnuW75oddCC0/sIDMt/V/yugraCvLJi6+pconsVjqurFyXgEUgyL/iwLcj
         BUh1b0+hNJE8VH2ftv9U75sW34aqNZeUutlo+JgK5f0CytjY4m7zGRbN0+SM5qa01083
         tnmQ==
X-Gm-Message-State: AC+VfDxY+Wrm6fbNpFeHGgDeylOkrAmiA38Dp54Hcz0Tou5UbzgAQU6d
        AXe4i+Ct2QBwwKcwctB3wDIRIw==
X-Google-Smtp-Source: ACHHUZ5oeSI5OJJe1UmE9B9/a6W7y2Q2NX78qVUBaVchfp8CJy5bY/W6p0kp8AW04oe76HXZRK41AQ==
X-Received: by 2002:a05:6a00:1a8e:b0:64a:9090:5147 with SMTP id e14-20020a056a001a8e00b0064a90905147mr16698628pfv.10.1684155964232;
        Mon, 15 May 2023 06:06:04 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id e4-20020aa78244000000b0064928cb5f03sm2475090pfn.69.2023.05.15.06.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 06:06:03 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 4/6] PKEY:selftest pkey_enforce_api for mprotect
Date:   Mon, 15 May 2023 13:05:50 +0000
Message-ID: <20230515130553.2311248-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230515130553.2311248-1-jeffxu@chromium.org>
References: <20230515130553.2311248-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add selftest for pkey_enforce_api for mprotect.

Signed-off-by: Jeff Xu<jeffxu@google.com>
---
 tools/testing/selftests/mm/Makefile           |   1 +
 tools/testing/selftests/mm/pkey_enforce_api.c | 875 ++++++++++++++++++
 2 files changed, 876 insertions(+)
 create mode 100644 tools/testing/selftests/mm/pkey_enforce_api.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 23af4633f0f4..93437a394128 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -71,6 +71,7 @@ CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_pr
 CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
 
 VMTARGETS := protection_keys
+VMTARGETS += pkey_enforce_api
 BINARIES_32 := $(VMTARGETS:%=%_32)
 BINARIES_64 := $(VMTARGETS:%=%_64)
 
diff --git a/tools/testing/selftests/mm/pkey_enforce_api.c b/tools/testing/selftests/mm/pkey_enforce_api.c
new file mode 100644
index 000000000000..23663c89bc9c
--- /dev/null
+++ b/tools/testing/selftests/mm/pkey_enforce_api.c
@@ -0,0 +1,875 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests pkey_enforce_api
+ *
+ * Compile like this:
+ * gcc -mxsave      -o pkey_enforce_api    -O2 -g -std=gnu99 -pthread -Wall pkey_enforce_api.c \
+ * -lrt -ldl -lm
+ * gcc -mxsave -m32 -o pkey_enforce_api_32 -O2 -g -std=gnu99 -pthread -Wall pkey_enforce_api.c \
+ * -lrt -ldl -lm
+ */
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+#include <errno.h>
+#include <linux/elf.h>
+#include <linux/futex.h>
+#include <pthread.h>
+#include <time.h>
+#include <sys/time.h>
+#include <sys/syscall.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <ucontext.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/ptrace.h>
+#include <setjmp.h>
+#include "../kselftest.h"
+#include <sys/prctl.h>
+
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+
+#define dprintf0(args...)
+#define dprintf1(args...)
+#define dprintf2(args...)
+#define dprintf3(args...)
+#define dprintf4(args...)
+
+#ifndef u16
+#define u16 __u16
+#endif
+
+#ifndef u32
+#define u32 __u32
+#endif
+
+#ifndef u64
+#define u64 __u64
+#endif
+
+#ifndef PTR_ERR_ENOTSUP
+#define PTR_ERR_ENOTSUP ((void *)-ENOTSUP)
+#endif
+
+int read_ptr(int *ptr)
+{
+	return *ptr;
+}
+
+void expected_pkey_fault(int pkey)
+{
+}
+
+#include "pkey-x86.h"
+
+#ifndef PKEY_ENFORCE_API
+#define PKEY_ENFORCE_API 1
+#endif
+
+#define PKEY_MASK (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
+
+#define LOG_TEST_ENTER(x)                                                      \
+	{                                                                      \
+		printf("%s, enforce=%d\n", __func__, x);                       \
+	}
+static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
+{
+	u32 shift = pkey_bit_position(pkey);
+	/* mask out bits from pkey in old value */
+	reg &= ~((u64)PKEY_MASK << shift);
+	/* OR in new bits for pkey */
+	reg |= (flags & PKEY_MASK) << shift;
+	return reg;
+}
+
+static inline u64 get_pkey_bits(u64 reg, int pkey)
+{
+	u32 shift = pkey_bit_position(pkey);
+	/*
+	 * shift down the relevant bits to the lowest two, then
+	 * mask off all the other higher bits
+	 */
+	return ((reg >> shift) & PKEY_MASK);
+}
+
+static u32 get_pkey(int pkey)
+{
+	return (u32)get_pkey_bits(__read_pkey_reg(), pkey);
+}
+
+static void set_pkey(int pkey, unsigned long pkey_value)
+{
+	u32 mask = (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
+	u64 new_pkey_reg;
+
+	assert(!(pkey_value & ~mask));
+	new_pkey_reg = set_pkey_bits(__read_pkey_reg(), pkey, pkey_value);
+	__write_pkey_reg(new_pkey_reg);
+}
+
+void pkey_disable_set(int pkey, int value)
+{
+	int pkey_new;
+
+	assert(value & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+
+	pkey_new = get_pkey(pkey);
+	pkey_new |= value;
+	set_pkey(pkey, pkey_new);
+}
+
+void pkey_disable_clear(int pkey, int value)
+{
+	int pkey_new;
+
+	assert(value & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+
+	pkey_new = get_pkey(pkey);
+	pkey_new &= ~value;
+
+	set_pkey(pkey, pkey_new);
+}
+
+void pkey_write_allow(int pkey)
+{
+	pkey_disable_clear(pkey, PKEY_DISABLE_WRITE);
+}
+void pkey_write_deny(int pkey)
+{
+	pkey_disable_set(pkey, PKEY_DISABLE_WRITE);
+}
+void pkey_access_allow(int pkey)
+{
+	pkey_disable_clear(pkey, PKEY_DISABLE_ACCESS);
+}
+void pkey_access_deny(int pkey)
+{
+	pkey_disable_set(pkey, PKEY_DISABLE_ACCESS);
+}
+
+int sys_mprotect(void *ptr, size_t size, unsigned long prot)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(SYS_mprotect, ptr, size, prot);
+	return sret;
+}
+
+int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
+		      unsigned long pkey)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(SYS_mprotect_key, ptr, size, orig_prot, pkey);
+	return sret;
+}
+
+int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
+{
+	int ret = syscall(SYS_pkey_alloc, flags, init_val);
+	return ret;
+}
+
+int sys_pkey_free(unsigned long pkey)
+{
+	int ret = syscall(SYS_pkey_free, pkey);
+	return ret;
+}
+
+bool can_create_pkey(void)
+{
+	int pkey;
+
+	pkey = sys_pkey_alloc(0, 0);
+	if (pkey <= 0)
+		return false;
+
+	sys_pkey_free(pkey);
+	return true;
+}
+
+static inline int is_pkeys_supported(void)
+{
+	/* check if the cpu supports pkeys */
+	if (!cpu_has_pkeys() || !can_create_pkey())
+		return 0;
+	return 1;
+}
+
+int pkey_alloc_with_check(bool enforce)
+{
+	int pkey;
+
+	if (enforce)
+		pkey = sys_pkey_alloc(PKEY_ENFORCE_API, 0);
+	else
+		pkey = sys_pkey_alloc(0, 0);
+
+	assert(pkey > 0);
+	return pkey;
+}
+
+void *addr1 = (void *)0x5000000;
+void *addr2 = (void *)0x5001000;
+void *addr3 = (void *)0x5002000;
+void *addr4 = (void *)0x5003000;
+
+void setup_single_address_with_pkey(bool enforce, int size, int *pkeyOut,
+				    void **ptrOut)
+{
+	int pkey;
+	void *ptr;
+	int ret;
+
+	pkey = pkey_alloc_with_check(enforce);
+
+	ptr = mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr != (void *)-1);
+
+	// assign pkey to the memory.
+	ret = sys_mprotect_pkey((void *)ptr, size, PROT_READ, pkey);
+	assert(!ret);
+
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+}
+
+void setup_single_fixed_address_with_pkey(bool enforce, int size, int *pkeyOut,
+					  void **ptrOut)
+{
+	int pkey;
+	void *ptr;
+	int ret;
+
+	pkey = pkey_alloc_with_check(enforce);
+
+	ptr = mmap(addr1, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr == (void *)addr1);
+
+	// assign pkey to the memory.
+	ret = sys_mprotect_pkey((void *)ptr, size, PROT_READ, pkey);
+	assert(!ret);
+
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+}
+
+void clean_single_address_with_pkey(int pkey, void *ptr, int size)
+{
+	int ret;
+
+	ret = munmap(ptr, size);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+void setup_two_continues_fixed_address_with_pkey(bool enforce, int size,
+						 int *pkeyOut, void **ptrOut,
+						 void **ptr2Out)
+{
+	void *ptr;
+	void *ptr2;
+	int pkey;
+	int ret;
+
+	pkey = pkey_alloc_with_check(enforce);
+
+	ptr = mmap(addr1, size, PROT_READ,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr == addr1);
+
+	ptr2 = mmap(addr2, size, PROT_READ,
+		    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr2 == addr2);
+
+	// assign pkey to both addresses in the same call (merged)
+	ret = sys_mprotect_pkey(ptr, size * 2,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	assert(!ret);
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+	*ptr2Out = ptr2;
+}
+
+void clean_two_address_with_pkey(int size, int pkey, void *ptr, void *ptr2)
+{
+	int ret;
+
+	ret = munmap(ptr, size);
+	assert(!ret);
+
+	ret = munmap(ptr2, size);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+// pkey_alloc with flags.
+void test_pkey_alloc(bool enforce)
+{
+	int ret;
+
+	LOG_TEST_ENTER(enforce);
+
+	ret = sys_pkey_alloc(0, 0);
+	assert(ret > 0);
+	ret = sys_pkey_free(ret);
+	assert(ret == 0);
+
+	if (enforce) {
+		ret = sys_pkey_alloc(PKEY_ENFORCE_API, 0);
+		assert(ret > 0);
+		ret = sys_pkey_free(ret);
+		assert(ret == 0);
+
+		// invalid flag.
+		ret = sys_pkey_alloc(0x4, 0);
+		assert(ret != 0);
+	}
+}
+
+// mmap one address.
+// assign pkey on the address.
+// mprotect is denied when no-writeable PKRU in enforce mode.
+void test_mprotect_single_address(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_single_fixed_address_with_pkey(enforce, size, &pkey, &ptr);
+
+	// disable write access.
+	pkey_write_deny(pkey);
+
+	ret = sys_mprotect_pkey(ptr, size, PROT_READ | PROT_WRITE, pkey);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(ret == 0);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect_pkey(ptr, size, PROT_READ, pkey);
+	assert(!ret);
+
+	ret = sys_mprotect(ptr, size, PROT_READ);
+	assert(ret == 0);
+
+	clean_single_address_with_pkey(pkey, ptr, size);
+}
+
+// mmap two address (continuous two pages).
+// assign PKEY to them with one mprotect_pkey call (merged address).
+// mprotect is denied when non-writeable PKRU in enforce mode.
+void test_mprotect_two_address_merge(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	void *ptr2;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_two_continues_fixed_address_with_pkey(enforce, size, &pkey, &ptr,
+						    &ptr2);
+
+	// disable write.
+	pkey_write_deny(pkey);
+
+	// modify the protection on both addresses (merged).
+	ret = sys_mprotect(ptr, size * 2, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect_pkey(ptr, size * 2,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	// modify the protection on both addresses (merged).
+	ret = sys_mprotect(ptr, size * 2, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	ret = sys_mprotect_pkey(ptr, size * 2,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	assert(!ret);
+
+	clean_two_address_with_pkey(size, pkey, ptr, ptr2);
+}
+
+void setup_two_continues_fixed_address_protect_second_with_pkey(
+	bool enforce, int size, int *pkeyOut, void **ptrOut, void **ptr2Out)
+{
+	void *ptr;
+	void *ptr2;
+	int pkey;
+	int ret;
+
+	LOG_TEST_ENTER(enforce);
+
+	pkey = pkey_alloc_with_check(enforce);
+
+	// mmap two addresses (continuous two pages).
+	ptr = mmap(addr1, size, PROT_READ,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr == addr1);
+
+	ptr2 = mmap(addr2, size, PROT_READ,
+		    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr2 == addr2);
+
+	// assign pkey to the second page.
+	ret = sys_mprotect_pkey(addr2, size, PROT_READ | PROT_WRITE | PROT_EXEC,
+				pkey);
+	assert(!ret);
+
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+	*ptr2Out = ptr2;
+}
+
+// mmap two address (continuous two pages).
+// assign PKEY to the second address.
+// mprotect on the second address is denied properly.
+// mprotect on both addresses (merged) is denied properly.
+void test_mprotect_two_address_deny_second(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	void *ptr2;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_two_continues_fixed_address_protect_second_with_pkey(
+		enforce, size, &pkey, &ptr, &ptr2);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// modify the first addr is allowed.
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	// modify the second mmap is protected by pkey.
+	ret = sys_mprotect(ptr2, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	// mprotect both addresses (merged).
+	ret = sys_mprotect_pkey(ptr, size * 2,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr, size * 2, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect_pkey(ptr, size * 2, PROT_READ, pkey);
+	assert(!ret);
+
+	ret = sys_mprotect(ptr, size * 2, PROT_READ);
+	assert(!ret);
+
+	clean_two_address_with_pkey(size, pkey, ptr, ptr2);
+}
+
+void setup_4pages_fixed_protect_second_page(bool enforce, int size,
+					    int *pkeyOut, void **ptrOut,
+					    void **ptr2Out, void **ptr3Out)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+
+	pkey = pkey_alloc_with_check(enforce);
+
+	// allocate 4 pages.
+	ptr = mmap(addr1, size * 4, PROT_READ,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr == addr1);
+
+	// assign pkey to the second address.
+	ret = sys_mprotect_pkey(addr2, size, PROT_READ | PROT_WRITE | PROT_EXEC,
+				pkey);
+	assert(!ret);
+
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+	*ptr2Out = addr2;
+	*ptr3Out = addr3;
+}
+
+// mmap one address with 4 pages.
+// assign PKEY to the second page only.
+// mprotect on the first page is allowed.
+// mprotect on the second page is protected in enforce mode.
+// mprotect on memory range that includes the second pages is protected.
+void test_mprotect_vma_middle_addr(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr, *ptr2, *ptr3;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_4pages_fixed_protect_second_page(enforce, size, &pkey, &ptr,
+					       &ptr2, &ptr3);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// modify to the first page is allowed.
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	// modify to the third page is allowed.
+	ret = sys_mprotect(ptr3, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	// modify to the second page is protected by pkey.
+	ret = sys_mprotect(ptr2, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	// modify to memory range that includes the second page is protected.
+	ret = sys_mprotect_pkey(ptr, size * 4,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr, size * 4, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect(addr2, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	ret = sys_mprotect_pkey(ptr, size * 4,
+				PROT_READ | PROT_WRITE | PROT_EXEC, pkey);
+	assert(!ret);
+
+	clean_single_address_with_pkey(pkey, ptr, size * 4);
+}
+
+// mmap one address with 4 pages.
+// assign PKEY to the second page only.
+// mprotect on the second page, but size is unaligned.
+void test_mprotect_unaligned(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr, *ptr2, *ptr3;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_4pages_fixed_protect_second_page(enforce, size, &pkey, &ptr,
+					       &ptr2, &ptr3);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// modify to the first page is allowed.
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	// modify to the second page is protected by pkey.
+	ret = sys_mprotect(ptr2, size - 1, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect(addr2, size - 1, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	clean_single_address_with_pkey(pkey, ptr, size * 4);
+}
+
+// mmap one address with 4 pages.
+// assign PKEY to the second page only.
+// mprotect on the second page, but size is unaligned.
+void test_mprotect_unaligned2(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr, *ptr2, *ptr3;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_4pages_fixed_protect_second_page(enforce, size, &pkey, &ptr,
+					       &ptr2, &ptr3);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// modify to the first page is allowed.
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	// modify to the second page is protected by pkey.
+	ret = sys_mprotect(ptr2, size + 1, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect(addr2, size + 1, PROT_READ | PROT_WRITE | PROT_EXEC);
+	assert(!ret);
+
+	clean_single_address_with_pkey(pkey, ptr, size * 4);
+}
+
+void setup_address_with_gap_two_pkeys(bool enforce, int size, int *pkeyOut,
+				      int *pkey2Out, void **ptrOut,
+				      void **ptr2Out)
+{
+	int pkey, pkey2;
+	void *ptr, *ptr2;
+	int ret;
+
+	pkey = pkey_alloc_with_check(enforce);
+	pkey2 = pkey_alloc_with_check(enforce);
+
+	ptr = mmap(addr1, size, PROT_READ,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr == (void *)addr1);
+
+	ptr2 = mmap(addr3, size, PROT_READ,
+		    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr2 == (void *)addr3);
+
+	// assign pkey to the memory.
+	ret = sys_mprotect_pkey((void *)ptr, size, PROT_READ, pkey);
+	assert(!ret);
+
+	// assign pkey to the memory.
+	ret = sys_mprotect_pkey((void *)ptr2, size, PROT_READ, pkey2);
+	assert(!ret);
+
+	*pkeyOut = pkey;
+	*ptrOut = ptr;
+
+	*pkey2Out = pkey2;
+	*ptr2Out = ptr2;
+}
+
+void clean_address_with_pag_two_pkeys(int pkey, void *ptr, int pkey2,
+				      void *ptr2, int size)
+{
+	int ret;
+
+	ret = munmap(ptr, size);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+
+	ret = munmap(ptr2, size);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey2);
+	assert(ret == 0);
+}
+
+// mmap two addresses, with a page gap between two.
+// assign pkeys on both address.
+// disable access to the second address.
+// mprotect from start of address1 to the end of address 2,
+// because there is a gap in the memory range, mprotect will fail.
+void test_mprotect_gapped_address_with_two_pkeys(bool enforce)
+{
+	int pkey, pkey2;
+	int ret;
+	void *ptr, *ptr2;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_address_with_gap_two_pkeys(enforce, size, &pkey, &pkey2, &ptr,
+					 &ptr2);
+
+	// disable write access.
+	pkey_write_deny(pkey2);
+
+	ret = sys_mprotect_pkey(ptr, size * 3, PROT_READ | PROT_WRITE, pkey);
+	assert(ret < 0);
+
+	ret = sys_mprotect(ptr, size * 3, PROT_READ | PROT_WRITE);
+	assert(ret < 0);
+
+	pkey_write_allow(pkey2);
+
+	ret = sys_mprotect_pkey(ptr, size * 3, PROT_READ, pkey);
+	assert(ret < 0);
+
+	ret = sys_mprotect(ptr, size * 3, PROT_READ);
+	assert(ret < 0);
+
+	clean_address_with_pag_two_pkeys(pkey, ptr, pkey2, ptr2, size);
+}
+
+struct thread_info {
+	int pkey;
+	void *addr;
+	int size;
+	bool enforce;
+};
+
+void *thread_mprotect(void *arg)
+{
+	struct thread_info *tinfo = arg;
+	void *ptr = tinfo->addr;
+	int size = tinfo->size;
+	bool enforce = tinfo->enforce;
+	int pkey = tinfo->pkey;
+	int ret;
+
+	// disable write access.
+	pkey_write_deny(pkey);
+	ret = sys_mprotect_pkey(ptr, size, PROT_READ | PROT_WRITE, pkey);
+
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(ret == 0);
+
+	pkey_write_allow(pkey);
+
+	ret = sys_mprotect_pkey(ptr, size, PROT_READ, pkey);
+	assert(!ret);
+
+	ret = sys_mprotect(ptr, size, PROT_READ);
+	assert(ret == 0);
+	return NULL;
+}
+
+// mmap one address.
+// assign pkey on the address.
+// in child thread, mprotect is denied when no-writeable PKRU in enforce mode.
+void test_mprotect_child_thread(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	int size = PAGE_SIZE;
+	pthread_t thread;
+	struct thread_info tinfo;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_single_fixed_address_with_pkey(enforce, size, &pkey, &ptr);
+	tinfo.size = size;
+	tinfo.addr = ptr;
+	tinfo.enforce = enforce;
+	tinfo.pkey = pkey;
+
+	ret = pthread_create(&thread, NULL, thread_mprotect, (void *)&tinfo);
+	assert(ret == 0);
+	pthread_join(thread, NULL);
+
+	clean_single_address_with_pkey(pkey, ptr, size);
+}
+
+void test_enforce_api(void)
+{
+	for (int i = 0; i < 2; i++) {
+		bool enforce = (i == 1);
+
+		test_pkey_alloc(enforce);
+
+		test_mprotect_single_address(enforce);
+		test_mprotect_two_address_merge(enforce);
+		test_mprotect_two_address_deny_second(enforce);
+		test_mprotect_vma_middle_addr(enforce);
+		test_mprotect_unaligned(enforce);
+		test_mprotect_unaligned2(enforce);
+		test_mprotect_child_thread(enforce);
+		test_mprotect_gapped_address_with_two_pkeys(enforce);
+	}
+}
+
+int main(void)
+{
+	int pkeys_supported = is_pkeys_supported();
+
+	printf("pid: %d\n", getpid());
+	printf("has pkeys: %d\n", pkeys_supported);
+	if (!pkeys_supported) {
+		printf("PKEY not supported, skip the test.\n");
+		exit(0);
+	}
+
+	test_enforce_api();
+	printf("done (all tests OK)\n");
+	return 0;
+}
+#else /* arch */
+int main(void)
+{
+	printf("SKIP: not supported arch\n");
+	return 0;
+}
+#endif /* arch */
-- 
2.40.1.606.ga4b1b128d6-goog

