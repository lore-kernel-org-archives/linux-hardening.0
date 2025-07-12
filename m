Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384D1632DF
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348261; cv=none; b=pO9LbcZjEnhRkZVzPms7RBZBT0IONgmwBEazEv0Pz6Q9+WJeAk21NcLpog6rdtTVik7hc5HpmguO34YXOAajr95snFqCpFFWZk+mo9LVCo6MYwWz2oNOHSeW4Q5SEAePXnLezVL33IE9Cz6Z6+TsqbP98RJ23NLQ40UMOSQYJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348261; c=relaxed/simple;
	bh=QUWbC4sBQUzNUG59rbv5BfsAHRiETZwXtrR8y3onrz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NPCpHzRA/jv/bwBa5G+9X9EyqRnCV6FIRfWsnjOnXlpPUgPT194cvw9Vc3W0lArjE3BmiVZEM1V878xk0s9MJFgzG7mZtwEKVFsKJ9dhFiS0ofJVumLWNampd7aoygmeu9b9vQfaZ/UM0mUnvY8of2RMJtvW11uKsUYXnLSTT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSlhbCOF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSlhbCOF"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313cde344d4so3314561a91.0
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348254; x=1752953054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kONp8j1d6svXeoYYcq6eQQIN/z6FHOBc0ExknA1MQsM=;
        b=MSlhbCOFD3/dMWNuRAAQPF+n+ZFweX1Vgb5duGgTmZ31k1Ei30TI19kScpdSjhfWdF
         89aPmanOmJ6zrWs90RypTpEXeoFMnwxOBDUgxQG6yYXAsvo1Sq8QQ+Q2uEwYRq30iXtD
         Ss23+BAPu9zVwRWyujOLCCQdB3eP0Gs+Knb3BWVqzKQM3jTmBIjOOQTPR+NO13uATSrS
         HTyIcvRNS+F9jqAEcZMctPOApvydaxYnX2oBU6a8GbfEvoNbsYAAIFtq/1mvrQ1HwWba
         03k3n3mP7ygHsxZTBeQOHt+EExiviPWSgXyF99Xn9aR/MlrI55sxqHg2VEi16fXQMlzl
         AZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348254; x=1752953054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kONp8j1d6svXeoYYcq6eQQIN/z6FHOBc0ExknA1MQsM=;
        b=DLZhQt3DZ3/QMkPGj9AleVOElX5V9dEGNrnNNYUQuWEExj6wycJLcF6kUWsMxHs81W
         gkOn8ENhpW8dBco2Pmk2oWOJeh2QirGp8MxImzuZbx9fJzNgydTy2Dm2CaB9zzJVJys7
         6UOgsXy53/0Eey+13Wkz9UOkZv5/aC2DcRT/03EswE0HGSM/7d/VlZ5AibjuhKLCzAMH
         vyOp9yXnKbCwgSmZMP/RhZ4zLaGXL0Ia9rZpEbQRzLsDpElwRcgUxA2i7RQZFdaE0BXJ
         rS2JRMWmPCqBaFYdGB6NogMeP5hNI7C4W9ShlYUBtRC79Cp/Z4xRGCezlpPxnUMXx5UY
         ufyg==
X-Gm-Message-State: AOJu0YwrPN1fjxwQVEY4fvyCJUTcw/hSt8ex2YxMOqdSaoCSMT/Nrst9
	Haz63Zd79GUPq09tUbBC15gcpuwDT4gTfVQKTNE7nZuMEIR21j1iciN/1XnSy4QN
X-Gm-Gg: ASbGncuLtOzH27QFnqHhkQBvtRH+UcFiCFq/VI1/mKgyRcdmdwG1Srd5w9lD1Y5i8S/
	EkvVMqTwN0/Cu36Q6U10uH6uJ/GmS/9BQ7PIBgF3ANav7cWPQ5ifCnv2cHHX71XodbAOtUpUwx/
	8RGLaZr+WwMrKXGbUG/E+2Tn0qV9YerUmLONWWNojYsXbMe3pYAUxLIhQrhJZNX7Zj0bESIqSbf
	OjXsS7XUfWqzsJGEANPyJZT/XfKetd1TNtuva5RlRLeBhD1MgRzmNIAdUD+OKSw+WmQ7qPBe9vr
	tvftu5uC76xFvNd2yfz5WURKElMzPJ3U8427AJAAaZsu0gbYJa0vR6YkPMCGFRCjon4xXTHo000
	CVoCs0a+JTxPxPtgGxJP/ceaiExFFVnJy1RR6a/Uw0CzC
X-Google-Smtp-Source: AGHT+IERkS8LoEztUCGaOOPS96gT9eB5RYOf24YX/zSRAySDBzvk3z/DcAoxroLlDMe6yqxOfC4onw==
X-Received: by 2002:a17:90a:d407:b0:315:cbe0:13b3 with SMTP id 98e67ed59e1d1-31c4f4b5635mr10157753a91.7.1752348252773;
        Sat, 12 Jul 2025 12:24:12 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:11 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 01/17] Add SafeFetch double-fetch protection to the kernel
Date: Sat, 12 Jul 2025 19:21:46 +0000
Message-Id: <20250712192202.707192-2-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

SafeFetch[1] protects the kernel from double-fetch vulnerabilities.
Double-fetch bugs enable time-of-check to time-of-use (TOCTTOU) attack
vectors. Scott Bauer found and patched a doube-fetch in dedupe ioctl[2]
of which the proof of concept (POC) was used to test SafeFetch[3][4][5],
see also the appendix PDF in [1].

SafeFetch accomplishes this protection by caching user data in syscall
specific caches to replay them when fetched again within the same
syscall [1].

SafeFetch is not currently intended for production use but rather for
finding bugs. Although the original authors presented enabling SafeFetch
had "marginal memory overheads and geometric performance overheads
consistently below 5% across various OS benchmarks" [1].

SafeFetch was originally created by Victor Duta, Mitchel Josephus
Alonserij, and Cristiano Giuffrida.

I have forward ported, and tested it with Scott Bauer's POC [4], from
v5.11 to v6.16-rc5. I have not yet tested it across various performance
suites to verify the persistence of the overhead claims from the paper
in the forward porting process. I have also not yet tested it across all
recommended configuration variants, or with some compiler versions.

[1] https://www.usenix.org/conference/usenixsecurity24/presentation/duta
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10eec60ce79187686e052092e5383c99b4420a20
[3] https://www.openwall.com/lists/oss-security/2016/07/31/6
[4] https://github.com/wpengfei/CVE-2016-6516-exploit/tree/master/Scott%20Bauer
[5] https://github.com/vusec/safefetch-ae/
---
 include/linux/dfcache_measuring.h     |   72 +
 include/linux/mem_range.h             |  302 ++++
 include/linux/region_allocator.h      |  188 +++
 include/linux/safefetch.h             |  222 +++
 include/linux/safefetch_static_keys.h |   22 +
 lib/Kconfig.safefetch                 |   36 +
 mm/safefetch/Makefile                 |   11 +
 mm/safefetch/mem_range.c              | 1882 +++++++++++++++++++++++++
 mm/safefetch/page_cache.c             |  129 ++
 mm/safefetch/page_cache.h             |  141 ++
 mm/safefetch/region_allocator.c       |  584 ++++++++
 mm/safefetch/safefetch.c              |  487 +++++++
 mm/safefetch/safefetch_debug.c        |  110 ++
 mm/safefetch/safefetch_debug.h        |   86 ++
 mm/safefetch/safefetch_static_keys.c  |  299 ++++
 scripts/Makefile.safefetch            |   10 +
 16 files changed, 4581 insertions(+)
 create mode 100644 include/linux/dfcache_measuring.h
 create mode 100644 include/linux/mem_range.h
 create mode 100644 include/linux/region_allocator.h
 create mode 100644 include/linux/safefetch.h
 create mode 100644 include/linux/safefetch_static_keys.h
 create mode 100644 lib/Kconfig.safefetch
 create mode 100644 mm/safefetch/Makefile
 create mode 100644 mm/safefetch/mem_range.c
 create mode 100644 mm/safefetch/page_cache.c
 create mode 100644 mm/safefetch/page_cache.h
 create mode 100644 mm/safefetch/region_allocator.c
 create mode 100644 mm/safefetch/safefetch.c
 create mode 100644 mm/safefetch/safefetch_debug.c
 create mode 100644 mm/safefetch/safefetch_debug.h
 create mode 100644 mm/safefetch/safefetch_static_keys.c
 create mode 100644 scripts/Makefile.safefetch

diff --git a/include/linux/dfcache_measuring.h b/include/linux/dfcache_measuring.h
new file mode 100644
index 000000000000..53ec57711f68
--- /dev/null
+++ b/include/linux/dfcache_measuring.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* source for TSC measurement code:
+ * https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/ia-32-ia-64-benchmark-code-execution-paper.pdf
+ */
+
+#define MEASURE_BEFORE(cycles_high, cycles_low)			\
+	asm volatile(						\
+		"CPUID\n\t"					\
+		"RDTSC\n\t"					\
+		"mov %%edx, %0\n\t"				\
+		"mov %%eax, %1\n\t"				\
+		: "=r" (cycles_high), "=r" (cycles_low)		\
+		:: "%rax", "%rbx", "%rcx", "%rdx");
+
+#define MEASURE_AFTER(cycles_high, cycles_low)			\
+	asm volatile(						\
+		"RDTSCP\n\t"					\
+		"mov %%edx, %0\n\t"				\
+		"mov %%eax, %1\n\t"				\
+		"CPUID\n\t"					\
+		: "=r" (cycles_high), "=r" (cycles_low)		\
+		:: "%rax", "%rbx", "%rcx", "%rdx");
+
+#define MAKESTRING2(x) #x
+#define MAKESTRING(x) MAKESTRING2(x)
+
+static int64_t make_int64(uint32_t high, uint32_t low)
+{
+	return (((int64_t) high) << 32) | (int64_t) low;
+}
+
+
+
+#define MEASURE_FUNC_AND_COUNT(code_to_measure, out_buffer, index) {				\
+	uint32_t cycles_low_before, cycles_high_before;						\
+	uint32_t cycles_low_after, cycles_high_after;						\
+	if (out_buffer) {									\
+		MEASURE_BEFORE(cycles_high_before, cycles_low_before);				\
+		do {										\
+			code_to_measure								\
+		} while (0);									\
+		MEASURE_AFTER(cycles_high_after, cycles_low_after);				\
+												\
+		if (index < SAFEFETCH_MEASURE_MAX) {						\
+			out_buffer[index++] = make_int64(cycles_high_after, cycles_low_after)	\
+			- make_int64(cycles_high_before, cycles_low_before) - rdmsr_ovr;	\
+		}										\
+	} else {										\
+		code_to_measure									\
+	}											\
+}
+
+
+
+#define MEASURE_FUNC(code_to_measure, out_buffer, index) {					\
+	uint32_t cycles_low_before, cycles_high_before;						\
+	uint32_t cycles_low_after, cycles_high_after;						\
+	if (out_buffer) {									\
+		MEASURE_BEFORE(cycles_high_before, cycles_low_before);				\
+		do {										\
+			code_to_measure								\
+		} while (0);									\
+		MEASURE_AFTER(cycles_high_after, cycles_low_after);				\
+												\
+		if (index < SAFEFETCH_MEASURE_MAX) {						\
+			out_buffer[index] = make_int64(cycles_high_after, cycles_low_after)	\
+			- make_int64(cycles_high_before, cycles_low_before) - rdmsr_ovr;	\
+		}										\
+	} else {										\
+		code_to_measure									\
+	}											\
+}
diff --git a/include/linux/mem_range.h b/include/linux/mem_range.h
new file mode 100644
index 000000000000..b264645c5270
--- /dev/null
+++ b/include/linux/mem_range.h
@@ -0,0 +1,302 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __MEM_RANGE_H__
+#define __MEM_RANGE_H__
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/safefetch_static_keys.h>
+#include <linux/region_allocator.h>
+
+#define safefetch_inline_attr noinline
+
+
+#define COPY_FUNC copy_user_generic
+#define ASSERT_OUT_OF_MEMORY(mr) if (unlikely(!mr)) return -1;
+
+unsigned long copy_range(unsigned long long user_src, unsigned long long kern_dst,
+			 unsigned long user_size);
+struct mem_range *search_range(unsigned long long user_begin, unsigned long long user_end);
+struct mem_range *create_mem_range(unsigned long long user_begin, unsigned long user_size);
+void defragment_mr(struct mem_range *new_mr, struct mem_range *mr);
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+unsigned long copy_range_pinning(unsigned long long user_src, unsigned long long kern_dst,
+				 unsigned long user_size);
+#endif
+
+#ifdef SAFEFETCH_DEBUG
+void dump_range_stats(int *range_size, unsigned long long *avg_size);
+void mem_range_dump(void);
+void dump_range(unsigned long long start);
+void dump_range_stats_extended(int *range_size, uint64_t *min_size, uint64_t *max_size,
+			       unsigned long long *avg_size, uint64_t *total_size);
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+void check_pins(void);
+#endif
+#endif
+
+//static inline struct mem_range* search_range(unsigned long long user_begin, unsigned long long user_end);
+
+#define SAFEFETCH_TASK_MEM_RANGE_INIT_FLAG(tsk) tsk->df_prot_struct_head.df_mem_range_allocator.initialized
+#define SAFEFETCH_MEM_RANGE_INIT_FLAG SAFEFETCH_TASK_MEM_RANGE_INIT_FLAG(current)
+
+#define SAFEFETCH_TASK_RESET_MEM_RANGE(tsk) {		\
+	SAFEFETCH_TASK_MEM_RANGE_INIT_FLAG(tsk) = 0;	\
+};
+
+#define SAFEFETCH_RESET_MEM_RANGE() {			\
+	SAFEFETCH_TASK_RESET_MEM_RANGE(current);	\
+};
+
+#if !defined(SAFEFETCH_RBTREE_MEM_RANGE) && !defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) && !defined(SAFEFETCH_STATIC_KEYS)
+
+#define SAFEFETCH_HEAD_NODE_LL(tsk) tsk->df_prot_struct_head.df_mem_range_allocator.node
+#define SAFEFETCH_NODE_MEMBER_LL node
+#define SAFEFETCH_MR_NODE_LL(mr) mr->node
+
+#elif defined(SAFEFETCH_RBTREE_MEM_RANGE)
+
+#define SAFEFETCH_HEAD_NODE_RB(tsk) tsk->df_prot_struct_head.df_mem_range_allocator.node
+#define SAFEFETCH_NODE_MEMBER_RB node
+#define SAFEFETCH_MR_NODE_RB(mr) mr->node
+
+#else
+
+#define SAFEFETCH_HEAD_NODE_LL(tsk) tsk->df_prot_struct_head.df_mem_range_allocator.ll_node
+#define SAFEFETCH_HEAD_NODE_RB(tsk) tsk->df_prot_struct_head.df_mem_range_allocator.rb_node
+#define SAFEFETCH_NODE_MEMBER_LL ll_node
+#define SAFEFETCH_NODE_MEMBER_RB rb_node
+#define SAFEFETCH_MR_NODE_LL(mr) mr->ll_node
+#define SAFEFETCH_MR_NODE_RB(mr) mr->rb_node
+
+#ifdef SAFEFETCH_FLOATING_ADAPTIVE_WATERMARK
+extern uint8_t SAFEFETCH_ADAPTIVE_WATERMARK;
+#else
+#define SAFEFETCH_ADAPTIVE_WATERMARK 63
+#endif
+
+#define SAFEFETCH_COPIES(tsk) tsk->df_prot_struct_head.df_mem_range_allocator.ncopies
+
+#ifndef SAFEFETCH_USE_SHIFT_COUNTER
+#define SAFEFETCH_RESET_COPIES(tsk)	(SAFEFETCH_COPIES(tsk) = (SAFEFETCH_ADAPTIVE_WATERMARK - 1))
+#define SAFEFETCH_INCREMENT_COPIES(tsk) (SAFEFETCH_COPIES(tsk)--)
+#define SAFEFETCH_DECREMENT_COPIES(tsk) (SAFEFETCH_COPIES(tsk)++)
+#define SAFEFETCH_CHECK_COPIES(tsk) (SAFEFETCH_COPIES(tsk) == 0)
+#else
+/* #warning "SafeFetch Using shift counter" */
+#define SAFEFETCH_RESET_COPIES(tsk)	(SAFEFETCH_COPIES(tsk) = ((uint64_t)1 << (SAFEFETCH_ADAPTIVE_WATERMARK - 1)))
+#define SAFEFETCH_INCREMENT_COPIES(tsk) (SAFEFETCH_COPIES(tsk) >>= 1)
+#define SAFEFETCH_DECREMENT_COPIES(tsk) (SAFEFETCH_COPIES(tsk) <<= 1)
+#define SAFEFETCH_CHECK_COPIES(tsk) ((uint8_t)SAFEFETCH_COPIES(tsk) & 1)
+
+#endif
+
+
+#define SAFEFETCH_RESET_ADAPTIVE(tsk) tsk->df_prot_struct_head.df_mem_range_allocator.adaptive = 0
+#define SAFEFETCH_SET_ADAPTIVE(tsk)   tsk->df_prot_struct_head.df_mem_range_allocator.adaptive = 1
+#define SAFEFETCH_IS_ADAPTIVE(tsk)    tsk->df_prot_struct_head.df_mem_range_allocator.adaptive
+
+
+
+#endif
+
+// This code snippet initialises the root pointer of the data structure
+#define SAFEFETCH_MEM_RANGE_ROOT_INIT_LL() {					\
+	SAFEFETCH_MEM_RANGE_TASK_ROOT_INIT_LL(current)				\
+};
+
+#define SAFEFETCH_MEM_RANGE_TASK_ROOT_INIT_LL(tsk) {				\
+	INIT_LIST_HEAD(&(SAFEFETCH_HEAD_NODE_LL(tsk)));				\
+	SAFEFETCH_TASK_MEM_RANGE_INIT_FLAG(tsk) = 1;				\
+};
+
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT_LL(prev_mr, mr)  list_add(&(SAFEFETCH_MR_NODE_LL(mr)), &(SAFEFETCH_MR_NODE_LL(prev_mr)));
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_LL(mr)  list_add(&(SAFEFETCH_MR_NODE_LL(mr)), &(SAFEFETCH_HEAD_NODE_LL(current)));
+
+#define SAFEFETCH_MEM_RANGE_ROOT_INIT_RB() {					\
+	SAFEFETCH_MEM_RANGE_TASK_ROOT_INIT_RB(current);				\
+};
+
+#define SAFEFETCH_MEM_RANGE_TASK_ROOT_INIT_RB(tsk) {				\
+	SAFEFETCH_HEAD_NODE_RB(tsk) = RB_ROOT;					\
+	SAFEFETCH_TASK_MEM_RANGE_INIT_FLAG(tsk) = 1;				\
+};
+
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT_RB(prev_mr, mr) {									\
+	if (mr->mr_begin < prev_mr->mr_begin) {											\
+		rb_link_node(&SAFEFETCH_MR_NODE_RB(mr), &SAFEFETCH_MR_NODE_RB(prev_mr), &(SAFEFETCH_MR_NODE_RB(prev_mr).rb_left));	\
+	} else {															\
+		/* Entry is on the right side of parent */										\
+		rb_link_node(&SAFEFETCH_MR_NODE_RB(mr), &SAFEFETCH_MR_NODE_RB(prev_mr), &(SAFEFETCH_MR_NODE_RB(prev_mr).rb_right));	\
+	}																\
+	rb_insert_color(&SAFEFETCH_MR_NODE_RB(mr), &SAFEFETCH_HEAD_NODE_RB(current));						\
+};
+
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_RB(mr) {						    \
+	rb_link_node(&SAFEFETCH_MR_NODE_RB(mr), NULL, &(SAFEFETCH_HEAD_NODE_RB(current).rb_node));	    \
+	rb_insert_color(&SAFEFETCH_MR_NODE_RB(mr), &SAFEFETCH_HEAD_NODE_RB(current));		    \
+};
+
+
+#if !defined(SAFEFETCH_RBTREE_MEM_RANGE) && !defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) && !defined(SAFEFETCH_STATIC_KEYS)
+// Default Linked list insertion functions.
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT(mr) SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_LL(mr)
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT(prev_mr, mr) SAFEFETCH_MEM_RANGE_STRUCT_INSERT_LL(prev_mr, mr)
+
+#elif defined(SAFEFETCH_RBTREE_MEM_RANGE)
+// Rb-tree insertion functions.
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT(mr) SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_RB(mr)
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT(prev_mr, mr) SAFEFETCH_MEM_RANGE_STRUCT_INSERT_RB(prev_mr, mr)
+
+#else
+// TODO adaptive builds make use of both LL and RB macros.
+// The root insertion will always happen in the linked list setup.
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_ADAPTIVE(mr) SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_LL(mr)
+
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ADAPTIVE(prev_mr, mr) {	\
+	if (likely(!SAFEFETCH_IS_ADAPTIVE(current))) {			\
+		SAFEFETCH_MEM_RANGE_STRUCT_INSERT_LL(prev_mr, mr);	\
+	} else {							\
+		SAFEFETCH_MEM_RANGE_STRUCT_INSERT_RB(prev_mr, mr);	\
+	}								\
+}
+
+#endif
+
+#if defined(SAFEFETCH_ADAPTIVE_MEM_RANGE)
+/* Dfcacher Adaptive insertion hooks. */
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_ADAPTIVE
+#define SAFEFETCH_MEM_RANGE_STRUCT_INSERT SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ADAPTIVE
+
+#elif defined(SAFEFETCH_STATIC_KEYS) // SAFEFETCH_ADAPTIVE_MEM_RANGE
+// Really hacky just to escape the incomplete type mess
+static inline void SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT(struct mem_range *mr)
+{
+	// Make this wrapper unlikely so we balance the extra jumps added by
+	// the static key implementation to all defense versions.
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_adaptive_key) {
+		SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_ADAPTIVE(mr);
+	} else {
+		// If the rb-tree key is on make this branch unlikely so we incur
+		// one jump if we fall-through here (safefetch_adaptive_key == False)
+		// We will force a jump in the link list implementation by forcing
+		// the extra adaptive implementation in the link-list as likely.
+		IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_rbtree_key) {
+			SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_RB(mr);
+		} else {
+			// The else branch is simply the link list implementation.
+			SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_LL(mr);
+		}
+	}
+}
+
+static inline void SAFEFETCH_MEM_RANGE_STRUCT_INSERT(struct mem_range *prev_mr,
+						     struct mem_range *mr)
+{
+	// Make this wrapper unlikely so we balance the extra jumps added by
+	// the static key implementation to all defense versions.
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_adaptive_key) {
+		SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ADAPTIVE(prev_mr, mr);
+	} else {
+		// If the rb-tree key is on make this branch unlikely so we incur
+		// one jump if we fall-through here (safefetch_adaptive_key == False)
+		// We will force a jump in the link list implementation by forcing
+		// the extra adaptive implementation in the link-list as likely.
+		IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_rbtree_key) {
+			SAFEFETCH_MEM_RANGE_STRUCT_INSERT_RB(prev_mr, mr);
+		} else {
+			// The else branch is simply the link list implementation.
+			SAFEFETCH_MEM_RANGE_STRUCT_INSERT_LL(prev_mr, mr);
+		}
+	}
+}
+#endif
+
+//(struct mem_range *prev_mr, struct mem_range *mr)
+
+#if defined(SAFEFETCH_DEBUG) && (defined(SAFEFETCH_DEBUG_TRACING) || defined(SAFEFETCH_DEBUG_LEAKS) || defined(SAFEFETCH_DEBUG_COLLECT_VULNERABILITIES))
+
+#define safefetch_traced()({								\
+	if (in_nmi() || current->df_stats.traced) {						\
+		return 0;									\
+	}											\
+})
+#else
+#define safefetch_traced()
+#endif
+
+#ifdef DFCACHER_PERF_SETUP
+
+//#define in_irq_ctx() (in_nmi() | in_hardirq() | in_serving_softirq())
+#define in_irq_ctx() in_nmi()
+
+#define safefetch_in_nmi()({							\
+	if (unlikely(in_irq_ctx())) {						\
+		return 0;								\
+	}										\
+})
+
+#else
+
+#define safefetch_in_nmi()
+
+#endif
+
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_COLLECT_VULNERABILITIES)
+#define macro_dump_vulnerability(X) SAFEFETCH_DEBUG_RUN(5, dump_vulnerability(X));
+#else
+#define macro_dump_vulnerability(X)
+#endif
+
+#define copy_range_loop(user_src, user_val, kern_dst)({							\
+													\
+	unsigned long long mr_offset, user_end, new_mr_begin, new_mr_size;				\
+	struct mem_range *new_mr, *mr;									\
+													\
+	safefetch_traced();										\
+	safefetch_in_nmi();										\
+													\
+	user_end = ((unsigned long long) user_src) + sizeof(__inttype(*user_src)) - 1;			\
+													\
+	mr = search_range((unsigned long long) user_src, user_end);					\
+	if (!mr) {											\
+		new_mr = create_mem_range((unsigned long long) user_src, sizeof(__inttype(*user_src)));	\
+		ASSERT_OUT_OF_MEMORY(new_mr);								\
+		*((__inttype(*user_src)*)(new_mr->mr_prot_loc)) = (__inttype(*user_src))user_val;	\
+		/* *(kern_dst) = *((__inttype(*user_src)*)(new_mr->mr_prot_loc)); */			\
+		/*list_add(&(new_mr->node), &(SAFEFETCH_HEAD_NODE));*/					\
+		SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT(new_mr);						\
+		SAFEFETCH_DEBUG_LOG(SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 4, "[SafeFetch][Info][Task %s][Sys %d] copy_range_loop: Created new region @ at 0x%llx with size(0x%llx bytes)\n", current->comm, DF_SYSCALL_NR, new_mr->mr_begin, new_mr->mr_end - new_mr->mr_begin + 1);	\
+		return 0;										\
+	}												\
+													\
+	if (mr->overlapping == df_range_previous) {							\
+		new_mr = create_mem_range((unsigned long long) user_src, sizeof(__inttype(*user_src)));	\
+		ASSERT_OUT_OF_MEMORY(new_mr);								\
+		*((__inttype(*user_src)*)(new_mr->mr_prot_loc)) = (__inttype(*user_src))user_val;	\
+		/* *(kern_dst) = *((__inttype(*user_src)*)(new_mr->mr_prot_loc)); */			\
+		/*list_add(&(new_mr->node), &(mr->node));*/						\
+		SAFEFETCH_MEM_RANGE_STRUCT_INSERT(mr, new_mr);						\
+		SAFEFETCH_DEBUG_LOG(SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 4, "[SafeFetch][Info][Task %s][Sys %d] copy_range_loop: Created new region at 0x%llx with size(0x%llx bytes)\n", current->comm, DF_SYSCALL_NR, new_mr->mr_begin, new_mr->mr_end - new_mr->mr_begin + 1); \
+	} else if (mr->overlapping == df_range_encapsulates) {						\
+		mr_offset = ((unsigned long long) user_src) - mr->mr_begin;				\
+		*(kern_dst) = *((__force __inttype(*user_src)*)(mr->mr_prot_loc + mr_offset));		\
+		SAFEFETCH_DEBUG_LOG(SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY, "[SafeFetch][Info][Task %s][Sys %d] copy_range_loop: Double fetch from region at 0x%llx with size(0x%llx bytes) offset(0x%llx)\n", current->comm, DF_SYSCALL_NR, mr->mr_begin, mr->mr_end - mr->mr_begin + 1, mr_offset);							     \
+		DF_INC_FETCHES;										\
+		macro_dump_vulnerability(3)								\
+	} else if (mr->overlapping == df_range_overlaps) {						\
+		new_mr_begin = ((unsigned long long) user_src) <= mr->mr_begin ? ((unsigned long long) user_src) : mr->mr_begin;		\
+		new_mr_size = user_end - new_mr_begin + 1;						\
+		new_mr = create_mem_range(new_mr_begin, new_mr_size);					\
+		ASSERT_OUT_OF_MEMORY(new_mr);								\
+		mr_offset = ((unsigned long long) user_src) - new_mr_begin;				\
+		*((__inttype(*user_src)*)(new_mr->mr_prot_loc + mr_offset))  = (__inttype(*user_src)) user_val;	\
+		defragment_mr(new_mr, mr);								\
+		*(kern_dst) = *((__force __inttype(*user_src)*)(new_mr->mr_prot_loc + mr_offset));	\
+		SAFEFETCH_DEBUG_LOG(SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 2, "[SafeFetch][Info][Task %s][Sys %d]  copy_range_loop: Overlapping previous region at 0x%llx with size(0x%llx bytes) offset(0x%llx) copy(0x%llx)\n", current->comm, DF_SYSCALL_NR, new_mr->mr_begin, new_mr->mr_end - new_mr->mr_begin + 1, mr_offset, user_end - (unsigned long long)user_src + 1);			       \
+		DF_INC_DEFRAGS;										\
+		macro_dump_vulnerability(4)								\
+	}												\
+	return 0;											\
+})
+
+#endif
diff --git a/include/linux/region_allocator.h b/include/linux/region_allocator.h
new file mode 100644
index 000000000000..d9771a0117da
--- /dev/null
+++ b/include/linux/region_allocator.h
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __REGION_ALLOCATOR_H__
+#define __REGION_ALLOCATOR_H__
+
+struct region_allocator {
+	struct mem_region *first; // First region in the allocator.
+	size_t region_size; // Default Region Allocator bytes
+	struct kmem_cache *cache;  // default cache used for allocations.
+	struct list_head extra_ranges; // All extra ranges (apart from the first)
+	struct list_head free_ranges;  // A list containing only those extra ranges that still have some bytes.
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+	struct list_head buddy_pages;
+	unsigned pinning:1;
+#endif
+	unsigned extended:1; // Does the region based allocator contain more than the preallocated page.
+	unsigned initialized:1; // If the region allocator contains at least the first page.
+};
+
+#define BYTE_GRANULARITY(allocator) allocator->region_size
+
+#define ASSERT_ALLOCATION_FAILURE(region, message) { \
+	if (unlikely(!region)) {                           \
+		printk(KERN_EMERG message);                 \
+		return 0;                                   \
+	}                                                  \
+}
+
+
+struct mem_region {
+	unsigned long long ptr; // ptr to the next free byte in the region.
+	size_t remaining;
+	struct list_head extra_ranges; // linked list of all allocated ranges for a range allocator (except the first).
+	struct list_head free_ranges; // linked list of all free ranges.
+#ifdef SAFEFETCH_MEASURE_MEMORY_CONSUMPTION
+	size_t size;
+#endif
+	unsigned is_cached:1;
+};
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+struct mem_pin {
+	void *ptr;
+#ifdef SAFEFETCH_MEASURE_MEMORY_CONSUMPTION
+	size_t size;
+#endif
+	struct list_head pin_link;
+};
+#endif
+
+#define REGION_PTR(region) region->ptr
+#define REGION_REMAINING_BYTES(region) region->remaining
+#define REGION_RANGES(region) (&(region->extra_ranges))
+#define REGION_FREELIST(region) (&(region->free_ranges))
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+#define PIN_LINK(pin) (&(pin->pin_link))
+#endif
+
+#ifdef SAFEFETCH_MEASURE_MEMORY_CONSUMPTION
+#define REGION_SIZE(region) region->size
+#endif
+
+#define REGION_CHECKS
+#define ADAPTIVE_REGION_ALLOCATOR
+//#define REGION_CHECKS_EXTENDED
+#define REGION_ALLOCATOR_LARGER_ORDER_ALLOCATIONS
+
+struct range_allocator {
+#if !defined(SAFEFETCH_RBTREE_MEM_RANGE) && !defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) && !defined(SAFEFETCH_STATIC_KEYS)
+	struct list_head node;
+#elif defined(SAFEFETCH_RBTREE_MEM_RANGE)
+	struct rb_root node;
+#else
+	union {
+		struct list_head ll_node;
+		struct rb_root rb_node;
+	};
+#endif
+#if defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) || defined(SAFEFETCH_STATIC_KEYS)
+#ifndef SAFEFETCH_USE_SHIFT_COUNTER
+	uint8_t ncopies;
+#else
+	uint64_t ncopies;
+#endif
+	unsigned adaptive:1;
+#endif
+	unsigned initialized:1;
+};
+
+//#define SAFEFETCH_LINKEDLIST_MEM_RANGE
+// Enum that indicates the current state of a memory range structure
+enum overlapping_types {
+	// We returned the previous range after which we should add our cfu range.
+	df_range_previous,
+	// Mem range struct fully contains the copy from user
+	df_range_encapsulates,
+	// Mem range overlaps the copy from user
+	df_range_overlaps
+};
+
+
+/* The protection memory range structure.
+ * For every copy_from_user/get_user structure there will be a memory range created
+ * These structs will be chained as a linked list for every syscall within every task
+ * This structure contains:
+ * -- the user space memory boundaries that is being copied to kernel space
+ * -- Pointer to the protected memory region for that specific user space memory area
+ * -- The current state of this memory range
+ * -- Pointer to the next memory range structure in the linked list
+ */
+struct mem_range {
+#if  !defined(SAFEFETCH_RBTREE_MEM_RANGE) && !defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) && !defined(SAFEFETCH_STATIC_KEYS)
+	struct list_head node;
+#elif defined(SAFEFETCH_RBTREE_MEM_RANGE)
+	struct rb_node node;
+#else
+	union {
+		struct list_head ll_node;
+		struct rb_node rb_node;
+	};
+#endif
+	unsigned long long mr_begin;
+	unsigned long long mr_end;
+	void *mr_prot_loc;
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+	void *mr_check_loc;
+#endif
+	unsigned overlapping:2;
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES)
+	unsigned is_trap:1;
+#endif
+};
+
+
+#define REGION_LOW_WATERMARK sizeof(struct mem_range)
+
+
+bool init_region_allocator(struct region_allocator *allocator, u8 cache_type);
+void shrink_region(struct region_allocator *allocator);
+void destroy_region(struct region_allocator *allocator);
+void *allocate_from_region(struct region_allocator *allocator, size_t alloc_size);
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+void *pin_compound_pages(struct region_allocator *allocator, void *kern_loc);
+#endif
+
+#ifdef SAFEFETCH_DEBUG
+void dump_region_stats(int *mregions, int *dregions, int *dkmalloc, size_t *dkmallocmax);
+#endif
+
+#define DF_CUR_METADATA_REGION_ALLOCATOR (&(current->df_prot_struct_head.df_metadata_allocator))
+#define DF_CUR_STORAGE_REGION_ALLOCATOR  (&(current->df_prot_struct_head.df_storage_allocator))
+#define DF_TASK_METADATA_REGION_ALLOCATOR(tsk) (&(tsk->df_prot_struct_head.df_metadata_allocator))
+#define DF_TASK_STORAGE_REGION_ALLOCATOR(tsk)  (&(tsk->df_prot_struct_head.df_storage_allocator))
+#define DF_CUR_MEM_RANGE_ALLOCATOR  (&(current->df_prot_struct_head.df_mem_range_allocator))
+
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+#define DF_CUR_MEASURE_STRUCT  (&(current->df_prot_struct_head.df_measures))
+#define DF_TASK_MEASURE_STRUCT(tsk)  (&(tsk->df_prot_struct_head.df_measures))
+#endif
+
+
+#ifdef DFCACHER_INLINE_FUNCTIONS
+// Called on syscall exit to remove extra regions except one.
+#define reset_regions() {                                      \
+	if (SAFEFETCH_MEM_RANGE_INIT_FLAG) {                      \
+		shrink_region(DF_CUR_STORAGE_REGION_ALLOCATOR);        \
+		shrink_region(DF_CUR_METADATA_REGION_ALLOCATOR);       \
+		SAFEFETCH_RESET_MEM_RANGE();                           \
+	}                                                         \
+}
+// Called on process exit to destroy regions.
+#define destroy_regions() {                                 \
+	destroy_region(DF_CUR_STORAGE_REGION_ALLOCATOR);       \
+	destroy_region(DF_CUR_METADATA_REGION_ALLOCATOR);      \
+	SAFEFETCH_RESET_MEM_RANGE();                           \
+}
+// Called by DFCACHE's memory range subsistem to initialize regions used to allocate memory ranges
+#define initialize_regions() (init_region_allocator(DF_CUR_METADATA_REGION_ALLOCATOR, METADATA) &&  \
+			     init_region_allocator(DF_CUR_STORAGE_REGION_ALLOCATOR, STORAGE))
+
+#else
+noinline void reset_regions(void);
+noinline void destroy_regions(void);
+noinline bool initialize_regions(void);
+#endif
+
+#endif
diff --git a/include/linux/safefetch.h b/include/linux/safefetch.h
new file mode 100644
index 000000000000..79b3df7a17e3
--- /dev/null
+++ b/include/linux/safefetch.h
@@ -0,0 +1,222 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef SAFEFETCH_EXTERN_FUNC
+#define SAFEFETCH_EXTERN_FUNC
+
+#include <linux/region_allocator.h>
+
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+
+
+// These are defined in safefetch.c
+extern char global_monitored_task[];
+extern int  global_monitored_syscall;
+extern uint64_t global_search_time[];
+extern uint64_t global_search_count;
+extern uint64_t rdmsr_ovr;
+
+#define SAFEFETCH_MEASURE_MAX 1200
+#define SAFEFETCH_MONITOR_TASK_SIZE 40
+
+struct df_measure_struct {
+	uint64_t *search_time;
+	uint64_t *insert_time;
+	uint64_t counter;
+};
+
+#define df_activate_measure_structs(tsk, sysnr) {                                                                          \
+	if ((!strcmp(tsk->comm, global_monitored_task)) && (global_monitored_syscall == sysnr)) {                             \
+		tsk->df_prot_struct_head.df_measures.search_time =  kmalloc(SAFEFETCH_MEASURE_MAX * sizeof(uint64_t), GFP_KERNEL); \
+		tsk->df_prot_struct_head.df_measures.insert_time =  kmalloc(SAFEFETCH_MEASURE_MAX * sizeof(uint64_t), GFP_KERNEL); \
+		memset(tsk->df_prot_struct_head.df_measures.search_time, 0, SAFEFETCH_MEASURE_MAX * sizeof(uint64_t));             \
+		memset(tsk->df_prot_struct_head.df_measures.insert_time, 0, SAFEFETCH_MEASURE_MAX * sizeof(uint64_t));             \
+		tsk->df_prot_struct_head.df_measures.counter = 0;                                                                  \
+	}                                                                                                                     \
+}
+
+#define df_init_measure_structs(tsk) {                                             \
+	tsk->df_prot_struct_head.df_measures.search_time = NULL;                      \
+	tsk->df_prot_struct_head.df_measures.insert_time = NULL;                      \
+	tsk->df_prot_struct_head.df_measures.counter = 0;                             \
+}
+
+// TODO all of these are macros so we bypass an error due to stupid inclusion order.
+#define df_init_current_measure_structs(tsk) { \
+	tsk->df_prot_struct_head.df_measures.search_time =  kmalloc(SAFEFETCH_MEASURE_MAX * sizeof(uint64_t), GFP_KERNEL); \
+	tsk->df_prot_struct_head.df_measures.insert_time =  kmalloc(SAFEFETCH_MEASURE_MAX * sizeof(uint64_t), GFP_KERNEL); \
+	memset(tsk->df_prot_struct_head.df_measures.search_time, 0, SAFEFETCH_MEASURE_MAX * sizeof(uint64_t));             \
+	memset(tsk->df_prot_struct_head.df_measures.insert_time, 0, SAFEFETCH_MEASURE_MAX * sizeof(uint64_t));             \
+	tsk->df_prot_struct_head.df_measures.counter = 0;                                                                  \
+}
+
+#define df_destroy_measure_structs() {                                                                                                                        \
+	if (current->df_prot_struct_head.df_measures.search_time) {                                                                                             \
+		kfree(current->df_prot_struct_head.df_measures.search_time);                                                                                        \
+		kfree(current->df_prot_struct_head.df_measures.insert_time);                                                                                        \
+	}                                                                                                                                                       \
+	current->df_prot_struct_head.df_measures.search_time = NULL;                                                                                            \
+	current->df_prot_struct_head.df_measures.insert_time = NULL;                                                                                            \
+	current->df_prot_struct_head.df_measures.counter = 0;                                                                                                   \
+}
+
+#if 0
+#define df_destroy_measure_structs() {                                                                                                                        \
+	if (current->df_prot_struct_head.df_measures.search_time) {                                                                                             \
+		memset(global_search_time, 0, SAFEFETCH_MEASURE_MAX * sizeof(uint64_t));                                                                            \
+		global_search_count = current->df_prot_struct_head.df_measures.counter;                                                                             \
+		memcpy(global_search_time, current->df_prot_struct_head.df_measures.search_time, current->df_prot_struct_head.df_measures.counter * sizeof(uint64_t));                          \
+		kfree(current->df_prot_struct_head.df_measures.search_time);                                                                                        \
+		kfree(current->df_prot_struct_head.df_measures.insert_time);                                                                                        \
+	}                                                                                                                                                       \
+	current->df_prot_struct_head.df_measures.search_time = NULL;                                                                                            \
+	current->df_prot_struct_head.df_measures.insert_time = NULL;                                                                                            \
+	current->df_prot_struct_head.df_measures.counter = 0;                                                                                                   \
+}
+#endif
+#endif
+
+/* This struct is inserted into every task struct
+ * It contains the pointers to all the required information and
+ * data structures for our protection mechanism.
+ * --> df_snapshot_first_mr: ptr towards the first inserted protection memory range
+ * --> safefetch_first_node: ptr towards the root node of the memory range rb tree
+ * --> base_page_mem_range_allocator: ptr towards the first pre-allocated page for memory range allocation
+ * --> curr_page_mem_range_allocator: ptr towards the current page for memory range allocation
+ * --> base_page_prot_allocator: ptr towards the first pre-allocated page for memory protection allocation
+ * --> curr_page_prot_allocator: ptr towards the current page for memory protection allocation
+ */
+
+/* This is the data structure that is added to every task struct for every running task
+ * It contains the pointer to the caching data structure
+ * It also contains the pointers needed for the custom allocators
+ */
+struct df_prot_struct {
+	struct range_allocator df_mem_range_allocator;
+	struct region_allocator df_metadata_allocator;
+	struct region_allocator df_storage_allocator;
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+	struct df_measure_struct df_measures;
+#endif
+#ifdef SAFEFETCH_WHITELISTING
+	unsigned is_whitelisted:1;
+#endif
+
+};
+
+#ifdef SAFEFETCH_WHITELISTING
+#define IS_WHITELISTED(current) (current->df_prot_struct_head.is_whitelisted)
+#endif
+
+// SafeFetch startup hook which is executed at boottime
+extern void df_startup(void);
+
+#ifdef SAFEFETCH_DEBUG
+
+#define PENDING_RESTART 1
+#define PENDING_RESTART_DELIVERED 2
+
+struct df_stats_struct {
+	int syscall_nr;
+	unsigned long long syscall_count;
+	unsigned long long num_fetches;
+	unsigned long long num_defrags;
+	unsigned long long cumm_metadata_size;
+	unsigned long long cumm_backing_size;
+	unsigned long long num_4k_copies; // number of copy from users larger than 1page
+	unsigned long long num_8b_copies; // number of copies smaller than 8 bytes
+	unsigned long long num_other_copies; // all other copies.
+	unsigned long nallocations;
+	unsigned pending:2;
+	unsigned check_next_access:1;
+	unsigned traced:1;
+	unsigned in_irq:1;
+};
+
+#define TASK_NAME_SIZE 25
+#if defined(SAFEFETCH_DEBUG_COLLECT_SAMPLES)
+struct df_sample_struct {
+	char comm[TASK_NAME_SIZE];
+	int syscall_nr;
+	pid_t pid;
+	uint64_t sys_count;
+	uint64_t min_size;
+	uint64_t max_size;
+	uint64_t avg_size;
+	uint64_t total_size;
+	uint64_t nfetches;
+	uint64_t ndefrags;
+	int rsize;
+	int mranges;
+	int dranges;
+	int dkmallocs;
+	size_t max_kmalloc;
+};
+
+struct df_sample_link {
+	struct df_sample_struct sample;
+	struct list_head node;
+};
+#elif defined(SAFEFETCH_MEASURE_MEMORY_CONSUMPTION)
+struct df_sample_struct {
+	char comm[TASK_NAME_SIZE];
+	int syscall_nr;
+	pid_t pid;
+	uint64_t rss;
+	uint64_t metadata;
+	uint64_t data;
+	uint64_t pins;
+};
+
+struct df_sample_link {
+	struct df_sample_struct sample;
+	struct list_head node;
+};
+#endif
+
+#ifdef SAFEFETCH_DEBUG_COLLECT_VULNERABILITIES
+struct df_bug_struct {
+	int syscall_nr;
+	int func;
+};
+#define MAX_SYSCALL_REPORTS 3
+#define MAX_REPORTS 200
+
+
+#endif
+
+
+// All of these were replaced with macros so use them as debug functions
+extern void df_debug_syscall_entry(int sys_nr, struct pt_regs *regs);
+extern void df_debug_syscall_exit(void);
+extern void df_debug_task_destroy(struct task_struct *tsk);
+#endif
+
+#if defined(SAFEFETCH_DEBUG) || defined(SAFEFETCH_STATIC_KEYS)
+extern void df_sysfs_init(void);
+#endif
+
+
+
+// SafeFetch task duplication hook
+extern void df_task_dup(struct task_struct *tsk);
+// SafeFetch task destruction hook
+
+// SafeFetch get_user familiy hooks
+extern int df_get_user1(unsigned long long user_src, unsigned char user_val,
+			unsigned long long kern_dst);
+extern int df_get_user2(unsigned long long user_src, unsigned short user_val,
+			unsigned long long kern_dst);
+extern int df_get_user4(unsigned long long user_src, unsigned int user_val,
+			unsigned long long kern_dst);
+extern int df_get_user8(unsigned long long user_src, unsigned long user_val,
+			unsigned long long kern_dst);
+extern int df_get_useru8(unsigned long long user_src, unsigned long user_val,
+			 unsigned long long kern_dst);
+
+// SafeFetch copy_from_user hook
+extern unsigned long df_copy_from_user(unsigned long long from, unsigned long long to,
+				       unsigned long size);
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+extern unsigned long df_copy_from_user_pinning(unsigned long long from, unsigned long long to,
+					       unsigned long size);
+#endif
+#endif
diff --git a/include/linux/safefetch_static_keys.h b/include/linux/safefetch_static_keys.h
new file mode 100644
index 000000000000..262f7b4359cd
--- /dev/null
+++ b/include/linux/safefetch_static_keys.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SAFEFETCH_STATIC_KEYS_H__
+#define __SAFEFETCH_STATIC_KEYS_H__
+
+#ifdef SAFEFETCH_STATIC_KEYS
+DECLARE_STATIC_KEY_FALSE(safefetch_copy_from_user_key);
+DECLARE_STATIC_KEY_FALSE(safefetch_hooks_key);
+DECLARE_STATIC_KEY_FALSE(safefetch_adaptive_key);
+DECLARE_STATIC_KEY_FALSE(safefetch_rbtree_key);
+
+#define IF_SAFEFETCH_STATIC_BRANCH_LIKELY_WRAPPER(key)   if (static_branch_likely(&key))
+#define IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(key) if (static_branch_unlikely(&key))
+
+void init_safefetch_skey_layer(void);
+
+#else /* SAFEFETCH_STATIC_KEYS */
+
+#define IF_SAFEFETCH_STATIC_BRANCH_LIKELY_WRAPPER(key)
+#define IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(key)
+#endif
+
+#endif
diff --git a/lib/Kconfig.safefetch b/lib/Kconfig.safefetch
new file mode 100644
index 000000000000..441caf7b7546
--- /dev/null
+++ b/lib/Kconfig.safefetch
@@ -0,0 +1,36 @@
+config HAVE_ARCH_SAFEFETCH
+  bool
+
+if HAVE_ARCH_SAFEFETCH
+
+config SAFEFETCH
+	bool "Safefetch : double fetch monitoring for copy_from_user/get_user calls"
+	select SAFEFETCH_STATIC_KEYS
+	default n
+	help
+	  SAFEFETCH is a strategy for eliminating double-fetch bugs by
+	  caching user data in exchange for a small performance cost.
+	  SAFEFETCH creates per-syscall caches to persist user data
+	  and replay on subsequent calls.
+
+config SAFEFETCH_STATIC_KEYS
+	bool "Safefetch : static keys safefetch"
+	depends on SAFEFETCH
+	default y
+	help
+	  Instrument SAFEFETCH protections through hooks which can be
+	  disabled through static keys, hooks are nop instructions
+	  otherwise. Enabling this option allows userspace to configure
+	  the protection scheme and enable/disable protections.
+
+config SAFEFETCH_DEBUG
+	bool "Safefetch : double fetch debugging layer"
+	default n
+	help
+	  Debugging messages for SAFEFETCH detected double fetches in the
+	  kernel ring buffer. Used for testing the patchset. If
+	  SAFEFETCH_DEBUG_COLLECT_VULNERABILITIES is enabled, then
+	  report vulnerabilities. Other SAFEFETCH_DEBUG_* options will
+	  enable additional reporting.
+
+endif
diff --git a/mm/safefetch/Makefile b/mm/safefetch/Makefile
new file mode 100644
index 000000000000..ecd095808015
--- /dev/null
+++ b/mm/safefetch/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y := page_cache.o mem_range.o region_allocator.o safefetch.o
+obj-$(CONFIG_SAFEFETCH_DEBUG)   += safefetch_debug.o
+obj-$(CONFIG_SAFEFETCH_STATIC_KEYS)   += safefetch_static_keys.o
+CFLAGS_REMOVE_page_cache.o=-Werror
+CFLAGS_REMOVE_mem_range.o=-Werror
+CFLAGS_REMOVE_region_allocator.o=-Werror
+CFLAGS_REMOVE_safefetch.o=-Werror
+KASAN_SANITIZE := n
+KCOV_INSTRUMENT := n
+UBSAN_SANITIZE := n
\ No newline at end of file
diff --git a/mm/safefetch/mem_range.c b/mm/safefetch/mem_range.c
new file mode 100644
index 000000000000..75efc8d38c4a
--- /dev/null
+++ b/mm/safefetch/mem_range.c
@@ -0,0 +1,1882 @@
+// SPDX-License-Identifier: GPL-2.0
+// Include the data structures needed by the defense
+#include <linux/mem_range.h>
+#include "safefetch_debug.h"
+
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+#include <linux/dfcache_measuring.h>
+#endif
+
+#if defined(SAFEFETCH_FLOATING_ADAPTIVE_WATERMARK) && \
+	defined(SAFEFETCH_STATIC_KEYS)
+/* #warning "SafeFetch Using Adaptive Watermark Scheme" */
+uint8_t SAFEFETCH_ADAPTIVE_WATERMARK = 63;
+#else
+/* #warning "SafeFetch NOT Using Adaptive Watermark Scheme" */
+#endif
+
+struct mem_range *create_mem_range(unsigned long long user_begin,
+				   unsigned long user_size)
+{
+	struct mem_range *new_mr;
+
+	new_mr = (struct mem_range *)allocate_from_region(
+		DF_CUR_METADATA_REGION_ALLOCATOR, sizeof(struct mem_range));
+
+	if (!new_mr) {
+		printk(KERN_EMERG "ERROR: Couldn't allocate new mem range");
+		return NULL;
+	}
+
+	// Set the pointer to the correct values
+	new_mr->mr_begin = user_begin;
+	new_mr->mr_end = user_begin + user_size - 1;
+
+	// Initialise the data structure related values
+	//SAFEFETCH_MEM_RANGE_STRUCT_INIT(new_mr);
+
+	new_mr->mr_prot_loc = allocate_from_region(
+		DF_CUR_STORAGE_REGION_ALLOCATOR, user_size);
+
+	if (!new_mr->mr_prot_loc) {
+		printk(KERN_EMERG
+		       "[%s] ERROR: Couldn't allocate user memory area %ld\n",
+		       current->comm, user_size);
+		return NULL;
+	}
+
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES)
+	new_mr->is_trap = 0;
+#endif
+
+	// Return newly created memory range
+	return new_mr;
+}
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+struct mem_range *create_pin_range(unsigned long long user_begin,
+				   unsigned long user_size,
+				   unsigned long long kern_loc)
+{
+	struct mem_range *new_mr;
+
+	new_mr = (struct mem_range *)allocate_from_region(
+		DF_CUR_METADATA_REGION_ALLOCATOR, sizeof(struct mem_range));
+
+	if (!new_mr) {
+		printk(KERN_EMERG "ERROR: Couldn't allocate new mem range");
+		return NULL;
+	}
+
+	// Set the pointer to the correct values
+	new_mr->mr_begin = user_begin;
+	new_mr->mr_end = user_begin + user_size - 1;
+
+	// Initialise the data structure related values
+	//SAFEFETCH_MEM_RANGE_STRUCT_INIT(new_mr);
+
+#ifdef SAFEFETCH_MEASURE_MEMORY_CONSUMPTION
+	new_mr->mr_prot_loc = pin_compound_pages(
+		DF_CUR_STORAGE_REGION_ALLOCATOR, (void *)kern_loc, user_size);
+#else
+	new_mr->mr_prot_loc = pin_compound_pages(
+		DF_CUR_STORAGE_REGION_ALLOCATOR, (void *)kern_loc);
+#endif
+
+	if (!new_mr->mr_prot_loc) {
+		printk(KERN_EMERG "ERROR: Couldn't allocate user memory area");
+		return NULL;
+	}
+
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_PIN_BUDDY_PAGES) && \
+	defined(SAFEFETCH_DEBUG_PINNING)
+	new_mr->mr_check_loc = kmalloc(user_size, GFP_ATOMIC);
+	memcpy(new_mr->mr_check_loc, (void *)kern_loc, user_size);
+#endif
+
+	new_mr->is_trap = 1;
+
+	// Return newly created memory range
+	return new_mr;
+}
+
+void copy_from_page_pin(void *kern_dst, unsigned long long pin_virt_addr,
+			unsigned long long user_size)
+{
+	void *src;
+	struct page *page;
+
+	unsigned long long page_reminder =
+		PAGE_SIZE - (pin_virt_addr & (PAGE_SIZE - 1));
+	page = virt_to_page(pin_virt_addr);
+	src = kmap_atomic(page);
+
+	if (page_reminder >= user_size) {
+		memcpy(kern_dst, (void *)pin_virt_addr, user_size);
+		kunmap_atomic(src);
+		return;
+	} else {
+		memcpy(kern_dst, (void *)pin_virt_addr, page_reminder);
+	}
+	kunmap_atomic(src);
+	user_size -= page_reminder;
+	kern_dst += page_reminder;
+	pin_virt_addr = ALIGN_DOWN(pin_virt_addr, PAGE_SIZE) + PAGE_SIZE;
+
+	while (user_size) {
+		page = virt_to_page(pin_virt_addr);
+		src = kmap_atomic(page);
+		if (user_size >= PAGE_SIZE) {
+			memcpy(kern_dst, src, PAGE_SIZE);
+			kunmap_atomic(src);
+		} else {
+			memcpy(kern_dst, src, user_size);
+			kunmap_atomic(src);
+			return;
+		}
+
+		pin_virt_addr += PAGE_SIZE;
+		kern_dst += PAGE_SIZE;
+		user_size -= PAGE_SIZE;
+	}
+}
+#endif
+
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_TRACING)
+// Started out nice but now all debugging functionality is sloppily
+// added all over the place. Find a way to merge all debugging functionality
+// (macros, functions) in the same place.
+#define SAFEFETCH_JUST_INTERRUPTS_WHILE_TASK_BLOCKED
+
+// This function warns us about interrupts that happen while no syscalls are in
+// tranzit.
+static inline void warn_dfcache_use(void)
+{
+	if (current->df_stats.check_next_access) {
+		current->df_stats.traced = 1;
+		WARN_ON(1);
+		current->df_stats.traced = 0;
+	}
+}
+
+// This warns us about interrupts that use DFCACHER while a syscall is blocked.
+static inline void warn_dfcache_use_on_blocked(void)
+{
+	if (!in_task() && !current->df_stats.check_next_access) {
+		current->df_stats.traced = 1;
+		WARN_ON(SAFEFETCH_MEM_RANGE_INIT_FLAG);
+		current->df_stats.traced = 0;
+	}
+}
+#endif
+
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_COLLECT_VULNERABILITIES)
+/* #warning "Compiling SafeFetch with vulnerability reporting" */
+struct df_bug_struct *vuln_reports[MAX_REPORTS] = { NULL };
+DEFINE_SPINLOCK(df_exploit_lock);
+static inline void dump_vulnerability(int func)
+{
+	int i;
+	int max_tries = 0;
+
+	spin_lock(&df_exploit_lock);
+	if (vuln_reports[0] == NULL)
+		memset(vuln_reports, 0,
+		       MAX_REPORTS * sizeof(struct df_bug_struct *));
+
+	for (i = 0; i < MAX_REPORTS; i++) {
+		if (max_tries == MAX_SYSCALL_REPORTS)
+			break;
+		if (vuln_reports[i] == NULL) {
+			// Report bug
+
+			current->df_stats.traced = 1;
+			printk("=====Bug in Syscal:%d Comm:%s\n", DF_SYSCALL_NR,
+			       current->comm);
+			WARN_ON(1);
+			printk("=====End of Bug:%d Comm:%s\n", DF_SYSCALL_NR,
+			       current->comm);
+			current->df_stats.traced = 0;
+
+			vuln_reports[i] = kmalloc(sizeof(struct df_bug_struct),
+						  GFP_ATOMIC);
+			memset(vuln_reports[i], 0,
+			       sizeof(struct df_bug_struct));
+			vuln_reports[i]->func = func;
+			vuln_reports[i]->syscall_nr = DF_SYSCALL_NR;
+
+			break;
+		}
+		if (vuln_reports[i]->syscall_nr == DF_SYSCALL_NR &&
+		    vuln_reports[i]->func == func) {
+			max_tries++;
+		}
+	}
+	spin_unlock(&df_exploit_lock);
+}
+#endif
+
+#ifndef SAFEFETCH_RBTREE_MEM_RANGE
+
+// DEBUGING UTILITIES
+#ifdef SAFEFETCH_DEBUG
+static inline void __mem_range_dump_ll(void)
+{
+	struct list_head *item;
+	struct mem_range *next_range;
+	unsigned int list_size = 0;
+
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG)
+		return;
+	printk(KERN_INFO
+	       "[SafeFetch][ModuleDebug]>====Start of mem_range_dump(LLIST)====<\n");
+	list_for_each(item, &(SAFEFETCH_HEAD_NODE_LL(current))) {
+		next_range = list_entry(item, struct mem_range,
+					SAFEFETCH_NODE_MEMBER_LL);
+		printk(KERN_INFO
+		       "[SafeFetch][ModuleDebug] [0x%llx - 0x%llx] size: 0x%llx\n",
+		       next_range->mr_begin, next_range->mr_end,
+		       next_range->mr_end - next_range->mr_begin + 1);
+		list_size++;
+	}
+	printk(KERN_INFO "[SafeFetch][ModuleDebug] MemRangeSize: %d\n",
+	       list_size);
+	printk(KERN_INFO "[SafeFetch][ModuleDebug] Mem Struct Size: %ld\n",
+	       sizeof(struct mem_range));
+	printk("[SafeFetch][ModuleDebug] Number of double fetches: %lld\n",
+	       DF_SYSCALL_FETCHES);
+	printk(KERN_INFO
+	       "[SafeFetch][ModuleDebug]>====End of mem_range_dump(LLIST)====<\n");
+}
+
+static inline void __dump_range_ll(unsigned long long start)
+{
+	struct list_head *item;
+	struct mem_range *next_range;
+	int i, size;
+
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG)
+		return;
+	printk(KERN_INFO
+	       "[SafeFetch][ModuleDebug]>====Start of dump_range====<\n");
+	list_for_each(item, &(SAFEFETCH_HEAD_NODE_LL(current))) {
+		next_range = list_entry(item, struct mem_range,
+					SAFEFETCH_NODE_MEMBER_LL);
+		if (next_range->mr_begin == start) {
+			size = next_range->mr_end - next_range->mr_begin + 1;
+			for (i = 0; i < size; i++) {
+				if ((i % 8) == 0)
+					printk("\n");
+				printk(KERN_CONT "0x%x ",
+				       *((unsigned char
+						  *)(next_range->mr_prot_loc +
+						     i)));
+			}
+			printk("\n");
+			break;
+		}
+	}
+
+	printk(KERN_INFO
+	       "[SafeFetch][ModuleDebug]>====End of dump_range====<\n");
+}
+
+static inline void __dump_range_stats_ll(int *range_size,
+					 unsigned long long *avg_size)
+{
+	struct list_head *item;
+	struct mem_range *next_range;
+	int rsize = 0;
+	uint64_t msize = 0;
+
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+		*range_size = 0;
+		*avg_size = 0;
+		return;
+	}
+	list_for_each(item, &(SAFEFETCH_HEAD_NODE_LL(current))) {
+		next_range = list_entry(item, struct mem_range,
+					SAFEFETCH_NODE_MEMBER_LL);
+		msize += next_range->mr_end - next_range->mr_begin + 1;
+		rsize++;
+	}
+
+	*range_size = rsize;
+	*avg_size = (unsigned long long)msize / rsize;
+}
+
+static inline void __dump_range_stats_extended_ll(int *range_size,
+						  uint64_t *min_size,
+						  uint64_t *max_size,
+						  unsigned long long *avg_size,
+						  uint64_t *total_size)
+{
+	struct list_head *item;
+	struct mem_range *next_range;
+	int rsize = 0;
+	uint64_t msize = 0, intermediate_size = 0;
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+		*range_size = 0;
+		*min_size = 0;
+		*max_size = 0;
+		*avg_size = 0;
+		*total_size = 0;
+		return;
+	}
+	*min_size = 0;
+	*max_size = 0;
+	list_for_each(item, &(SAFEFETCH_HEAD_NODE_LL(current))) {
+		next_range = list_entry(item, struct mem_range,
+					SAFEFETCH_NODE_MEMBER_LL);
+		intermediate_size =
+			next_range->mr_end - next_range->mr_begin + 1;
+		msize += intermediate_size;
+		if (intermediate_size > *max_size)
+			*max_size = intermediate_size;
+		if (*min_size == 0 || (*min_size > intermediate_size))
+			*min_size = intermediate_size;
+		rsize++;
+	}
+
+	*range_size = rsize;
+	*total_size = msize;
+	*avg_size = (unsigned long long)msize / rsize;
+}
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+/* #warning "Debuggin Page Pinning" */
+static inline void __check_pins_ll(void)
+{
+	struct list_head *item;
+	struct mem_range *next_range;
+	size_t size;
+	void *intermediate_buff;
+	int val;
+
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG)
+		return;
+
+	list_for_each(item, &(SAFEFETCH_HEAD_NODE_LL(current))) {
+		next_range = list_entry(item, struct mem_range,
+					SAFEFETCH_NODE_MEMBER_LL);
+		if (next_range->is_trap) {
+			size = next_range->mr_end - next_range->mr_begin + 1;
+			intermediate_buff = kmalloc(size, GFP_KERNEL);
+			copy_from_page_pin(
+				intermediate_buff,
+				(unsigned long long)next_range->mr_prot_loc,
+				size);
+			if ((val = memcmp(intermediate_buff,
+					  next_range->mr_check_loc, size)) !=
+			    0) {
+				printk("[SafeFetch][Page_Pinning][Sys %d][Comm %s] Buffers Differ At Some point %d %ld\n",
+				       DF_SYSCALL_NR, current->comm, val, size);
+			}
+
+			kfree(intermediate_buff);
+			kfree(next_range->mr_check_loc);
+		}
+	}
+}
+#endif
+
+#endif
+
+// Search for the first overlapping range or return the first range after which our
+// copy chunk should be placed.
+static inline struct mem_range *__search_range_ll(unsigned long long user_begin,
+						  unsigned long long user_end)
+{
+	struct list_head *item;
+	struct mem_range *next_range, *prev_range;
+
+	prev_range = NULL;
+
+	list_for_each(item, &(SAFEFETCH_HEAD_NODE_LL(current))) {
+		next_range = list_entry(item, struct mem_range,
+					SAFEFETCH_NODE_MEMBER_LL);
+		// Range fully encapsulates our requested copy chunk.
+		if (likely((user_begin > next_range->mr_end))) {
+			// Remember last range.
+			prev_range = next_range;
+			continue;
+		} else if (likely((user_end < next_range->mr_begin))) {
+			// Return previous range.
+			break;
+		} else if (next_range->mr_begin <= user_begin &&
+			   next_range->mr_end >= user_end) {
+			next_range->overlapping = df_range_encapsulates;
+			return next_range;
+		} else {
+			//  In this case the memory region intersects our user buffer.
+			// ((user_begin <= next_range->mr_begin && user_end >= next_range->mr_begin) or
+			// (next_range->mr_end <= user_end && next_range->mr_end >= user_begin))
+			next_range->overlapping = df_range_overlaps;
+			return next_range;
+		}
+	}
+
+	if (prev_range) {
+		/* We are returning the range after which we must add the new chunk */
+		prev_range->overlapping = df_range_previous;
+	}
+
+#if defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) || defined(SAFEFETCH_STATIC_KEYS)
+	// We are about to add a new range in the link list, increment the counter
+	// If we reached the watermark on the next copy from user we switch to the
+	// rb-tree implementation.
+	IF_SAFEFETCH_STATIC_BRANCH_LIKELY_WRAPPER(safefetch_adaptive_key)
+	{
+		SAFEFETCH_INCREMENT_COPIES(current);
+	}
+#endif
+
+	return prev_range;
+}
+// @mr position from where we start copying into the new mr
+// @new_mr new memory region where we will copy old mrs.
+static inline void __defragment_mr_ll(struct mem_range *new_mr,
+				      struct mem_range *mr)
+{
+	struct mem_range *mr_next;
+	unsigned long long split_mr_begin, mr_offset, mr_size;
+#ifdef SAFEFETCH_DEBUG
+	unsigned long long nranges = 0, nbytes = 0;
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+	size_t new_size;
+	char *intermediary;
+#endif
+#endif
+
+	// Add our new_mr just before the first mr we will remove.
+	list_add_tail(&(SAFEFETCH_MR_NODE_LL(new_mr)),
+		      &(SAFEFETCH_MR_NODE_LL(mr)));
+
+#if defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) || defined(SAFEFETCH_STATIC_KEYS)
+	// We are about to add a new range in the link list, increment the counter
+	// If we reached the watermark on the next copy from user we switch to the
+	// rb-tree implementation.
+	IF_SAFEFETCH_STATIC_BRANCH_LIKELY_WRAPPER(safefetch_adaptive_key)
+	{
+		SAFEFETCH_INCREMENT_COPIES(current);
+	}
+#endif
+
+	// Iterate over all previous mrs that span across the user buffer and
+	// copy these mrs into the new mr.
+	list_for_each_entry_safe_from(mr, mr_next,
+				      &(SAFEFETCH_HEAD_NODE_LL(current)),
+				      SAFEFETCH_NODE_MEMBER_LL) {
+		// This might be the last mr that must be patched.
+		// If not this is past the user buffer address so simply break the loop
+		// as all remaining ranges are past this.
+		if (mr->mr_end > new_mr->mr_end) {
+			// The beginning of the new Split mr will be new_mr->mr_end + 1.
+			split_mr_begin = new_mr->mr_end + 1;
+			// Split mr only if this is the last mr that intersects the user buffer.
+			if (split_mr_begin > mr->mr_begin) {
+				// Copy [mr->mr_begin, split_mr_begin) to the new protection range
+				mr_offset = mr->mr_begin - new_mr->mr_begin;
+				mr_size = split_mr_begin - mr->mr_begin;
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+				if (!mr->is_trap)
+					memcpy(new_mr->mr_prot_loc + mr_offset,
+					       mr->mr_prot_loc, mr_size);
+				else
+					copy_from_page_pin(
+						new_mr->mr_prot_loc + mr_offset,
+						(unsigned long long)
+							mr->mr_prot_loc,
+						mr_size);
+
+#else
+				memcpy(new_mr->mr_prot_loc + mr_offset,
+				       mr->mr_prot_loc, mr_size);
+#endif
+
+				// Split the old mr
+				mr->mr_prot_loc =
+					(char *)(mr->mr_prot_loc + mr_size);
+				mr->mr_begin = split_mr_begin;
+#ifdef SAFEFETCH_DEBUG
+
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+				// In case we do defragmentation adjust the check location.
+				new_size = mr->mr_end - mr->mr_begin + 1;
+				intermediary = kmalloc(new_size, GFP_ATOMIC);
+				memcpy(intermediary, mr->mr_check_loc + mr_size,
+				       new_size);
+				kfree(mr->mr_check_loc);
+				mr->mr_check_loc = intermediary;
+#endif
+
+				nranges++;
+				nbytes += mr_size;
+				SAFEFETCH_DEBUG_LOG(
+					SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY +
+						1,
+					"[SafeFetch][Info][Task %s][Sys %d]  defragment_mem_range: [0x%llx] Split Fragment at 0x%llx of size 0x%llx\n",
+					current->comm, DF_SYSCALL_NR,
+					new_mr->mr_begin, mr->mr_begin,
+					mr_size);
+#endif
+			}
+			// If not this mr is past the user buffer so don't do anything.
+
+			break;
+		}
+		/* Copy previous mr to the new mr */
+		mr_offset = mr->mr_begin - new_mr->mr_begin;
+		mr_size = mr->mr_end - mr->mr_begin + 1;
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+		if (!mr->is_trap)
+			memcpy(new_mr->mr_prot_loc + mr_offset, mr->mr_prot_loc,
+			       mr_size);
+		else
+			copy_from_page_pin(new_mr->mr_prot_loc + mr_offset,
+					   (unsigned long long)mr->mr_prot_loc,
+					   mr_size);
+#else
+		memcpy(new_mr->mr_prot_loc + mr_offset, mr->mr_prot_loc,
+		       mr_size);
+#endif
+
+#if defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) || defined(SAFEFETCH_STATIC_KEYS)
+		// We are about to add a new range in the link list, increment the counter
+		// If we reached the watermark on the next copy from user we switch to the
+		// rb-tree implementation.
+		IF_SAFEFETCH_STATIC_BRANCH_LIKELY_WRAPPER(
+			safefetch_adaptive_key)
+		{
+			SAFEFETCH_DECREMENT_COPIES(current);
+		}
+#endif
+		/*  Remove this range now */
+		list_del(&(SAFEFETCH_MR_NODE_LL(mr)));
+
+#ifdef SAFEFETCH_DEBUG
+		nranges++;
+		nbytes += mr_size;
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 1,
+			"[SafeFetch][Info][Task %s][Sys %d]  defragment_mem_range: [0x%llx] Fragment at 0x%llx of size 0x%llx\n",
+			current->comm, DF_SYSCALL_NR, new_mr->mr_begin,
+			mr->mr_begin, mr_size);
+#endif
+	}
+
+	SAFEFETCH_DEBUG_LOG(
+		SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 1,
+		"[SafeFetch][Info][Task %s][Sys %d]  defragment_mem_range: Defragmented %lld ranges totaling 0x%llx bytes for 0x%llx\n",
+		current->comm, DF_SYSCALL_NR, nranges, nbytes,
+		new_mr->mr_begin);
+}
+
+#endif // !defined(SAFEFETCH_RBTREE_MEM_RANGE)
+
+#if defined(SAFEFETCH_RBTREE_MEM_RANGE) ||       \
+	defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) || \
+	defined(SAFEFETCH_STATIC_KEYS)
+
+#ifdef SAFEFETCH_DEBUG
+// Just a small test to see that the rb_trees are indeed resonably balanced.
+// Walk the rb-tree first left then right and output the sizes.
+static noinline void __mem_range_debug_balance(void)
+{
+	unsigned int depth;
+	struct rb_node *mr_node = (&SAFEFETCH_HEAD_NODE_RB(current))->rb_node;
+
+	depth = 0;
+	while (mr_node) {
+		depth++;
+		mr_node = mr_node->rb_left;
+	}
+
+	printk(KERN_INFO "[SafeFetch][ModuleDebug] Depth_left: %d\n", depth);
+
+	mr_node = (&SAFEFETCH_HEAD_NODE_RB(current))->rb_node;
+	depth = 0;
+	while (mr_node) {
+		mr_node = mr_node->rb_right;
+		depth++;
+	}
+
+	printk(KERN_INFO "[SafeFetch][ModuleDebug] Depth_right: %d\n", depth);
+}
+
+static inline void __mem_range_dump_rb(void)
+{
+	struct rb_node *mr_node;
+	struct mem_range *next_range;
+	unsigned int list_size = 0;
+
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG)
+		return;
+	printk(KERN_INFO
+	       "[SafeFetch][ModuleDebug]>====Start of mem_range_dump(RBTREE)====<\n");
+	mr_node = rb_first(&SAFEFETCH_HEAD_NODE_RB(current));
+	do {
+		next_range = rb_entry(mr_node, struct mem_range,
+				      SAFEFETCH_NODE_MEMBER_RB);
+		printk(KERN_INFO
+		       "[SafeFetch][ModuleDebug] [0x%llx - 0x%llx] size: 0x%llx\n",
+		       next_range->mr_begin, next_range->mr_end,
+		       next_range->mr_end - next_range->mr_begin + 1);
+		mr_node = rb_next(&SAFEFETCH_MR_NODE_RB(next_range));
+		list_size++;
+
+	} while (mr_node);
+
+	printk(KERN_INFO "[SafeFetch][ModuleDebug] MemRangeSize: %d\n",
+	       list_size);
+	printk("[SafeFetch][ModuleDebug] Number of double fetches: %lld\n",
+	       DF_SYSCALL_FETCHES);
+	printk(KERN_INFO "[SafeFetch][ModuleDebug] Mem Struct Size: %ld\n",
+	       sizeof(struct mem_range));
+	__mem_range_debug_balance();
+	printk(KERN_INFO
+	       "[SafeFetch][ModuleDebug]>====End of mem_range_dump(RBTREE)====<\n");
+}
+
+static inline void __dump_range_rb(unsigned long long start)
+{
+	struct rb_node *mr_node;
+	struct mem_range *next_range;
+	int i, size;
+
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG)
+		return;
+	printk(KERN_INFO
+	       "[SafeFetch][ModuleDebug]>====Start of dump_range====<\n");
+	mr_node = rb_first(&SAFEFETCH_HEAD_NODE_RB(current));
+	do {
+		next_range = rb_entry(mr_node, struct mem_range,
+				      SAFEFETCH_NODE_MEMBER_RB);
+		if (next_range->mr_begin == start) {
+			size = next_range->mr_end - next_range->mr_begin + 1;
+			for (i = 0; i < size; i++) {
+				if ((i % 8) == 0)
+					printk("\n");
+				printk(KERN_CONT "0x%x ",
+				       *((unsigned char
+						  *)(next_range->mr_prot_loc +
+						     i)));
+			}
+			printk("\n");
+			break;
+		}
+		mr_node = rb_next(&SAFEFETCH_MR_NODE_RB(next_range));
+
+	} while (mr_node);
+
+	printk(KERN_INFO
+	       "[SafeFetch][ModuleDebug]>====End of dump_range====<\n");
+}
+
+static inline void __dump_range_stats_rb(int *range_size,
+					 unsigned long long *avg_size)
+{
+	struct rb_node *mr_node;
+	struct mem_range *next_range;
+	int rsize = 0;
+	uint64_t msize = 0;
+
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+		*range_size = 0;
+		*avg_size = 0;
+		return;
+	}
+	mr_node = rb_first(&SAFEFETCH_HEAD_NODE_RB(current));
+	do {
+		next_range = rb_entry(mr_node, struct mem_range,
+				      SAFEFETCH_NODE_MEMBER_RB);
+		msize += next_range->mr_end - next_range->mr_begin + 1;
+		rsize++;
+		mr_node = rb_next(&SAFEFETCH_MR_NODE_RB(next_range));
+	} while (mr_node);
+
+	*range_size = rsize;
+	*avg_size = (unsigned long long)msize / rsize;
+}
+
+static inline void __dump_range_stats_extended_rb(int *range_size,
+						  uint64_t *min_size,
+						  uint64_t *max_size,
+						  unsigned long long *avg_size,
+						  uint64_t *total_size)
+{
+	struct rb_node *mr_node;
+	struct mem_range *next_range;
+	int rsize = 0;
+	uint64_t msize = 0, intermediate_size = 0;
+
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+		*range_size = 0;
+		*min_size = 0;
+		*max_size = 0;
+		*avg_size = 0;
+		*total_size = 0;
+		return;
+	}
+	mr_node = rb_first(&SAFEFETCH_HEAD_NODE_RB(current));
+	*min_size = 0;
+	*max_size = 0;
+	do {
+		next_range = rb_entry(mr_node, struct mem_range,
+				      SAFEFETCH_NODE_MEMBER_RB);
+		intermediate_size =
+			next_range->mr_end - next_range->mr_begin + 1;
+		msize += intermediate_size;
+		rsize++;
+		if (intermediate_size > *max_size)
+			*max_size = intermediate_size;
+		if (*min_size == 0 || (*min_size > intermediate_size))
+			*min_size = intermediate_size;
+		mr_node = rb_next(&SAFEFETCH_MR_NODE_RB(next_range));
+	} while (mr_node);
+
+	*range_size = rsize;
+	*total_size = msize;
+	*avg_size = (unsigned long long)msize / rsize;
+}
+
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+static inline void __check_pins_rb(void)
+{
+	struct mem_range *next_range;
+	struct rb_node *mr_node;
+	size_t size;
+	void *intermediate_buff;
+	int val;
+
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG)
+		return;
+
+	mr_node = rb_first(&SAFEFETCH_HEAD_NODE_RB(current));
+	do {
+		next_range = rb_entry(mr_node, struct mem_range,
+				      SAFEFETCH_NODE_MEMBER_RB);
+		if (next_range->is_trap) {
+			size = next_range->mr_end - next_range->mr_begin + 1;
+			intermediate_buff = kmalloc(size, GFP_KERNEL);
+			copy_from_page_pin(
+				intermediate_buff,
+				(unsigned long long)next_range->mr_prot_loc,
+				size);
+			if ((val = memcmp(intermediate_buff,
+					  next_range->mr_check_loc, size)) !=
+			    0) {
+				printk("[SafeFetch][Page_Pinning][Sys %d][Comm %s] Buffers Differ At Some point %d %ld\n",
+				       DF_SYSCALL_NR, current->comm, val, size);
+			}
+
+			kfree(intermediate_buff);
+			kfree(next_range->mr_check_loc);
+		}
+		mr_node = rb_next(&SAFEFETCH_MR_NODE_RB(next_range));
+	} while (mr_node);
+}
+#endif
+
+#endif
+
+// Search for the first overlapping range or return the first range after which our
+// copy chunk should be placed.
+static inline struct mem_range *__search_range_rb(unsigned long long user_begin,
+						  unsigned long long user_end)
+{
+	struct rb_node *mr_node;
+	struct mem_range *next_range, *prev_range;
+
+	prev_range = NULL;
+
+	mr_node = (&SAFEFETCH_HEAD_NODE_RB(current))->rb_node;
+
+	while (mr_node) {
+		next_range = rb_entry(mr_node, struct mem_range,
+				      SAFEFETCH_NODE_MEMBER_RB);
+		// Check if entry is on the right
+		if (likely((user_begin > next_range->mr_end))) {
+			mr_node = mr_node->rb_right;
+		}
+		// Check if entry is on the left
+		else if (likely((user_end < next_range->mr_begin))) {
+			mr_node = mr_node->rb_left;
+		}
+		// Range fully encapsulates our requested copy chunk.
+		else if (next_range->mr_begin <= user_begin &&
+			 next_range->mr_end >= user_end) {
+			next_range->overlapping = df_range_encapsulates;
+			return next_range;
+		} else {
+			//  In this case the memory region intersects our user buffer.
+			// ((user_begin <= next_range->mr_begin && user_end >= next_range->mr_begin) or
+			// (next_range->mr_end <= user_end && next_range->mr_end >= user_begin))
+			// TODO this can be further optimized if we do rb_prev in defragment_mr
+			// to save one more iteration over the RB-Tree.
+			while ((mr_node = rb_prev(mr_node))) {
+				prev_range = rb_entry(mr_node, struct mem_range,
+						      SAFEFETCH_NODE_MEMBER_RB);
+				if (prev_range->mr_end < user_begin)
+					break;
+				next_range = prev_range;
+			}
+			next_range->overlapping = df_range_overlaps;
+			return next_range;
+		}
+
+		prev_range = next_range;
+	}
+
+	if (prev_range) {
+		/* We are returning the range closest to where we need to insert the node */
+		prev_range->overlapping = df_range_previous;
+	}
+
+	return prev_range;
+}
+
+// @mr position from where we start copying into the new mr
+// @new_mr new memory region where we will copy old mrs.
+static inline void __defragment_mr_rb(struct mem_range *new_mr,
+				      struct mem_range *mr)
+{
+	struct rb_node *mr_node, *prev_node;
+	struct rb_node **position;
+	unsigned long long split_mr_begin, mr_offset, mr_size;
+#ifdef SAFEFETCH_DEBUG
+	unsigned long long nranges = 0, nbytes = 0;
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+	size_t new_size;
+	char *intermediary;
+#endif
+#endif
+
+	prev_node = NULL;
+
+	do {
+		// This might be the last mr that must be patched.
+		// If not this is past the user buffer address so simply break the loop
+		// as all remaining ranges are past this.
+		if (mr->mr_end > new_mr->mr_end) {
+			// The beginning of the new Split mr will be new_mr->mr_end + 1.
+			split_mr_begin = new_mr->mr_end + 1;
+			// Split mr only if this is the last mr that intersects the user buffer.
+			if (split_mr_begin > mr->mr_begin) {
+				// Copy [mr->mr_begin, split_mr_begin) to the new protection range
+				mr_offset = mr->mr_begin - new_mr->mr_begin;
+				mr_size = split_mr_begin - mr->mr_begin;
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+				if (!mr->is_trap)
+					memcpy(new_mr->mr_prot_loc + mr_offset,
+					       mr->mr_prot_loc, mr_size);
+				else
+					copy_from_page_pin(
+						new_mr->mr_prot_loc + mr_offset,
+						(unsigned long long)
+							mr->mr_prot_loc,
+						mr_size);
+#else
+				memcpy(new_mr->mr_prot_loc + mr_offset,
+				       mr->mr_prot_loc, mr_size);
+#endif
+
+				// Split the old mr
+				mr->mr_prot_loc =
+					(char *)(mr->mr_prot_loc + mr_size);
+				mr->mr_begin = split_mr_begin;
+#ifdef SAFEFETCH_DEBUG
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+				// In case we do defragmentation adjust the check location.
+				new_size = mr->mr_end - mr->mr_begin + 1;
+				intermediary = kmalloc(new_size, GFP_ATOMIC);
+				memcpy(intermediary, mr->mr_check_loc + mr_size,
+				       new_size);
+				kfree(mr->mr_check_loc);
+				mr->mr_check_loc = intermediary;
+#endif
+				nranges++;
+				nbytes += mr_size;
+				SAFEFETCH_DEBUG_LOG(
+					SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY +
+						1,
+					"[SafeFetch][Info][Task %s][Sys %d]  defragment_mem_range: [0x%llx] Split Fragment at 0x%llx of size 0x%llx\n",
+					current->comm, DF_SYSCALL_NR,
+					new_mr->mr_begin, mr->mr_begin,
+					mr_size);
+#endif
+			}
+			// If not this mr is past the user buffer so don't do anything.
+
+			break;
+		}
+
+		// Erase the node in the previous iteration
+		if (prev_node)
+			rb_erase(prev_node, &SAFEFETCH_HEAD_NODE_RB(current));
+
+		/* Copy previous mr to the new mr */
+		mr_offset = mr->mr_begin - new_mr->mr_begin;
+		mr_size = mr->mr_end - mr->mr_begin + 1;
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+		if (!mr->is_trap)
+			memcpy(new_mr->mr_prot_loc + mr_offset, mr->mr_prot_loc,
+			       mr_size);
+		else
+			copy_from_page_pin(new_mr->mr_prot_loc + mr_offset,
+					   (unsigned long long)mr->mr_prot_loc,
+					   mr_size);
+#else
+		memcpy(new_mr->mr_prot_loc + mr_offset, mr->mr_prot_loc,
+		       mr_size);
+#endif
+
+#ifdef SAFEFETCH_DEBUG
+		nranges++;
+		nbytes += mr_size;
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 1,
+			"[SafeFetch][Info][Task %s][Sys %d]  defragment_mem_range: [0x%llx] Fragment at 0x%llx of size 0x%llx\n",
+			current->comm, DF_SYSCALL_NR, new_mr->mr_begin,
+			mr->mr_begin, mr_size);
+#endif
+
+		mr_node = rb_next(&SAFEFETCH_MR_NODE_RB(mr));
+
+		// Keep track of previous mr node.
+		prev_node = &SAFEFETCH_MR_NODE_RB(mr);
+
+		mr = (mr_node) ? rb_entry(mr_node, struct mem_range,
+					  SAFEFETCH_NODE_MEMBER_RB) :
+				 NULL;
+
+	} while (mr);
+
+	if (prev_node) {
+		// If we have a previous node, then replace it with our new node.
+		rb_replace_node(prev_node, &SAFEFETCH_MR_NODE_RB(new_mr),
+				&SAFEFETCH_HEAD_NODE_RB(current));
+	} else {
+		// If not then we split the previous mr, which now is exactly the mr before which we need to include our new node.
+		prev_node = &(SAFEFETCH_MR_NODE_RB(mr));
+		position = &(prev_node->rb_left);
+		while ((*position)) {
+			prev_node = *position;
+			position = &((*position)->rb_right);
+		}
+		rb_link_node(&SAFEFETCH_MR_NODE_RB(new_mr), prev_node,
+			     position);
+		rb_insert_color(&SAFEFETCH_MR_NODE_RB(new_mr),
+				&SAFEFETCH_HEAD_NODE_RB(current));
+	}
+
+	SAFEFETCH_DEBUG_LOG(
+		SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 1,
+		"[SafeFetch][Info][Task %s][Sys %d]  defragment_mem_range: Defragmented %lld ranges totaling 0x%llx bytes for 0x%llx\n",
+		current->comm, DF_SYSCALL_NR, nranges, nbytes,
+		new_mr->mr_begin);
+}
+#endif // defined(SAFEFETCH_RBTREE_MEM_RANGE) || defined(SAFEFETCH_ADAPTIVE_MEM_RANGE)
+
+#if !defined(SAFEFETCH_RBTREE_MEM_RANGE) &&       \
+	!defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) && \
+	!defined(SAFEFETCH_STATIC_KEYS)
+// Link List main hooks
+
+struct mem_range *search_range(unsigned long long user_begin,
+			       unsigned long long user_end)
+{
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_TRACING)
+#ifndef SAFEFETCH_JUST_INTERRUPTS_WHILE_TASK_BLOCKED
+	warn_dfcache_use();
+#endif
+	warn_dfcache_use_on_blocked();
+#endif
+	/* We could replace this with a bit check on the current struct */
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+		/* Lazy initialization of metadata/data regions */
+		if (unlikely(!initialize_regions()))
+			return NULL;
+		SAFEFETCH_MEM_RANGE_ROOT_INIT_LL();
+		return NULL;
+	}
+
+	return __search_range_ll(user_begin, user_end);
+}
+
+void defragment_mr(struct mem_range *new_mr, struct mem_range *mr)
+{
+	__defragment_mr_ll(new_mr, mr);
+}
+
+#ifdef SAFEFETCH_DEBUG
+
+void dump_range_stats(int *range_size, unsigned long long *avg_size)
+{
+	__dump_range_stats_ll(range_size, avg_size);
+}
+
+void mem_range_dump(void)
+{
+	__mem_range_dump_ll();
+}
+
+void dump_range(unsigned long long start)
+{
+	__dump_range_ll(start);
+}
+
+void dump_range_stats_extended(int *range_size, uint64_t *min_size,
+			       uint64_t *max_size, unsigned long long *avg_size,
+			       uint64_t *total_size)
+{
+	__dump_range_stats_extended_ll(range_size, min_size, max_size, avg_size,
+				       total_size);
+}
+
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+void check_pins(void)
+{
+	__check_pins_ll();
+}
+#endif
+
+#endif
+
+#elif defined(SAFEFETCH_RBTREE_MEM_RANGE)
+// NOTES: RB-tree main hooks
+
+struct mem_range *search_range(unsigned long long user_begin,
+			       unsigned long long user_end)
+{
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_TRACING)
+#ifndef SAFEFETCH_JUST_INTERRUPTS_WHILE_TASK_BLOCKED
+	warn_dfcache_use();
+#endif
+	warn_dfcache_use_on_blocked();
+#endif
+
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+		if (unlikely(!initialize_regions()))
+			return NULL;
+		SAFEFETCH_MEM_RANGE_ROOT_INIT_RB();
+		return NULL;
+	}
+
+	return __search_range_rb(user_begin, user_end);
+}
+
+void defragment_mr(struct mem_range *new_mr, struct mem_range *mr)
+{
+	__defragment_mr_rb(new_mr, mr);
+}
+
+#ifdef SAFEFETCH_DEBUG
+
+void dump_range_stats(int *range_size, unsigned long long *avg_size)
+{
+	__dump_range_stats_rb(range_size, avg_size);
+}
+
+void mem_range_dump(void)
+{
+	__mem_range_dump_rb();
+}
+
+void dump_range(unsigned long long start)
+{
+	__dump_range_rb(start);
+}
+
+void dump_range_stats_extended(int *range_size, uint64_t *min_size,
+			       uint64_t *max_size, unsigned long long *avg_size,
+			       uint64_t *total_size)
+{
+	__dump_range_stats_extended_rb(range_size, min_size, max_size, avg_size,
+				       total_size);
+}
+
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+void check_pins(void)
+{
+	__check_pins_rb();
+}
+#endif
+
+#endif
+
+#else
+// NOTES: Adaptive implementation hooks.
+#define CONVERT_LIMIT (SAFEFETCH_ADAPTIVE_WATERMARK + 1)
+
+noinline void convert_to_rbtree(uint8_t nelem)
+{
+	uint8_t i, step, parent, level;
+	struct list_head *item;
+#if defined(SAFEFETCH_FLOATING_ADAPTIVE_WATERMARK) && \
+	defined(SAFEFETCH_STATIC_KEYS)
+	struct mem_range *range_vector[64];
+#else
+	struct mem_range *range_vector[CONVERT_LIMIT];
+#endif
+	i = 1;
+	list_for_each(item, &(SAFEFETCH_HEAD_NODE_LL(current))) {
+		range_vector[i++] = list_entry(item, struct mem_range,
+					       SAFEFETCH_NODE_MEMBER_LL);
+	}
+
+	level = nelem >> 1;
+	SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT_RB(range_vector[level]);
+
+	while ((level = level >> 1)) {
+		step = level << 2;
+		for (i = level; i < nelem; i += step) {
+			parent = i + level;
+			rb_link_node(
+				&SAFEFETCH_MR_NODE_RB(range_vector[i]),
+				&SAFEFETCH_MR_NODE_RB(range_vector[parent]),
+				&(SAFEFETCH_MR_NODE_RB(range_vector[parent])
+					  .rb_left));
+			rb_insert_color(&SAFEFETCH_MR_NODE_RB(range_vector[i]),
+					&SAFEFETCH_HEAD_NODE_RB(current));
+			rb_link_node(
+				&SAFEFETCH_MR_NODE_RB(
+					range_vector[parent + level]),
+				&SAFEFETCH_MR_NODE_RB(range_vector[parent]),
+				&(SAFEFETCH_MR_NODE_RB(range_vector[parent])
+					  .rb_right));
+			rb_insert_color(&SAFEFETCH_MR_NODE_RB(
+						range_vector[parent + level]),
+					&SAFEFETCH_HEAD_NODE_RB(current));
+		}
+	}
+}
+
+safefetch_inline_attr struct mem_range *
+__search_range_rb_noinline_hook(unsigned long long user_begin,
+				unsigned long long user_end)
+{
+	return __search_range_rb(user_begin, user_end);
+}
+
+safefetch_inline_attr struct mem_range *
+__search_range_ll_noinline_hook(unsigned long long user_begin,
+				unsigned long long user_end)
+{
+	return __search_range_ll(user_begin, user_end);
+}
+
+safefetch_inline_attr void
+__defragment_mr_ll_noinline_hook(struct mem_range *new_mr, struct mem_range *mr)
+{
+	__defragment_mr_ll(new_mr, mr);
+}
+
+safefetch_inline_attr void
+__defragment_mr_rb_noinline_hook(struct mem_range *new_mr, struct mem_range *mr)
+{
+	__defragment_mr_rb(new_mr, mr);
+}
+
+static inline struct mem_range *
+__search_range_adaptive(unsigned long long user_begin,
+			unsigned long long user_end)
+{
+
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_TRACING)
+#ifndef SAFEFETCH_JUST_INTERRUPTS_WHILE_TASK_BLOCKED
+	warn_dfcache_use();
+#endif
+	warn_dfcache_use_on_blocked();
+#endif
+
+	/* We could replace this with a bit check on the current struct */
+	if (!SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+		/* Lazy initialization of metadata/data regions */
+		if (unlikely(!initialize_regions()))
+			return NULL;
+		SAFEFETCH_MEM_RANGE_ROOT_INIT_LL();
+		SAFEFETCH_RESET_ADAPTIVE(current);
+		SAFEFETCH_RESET_COPIES(current);
+		return NULL;
+	}
+
+	if (likely(!SAFEFETCH_IS_ADAPTIVE(current))) {
+		// Move previous check outside of function. This helps
+		if (SAFEFETCH_CHECK_COPIES(current)) {
+			SAFEFETCH_SET_ADAPTIVE(current);
+			// TODO Build rb-tree.
+			convert_to_rbtree(CONVERT_LIMIT);
+			// Now search the new range in the rb-tree
+			return __search_range_rb_noinline_hook(user_begin,
+							       user_end);
+		}
+
+		return __search_range_ll_noinline_hook(user_begin, user_end);
+	}
+
+	return __search_range_rb_noinline_hook(user_begin, user_end);
+}
+
+static inline void __defragment_mr_adaptive(struct mem_range *new_mr,
+					    struct mem_range *mr)
+{
+	likely(!SAFEFETCH_IS_ADAPTIVE(current)) ?
+		__defragment_mr_ll_noinline_hook(new_mr, mr) :
+		__defragment_mr_rb_noinline_hook(new_mr, mr);
+}
+
+#ifdef SAFEFETCH_DEBUG
+
+static inline void __dump_range_stats_adaptive(int *range_size,
+					       unsigned long long *avg_size)
+{
+	!SAFEFETCH_IS_ADAPTIVE(current) ?
+		__dump_range_stats_ll(range_size, avg_size) :
+		__dump_range_stats_rb(range_size, avg_size);
+}
+
+static inline void __mem_range_dump_adaptive(void)
+{
+	!SAFEFETCH_IS_ADAPTIVE(current) ? __mem_range_dump_ll() :
+					  __mem_range_dump_rb();
+}
+
+static inline void __dump_range_adaptive(unsigned long long start)
+{
+	!SAFEFETCH_IS_ADAPTIVE(current) ? __dump_range_ll(start) :
+					  __dump_range_rb(start);
+}
+
+void __dump_range_stats_extended_adaptive(int *range_size, uint64_t *min_size,
+					  uint64_t *max_size,
+					  unsigned long long *avg_size,
+					  uint64_t *total_size)
+{
+	!SAFEFETCH_IS_ADAPTIVE(current) ?
+		__dump_range_stats_extended_ll(range_size, min_size, max_size,
+					       avg_size, total_size) :
+		__dump_range_stats_extended_rb(range_size, min_size, max_size,
+					       avg_size, total_size);
+}
+
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+static void __check_pins_adaptive(void)
+{
+	!SAFEFETCH_IS_ADAPTIVE(current) ? __check_pins_ll() : __check_pins_rb();
+}
+#endif
+
+#endif
+
+#if defined(SAFEFETCH_ADAPTIVE_MEM_RANGE)
+// Adittional layer of indirection (so we can use the previous hooks in the static key
+// implementation.
+struct mem_range *search_range(unsigned long long user_begin,
+			       unsigned long long user_end)
+{
+	return __search_range_adaptive(user_begin, user_end);
+}
+
+void defragment_mr(struct mem_range *new_mr, struct mem_range *mr)
+{
+	__defragment_mr_adaptive(new_mr, mr);
+}
+
+#ifdef SAFEFETCH_DEBUG
+
+void dump_range_stats(int *range_size, unsigned long long *avg_size)
+{
+	__dump_range_stats_adaptive(range_size, avg_size);
+}
+
+void mem_range_dump(void)
+{
+	__mem_range_dump_adaptive();
+}
+
+void dump_range(unsigned long long start)
+{
+	__dump_range_adaptive(start);
+}
+
+void dump_range_stats_extended(int *range_size, uint64_t *min_size,
+			       uint64_t *max_size, unsigned long long *avg_size,
+			       uint64_t *total_size)
+{
+	__dump_range_stats_extended_adaptive(range_size, min_size, max_size,
+					     avg_size, total_size);
+}
+
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+void check_pins(void)
+{
+	__check_pins_adaptive();
+}
+#endif
+#endif
+
+#elif defined(SAFEFETCH_STATIC_KEYS) // SAFEFETCH_ADAPTIVE_MEM_RANGE
+// TODO Static key implementation goes here.
+struct mem_range *search_range(unsigned long long user_begin,
+			       unsigned long long user_end)
+{
+	// Make this wrapper unlikely so we balance the extra jumps added by
+	// the static key implementation to all defense versions.
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_adaptive_key)
+	{
+		return __search_range_adaptive(user_begin, user_end);
+	} else {
+		// If the rb-tree key is on make this branch unlikely so we incur
+		// one jump if we fall-through here (safefetch_adaptive_key == False)
+		// We will force a jump in the link list implementation by forcing
+		// the extra adaptive implementation in the link-list as likely.
+		IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(
+			safefetch_rbtree_key)
+		{
+			if (!SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+				if (unlikely(!initialize_regions()))
+					return NULL;
+				SAFEFETCH_MEM_RANGE_ROOT_INIT_RB();
+				return NULL;
+			}
+			return __search_range_rb(user_begin, user_end);
+		} else {
+			// The else branch is simply the link list implementation.
+			if (!SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+				/* Lazy initialization of metadata/data regions */
+				if (unlikely(!initialize_regions()))
+					return NULL;
+				SAFEFETCH_MEM_RANGE_ROOT_INIT_LL();
+				return NULL;
+			}
+			return __search_range_ll(user_begin, user_end);
+		}
+	}
+}
+void defragment_mr(struct mem_range *new_mr, struct mem_range *mr)
+{
+	// Make this wrapper unlikely so we balance the extra jumps added by
+	// the static key implementation to all defense versions.
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_adaptive_key)
+	{
+		__defragment_mr_adaptive(new_mr, mr);
+		return;
+	} else {
+		// If the rb-tree key is on make this branch unlikely so we incur
+		// one jump if we fall-through here (safefetch_adaptive_key == False)
+		// We will force a jump in the link list implementation by forcing
+		// the extra adaptive implementation in the link-list as likely.
+		IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(
+			safefetch_rbtree_key)
+		{
+			__defragment_mr_rb(new_mr, mr);
+			return;
+		} else {
+			// The else branch is simply the link list implementation.
+			__defragment_mr_ll(new_mr, mr);
+			return;
+		}
+	}
+}
+
+#ifdef SAFEFETCH_DEBUG
+
+void dump_range_stats(int *range_size, unsigned long long *avg_size)
+{
+	// Make this wrapper unlikely so we balance the extra jumps added by
+	// the static key implementation to all defense versions.
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_adaptive_key)
+	{
+		__dump_range_stats_adaptive(range_size, avg_size);
+	} else {
+		// If the rb-tree key is on make this branch unlikely so we incur
+		// one jump if we fall-through here (safefetch_adaptive_key == False)
+		// We will force a jump in the link list implementation by forcing
+		// the extra adaptive implementation in the link-list as likely.
+		IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(
+			safefetch_rbtree_key)
+		{
+			__dump_range_stats_rb(range_size, avg_size);
+		} else {
+			// The else branch is simply the link list implementation.
+			__dump_range_stats_ll(range_size, avg_size);
+		}
+	}
+}
+
+void mem_range_dump(void)
+{
+	// Make this wrapper unlikely so we balance the extra jumps added by
+	// the static key implementation to all defense versions.
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_adaptive_key)
+	{
+		__mem_range_dump_adaptive();
+	} else {
+		// If the rb-tree key is on make this branch unlikely so we incur
+		// one jump if we fall-through here (safefetch_adaptive_key == False)
+		// We will force a jump in the link list implementation by forcing
+		// the extra adaptive implementation in the link-list as likely.
+		IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(
+			safefetch_rbtree_key)
+		{
+			__mem_range_dump_rb();
+		} else {
+			// The else branch is simply the link list implementation.
+			__mem_range_dump_ll();
+		}
+	}
+}
+
+void dump_range(unsigned long long start)
+{
+	// Make this wrapper unlikely so we balance the extra jumps added by
+	// the static key implementation to all defense versions.
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_adaptive_key)
+	{
+		__dump_range_adaptive(start);
+	} else {
+		// If the rb-tree key is on make this branch unlikely so we incur
+		// one jump if we fall-through here (safefetch_adaptive_key == False)
+		// We will force a jump in the link list implementation by forcing
+		// the extra adaptive implementation in the link-list as likely.
+		IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(
+			safefetch_rbtree_key)
+		{
+			__dump_range_rb(start);
+		} else {
+			// The else branch is simply the link list implementation.
+			__dump_range_ll(start);
+		}
+	}
+}
+
+void dump_range_stats_extended(int *range_size, uint64_t *min_size,
+			       uint64_t *max_size, unsigned long long *avg_size,
+			       uint64_t *total_size)
+{
+	// Make this wrapper unlikely so we balance the extra jumps added by
+	// the static key implementation to all defense versions.
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_adaptive_key)
+	{
+		__dump_range_stats_extended_adaptive(
+			range_size, min_size, max_size, avg_size, total_size);
+	} else {
+		// If the rb-tree key is on make this branch unlikely so we incur
+		// one jump if we fall-through here (safefetch_adaptive_key == False)
+		// We will force a jump in the link list implementation by forcing
+		// the extra adaptive implementation in the link-list as likely.
+		IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(
+			safefetch_rbtree_key)
+		{
+			__dump_range_stats_extended_rb(range_size, min_size,
+						       max_size, avg_size,
+						       total_size);
+		} else {
+			// The else branch is simply the link list implementation.
+			__dump_range_stats_extended_ll(range_size, min_size,
+						       max_size, avg_size,
+						       total_size);
+		}
+	}
+}
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+void check_pins(void)
+{
+	// Make this wrapper unlikely so we balance the extra jumps added by
+	// the static key implementation to all defense versions.
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_adaptive_key)
+	{
+		__check_pins_adaptive();
+	} else {
+		// If the rb-tree key is on make this branch unlikely so we incur
+		// one jump if we fall-through here (safefetch_adaptive_key == False)
+		// We will force a jump in the link list implementation by forcing
+		// the extra adaptive implementation in the link-list as likely.
+		IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(
+			safefetch_rbtree_key)
+		{
+			__check_pins_rb();
+		} else {
+			// The else branch is simply the link list implementation.
+			__check_pins_ll();
+		}
+	}
+}
+#endif
+
+#endif // SAFEFETCH_DEBUG
+
+#endif // SAFEFETCH_STATIC_KEYS
+
+#endif
+
+#ifdef SAFEFETCH_DEBUG
+EXPORT_SYMBOL(dump_range);
+EXPORT_SYMBOL(mem_range_dump);
+#endif
+
+#define PATCH_COPY_FUNCTION_RETURN(user, ret) \
+	if (!(user -= ret))                   \
+	return ret
+
+// TODO Pattern this function when porting the RBTREE
+unsigned long copy_range(unsigned long long user_src,
+			 unsigned long long kern_dst, unsigned long user_size)
+{
+	/* Get nearby range */
+	unsigned long long mr_offset, user_end, new_mr_begin, new_mr_size;
+	struct mem_range *new_mr, *mr;
+	unsigned long ret;
+
+	user_end = user_src + user_size - 1;
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+	/* #warning "SafeFetch Measuring defense" */
+	MEASURE_FUNC_AND_COUNT(
+		mr = search_range(user_src, user_end);
+		, current->df_prot_struct_head.df_measures.search_time,
+		current->df_prot_struct_head.df_measures.counter);
+#else
+	/* Search for the range closest to our copy from user */
+	mr = search_range(user_src, user_end);
+#endif
+
+	/* If no mr we either have no ranges previously copied from user or all ranges are
+	 * larger than this range. Add the range at beginning of the list.
+	 * In case of a RB-Tree if mr == NULL then we have an empty RB-Tree so add
+	 * the new mr as root.
+	 */
+	if (!mr) {
+		/* Default to a normal copy and add range into the datastructure */
+
+		/* First copy everything in the kernel destination just in case we
+		 * copy less then the specified ammount of bytes
+		 */
+		ret = COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				user_size);
+
+		/* If ret != 0 we haven't copied all bytes so trim the size of the buffer. */
+		if (ret) {
+			SAFEFETCH_DEBUG_LOG(
+				SAFEFETCH_LOG_WARNING,
+				"[SafeFetch][Warning][Task %s][Sys %d] copy_range: Copied less bytes required(0x%lx bytes) copied(0x%lx bytes)\n",
+				current->comm, DF_SYSCALL_NR, user_size,
+				user_size - ret);
+			//user_size -= ret;
+			PATCH_COPY_FUNCTION_RETURN(user_size, ret);
+		}
+
+		new_mr = create_mem_range(user_src, user_size);
+
+		/* Now simply returns -1 */
+		ASSERT_OUT_OF_MEMORY(new_mr);
+
+		/* Add the node at the beginning */
+		//list_add(&(new_mr->node), &(SAFEFETCH_HEAD_NODE));
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+		MEASURE_FUNC(
+			SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT(new_mr);
+			, current->df_prot_struct_head.df_measures.insert_time,
+			(current->df_prot_struct_head.df_measures.counter - 1));
+#else
+		SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT(new_mr);
+#endif
+
+		memcpy(new_mr->mr_prot_loc, (void *)kern_dst, user_size);
+
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 3,
+			"[SafeFetch][Info][Task %s][Sys %d] copy_range: Created new region @ at 0x%llx with size(0x%llx bytes)\n",
+			current->comm, DF_SYSCALL_NR, new_mr->mr_begin,
+			new_mr->mr_end - new_mr->mr_begin + 1);
+
+	} else if (mr->overlapping == df_range_previous) {
+		/* First copy everything in the kernel destination just in case we
+		 * copy less then the specified ammount of bytes
+		 */
+		ret = COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				user_size);
+
+		/* If ret != 0 we haven't copied all bytes so trim the size of the buffer. */
+		if (ret) {
+			SAFEFETCH_DEBUG_LOG(
+				SAFEFETCH_LOG_WARNING,
+				"[SafeFetch][Warning][Task %s][Sys %d] copy_range: Copied less bytes required(0x%lx bytes) copied(0x%lx bytes)\n",
+				current->comm, DF_SYSCALL_NR, user_size,
+				user_size - ret);
+			//user_size -= ret;
+			PATCH_COPY_FUNCTION_RETURN(user_size, ret);
+		}
+
+		/* Just add the range after to this one */
+		new_mr = create_mem_range(user_src, user_size);
+
+		ASSERT_OUT_OF_MEMORY(new_mr);
+
+		/* Add the node between mr and mr->next */
+		//list_add(&(new_mr->node), &(mr->node));
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+		MEASURE_FUNC(
+			SAFEFETCH_MEM_RANGE_STRUCT_INSERT(mr, new_mr);
+			, current->df_prot_struct_head.df_measures.insert_time,
+			(current->df_prot_struct_head.df_measures.counter - 1));
+#else
+		SAFEFETCH_MEM_RANGE_STRUCT_INSERT(mr, new_mr);
+#endif
+
+		/* Now copy kernel destination into the new protection structure */
+
+		memcpy(new_mr->mr_prot_loc, (void *)kern_dst, user_size);
+
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 3,
+			"[SafeFetch][Info][Task %s][Sys %d] copy_range: Created new region at 0x%llx with size(0x%llx bytes)\n",
+			current->comm, DF_SYSCALL_NR, new_mr->mr_begin,
+			new_mr->mr_end - new_mr->mr_begin + 1);
+
+	} else if (mr->overlapping == df_range_overlaps) {
+		/* Our new range goes from min(user_src, mr->mr_begin) to user_end */
+		new_mr_begin = user_src <= mr->mr_begin ? user_src :
+							  mr->mr_begin;
+		new_mr_size = user_end - new_mr_begin + 1;
+
+		new_mr = create_mem_range(new_mr_begin, new_mr_size);
+
+		ASSERT_OUT_OF_MEMORY(new_mr);
+
+		mr_offset = user_src - new_mr_begin;
+
+		// First copy-in the user buffer from userspace.
+
+		ret = COPY_FUNC(new_mr->mr_prot_loc + mr_offset,
+				(__force void *)user_src, user_size);
+
+		if (ret) {
+			SAFEFETCH_DEBUG_LOG(
+				SAFEFETCH_LOG_WARNING,
+				"[SafeFetch][Warning][Task %s][Sys %d] copy_range: Copied less bytes required(0x%lx bytes) copied(0x%lx bytes)\n",
+				current->comm, DF_SYSCALL_NR, user_size,
+				user_size - ret);
+			new_mr->mr_end -= ret;
+			// This we can optimize if we first copy in the kernel buffer and do defragmentation on the spot.
+			//user_size -= ret;
+			PATCH_COPY_FUNCTION_RETURN(user_size, ret);
+		}
+
+		// Copy fragments to new_mr and add new_mr to the data structure
+		defragment_mr(new_mr, mr);
+
+		/* Copy the new range in the kernel destination */
+		memcpy((void *)kern_dst, new_mr->mr_prot_loc + mr_offset,
+		       user_size);
+
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 1,
+			"[SafeFetch][Info][Task %s][Sys %d]  copy_range: Overlapping previous region at 0x%llx with size(0x%llx bytes) offset(0x%llx) copy(0x%lx)\n",
+			current->comm, DF_SYSCALL_NR, new_mr->mr_begin,
+			new_mr->mr_end - new_mr->mr_begin + 1, mr_offset,
+			user_size);
+
+		DF_INC_DEFRAGS;
+
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_COLLECT_VULNERABILITIES)
+		SAFEFETCH_DEBUG_RUN(5, dump_vulnerability(0));
+#endif
+
+	} else if (mr->overlapping == df_range_encapsulates) {
+		/* If range encapsulates our copy chunk then copy from range */
+		mr_offset = user_src - mr->mr_begin;
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+		if (!mr->is_trap)
+			memcpy((void *)kern_dst, mr->mr_prot_loc + mr_offset,
+			       user_size);
+		else
+			copy_from_page_pin((void *)kern_dst,
+					   (unsigned long long)mr->mr_prot_loc +
+						   mr_offset,
+					   user_size);
+#else
+		memcpy((void *)kern_dst, mr->mr_prot_loc + mr_offset,
+		       user_size);
+#endif
+
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY - 1,
+			"[SafeFetch][Info][Task %s][Sys %d] copy_range: Double fetch from region at 0x%llx with size(0x%llx bytes) offset(0x%llx)\n",
+			current->comm, DF_SYSCALL_NR, mr->mr_begin,
+			mr->mr_end - mr->mr_begin + 1, mr_offset);
+#ifdef SAFEFETCH_DEBUG
+		DF_SYSCALL_FETCHES++;
+#endif
+
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_COLLECT_VULNERABILITIES)
+		SAFEFETCH_DEBUG_RUN(5, dump_vulnerability(1));
+#endif
+		return 0;
+	}
+
+	return ret;
+}
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+// TODO Pattern this function when porting the RBTREE
+unsigned long copy_range_pinning(unsigned long long user_src,
+				 unsigned long long kern_dst,
+				 unsigned long user_size)
+{
+	/* Get nearby range */
+	unsigned long long mr_offset, user_end, new_mr_begin, new_mr_size;
+	struct mem_range *new_mr, *mr;
+	unsigned long ret;
+
+	user_end = user_src + user_size - 1;
+
+	/* Search for the range closest to our copy from user */
+	mr = search_range(user_src, user_end);
+
+	/* If no mr we either have no ranges previously copied from user or all ranges are
+	 * larger than this range. Add the range at beginning of the list.
+	 * In case of a RB-Tree if mr == NULL then we have an empty RB-Tree so add
+	 * the new mr as root.
+	 */
+	if (!mr) {
+		/* Default to a normal copy and add range into the datastructure */
+
+		/* First copy everything in the kernel destination just in case we
+		 * copy less then the specified ammount of bytes
+		 */
+		ret = COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				user_size);
+
+		/* If ret != 0 we haven't copied all bytes so trim the size of the buffer. */
+		if (ret) {
+			SAFEFETCH_DEBUG_LOG(
+				SAFEFETCH_LOG_WARNING,
+				"[SafeFetch][Warning][Task %s][Sys %d] copy_range: Copied less bytes required(0x%lx bytes) copied(0x%lx bytes)\n",
+				current->comm, DF_SYSCALL_NR, user_size,
+				user_size - ret);
+			//user_size -= ret;
+			PATCH_COPY_FUNCTION_RETURN(user_size, ret);
+		}
+
+		new_mr = create_pin_range(user_src, user_size, kern_dst);
+
+		/* Now simply returns -1 */
+		ASSERT_OUT_OF_MEMORY(new_mr);
+
+		/* Add the node at the beginning */
+		//list_add(&(new_mr->node), &(SAFEFETCH_HEAD_NODE));
+		SAFEFETCH_MEM_RANGE_STRUCT_INSERT_ROOT(new_mr);
+
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 3,
+			"[SafeFetch][Info][Task %s][Sys %d] copy_range: Created new region @ at 0x%llx with size(0x%llx bytes)\n",
+			current->comm, DF_SYSCALL_NR, new_mr->mr_begin,
+			new_mr->mr_end - new_mr->mr_begin + 1);
+
+	} else if (mr->overlapping == df_range_previous) {
+		/* First copy everything in the kernel destination just in case we
+		 * copy less then the specified ammount of bytes
+		 */
+		ret = COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				user_size);
+
+		/* If ret != 0 we haven't copied all bytes so trim the size of the buffer. */
+		if (ret) {
+			SAFEFETCH_DEBUG_LOG(
+				SAFEFETCH_LOG_WARNING,
+				"[SafeFetch][Warning][Task %s][Sys %d] copy_range: Copied less bytes required(0x%lx bytes) copied(0x%lx bytes)\n",
+				current->comm, DF_SYSCALL_NR, user_size,
+				user_size - ret);
+			//user_size -= ret;
+			PATCH_COPY_FUNCTION_RETURN(user_size, ret);
+		}
+
+		/* Just add the range after to this one */
+		new_mr = create_pin_range(user_src, user_size, kern_dst);
+
+		ASSERT_OUT_OF_MEMORY(new_mr);
+
+		/* Add the node between mr and mr->next */
+		//list_add(&(new_mr->node), &(mr->node));
+		SAFEFETCH_MEM_RANGE_STRUCT_INSERT(mr, new_mr);
+
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 3,
+			"[SafeFetch][Info][Task %s][Sys %d] copy_range: Created new region at 0x%llx with size(0x%llx bytes)\n",
+			current->comm, DF_SYSCALL_NR, new_mr->mr_begin,
+			new_mr->mr_end - new_mr->mr_begin + 1);
+
+	} else if (mr->overlapping == df_range_overlaps) {
+		/* Our new range goes from min(user_src, mr->mr_begin) to user_end */
+		new_mr_begin = user_src <= mr->mr_begin ? user_src :
+							  mr->mr_begin;
+		new_mr_size = user_end - new_mr_begin + 1;
+
+		new_mr = create_mem_range(new_mr_begin, new_mr_size);
+
+		ASSERT_OUT_OF_MEMORY(new_mr);
+
+		mr_offset = user_src - new_mr_begin;
+
+		// First copy-in the user buffer from userspace.
+
+		ret = COPY_FUNC(new_mr->mr_prot_loc + mr_offset,
+				(__force void *)user_src, user_size);
+
+		if (ret) {
+			SAFEFETCH_DEBUG_LOG(
+				SAFEFETCH_LOG_WARNING,
+				"[SafeFetch][Warning][Task %s][Sys %d] copy_range: Copied less bytes required(0x%lx bytes) copied(0x%lx bytes)\n",
+				current->comm, DF_SYSCALL_NR, user_size,
+				user_size - ret);
+			new_mr->mr_end -= ret;
+			//user_size -= ret;
+			PATCH_COPY_FUNCTION_RETURN(user_size, ret);
+		}
+
+		// Copy fragments to new_mr and add new_mr to the data structure
+		defragment_mr(new_mr, mr);
+
+		/* Copy the new range in the kernel destination */
+		memcpy((void *)kern_dst, new_mr->mr_prot_loc + mr_offset,
+		       user_size);
+
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY + 1,
+			"[SafeFetch][Info][Task %s][Sys %d]  copy_range: Overlapping previous region at 0x%llx with size(0x%llx bytes) offset(0x%llx) copy(0x%lx)\n",
+			current->comm, DF_SYSCALL_NR, new_mr->mr_begin,
+			new_mr->mr_end - new_mr->mr_begin + 1, mr_offset,
+			user_size);
+
+		DF_INC_DEFRAGS;
+
+	} else if (mr->overlapping == df_range_encapsulates) {
+		/* If range encapsulates our copy chunk then copy from range */
+		mr_offset = user_src - mr->mr_begin;
+
+		if (!mr->is_trap)
+			memcpy((void *)kern_dst, mr->mr_prot_loc + mr_offset,
+			       user_size);
+		else
+			copy_from_page_pin((void *)kern_dst,
+					   (unsigned long long)mr->mr_prot_loc +
+						   mr_offset,
+					   user_size);
+
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY - 1,
+			"[SafeFetch][Info][Task %s][Sys %d] copy_range: Double fetch from region at 0x%llx with size(0x%llx bytes) offset(0x%llx)\n",
+			current->comm, DF_SYSCALL_NR, mr->mr_begin,
+			mr->mr_end - mr->mr_begin + 1, mr_offset);
+#ifdef SAFEFETCH_DEBUG
+		DF_SYSCALL_FETCHES++;
+#endif
+		return 0;
+	}
+
+	return ret;
+}
+#endif
diff --git a/mm/safefetch/page_cache.c b/mm/safefetch/page_cache.c
new file mode 100644
index 000000000000..10e1ee9ee6f9
--- /dev/null
+++ b/mm/safefetch/page_cache.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __PAGE_CACHE_C__
+#define __PAGE_CACHE_C__
+
+#include <linux/mem_range.h>
+#include <linux/delay.h>
+#include "page_cache.h"
+
+struct kmem_cache *df_metadata_cache, *df_storage_cache;
+size_t safefetch_metadata_cache_size;
+size_t safefetch_storage_cache_size;
+uint8_t safefetch_slow_path_order;
+
+void df_init_page_alloc_array(void)
+{
+	df_metadata_cache = kmem_cache_create(
+		"df_metadata_cache", METADATA_CACHE_SIZE, 0, SLAB_PANIC, NULL);
+
+	df_storage_cache = kmem_cache_create(
+		"df_storage_cache", STORAGE_CACHE_SIZE, 0, SLAB_PANIC, NULL);
+
+	safefetch_metadata_cache_size = METADATA_CACHE_SIZE;
+	safefetch_storage_cache_size = STORAGE_CACHE_SIZE;
+
+	printk("Page_Cache: Page cache enabled\n");
+}
+
+// WARNING - this functions needs to be called with the copy_from_user hook disabled.
+// Removes all regions in tranzit so we can switch to a different cache region.
+#define MAX_WAIT_FIXUP 200000
+static void fixup_in_tranzit_regions(void)
+{
+	struct task_struct *iter, *process;
+	unsigned int cleanups = 0;
+	unsigned long wait_time;
+	unsigned int state;
+
+	/* Wait such that all processes have enough time to shrink their regions */
+	for_each_process_thread(iter, process) {
+		wait_time = 0;
+		while (SAFEFETCH_TASK_MEM_RANGE_INIT_FLAG(process)) {
+			usleep_range(10, 20);
+			wait_time++;
+			if (wait_time >= MAX_WAIT_FIXUP) {
+				state = READ_ONCE(process->__state);
+				// Who'se the hogging task and why?
+				printk(KERN_WARNING
+				       "Waited but task %s did not finish [%d %d %d %d %d 0x%x]",
+				       process->comm,
+				       state & TASK_INTERRUPTIBLE,
+				       state & TASK_DEAD, state & EXIT_TRACE,
+				       current == process,
+				       !!(process->flags & PF_KTHREAD), state);
+				// Lets force the cleanup of this task here and see if something bad happens.
+				destroy_region(DF_TASK_STORAGE_REGION_ALLOCATOR(
+					process));
+				destroy_region(
+					DF_TASK_METADATA_REGION_ALLOCATOR(
+						process));
+				SAFEFETCH_TASK_RESET_MEM_RANGE(process);
+
+				break;
+			}
+		}
+	}
+
+	/* Warning - if a task dies now we may be hitting a race condition */
+	// What we could do in case we want to force deletion ourselves it to
+	// set a bit in the task  to skip its destroy_regions.
+	for_each_process_thread(iter, process) {
+		if (!(process->flags & PF_KTHREAD)) {
+			/* Destroy some regions */
+			cleanups +=
+				(unsigned int)(DF_TASK_STORAGE_REGION_ALLOCATOR(
+						       process)
+						       ->initialized |
+					       DF_TASK_METADATA_REGION_ALLOCATOR(
+						       process)
+						       ->initialized);
+
+			destroy_region(
+				DF_TASK_STORAGE_REGION_ALLOCATOR(process));
+			destroy_region(
+				DF_TASK_METADATA_REGION_ALLOCATOR(process));
+		}
+	}
+
+	printk("We cleaned up %d regions\n", cleanups);
+}
+
+void df_resize_page_caches(size_t _metadata_size, size_t _storage_size,
+			   uint8_t _order)
+{
+	/* First destroy all in tranzit safefetch regions such that taks will
+	 * pickup regions from the newly assigned slab caches
+	 */
+	fixup_in_tranzit_regions();
+
+	/* After this we can freely reinitialize the slab caches as no task should
+	 * be using them
+	 */
+	if (_metadata_size != safefetch_metadata_cache_size) {
+		kmem_cache_destroy(df_metadata_cache);
+		df_metadata_cache = kmem_cache_create("df_metadata_cache",
+						      _metadata_size, 0,
+						      SLAB_PANIC, NULL);
+
+		safefetch_metadata_cache_size = _metadata_size;
+
+		WARN_ON(!df_metadata_cache);
+	}
+
+	if (_storage_size != safefetch_storage_cache_size) {
+		kmem_cache_destroy(df_storage_cache);
+		df_storage_cache = kmem_cache_create(
+			"df_storage_cache", _storage_size, 0, SLAB_PANIC, NULL);
+		safefetch_storage_cache_size = _storage_size;
+
+		WARN_ON(!df_storage_cache);
+	}
+
+	safefetch_slow_path_order = _order;
+
+	printk("Initialized new allocator having METADATA_SIZE: %ld STORAGE_SIZE: %ld ORDER: %d\n",
+	       safefetch_metadata_cache_size, safefetch_storage_cache_size,
+	       safefetch_slow_path_order);
+}
+
+#endif
diff --git a/mm/safefetch/page_cache.h b/mm/safefetch/page_cache.h
new file mode 100644
index 000000000000..8da14971327d
--- /dev/null
+++ b/mm/safefetch/page_cache.h
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PAGE_CACHE_H__
+#define __PAGE_CACHE_H__
+
+#include <linux/slab.h>
+#include <asm/processor.h>
+// #include <linux/processor.h> instead?
+#include "safefetch_debug.h"
+extern struct kmem_cache *df_metadata_cache, *df_storage_cache;
+
+#if 0
+#define NUM_METADATA_PAGES 1
+#define NUM_BACKING_STORAGE_PAGES 1
+#endif
+
+#ifndef METADATA_CACHE_SIZE
+#define METADATA_CACHE_SIZE PAGE_SIZE
+#else
+/* #warning Using User Supplied Cache for Metadata */
+#endif
+#ifndef STORAGE_CACHE_SIZE
+#define STORAGE_CACHE_SIZE PAGE_SIZE
+#else
+/* #warning Using User Supplied Cache for Storage */
+#endif
+
+extern size_t safefetch_metadata_cache_size, safefetch_storage_cache_size;
+extern uint8_t safefetch_slow_path_order;
+void df_init_page_alloc_array(void);
+void df_resize_page_caches(size_t _metadata_size, size_t _storage_size,
+			   uint8_t _order);
+
+#ifndef PAGE_SHIFT
+#define PAGE_SHIFT 12
+#endif
+
+enum df_cache_type { METADATA, STORAGE };
+
+static __always_inline void *df_allocate_metadata_chunk(void)
+{
+	return kmem_cache_alloc(df_metadata_cache, GFP_ATOMIC);
+}
+
+static __always_inline void *df_allocate_storage_chunk(void)
+{
+	return kmem_cache_alloc(df_storage_cache, GFP_ATOMIC);
+}
+
+static __always_inline void df_release_metadata_chunk(void *obj)
+{
+	kmem_cache_free(df_metadata_cache, obj);
+	return;
+}
+
+static __always_inline void df_release_storage_chunk(void *obj)
+{
+	kmem_cache_free(df_storage_cache, obj);
+	return;
+}
+
+static __always_inline void *df_allocate_page(u8 cache_type)
+{
+	switch (cache_type) {
+	case METADATA:
+		return df_allocate_metadata_chunk();
+	case STORAGE:
+		return df_allocate_storage_chunk();
+	}
+	return 0;
+}
+
+static __always_inline void df_free_page(void *obj, u8 cache_type)
+{
+	switch (cache_type) {
+	case METADATA:
+		df_release_metadata_chunk(obj);
+		return;
+	case STORAGE:
+		df_release_storage_chunk(obj);
+		return;
+	}
+	return;
+}
+
+static __always_inline void *df_allocate_chunk(struct kmem_cache *cache)
+{
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_LEAKS)
+	unsigned long iflags;
+
+	spin_lock_irqsave(&allocations_lock, iflags);
+	global_allocations++;
+	DF_ALLOCATIONS(current)++;
+	spin_unlock_irqrestore(&allocations_lock, iflags);
+#endif
+	gfp_t flags = unlikely(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL;
+
+	return kmem_cache_alloc(cache, flags);
+}
+
+static __always_inline void df_free_chunk(struct kmem_cache *cache, void *obj)
+{
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_LEAKS)
+	unsigned long iflags;
+
+	spin_lock_irqsave(&allocations_lock, iflags);
+	global_allocations--;
+	DF_ALLOCATIONS(current)--;
+	spin_unlock_irqrestore(&allocations_lock, iflags);
+#endif
+	kmem_cache_free(cache, obj);
+}
+
+static __always_inline void *df_allocate_chunk_slowpath(size_t size)
+{
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_LEAKS)
+	unsigned long iflags;
+
+	spin_lock_irqsave(&allocations_lock, iflags);
+	global_allocations++;
+	DF_ALLOCATIONS(current)++;
+	spin_unlock_irqrestore(&allocations_lock, iflags);
+#endif
+	gfp_t flags = unlikely(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL;
+
+	return kmalloc(size, flags);
+}
+
+static __always_inline void df_free_chunk_slowpath(void *obj)
+{
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_LEAKS)
+	unsigned long iflags;
+
+	spin_lock_irqsave(&allocations_lock, iflags);
+	global_allocations--;
+	DF_ALLOCATIONS(current)--;
+	spin_unlock_irqrestore(&allocations_lock, iflags);
+#endif
+	kfree(obj);
+}
+
+#endif
diff --git a/mm/safefetch/region_allocator.c b/mm/safefetch/region_allocator.c
new file mode 100644
index 000000000000..47c3e6c33dfa
--- /dev/null
+++ b/mm/safefetch/region_allocator.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0
+//#include <linux/region_allocator.h>
+#include "page_cache.h"
+#include <linux/mem_range.h>
+#include <linux/page_frag_cache.h>
+#include "safefetch_debug.h"
+
+#ifdef SAFEFETCH_MEASURE_MEMORY_CONSUMPTION
+/* #warning "SafeFetch: Measuring memory consumption" */
+void dump_mem_consumption(struct task_struct *tsk,
+			  unsigned long long *total_metadata_region_size,
+			  unsigned long long *total_data_region_size,
+			  unsigned long long *total_pin_size)
+{
+	struct region_allocator *allocator;
+	struct list_head *item;
+	struct mem_region *next_region;
+	struct mem_pin *next_pin;
+
+	unsigned long long total_size = 0;
+
+	allocator = DF_TASK_METADATA_REGION_ALLOCATOR(tsk);
+	if (!(allocator->initialized))
+		goto mconsume_skip;
+
+	total_size += REGION_SIZE(allocator->first);
+
+	if (!(allocator->extended))
+		goto mconsume_skip;
+	list_for_each(item, &(allocator->extra_ranges)) {
+		next_region = list_entry(item, struct mem_region, extra_ranges);
+		total_size += REGION_SIZE(next_region);
+	}
+
+mconsume_skip:
+
+	*total_metadata_region_size = total_size;
+	total_size = 0;
+
+	allocator = DF_TASK_STORAGE_REGION_ALLOCATOR(tsk);
+
+	if (!(allocator->initialized))
+		goto dconsume_skip;
+
+	total_size += REGION_SIZE(allocator->first);
+
+	if (!(allocator->extended))
+		goto dconsume_skip;
+	list_for_each(item, &(allocator->extra_ranges)) {
+		next_region = list_entry(item, struct mem_region, extra_ranges);
+		total_size += REGION_SIZE(next_region);
+	}
+
+dconsume_skip:
+
+	*total_data_region_size = total_size;
+	total_size = 0;
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+	if (allocator->pinning) {
+		list_for_each(item, &(allocator->buddy_pages)) {
+			next_pin = list_entry(item, struct mem_pin, pin_link);
+			total_size += REGION_SIZE(next_pin);
+		}
+	}
+#endif
+
+	*total_pin_size = total_size;
+}
+
+EXPORT_SYMBOL(dump_mem_consumption);
+#endif
+
+#ifdef SAFEFETCH_DEBUG
+void dump_region_stats(int *mregions, int *dregions, int *dkmalloc,
+		       size_t *dkmallocmax)
+{
+	struct region_allocator *allocator;
+	struct list_head *item;
+	struct mem_region *next_region;
+	int regions, kmallocs;
+	size_t kmallocmax;
+
+	allocator = DF_CUR_METADATA_REGION_ALLOCATOR;
+	regions = 0;
+	if (!(allocator->extended))
+		goto mskip;
+	list_for_each(item, &(allocator->extra_ranges)) {
+		next_region = list_entry(item, struct mem_region, extra_ranges);
+		regions++;
+	}
+
+mskip:
+
+	*mregions = regions;
+
+	allocator = DF_CUR_STORAGE_REGION_ALLOCATOR;
+	regions = 0;
+	kmallocs = 0;
+	kmallocmax = 0;
+
+	if (!(allocator->extended))
+		goto dskip;
+	list_for_each(item, &(allocator->extra_ranges)) {
+		next_region = list_entry(item, struct mem_region, extra_ranges);
+		regions++;
+		if (!(next_region->is_cached)) {
+			kmallocs++;
+			if (REGION_REMAINING_BYTES(next_region) > kmallocmax) {
+				kmallocmax =
+					REGION_REMAINING_BYTES(next_region);
+			}
+		}
+	}
+
+dskip:
+
+	*dregions = regions;
+	*dkmalloc = kmallocs;
+	*dkmallocmax = kmallocmax;
+}
+
+#endif
+
+#ifndef DFCACHER_INLINE_FUNCTIONS
+/* #warning "Region functions not inlined" */
+// TODO Find a smarter way to do all of these includes (looks sloppy now)
+// Called on syscall exit to remove extra regions except one.
+noinline void reset_regions(void)
+{
+	if (SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+		/* Reset the range first if by some unfortunate incident
+		 * we get rescheduled by an interrupt here (that uses current)
+		 * as long as we mark the mem_range as uninitialized and
+		 * as long as the interrupt uses less than the first region
+		 * there should be no concurency issue and after the interrupt
+		 * is over we can cleanup any extra range. In case the interrupt
+		 * happens prior to the flag being set than the interrupt just
+		 * adds to the extended regions which we will clean after the
+		 * interrupt ends.
+		 */
+		SAFEFETCH_RESET_MEM_RANGE();
+		shrink_region(DF_CUR_STORAGE_REGION_ALLOCATOR);
+		shrink_region(DF_CUR_METADATA_REGION_ALLOCATOR);
+#ifdef SAFEFETCH_DEBUG
+		WARN_ON(SAFEFETCH_MEM_RANGE_INIT_FLAG);
+#endif
+	}
+#if defined(SAFEFETCH_DEBUG) && defined(SAFEFETCH_DEBUG_TRACING)
+	/* #warning "We have tracing enabled with debugging." */
+	// Check all accesses from interrupt context
+	current->df_stats.check_next_access = 1;
+#endif
+}
+// Called on process exit to destroy regions.
+noinline void destroy_regions(void)
+{
+	SAFEFETCH_RESET_MEM_RANGE();
+	destroy_region(DF_CUR_STORAGE_REGION_ALLOCATOR);
+	destroy_region(DF_CUR_METADATA_REGION_ALLOCATOR);
+}
+// Called by DFCACHE's memory range subsistem to initialize regions used to allocate memory ranges
+noinline bool initialize_regions(void)
+{
+	return init_region_allocator(DF_CUR_METADATA_REGION_ALLOCATOR,
+				     METADATA) &&
+	       init_region_allocator(DF_CUR_STORAGE_REGION_ALLOCATOR, STORAGE);
+}
+#else
+/* #warning "Region functions inlined" */
+#endif
+
+// Return: The pointer to the beginning of the allocated page
+static struct mem_region *create_new_region(struct region_allocator *allocator,
+					    size_t alloc_size)
+{
+	struct mem_region *new_region;
+#ifdef REGION_ALLOCATOR_LARGER_ORDER_ALLOCATIONS
+	size_t to_allocate;
+#endif
+	// Take into consideration that the newly allocated region must also contain a header.
+	size_t nbytes = (alloc_size + sizeof(struct mem_region));
+	// We can allocate from our special allocator.
+	if (nbytes <= BYTE_GRANULARITY(allocator)) {
+		new_region = (struct mem_region *)df_allocate_chunk(
+			allocator->cache);
+		ASSERT_ALLOCATION_FAILURE(
+			new_region,
+			"create_new_region: Problem when allocating new region in region allocator!");
+
+		// Also allocate the new region but only fixup the pointer after we return it to the caller.
+		REGION_REMAINING_BYTES(new_region) =
+			BYTE_GRANULARITY(allocator) - nbytes;
+		// If region is cached then we must dealocate it through the slab cache else kfree it.
+		new_region->is_cached = 1;
+#ifdef SAFEFETCH_MEASURE_MEMORY_CONSUMPTION
+		REGION_SIZE(new_region) = BYTE_GRANULARITY(allocator);
+#endif
+
+	} else {
+#ifdef REGION_ALLOCATOR_LARGER_ORDER_ALLOCATIONS
+		/* #warning "We are using higher order allocations" */
+		to_allocate = ((nbytes >> PAGE_SHIFT) + 1);
+		if (to_allocate != 1) {
+			to_allocate <<=
+				(safefetch_slow_path_order + PAGE_SHIFT);
+		} else {
+			// In case we have less than PAGE_SIZE bytes allocate only one page.
+			to_allocate <<= PAGE_SHIFT;
+		}
+		new_region = (struct mem_region *)df_allocate_chunk_slowpath(
+			to_allocate);
+#else
+		new_region =
+			(struct mem_region *)df_allocate_chunk_slowpath(nbytes);
+#endif
+		ASSERT_ALLOCATION_FAILURE(
+			new_region,
+			"create_new_region: Problem when allocating new region in region allocator!");
+		// No point in initializing the remaining bytes for this region. It's always 0.
+		new_region->is_cached = 0;
+#ifdef REGION_ALLOCATOR_LARGER_ORDER_ALLOCATIONS
+		// For debugging purposes keep track of how large of an allocation we had in case of kmalloc chunks
+		REGION_REMAINING_BYTES(new_region) = to_allocate - nbytes;
+#ifdef SAFEFETCH_MEASURE_MEMORY_CONSUMPTION
+		REGION_SIZE(new_region) = to_allocate;
+#endif
+#endif
+
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_REGION_FUNCTIONALITY,
+			"[SafeFetch][Info][Task %s][Sys %d] create_new_region: Serving allocation from kmalloc.",
+			current->comm, DF_SYSCALL_NR);
+	}
+
+	REGION_PTR(new_region) = (unsigned long long)(new_region + 1);
+
+	return new_region;
+}
+
+/* Initialize allocator based on an underlying page cache */
+bool init_region_allocator(struct region_allocator *allocator, u8 cache_type)
+{
+	struct mem_region *first_region = allocator->first;
+
+	if (likely(allocator->initialized)) {
+		// Expect at least a couple of syscalls in the process so it's most likely that the allocator
+		// is already initialized so reset the base of the region.
+		REGION_REMAINING_BYTES(first_region) =
+			BYTE_GRANULARITY(allocator) - sizeof(struct mem_region);
+		REGION_PTR(first_region) =
+			(unsigned long long)(first_region + 1);
+
+		// No need to mark the allocator as not extended. We do this once we shrink the region now (as it seems necessary).
+		//allocator->extended = 0;
+		return true;
+	}
+
+	switch (cache_type) {
+	case METADATA:
+		BYTE_GRANULARITY(allocator) = safefetch_metadata_cache_size;
+		allocator->cache = df_metadata_cache;
+		break;
+	case STORAGE:
+		BYTE_GRANULARITY(allocator) = safefetch_storage_cache_size;
+		allocator->cache = df_storage_cache;
+		break;
+	}
+
+	/* Create first range  */
+	first_region = (struct mem_region *)df_allocate_chunk(allocator->cache);
+
+	if (!first_region) {
+		printk(KERN_EMERG
+		       "init_region_allocator: Problem when allocating new region in region allocator!");
+		allocator->first = 0;
+		return false;
+	}
+
+	REGION_REMAINING_BYTES(first_region) =
+		BYTE_GRANULARITY(allocator) - sizeof(struct mem_region);
+	REGION_PTR(first_region) = (unsigned long long)(first_region + 1);
+
+#ifdef SAFEFETCH_MEASURE_MEMORY_CONSUMPTION
+	REGION_SIZE(first_region) = BYTE_GRANULARITY(allocator);
+#endif
+
+	/* Initialize allocator */
+	allocator->first = first_region;
+	/* Allocator has only the first region */
+	allocator->extended = 0;
+	/* Now allocator is initialized */
+	allocator->initialized = 1;
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+	allocator->pinning = 0;
+#endif
+
+	return true;
+}
+
+static __always_inline void __shrink_region(struct region_allocator *allocator)
+{
+	struct list_head *item, *next;
+	struct mem_region *next_region;
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+	void *frag;
+#endif
+
+#ifdef SAFEFETCH_DEBUG
+	int num_freed_regions = 0;
+#endif
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+	if (unlikely(allocator->pinning)) {
+		list_for_each(item, &(allocator->buddy_pages)) {
+			// Decrement ref on each page and remove the page if necessary.
+#if 0
+	 page = (void *) (list_entry(item, struct mem_pin, pin_link)->ptr);
+	 if (put_page_testzero(page))
+		free_the_page(page, compound_order(page));
+#endif
+			frag = (list_entry(item, struct mem_pin, pin_link)->ptr);
+			page_frag_free(frag);
+		}
+		allocator->pinning = 0;
+	}
+#endif
+
+	if (likely(!(allocator->extended))) {
+		// TODO Add slowpath check (might be useful for debugging fork)
+		return;
+	}
+
+	/* Remove all extra regions allocated for the syscall. Must be
+	 * list_for_each_safe else we may release regions and at the same
+	 * time some will grab it and modify our linked lists.
+	 */
+	list_for_each_safe(item, next, &(allocator->extra_ranges)) {
+		next_region = list_entry(item, struct mem_region, extra_ranges);
+		if (next_region->is_cached)
+			df_free_chunk(allocator->cache, (void *)next_region);
+		else
+			df_free_chunk_slowpath(next_region);
+#ifdef SAFEFETCH_DEBUG
+		num_freed_regions++;
+#endif
+	}
+	// Don't free linked list as we're simply going to reinitialize the list once another
+	// task grabs those pages. However mark the allocator as not extended anymore.
+	// If the process receives a signal in the middle of handling a syscall after the
+	// region is shrunk we might attempt to shrink the region again.
+	allocator->extended = 0;
+
+	SAFEFETCH_DEBUG_ASSERT(
+		SAFEFETCH_LOG_INFO_REGION_FUNCTIONALITY,
+		(num_freed_regions == 0),
+		"[SafeFetch][Info][Task %s][Sys %d] shrink_region: Removed %d regions.",
+		current->comm, DF_SYSCALL_NR, num_freed_regions);
+	return;
+}
+
+void shrink_region(struct region_allocator *allocator)
+{
+#if 0
+	// Now if any of the two allocators are not initialized the mem_range_init flag
+	// is not set to 1.
+	// TODO once we guarded shrink_region and destroy_region with the mem_range
+	// initialization flag the test for allocator->initialized only becomes relevant
+	// in case the initialization failed via kmalloc. There must be a faster way
+	// to do this. Also, now this condition became unlikely given that this code will
+	// mostly execute ONLY if the allocator is initialized (under the guard of the
+	// mem_range flag).
+	if (unlikely(!(allocator->initialized))) {
+#ifdef REGION_CHECKS_EXTENDED
+		printk("[Task %s] [K %llx] shrink_region: Error allocator is not initialized\n", current->comm, current->flags & PF_KTHREAD);
+#endif
+		return;
+	}
+#endif
+	__shrink_region(allocator);
+}
+
+void destroy_region(struct region_allocator *allocator)
+{
+	/* We assume that the process will call at least one copy from user so
+	 * it has at least the first region initialized.
+	 */
+	if (unlikely(!(allocator->initialized))) {
+#ifdef REGION_CHECKS_EXTENDED
+		printk("[Task %s] [K %llx] destroy_region: Error allocator is not initialized\n",
+			current->comm, current->flags & PF_KTHREAD);
+#endif
+		return;
+	}
+
+#ifdef REGION_CHECKS_EXTENDED
+	if (!(allocator->first)) {
+		printk("[Task %s] [K %llx] destroy_region: Error default region is missing\n",
+		       current->comm, current->flags & PF_KTHREAD);
+		return;
+	}
+#endif
+	// Shrink region if appropriate.
+	__shrink_region(allocator);
+
+	// Remove our first chunk and release everything (We need to call this last with
+	// page pinning because page pinning might allocate page pins in the first region)
+	df_free_chunk(allocator->cache, (void *)allocator->first);
+
+	// Mark allocator as uninitialized.
+	allocator->initialized = 0;
+}
+
+void *allocate_from_region(struct region_allocator *allocator,
+			   size_t alloc_size)
+{
+	unsigned long long ptr;
+	struct list_head *item;
+	struct mem_region *next_region = allocator->first;
+#ifdef ADAPTIVE_REGION_ALLOCATOR
+	struct mem_region *to_flip;
+#endif
+
+	if (unlikely(!(allocator->initialized))) {
+#ifdef REGION_CHECKS_EXTENDED
+		printk("[Task %s] [K %d] allocate_from_region: Error ALLOCATOR not initialized\n",
+		       current->comm, current->flags & PF_KTHREAD);
+#endif
+		return 0;
+	}
+
+#ifdef REGION_CHECKS_EXTENDED
+	if (!next_region) {
+		printk("[Task %s] [K %d] allocate_from_region: Error DEFAULT region is missing\n",
+		       current->comm, current->flags & PF_KTHREAD);
+		return 0;
+	}
+#endif
+
+	// Fast path allocates from the first region.
+	if (alloc_size <= REGION_REMAINING_BYTES(next_region)) {
+		ptr = REGION_PTR(next_region);
+		REGION_REMAINING_BYTES(next_region) =
+			REGION_REMAINING_BYTES(next_region) - alloc_size;
+		REGION_PTR(next_region) = ptr + alloc_size;
+		return (void *)ptr;
+	}
+
+	// If allocator was not extended then prepare to extend the allocator.
+	if (!(allocator->extended)) {
+		INIT_LIST_HEAD(&(allocator->extra_ranges));
+		INIT_LIST_HEAD(&(allocator->free_ranges));
+		allocator->extended = 1;
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_INFO_REGION_FUNCTIONALITY,
+			"[SafeFetch][Info][Task %s][Sys %d] allocate_from_region: Extending allocator.",
+			current->comm, DF_SYSCALL_NR);
+		goto slow_path;
+	}
+
+	list_for_each(item, &(allocator->free_ranges)) {
+		next_region = list_entry(item, struct mem_region, free_ranges);
+		/* We found a range that can fit our needs */
+		if (alloc_size <= REGION_REMAINING_BYTES(next_region)) {
+			ptr = REGION_PTR(next_region);
+			REGION_REMAINING_BYTES(next_region) =
+				REGION_REMAINING_BYTES(next_region) -
+				alloc_size;
+			REGION_PTR(next_region) = ptr + alloc_size;
+
+			/* If we're bellow the watermark remove the region from the list of free regions */
+			if (REGION_REMAINING_BYTES(next_region) <
+			    REGION_LOW_WATERMARK)
+				list_del(item);
+
+			SAFEFETCH_DEBUG_LOG(
+				SAFEFETCH_LOG_INFO_REGION_FUNCTIONALITY,
+				"[SafeFetch][Info][Task %s][Sys %d] allocate_from_region: Serving allocation from freelist.",
+				current->comm, DF_SYSCALL_NR);
+
+			return (void *)ptr;
+		}
+	}
+
+	/* If we did not find any suitable region we must create a new region and insert it in  */
+slow_path:
+
+	SAFEFETCH_DEBUG_LOG(
+		SAFEFETCH_LOG_INFO_REGION_FUNCTIONALITY,
+		"[SafeFetch][Info][Task %s][Sys %d] allocate_from_region: Executing slow_path.",
+		current->comm, DF_SYSCALL_NR);
+
+	next_region = create_new_region(allocator, alloc_size);
+
+	if (!next_region)
+		return 0;
+
+	ptr = REGION_PTR(next_region);
+
+#ifndef REGION_ALLOCATOR_LARGER_ORDER_ALLOCATIONS
+	// Only add cached regions to the list of free ranges
+	if (next_region->is_cached) {
+		// Setup the next region pointer
+		REGION_PTR(next_region) = ptr + alloc_size;
+
+#ifdef ADAPTIVE_REGION_ALLOCATOR
+		// In case we have more  bytes in the next allocated region then flip the main region
+		// to avoid scenarios where large allocations are served from the main page and region
+		// allocation goes to slow path too often.
+		if (REGION_REMAINING_BYTES(next_region) >
+		    REGION_REMAINING_BYTES(allocator->first)) {
+			to_flip = allocator->first;
+			allocator->first = next_region;
+			next_region = to_flip;
+		}
+
+#endif // As an optimization do not add the new region in the free region list if
+		// it's bellow a low watermark.
+		if (REGION_REMAINING_BYTES(next_region) >= REGION_LOW_WATERMARK)
+			list_add(REGION_FREELIST(next_region),
+				 &(allocator->free_ranges));
+	}
+#else // REGION_ALLOCATOR_LARGER_ORDER_ALLOCATIONS
+	REGION_PTR(next_region) = ptr + alloc_size;
+
+#ifdef ADAPTIVE_REGION_ALLOCATOR
+	// In case we have more  bytes in the next allocated region then flip the main region
+	// to avoid scenarios where large allocations are served from the main page and region
+	// allocation goes to slow path too often.
+	if (next_region->is_cached &&
+	    (REGION_REMAINING_BYTES(next_region) >
+	     REGION_REMAINING_BYTES(allocator->first))) {
+		to_flip = allocator->first;
+		allocator->first = next_region;
+		next_region = to_flip;
+	}
+
+#endif
+	if (REGION_REMAINING_BYTES(next_region) >= REGION_LOW_WATERMARK)
+		list_add(REGION_FREELIST(next_region),
+			 &(allocator->free_ranges));
+
+#endif
+
+	list_add(REGION_RANGES(next_region), &(allocator->extra_ranges));
+
+	return (void *)ptr;
+}
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+#ifdef SAFEFETCH_MEASURE_MEMORY_CONSUMPTION
+void *pin_compound_pages(struct region_allocator *allocator, void *kern_loc,
+			 unsigned long usize)
+{
+#else
+void *pin_compound_pages(struct region_allocator *allocator, void *kern_loc)
+{
+#endif
+	struct mem_pin *pin;
+	struct page *page = virt_to_head_page(kern_loc);
+	// Increase page refcount
+	if (!get_page_unless_zero(page))
+		return NULL;
+
+	// Use our advanced region allocator to keep track that we pinned this page.
+	pin = (struct mem_pin *)allocate_from_region(allocator,
+						     sizeof(struct mem_pin));
+	// Either the head page or the virtual address of this page would work.
+	pin->ptr = (void *)kern_loc;
+
+	if (!allocator->pinning) {
+		INIT_LIST_HEAD(&(allocator->buddy_pages));
+		allocator->pinning = 1;
+	}
+
+	list_add(PIN_LINK(pin), &(allocator->buddy_pages));
+
+#ifdef SAFEFETCH_MEASURE_MEMORY_CONSUMPTION
+	REGION_SIZE(pin) = usize;
+#endif
+
+	return kern_loc;
+}
+#endif
diff --git a/mm/safefetch/safefetch.c b/mm/safefetch/safefetch.c
new file mode 100644
index 000000000000..b979a525b415
--- /dev/null
+++ b/mm/safefetch/safefetch.c
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include "safefetch_debug.h"
+
+#include "page_cache.h"
+#include <linux/mem_range.h>
+#include <linux/safefetch_static_keys.h>
+
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+
+char global_monitored_task[SAFEFETCH_MONITOR_TASK_SIZE] = { 'x', 'x', 'o',
+							    'x', 'o', 0 };
+int global_monitored_syscall = -2;
+uint64_t global_search_time[SAFEFETCH_MEASURE_MAX];
+uint64_t global_search_count;
+uint64_t rdmsr_ovr;
+EXPORT_SYMBOL(global_search_time);
+EXPORT_SYMBOL(global_search_count);
+EXPORT_SYMBOL(global_monitored_task);
+EXPORT_SYMBOL(global_monitored_syscall);
+EXPORT_SYMBOL(rdmsr_ovr);
+#endif
+
+/*
+ * This file contains the top level code.
+ * It has the functions that will be hooked from specific locations within
+ * the linux kernel based on the current control flow.
+ * It also contains the main content for performing the defense
+ */
+
+// This function initialises the protection structures that needed for the defense
+// This function is called once during booting
+// Calling location: init/main.c:start_kernel()
+// Return: None
+inline void df_startup(void)
+{
+	printk(KERN_INFO "[SafeFetch] Initialising SafeFetch...");
+#ifdef SAFEFETCH_RBTREE_MEM_RANGE
+	printk(KERN_INFO
+	       "[SafeFetch] Using RB-tree memory range data structure");
+#elif defined(SAFEFETCH_ADAPTIVE_MEM_RANGE)
+	printk(KERN_INFO
+	       "[SafeFetch] Using ADAPTIVE memory range data structure");
+#elif defined(SAFEFETCH_STATIC_KEYS)
+	printk(KERN_INFO
+	       "[SafeFetch] Using STATIC_KEYS memory range data structure");
+#else
+	printk(KERN_INFO
+	       "[SafeFetch] Using Linked list memory range data structure");
+#endif
+
+	df_init_page_alloc_array();
+	printk(KERN_INFO "[SafeFetch] - Pre-page allocation enabled");
+	printk(KERN_INFO "[SafeFetch] - Metadata Page Cache Size %d",
+	       (uint32_t)safefetch_metadata_cache_size);
+	printk(KERN_INFO "[SafeFetch] - Data Page Cache Size %d",
+	       (uint32_t)safefetch_storage_cache_size);
+}
+
+// This function is called every time a task is being duplicated.
+// It resets the pointers inside the task struct so no double usages occur.
+// Calling location: kernel/fork.c:dup_task_struct()
+// Return: None
+inline void df_task_dup(struct task_struct *tsk)
+{
+	SAFEFETCH_TASK_RESET_MEM_RANGE(tsk);
+
+	tsk->df_prot_struct_head.df_metadata_allocator.initialized = 0;
+	tsk->df_prot_struct_head.df_storage_allocator.initialized = 0;
+
+#if defined(SAFEFETCH_DEBUG)
+	tsk->df_stats.traced = 0;
+	tsk->df_stats.check_next_access = 0;
+	tsk->df_stats.syscall_count = 0;
+	tsk->df_stats.in_irq = 0;
+	tsk->df_stats.num_fetches = 0;
+	tsk->df_stats.num_defrags = 0;
+#endif
+
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+	df_init_measure_structs(tsk);
+#endif
+
+	//tsk->df_prot_struct_head.df_metadata_allocator.extended = 0;
+	//tsk->df_prot_struct_head.df_storage_allocator.extended = 0;
+
+	//init_region_allocator(&(tsk->df_prot_struct_head.df_metadata_allocator), METADATA);
+	//init_region_allocator(&(tsk->df_prot_struct_head.df_storage_allocator), STORAGE);
+}
+
+#if defined(SAFEFETCH_DEBUG) || defined(SAFEFETCH_STATIC_KEYS)
+void df_sysfs_init(void)
+{
+#ifdef SAFEFETCH_DEBUG
+	init_safefetch_debug_layer();
+	printk(KERN_INFO "[SafeFetch] - Initialized sysfs debug interface");
+#endif
+#ifdef SAFEFETCH_STATIC_KEYS
+	init_safefetch_skey_layer();
+#endif
+}
+#endif
+
+#ifdef SAFEFETCH_DEBUG
+
+#if defined(SAFEFETCH_DEBUG_COLLECT_SAMPLES) || \
+	defined(SAFEFETCH_MEASURE_MEMORY_CONSUMPTION)
+LIST_HEAD(sample_list_node);
+EXPORT_SYMBOL(sample_list_node);
+DEFINE_SPINLOCK(df_sample_lock);
+EXPORT_SYMBOL(df_sample_lock);
+
+#define FILTER_TOTAL_SIZE 14
+char *sample_filter[FILTER_TOTAL_SIZE] = { "bw_",
+					   "lat_",
+					   "nginx",
+					   "apache",
+					   "redis",
+					   "git",
+					   "openssl",
+					   "pybench",
+					   "ipc-benchmark",
+					   "create_threads",
+					   "create_processe",
+					   "launch_programs",
+					   "create_files",
+					   "mem_alloc" };
+
+bool check_filter(void)
+{
+	int i;
+
+	for (i = 0; i < FILTER_TOTAL_SIZE; i++) {
+		if (strncmp(current->comm, sample_filter[i],
+			    strlen(sample_filter[i])) == 0) {
+			return true;
+		}
+	}
+	return false;
+}
+
+#endif
+
+#if defined(SAFEFETCH_DEBUG_COLLECT_SAMPLES)
+/* #warning "Building with debug and sample collection" */
+static inline void collect_sample(void)
+{
+	struct df_sample_struct sample;
+	struct df_sample_link *link;
+
+	link = kmalloc(sizeof(struct df_sample_link), GFP_KERNEL);
+	memset(&sample, 0, sizeof(struct df_sample_struct));
+	strncpy(sample.comm, current->comm, TASK_NAME_SIZE);
+	sample.comm[TASK_NAME_SIZE - 1] = 0;
+	sample.syscall_nr = DF_SYSCALL_NR;
+	sample.nfetches = DF_SYSCALL_FETCHES;
+	sample.ndefrags = DF_SYSCALL_DEFRAGS;
+	sample.sys_count = DF_SYSCALL_COUNT;
+	sample.pid = current->pid;
+	dump_region_stats(&(sample.mranges), &(sample.dranges),
+			  &(sample.dkmallocs), &(sample.max_kmalloc));
+	dump_range_stats_extended(&(sample.rsize), &(sample.min_size),
+				  &(sample.max_size), &(sample.avg_size),
+				  &(sample.total_size));
+
+	if (sample.rsize) {
+		sample.mranges++;
+		sample.dranges++;
+	}
+
+	memcpy(&(link->sample), &sample, sizeof(struct df_sample_struct));
+
+	spin_lock(&df_sample_lock);
+	list_add_tail(&(link->node), &(sample_list_node));
+	spin_unlock(&df_sample_lock);
+}
+#elif defined(SAFEFETCH_MEASURE_MEMORY_CONSUMPTION)
+/* #warning "Building with debug and memory collection" */
+static inline void collect_sample(void)
+{
+	struct df_sample_struct sample;
+	struct df_sample_link *link;
+	// Only collect sizes for specific processes
+	if (!check_filter())
+		return;
+	memset(&sample, 0, sizeof(struct df_sample_struct));
+	dump_mem_consumption(current, &(sample.metadata), &(sample.data),
+			     &(sample.pins));
+
+	// Skip syscalls that do not allocate any data.
+	if (!(sample.metadata))
+		return;
+
+	sample.metadata >>= 10;
+	sample.data >>= 10;
+	sample.pins >>= 10;
+
+	link = kmalloc(sizeof(struct df_sample_link), GFP_KERNEL);
+
+	strncpy(sample.comm, current->comm, TASK_NAME_SIZE);
+	sample.comm[TASK_NAME_SIZE - 1] = 0;
+	sample.syscall_nr = DF_SYSCALL_NR;
+	sample.pid = current->pid;
+	sample.rss = get_mm_rss(current->mm) << 2;
+
+	memcpy(&(link->sample), &sample, sizeof(struct df_sample_struct));
+
+	spin_lock(&df_sample_lock);
+	list_add_tail(&(link->node), &(sample_list_node));
+	spin_unlock(&df_sample_lock);
+}
+#endif
+// This function is called on every syscall start
+// It initialises the data structures needed for the safefetch defense
+// Calling location: arch/x86/entry/common.c:do_syscall_64()
+// Return: None
+void df_debug_syscall_entry(int sys_nr, struct pt_regs *regs)
+{
+	int same_syscall = 0;
+
+	// Mark the pending copies from user as access ok.
+#if defined(SAFEFETCH_DEBUG_TRACING)
+	current->df_stats.check_next_access = 0;
+#endif
+	if (current->df_stats.pending == PENDING_RESTART_DELIVERED) {
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_SIGNAL_CHAINING,
+			"[SafeFetch][Signals][Task %s][Sys %d][Previous %d] Delivered restart to syscall from RIP 0x%lx (orig ax: 0x%ld ax: 0x%lx)\n",
+			current->comm, sys_nr, DF_SYSCALL_NR, regs->ip,
+			regs->orig_ax, regs->ax);
+		current->df_stats.pending = 0;
+		same_syscall = 1;
+	}
+
+	if (SAFEFETCH_MEM_RANGE_INIT_FLAG) {
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_SIGNAL_CHAINING,
+			"[SafeFetch][Signals][Task %s][Sys %d][Previous %d] Major error, some init flag not set correctly from RIP 0x%lx (orig ax: 0x%ld ax: 0x%lx) [%d]\n",
+			current->comm, sys_nr, DF_SYSCALL_NR, regs->ip,
+			regs->orig_ax, regs->ax, same_syscall);
+		current->df_stats.pending = PENDING_RESTART;
+		SAFEFETCH_RESET_MEM_RANGE();
+	} else {
+		current->df_stats.pending = 0;
+	}
+
+	DF_SYSCALL_NR = sys_nr;
+	DF_SYSCALL_FETCHES = 0;
+	DF_SYSCALL_DEFRAGS = 0;
+	current->df_stats.syscall_count++;
+}
+
+// This function is called on every syscall termination.
+// It clears the used memory ranges
+// Calling location: arch/x86/entry/common.c:do_syscall_64()
+// Return: None
+void df_debug_syscall_exit(void)
+{
+	if (current->df_stats.pending == PENDING_RESTART)
+		current->df_stats.pending = PENDING_RESTART_DELIVERED;
+#if defined(SAFEFETCH_DEBUG_COLLECT_SAMPLES) || \
+	defined(SAFEFETCH_MEASURE_MEMORY_CONSUMPTION)
+	SAFEFETCH_DEBUG_RUN(5, collect_sample());
+#endif
+
+#if defined(SAFEFETCH_PIN_BUDDY_PAGES) && defined(SAFEFETCH_DEBUG_PINNING)
+	check_pins();
+#endif
+}
+
+// This function is called every time a process dies
+// It destroys all the allocated memory attached to this process
+// Calling location: kernel/exit.c:do_exit()
+// Return: None
+inline void df_debug_task_destroy(struct task_struct *tsk)
+{
+	tsk->df_stats.pending = 0;
+	tsk->df_stats.syscall_nr = -1;
+}
+
+#endif
+
+// This function intercepts a get_user instruction of 1 byte
+// It will insert the data into the protection structure and then
+// copies back the double fetch protected data for that specific memory
+// area into the kernel destination.
+// Calling location: arch/x86/include/asm/uaccess.h:do_get_user_call
+// Return: Response code (-1 = failure)
+inline int df_get_user1(unsigned long long user_src, unsigned char user_val,
+			unsigned long long kern_dst)
+{
+#ifdef SAFEFETCH_WHITELISTING
+	if (IS_WHITELISTED(current))
+		return 0;
+#endif
+	copy_range_loop((unsigned char *)user_src, user_val,
+			(unsigned char *)kern_dst);
+}
+
+// This function intercepts a get_user instruction of 2 bytes
+// It will insert the data into the protection structure and then
+// copies back the double fetch protected data for that specific memory
+// area into the kernel destination.
+// Calling location: arch/x86/include/asm/uaccess.h:do_get_user_call
+// Return: Response code (-1 = failure)
+inline int df_get_user2(unsigned long long user_src, unsigned short user_val,
+			unsigned long long kern_dst)
+{
+#ifdef SAFEFETCH_WHITELISTING
+	if (IS_WHITELISTED(current))
+		return 0;
+#endif
+	copy_range_loop((unsigned short *)user_src, user_val,
+			(unsigned short *)kern_dst);
+}
+
+// This function intercepts a get_user instruction of 4 bytes
+// It will insert the data into the protection structure and then
+// copies back the double fetch protected data for that specific memory
+// area into the kernel destination.
+// Calling location: arch/x86/include/asm/uaccess.h:do_get_user_call
+// Return: Response code (-1 = failure)
+inline int df_get_user4(unsigned long long user_src, unsigned int user_val,
+			unsigned long long kern_dst)
+{
+#ifdef SAFEFETCH_WHITELISTING
+	if (IS_WHITELISTED(current))
+		return 0;
+#endif
+	copy_range_loop((unsigned int *)user_src, user_val,
+			(unsigned int *)kern_dst);
+}
+
+// This function intercepts a get_user instruction of 8 bytes
+// It will insert the data into the protection structure and then
+// copies back the double fetch protected data for that specific memory
+// area into the kernel destination.
+// Calling location: arch/x86/include/asm/uaccess.h:do_get_user_call
+// Return: Response code (-1 = failure)
+inline int df_get_user8(unsigned long long user_src, unsigned long user_val,
+			unsigned long long kern_dst)
+{
+#ifdef SAFEFETCH_WHITELISTING
+	if (IS_WHITELISTED(current))
+		return 0;
+#endif
+	copy_range_loop((unsigned long *)user_src, user_val,
+			(unsigned long *)kern_dst);
+}
+
+// This function intercepts a get_user instruction of 8 unsigned bytes
+// It will insert the data into the protection structure and then
+// copies back the double fetch protected data for that specific memory
+// area into the kernel destination.
+// Calling location: arch/x86/include/asm/uaccess.h:do_get_user_call
+// Return: Response code (-1 = failure)
+inline int df_get_useru8(unsigned long long user_src,
+			 unsigned long user_val,
+			 unsigned long long kern_dst)
+{
+#ifdef SAFEFETCH_WHITELISTING
+	if (IS_WHITELISTED(current))
+		return 0;
+#endif
+	copy_range_loop((unsigned long *)user_src, user_val,
+			(unsigned long *)kern_dst);
+}
+
+// This function intercepts a copy from user instruction
+// It will insert the data into the protection structure and then
+// copies back the double fetch protected data for that specific memory
+// area into the kernel destination.
+// Calling location: arch/x86/include/asm/uaccess.h:do_get_user_call
+// Return: Response code (-1 = failure)
+inline unsigned long df_copy_from_user(unsigned long long user_src,
+				       unsigned long long kern_dst,
+				       unsigned long user_size)
+{
+	unsigned long ret;
+
+#if defined(SAFEFETCH_DEBUG) &&                                                \
+	(defined(SAFEFETCH_DEBUG_TRACING) || defined(SAFEFETCH_DEBUG_LEAKS) || \
+	 defined(SAFEFETCH_DEBUG_COLLECT_VULNERABILITIES))
+	if (in_nmi() || current->df_stats.traced) {
+		return COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				 user_size);
+	}
+#endif
+
+#ifdef DFCACHER_PERF_SETUP
+	/* #warning "DFCACHER perf build" */
+	// Switch off defense for nmi interrupts.
+	if (unlikely(in_irq_ctx())) {
+		return COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				 user_size);
+	}
+#endif
+
+#ifdef SAFEFETCH_WHITELISTING
+	if (IS_WHITELISTED(current)) {
+		return COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				 user_size);
+	}
+#endif
+
+	if (unlikely(!user_size))
+		return 0;
+
+	ret = copy_range(user_src, kern_dst, user_size);
+
+	if (unlikely(ret == -1)) {
+		printk(KERN_INFO
+		       "[SafeFetch][Warning] df_copy_from_user: Failed copy_range reverting to default implementation\n");
+		return COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				 user_size);
+	}
+
+	return ret;
+}
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+inline unsigned long df_copy_from_user_pinning(unsigned long long user_src,
+					       unsigned long long kern_dst,
+					       unsigned long user_size)
+{
+	unsigned long ret;
+
+#if defined(SAFEFETCH_DEBUG) &&                                                \
+	(defined(SAFEFETCH_DEBUG_TRACING) || defined(SAFEFETCH_DEBUG_LEAKS) || \
+	 defined(SAFEFETCH_DEBUG_COLLECT_VULNERABILITIES))
+	if (in_nmi() || current->df_stats.traced) {
+		return COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				 user_size);
+	}
+#endif
+
+#ifdef DFCACHER_PERF_SETUP
+	/* #warning "DFCACHER perf build" */
+	// Switch off defense for nmi interrupts.
+	if (unlikely(in_irq_ctx())) {
+		return COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				 user_size);
+	}
+#endif
+
+#ifdef SAFEFETCH_WHITELISTING
+	if (IS_WHITELISTED(current)) {
+		return COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				 user_size);
+	}
+#endif
+
+	if (unlikely(!user_size))
+		return 0;
+
+	ret = copy_range_pinning(user_src, kern_dst, user_size);
+
+	if (unlikely(ret == -1)) {
+		SAFEFETCH_DEBUG_LOG(
+			SAFEFETCH_LOG_WARNING,
+			"[SafeFetch][Warning] df_copy_from_user: Failed copy_range reverting to default implementation\n");
+		return COPY_FUNC((void *)kern_dst, (__force void *)user_src,
+				 user_size);
+	}
+
+	return ret;
+}
+#endif
+
+#ifdef SAFEFETCH_DEBUG
+EXPORT_SYMBOL(df_debug_syscall_entry);
+EXPORT_SYMBOL(df_debug_syscall_exit);
+EXPORT_SYMBOL(df_debug_task_destroy);
+#endif
+
+EXPORT_SYMBOL(df_startup);
+EXPORT_SYMBOL(df_task_dup);
+EXPORT_SYMBOL(df_get_user1);
+EXPORT_SYMBOL(df_get_user2);
+EXPORT_SYMBOL(df_get_user4);
+EXPORT_SYMBOL(df_get_user8);
+EXPORT_SYMBOL(df_get_useru8);
+EXPORT_SYMBOL(df_copy_from_user);
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+EXPORT_SYMBOL(df_copy_from_user_pinning);
+#endif
diff --git a/mm/safefetch/safefetch_debug.c b/mm/safefetch/safefetch_debug.c
new file mode 100644
index 000000000000..3ee93b0d0e62
--- /dev/null
+++ b/mm/safefetch/safefetch_debug.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include "safefetch_debug.h"
+
+volatile int df_cacher_log_level;
+volatile int df_cacher_assert_level;
+volatile unsigned long global_allocations;
+spinlock_t allocations_lock;
+spinlock_t df_sample_lock;
+
+static ssize_t allocations_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct task_struct *iter, *process;
+
+	for_each_process_thread(iter, process) {
+		if (DF_ALLOCATIONS(process)) {
+			printk("%s has %ld in transit allocations. [Initialized %d]\n",
+			       process->comm, DF_ALLOCATIONS(process),
+			       DEBUG_TASK_INITIALIZED(process));
+		}
+	}
+	return sprintf(buf, "%ld", global_allocations);
+}
+static ssize_t allocations_store(struct kobject *kobj,
+				 struct kobj_attribute *attr, const char *buf,
+				 size_t count)
+{
+	global_allocations = 0;
+	return count;
+}
+
+static ssize_t log_show(struct kobject *kobj, struct kobj_attribute *attr,
+			char *buf)
+{
+	return sprintf(buf, "%d", df_cacher_log_level);
+}
+static ssize_t log_store(struct kobject *kobj, struct kobj_attribute *attr,
+			 const char *buf, size_t count)
+{
+	sscanf(buf, "%d", &df_cacher_log_level);
+	return count;
+}
+
+static ssize_t assert_show(struct kobject *kobj, struct kobj_attribute *attr,
+			   char *buf)
+{
+	return sprintf(buf, "%d", df_cacher_assert_level);
+}
+static ssize_t assert_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	sscanf(buf, "%d", &df_cacher_assert_level);
+	return count;
+}
+
+struct kobj_attribute df_cacher_log_attr =
+	__ATTR(df_cacher_log_level, 0660, log_show, log_store);
+
+struct kobj_attribute df_cacher_assert_attr =
+	__ATTR(df_cacher_assert_level, 0660, assert_show, assert_store);
+struct kobj_attribute allocations_attr =
+	__ATTR(global_allocations, 0660, allocations_show, allocations_store);
+
+void init_safefetch_debug_layer(void)
+{
+	//This Function will be called from Init function
+	/*Creating a directory in /sys/kernel/ */
+	struct kobject *kobj_ref =
+		kobject_create_and_add("dfcacher", kernel_kobj);
+
+	if (!kobj_ref) {
+		printk(KERN_INFO "[SafeFetch] Cannot create kobj_ref......\n");
+		goto end;
+	}
+	printk(KERN_INFO "[SafeFetch] Successfully created kobj_ref......\n");
+
+	if (sysfs_create_file(kobj_ref, &df_cacher_log_attr.attr)) {
+		printk(KERN_INFO
+		       "[SafeFetch] Cannot create sysfs file......\n");
+		goto log_sysfs;
+	}
+
+	if (sysfs_create_file(kobj_ref, &df_cacher_assert_attr.attr)) {
+		printk(KERN_INFO
+		       "[SafeFetch] Cannot create sysfs file......\n");
+		goto assert_sysfs;
+	}
+
+	if (sysfs_create_file(kobj_ref, &allocations_attr.attr)) {
+		printk(KERN_INFO
+		       "[SafeFetch] Cannot create sysfs file for allocations number......\n");
+		goto allocations_error;
+	}
+
+	spin_lock_init(&allocations_lock);
+end:
+
+	printk(KERN_INFO
+	       "[SafeFetch] Successfully initialized debugging layer......\n");
+	return;
+allocations_error:
+	sysfs_remove_file(kernel_kobj, &allocations_attr.attr);
+assert_sysfs:
+	sysfs_remove_file(kernel_kobj, &df_cacher_assert_attr.attr);
+log_sysfs:
+	sysfs_remove_file(kernel_kobj, &df_cacher_log_attr.attr);
+	kobject_put(kobj_ref);
+}
diff --git a/mm/safefetch/safefetch_debug.h b/mm/safefetch/safefetch_debug.h
new file mode 100644
index 000000000000..92ccc9328849
--- /dev/null
+++ b/mm/safefetch/safefetch_debug.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SAFEFETCH_DEBUG_H__
+#define __SAFEFETCH_DEBUG_H__
+
+//#define SAFEFETCH_DEBUG
+#ifdef SAFEFETCH_DEBUG
+
+#define DF_SYSCALL_NR get_current()->df_stats.syscall_nr
+#define DF_SYSCALL_FETCHES get_current()->df_stats.num_fetches
+#define DF_SYSCALL_DEFRAGS get_current()->df_stats.num_defrags
+#define DF_SYSCALL_COUNT get_current()->df_stats.syscall_count
+#define DF_INC_FETCHES (DF_SYSCALL_FETCHES++)
+#define DF_INC_DEFRAGS (DF_SYSCALL_DEFRAGS++)
+#define DF_ALLOCATIONS(tsk) tsk->df_stats.nallocations
+#define DEBUG_TASK_INITIALIZED(tsk) \
+	tsk->df_prot_struct_head.df_mem_range_allocator.initialized
+
+// Enable this in order to check in tranzit allocations.
+// #define SAFEFETCH_DEBUG_LEAKS
+
+// TODO when we split the implementation in standalone compilation units
+// these way of defining variables will be a problem.
+extern volatile int df_cacher_log_level;
+extern volatile int df_cacher_assert_level;
+extern volatile unsigned long global_allocations;
+extern spinlock_t allocations_lock;
+extern spinlock_t df_sample_lock;
+
+void init_safefetch_debug_layer(void);
+
+#define SAFEFETCH_DEBUG_LOG(log_level, ...)     \
+	if ((log_level) <= df_cacher_log_level) \
+		printk(KERN_INFO __VA_ARGS__)
+#define SAFEFETCH_DEBUG_ASSERT(log_level, assertion, ...) \
+	if ((log_level) <= df_cacher_assert_level) {      \
+		if (!(assertion))                         \
+			printk(KERN_INFO __VA_ARGS__);    \
+	}
+#define SAFEFETCH_DEBUG_RUN(log_level, run_func)  \
+	if ((log_level) <= df_cacher_log_level) { \
+		run_func;                         \
+	}
+#else
+#define SAFEFETCH_DEBUG_LOG(log_level, ...)
+#define SAFEFETCH_DEBUG_ASSERT(log_level, assertion, ...)
+#define SAFEFETCH_DEBUG_RUN(log_level, run_func)
+#define DF_INC_FETCHES
+#define DF_INC_DEFRAGS
+#endif
+
+#define SAFEFETCH_LOG_ERROR 1
+#define SAFEFETCH_LOG_WARNING 2
+#define SAFEFETCH_LOG_INFO 3
+#define SAFEFETCH_LOG_INFO_MEM_RANGE_FUNCTIONALITY 20
+#define SAFEFETCH_LOG_INFO_REGION_FUNCTIONALITY 10 //10
+// Just keep it fully activated by default for debug builds
+#define SAFEFETCH_LOG_SIGNAL_CHAINING 10
+// Set to 5 when running debug syscall stats
+#define SAFEFETCH_LOG_INFO_DFCACHER_STATS 40
+#define SAFEFETCH_IRQ_FUNCTIONALITY 4
+
+#define SAFEFETCH_ASSERT_ALL 1
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+struct mem_range *create_pin_range(unsigned long long, unsigned long,
+				   unsigned long long);
+void copy_from_page_pin(void *, unsigned long long, unsigned long long);
+#endif
+
+#if !defined(SAFEFETCH_RBTREE_MEM_RANGE) &&       \
+	!defined(SAFEFETCH_ADAPTIVE_MEM_RANGE) && \
+	!defined(SAFEFETCH_RBTREE_MEM_RANGE)
+void convert_to_rbtree(uint8_t);
+struct mem_range *__search_range_rb_noinline_hook(unsigned long long,
+						  unsigned long long);
+struct mem_range *__search_range_ll_noinline_hook(unsigned long long,
+						  unsigned long long);
+void __defragment_mr_ll_noinline_hook(struct mem_range *, struct mem_range *);
+void __defragment_mr_rb_noinline_hook(struct mem_range *, struct mem_range *);
+#ifdef SAFEFETCH_DEBUG
+void __dump_range_stats_extended_adaptive(int *, uint64_t *, uint64_t *,
+					  unsigned long long *, uint64_t *);
+#endif
+#endif
+
+#endif
diff --git a/mm/safefetch/safefetch_static_keys.c b/mm/safefetch/safefetch_static_keys.c
new file mode 100644
index 000000000000..503029238b1b
--- /dev/null
+++ b/mm/safefetch/safefetch_static_keys.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include "page_cache.h"
+
+DEFINE_STATIC_KEY_FALSE(safefetch_copy_from_user_key);
+DEFINE_STATIC_KEY_FALSE(safefetch_hooks_key);
+DEFINE_STATIC_KEY_FALSE(safefetch_adaptive_key);
+DEFINE_STATIC_KEY_FALSE(safefetch_rbtree_key);
+
+EXPORT_SYMBOL(safefetch_copy_from_user_key);
+
+#ifdef SAFEFETCH_FLOATING_ADAPTIVE_WATERMARK
+extern uint8_t SAFEFETCH_ADAPTIVE_WATERMARK;
+#endif
+
+volatile int copy_from_user_key_ctrl;
+volatile int hooks_key_ctrl;
+volatile int defense_config_ctrl = -1;
+volatile int storage_regions_ctrl = -1;
+volatile uint8_t adaptive_watermark_ctrl = -1;
+
+static ssize_t hooks_show(struct kobject *kobj, struct kobj_attribute *attr,
+			  char *buf)
+{
+	return sprintf(buf, "%d", hooks_key_ctrl);
+}
+static ssize_t hooks_store(struct kobject *kobj, struct kobj_attribute *attr,
+			   const char *buf, size_t count)
+{
+	int val;
+
+	sscanf(buf, "%d", &val);
+	// WARNING. Only enable the hooks once (disabling this after enabling
+	// it will cause race conditions or missing cleanups).
+	if ((hooks_key_ctrl != val) && (val == 0 || val == 1)) {
+		hooks_key_ctrl = val;
+		if (hooks_key_ctrl)
+			static_branch_enable(&safefetch_hooks_key);
+		else
+			static_branch_disable(&safefetch_hooks_key);
+	}
+
+	return count;
+}
+
+static ssize_t copy_from_user_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d", copy_from_user_key_ctrl);
+}
+static ssize_t copy_from_user_store(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int val;
+
+	sscanf(buf, "%d", &val);
+	// Nothing to do if we already have it activated or deactivated.
+	if ((copy_from_user_key_ctrl != val) && (val == 0 || val == 1)) {
+		copy_from_user_key_ctrl = val;
+		if (copy_from_user_key_ctrl)
+			static_branch_enable(&safefetch_copy_from_user_key);
+		else
+			static_branch_disable(&safefetch_copy_from_user_key);
+	}
+	return count;
+}
+
+static ssize_t defense_config_ctrl_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d", defense_config_ctrl);
+}
+
+// Warning. This function must be called with safefetch_copy_from_user_key
+// disabled. Previously the assumption was to also disable the hook key
+// but this causes race conditions. So, after enabling the hook key once
+// never disable it (we cannot toggle back to baseline in other words).
+static ssize_t defense_config_ctrl_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	int val;
+
+	sscanf(buf, "%d", &val);
+
+	if (val == defense_config_ctrl)
+		return count;
+
+	if (val == 0) { // Linked list configuration
+		static_branch_disable(&safefetch_adaptive_key);
+		static_branch_disable(&safefetch_rbtree_key);
+	} else if (val == 1) { // RB-Tree configuration.
+		static_branch_disable(&safefetch_adaptive_key);
+		static_branch_enable(&safefetch_rbtree_key);
+	} else if (val == 2) { // Adaptive configuration
+		static_branch_disable(&safefetch_rbtree_key);
+		static_branch_enable(&safefetch_adaptive_key);
+	}
+
+	defense_config_ctrl = val;
+
+	return count;
+}
+
+static ssize_t storage_regions_ctrl_show(struct kobject *kobj,
+					 struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d", storage_regions_ctrl);
+}
+
+// Warning. This function must be called with safefetch_copy_from_user_key
+// disabled. Previously the assumption was to also disable the hook key
+// but this causes race conditions. So, after enabling the hook key once
+// never disable it (we cannot toggle back to baseline in other words).
+static ssize_t storage_regions_ctrl_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	size_t metadata, storage;
+	uint8_t order = 0;
+
+	sscanf(buf, "%ld %ld %hhd", &metadata, &storage, &order);
+
+	printk("Supplied METADATA: %ld and STORAGE: %ld and ORDER: %d\n",
+	       metadata, storage, order);
+
+	df_resize_page_caches(metadata, storage, order);
+
+	return count;
+}
+
+static ssize_t adaptive_watermark_ctrl_show(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    char *buf)
+{
+	return sprintf(buf, "%hhd", adaptive_watermark_ctrl);
+}
+
+// Warning. This function must be called with safefetch_copy_from_user_key
+// disabled. Previously the assumption was to also disable the hook key
+// but this causes race conditions. So, after enabling the hook key once
+// never disable it (we cannot toggle back to baseline in other words).
+static ssize_t adaptive_watermark_ctrl_store(struct kobject *kobj,
+					     struct kobj_attribute *attr,
+					     const char *buf, size_t count)
+{
+	adaptive_watermark_ctrl = 0;
+
+	sscanf(buf, "%hhd", &adaptive_watermark_ctrl);
+
+#ifdef SAFEFETCH_FLOATING_ADAPTIVE_WATERMARK
+	if (adaptive_watermark_ctrl &&
+	    (((adaptive_watermark_ctrl + 1) & adaptive_watermark_ctrl) == 0)) {
+		SAFEFETCH_ADAPTIVE_WATERMARK = adaptive_watermark_ctrl;
+		printk("Supplied ADAPTIVE watermark %hhd\n",
+		       SAFEFETCH_ADAPTIVE_WATERMARK);
+	}
+#endif
+
+	return count;
+}
+
+#if 0
+static ssize_t defense_full_ctrl_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d", defense_full_ctrl);
+}
+
+// TODO, this sysfs entry is deprecated. Remove it.
+static ssize_t defense_full_ctrl_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int val;
+
+	sscanf(buf, "%d", &val);
+
+	if (val == defense_full_ctrl)
+		return count;
+
+	if (val == 0) { // Linked list configuration
+		static_branch_disable(&safefetch_copy_from_user_key);
+		static_branch_disable(&safefetch_hooks_key);
+		static_branch_disable(&safefetch_adaptive_key);
+		static_branch_disable(&safefetch_rbtree_key);
+		static_branch_enable(&safefetch_hooks_key);
+		static_branch_enable(&safefetch_copy_from_user_key);
+	} else if (val == 1) { // RB-Tree configuration.
+		static_branch_disable(&safefetch_copy_from_user_key);
+		static_branch_disable(&safefetch_hooks_key);
+		static_branch_disable(&safefetch_adaptive_key);
+		static_branch_enable(&safefetch_rbtree_key);
+		static_branch_enable(&safefetch_hooks_key);
+		static_branch_enable(&safefetch_copy_from_user_key);
+	} else if (val == 2) { // Adaptive configuration
+		static_branch_disable(&safefetch_copy_from_user_key);
+		static_branch_disable(&safefetch_hooks_key);
+		static_branch_enable(&safefetch_adaptive_key);
+		static_branch_disable(&safefetch_rbtree_key);
+		static_branch_enable(&safefetch_hooks_key);
+		static_branch_enable(&safefetch_copy_from_user_key);
+	} else if (val == 3) { // Full disable
+		static_branch_disable(&safefetch_copy_from_user_key);
+		static_branch_disable(&safefetch_hooks_key);
+	} else if (val == 4) { // Full disable
+		static_branch_enable(&safefetch_hooks_key);
+		static_branch_enable(&safefetch_copy_from_user_key);
+	}
+
+	defense_full_ctrl = val;
+
+	return count;
+}
+#endif
+
+struct kobj_attribute copy_from_user_key_ctrl_attr =
+	__ATTR(copy_from_user_key_ctrl, 0660, copy_from_user_show,
+	       copy_from_user_store);
+
+struct kobj_attribute hooks_key_ctrl_attr =
+	__ATTR(hooks_key_ctrl, 0660, hooks_show, hooks_store);
+
+struct kobj_attribute defense_config_ctrl_attr =
+	__ATTR(defense_config_ctrl, 0660, defense_config_ctrl_show,
+	       defense_config_ctrl_store);
+
+struct kobj_attribute storage_regions_ctrl_attr =
+	__ATTR(storage_regions_ctrl, 0660, storage_regions_ctrl_show,
+	       storage_regions_ctrl_store);
+
+struct kobj_attribute adaptive_watermark_ctrl_attr =
+	__ATTR(adaptive_watermark_ctrl, 0660, adaptive_watermark_ctrl_show,
+	       adaptive_watermark_ctrl_store);
+
+void init_safefetch_skey_layer(void)
+{
+	//This Function will be called from Init function
+	/*Creating a directory in /sys/kernel/ */
+	struct kobject *kobj_ref =
+		kobject_create_and_add("dfcacher_keys", kernel_kobj);
+
+	if (!kobj_ref) {
+		printk(KERN_INFO
+		       "[SafeFetch-keys] Cannot create kobj_ref......\n");
+		goto end;
+	}
+
+	if (sysfs_create_file(kobj_ref, &copy_from_user_key_ctrl_attr.attr)) {
+		printk(KERN_INFO
+		       "[SafeFetch-keys] Cannot create sysfs file for copy_from_user control......\n");
+		goto fail_copy_key;
+	}
+
+	if (sysfs_create_file(kobj_ref, &hooks_key_ctrl_attr.attr)) {
+		printk(KERN_INFO
+		       "[SafeFetch-keys] Cannot create sysfs file for hook control......\n");
+		goto fail_hooks_key;
+	}
+
+	if (sysfs_create_file(kobj_ref, &defense_config_ctrl_attr.attr)) {
+		printk(KERN_INFO
+		       "[SafeFetch-keys] Cannot create sysfs file for defense control......\n");
+		goto fail_defense_key;
+	}
+
+	if (sysfs_create_file(kobj_ref, &storage_regions_ctrl_attr.attr)) {
+		printk(KERN_INFO
+		       "[SafeFetch-keys] Cannot create sysfs file for storage region control......\n");
+		goto fail_storage_key;
+	}
+
+	if (sysfs_create_file(kobj_ref, &adaptive_watermark_ctrl_attr.attr)) {
+		printk(KERN_INFO
+		       "[SafeFetch-keys] Cannot create sysfs file for storage region control......\n");
+		goto fail_adaptive_key;
+	}
+
+	printk(KERN_INFO
+	       "[SafeFetch-keys] Successfully created references to control DFCACHER......\n");
+
+	return;
+
+fail_adaptive_key:
+	sysfs_remove_file(kernel_kobj, &adaptive_watermark_ctrl_attr.attr);
+fail_storage_key:
+	sysfs_remove_file(kernel_kobj, &storage_regions_ctrl_attr.attr);
+fail_defense_key:
+	sysfs_remove_file(kernel_kobj, &defense_config_ctrl_attr.attr);
+fail_hooks_key:
+	sysfs_remove_file(kernel_kobj, &hooks_key_ctrl_attr.attr);
+fail_copy_key:
+	sysfs_remove_file(kernel_kobj, &copy_from_user_key_ctrl_attr.attr);
+	kobject_put(kobj_ref);
+
+end:
+	return;
+}
diff --git a/scripts/Makefile.safefetch b/scripts/Makefile.safefetch
new file mode 100644
index 000000000000..d20276c8e0be
--- /dev/null
+++ b/scripts/Makefile.safefetch
@@ -0,0 +1,10 @@
+export CFLAGS_SAFEFETCH:= -DSAFEFETCH_PIN_BUDDY_PAGES
+
+ifeq ($(CONFIG_SAFEFETCH_STATIC_KEYS),y)
+export CFLAGS_SAFEFETCH:= $(CFLAGS_SAFEFETCH) -DSAFEFETCH_STATIC_KEYS
+endif
+
+ifeq ($(CONFIG_SAFEFETCH_DEBUG),y)
+export CFLAGS_SAFEFETCH:= $(CFLAGS_SAFEFETCH) -DSAFEFETCH_DEBUG
+endif
+
-- 
2.25.1

