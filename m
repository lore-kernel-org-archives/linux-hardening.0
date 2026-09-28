Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6074F4CEE
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617328; cv=none; b=E00Us7PEN7xjdjsKP3cLinFtaufGnUsl1LLNN0prWA8iCnVSUxNRIOaaJ/ejUhA3uiU7Dt6HHZm/rFHZ3Pp82I62wJUVvodt936q7IbJUwJFaB61g5wZRTNUvVyHlh+ARnSARSQP7WFP/hzH4zxdJg9aZ9DhZ+QEs7CBV6+FARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617328; c=relaxed/simple;
	bh=fqb9OvcrF+1YGNg2ZQpu0FVkmCJMPIgeYZw98qjd2TE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ct1z8G6KPaazl+X4GQXzXn66gZA+1poGE9Vhh020/7JPrGVLfMEkB5f4nkcpL8XHkcgX5VlSxu+04K1PmAgo6xRNIRquVmws38C4m4tP1rD7qLvzgBgXIJDW2fQBiZEZ0iRHGgHrtAG1/sS7o3zPBj34pQeDF/mFPmyCMHC6J98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9oWZ0rV; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9oWZ0rV"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49fffa5de0fso25076575e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617323; x=1791222123; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5BgLva5vXrAwBl9Y3v1BBOsVeywVgMCKKqE5NVyRxk=;
        b=R9oWZ0rV7gKjtA+la0UmSJwqWvDqq8wPLqFAoKyMDtFhs+vbe53tpGCRzWJ9ioM8F6
         MZksfaaiPsdWKeF9s75UWfH005UDaew0pgQPt4kE2S/O3XZuJ7PNkRZekOjBByC1ietp
         /WWRysDJT2/2FG/y+UryCV7l5fWn4Mt+FJlpcbD+B+8L6DLhBifTJVYlpI3q9RdRpNJ5
         pCzff2k5EJbV9W5yOnqn5NIDZ5ws2C0oS4uK52rsdaIQeDmVPompBLDRP+GHORm/SZDm
         UASyolwVaW6G/QQ3sN79899OUbU4HhV6rZkcpqLNXCcBYBCO1vsB1gs2hfo1xCcVo1J3
         IYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617323; x=1791222123;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5BgLva5vXrAwBl9Y3v1BBOsVeywVgMCKKqE5NVyRxk=;
        b=2p4k2JPtK2QvAJw271TXPxNvCjh1qZgguMDjrPyURF8wMeMlzR7FvEohtl1LgFK1tq
         LsCMZ1Z8GsO7sX9drDoEEvmZjuiCguuIsgmSsHmomg3PWuDesoVLZQgKicf46P1Gx0GM
         +vuFDX/7D3UuBHV35UlS6SO68ZckTrfwZqNvqUbWx9VQKWF76wMH/QuHbNf2kBExrBUL
         vXCoA5/6wP6k9WiHjYNN6vufO3MBo116+i550NUI+Dlu1sDjmXzqRhmq1vGG1NxtBlFL
         MZif0VkOXqLEj+ZK2HO6vy5xNtIaCJDjRuS2A+HCPLfSM7gp9uvzavh45q1lukkX+ShB
         S86w==
X-Forwarded-Encrypted: i=1; AKwUvByNOxD8djdQtUh+Pigb6/kpOMQhXDeX8+5kOaWv4aDNfASPhdAtLK4SRQl52aOP7Vjsq/wgcB+KdNWnm6cgEZw=@vger.kernel.org
X-Gm-Message-State: AFuF++mB7RuzEVawNejrSjCoswbdgvubhwd+8X8TwlNsLh4SXou2XptM
	CvVPuTikGKx+wX0dARmDETxLrQiYxS9bKdMYZ6U580wzas60tSl1vJZ6EqXqYZCjDD2bsIrZ3K6
	z9JUNL6iEvvbE5A==
X-Received: from wmhj21.prod.google.com ([2002:a05:600c:3015:b0:49e:8337:33d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c4:b0:49f:c331:39e4 with SMTP id 5b1f17b1804b1-49fe66ca101mr236733115e9.7.1790617322864;
 Mon, 28 Sep 2026 10:42:02 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:19 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-13-smostafa@google.com>
Subject: [RFC PATCH 12/15] sched/task_stack: Introduce ARCH_HAS_VARIABLE_STACK_SIZE
From: Mostafa Saleh <smostafa@google.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	akpm@linux-foundation.org, urezki@gmail.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, kees@kernel.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, gustavoars@kernel.org, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

When CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE is enabled, the kernel stack
may not be fully populated with the THREAD_SIZE virtual area.

Teach task_stack_size() to return the size of the vm area and not a
fixed size.

This propagates to end_of_stack() which makes functions like
stack_not_used() and set_task_stack_end_magic() to use the lowest
valid stack address instead of THREAD_SIZE which would cause data
aborts.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/Kconfig                     | 10 ++++++++++
 include/linux/sched/task_stack.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 45c657772362..d6fa2ccb0599 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -431,6 +431,16 @@ config HAVE_ASM_MODVERSIONS
 	  <asm/asm-prototypes.h> to support the module versioning for symbols
 	  exported from assembly code.
 
+config ARCH_HAS_VARIABLE_STACK_SIZE
+	bool
+	depends on VMAP_STACK
+	depends on !STACK_GROWSUP
+	depends on THREAD_INFO_IN_TASK
+	help
+	  An arch should select this if it supports dynamically configuring the
+	  kernel stack size.
+	  For example the kernel stack size can be from the command line.
+
 config HAVE_REGS_AND_STACK_ACCESS_API
 	bool
 	help
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 4a808f9c4631..07d73adaecd1 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -10,6 +10,7 @@
 #include <linux/magic.h>
 #include <linux/refcount.h>
 #include <linux/kasan.h>
+#include <linux/vmalloc.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
@@ -96,6 +97,10 @@ static inline unsigned long *end_of_stack(const struct task_struct *p)
  */
 static __always_inline unsigned long task_stack_size(const struct task_struct *task)
 {
+#ifdef CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE
+	if (task->stack_vm_area)
+		return task->stack_vm_area->nr_pages * PAGE_SIZE;
+#endif
 	return THREAD_SIZE;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

