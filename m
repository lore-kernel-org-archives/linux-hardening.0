Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F154EC66F
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617318; cv=none; b=Qxl227kM8gTgMhj289kxHy0DNH3B2Pkit1AR/mXfyqrxPXvAioQUQhnBzDDG4nm1bj7gTAMt0SlqXenk6MJxi6pf1Gt/B3A+LnUAK9HW67K/r6lp4j60icQpgy80IIMz9SUjGgzZ66YGYo+QOjtIqxyBzNddjjLETfi+tJIaef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617318; c=relaxed/simple;
	bh=92UIyLy7GtKPROYl2Br7ZP/exzYZtpSXAMuolLK+K3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cdkglu0LA3hEp+AGY/giGiNrp8VJf6zqOj/mzDBO9rLbr5K5wEL41xY3d6obcO59XJ2hUDfKjT0LKKUmHrXxoqoIpZC08SQ6sIXW+3LgOTV+KOR4+iZAHsb/qfGKjmvL0mnjydCfrOllH7GMKg8l5zY8GdiXXdhWDqKHLt/P2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLsfqJxW; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLsfqJxW"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so28031905e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617313; x=1791222113; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLizaoNOz6hydwy+EEJKSgP0D8TbobflQ2CjOBToA3A=;
        b=nLsfqJxWSua0QwmHUFI2GZjRHL5NB/vnb24Rh/xuKWfxf9VJtWDKn0fJYUwINJp5Be
         Nqi/AmzLeZ/S8OVyewsBlXbGketoFwA73JlcKAl1+p0f+XdQo2LetNO8BI8WSSh35/Pc
         rK7/FOwB2HYxFrAnmPUrsApNI8U8YUIwP2HM27WAYOPRg+YiBSzn0rJHR8b6NiQZamJw
         KxtNIzLTdTA0WrwYwyAB5pJxQhyfL/Bnn3qJAFEJAjfMF47TWDPOakZgSVyTUHauhNyo
         nmN1PKuZGZ/8t3GbKixyRpcE2lBHFbfR8ssU0t5IJSbKnXHKYdm0ckmec3mIHXToMJB9
         8ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617313; x=1791222113;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLizaoNOz6hydwy+EEJKSgP0D8TbobflQ2CjOBToA3A=;
        b=OZeQxZyT1/2BBT4DPN8tca5ob2Kr61Ufj+kAegXrBKgoyNww+3009AIT5sF+jW6n9q
         lp1Tm6C5A4scXVoq2IhbtDnnOOm52IyC7b91pj4vFsaSsOA0PEKWF/FjzKY4WuRWmXoi
         QNAT0uVxDC64auj5bqYj7WU7yDcNpJq6I/+jpkExgG3R0Fh3MAcpvA+87Tkuc6qKASTc
         sxy1oRzP31qaQCfEVvzaAgCR1bVtgWQZfwW8qe4VviW6UQISWcqfJ0gzwSsK56qUNzEi
         KeYZV7iWV8Jpq9WTaqpSfNyJb80OfJ1ZOGvvaBDy1eVOauy18d4LU+9fUh99qsN4o5oY
         B/Uw==
X-Forwarded-Encrypted: i=1; AKwUvBw9jTGukDIHcmJpegKuZVsvzYdOjSEQvah++QJpWoBwqhdVHWwoR6euyBzNNyjETWDt56Uvo4cqwVshQ5gN2Sc=@vger.kernel.org
X-Gm-Message-State: AFuF++nVKipxL7gHEMIprsULn/jo3xzcamY+Dz9cN93h8fIFVJ8Oi7yc
	T8VY5is1cm831pjo/T7gqpdru6jffpIgl83qdbDB/ichYdfEwjOGpGCjhVR8o30LRHiqufCMEMW
	dG2X7CTd/t7Z+Cg==
X-Received: from wmnb21.prod.google.com ([2002:a05:600c:6d5:b0:49f:e43f:afd1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c5:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49fe66c8623mr231494305e9.1.1790617313066;
 Mon, 28 Sep 2026 10:41:53 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:12 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-6-smostafa@google.com>
Subject: [RFC PATCH 05/15] sched/task_stack: Add helpers for stack high/low
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

Soon, memory mapped for a kernel stack can be less than THREAD_SIZE.
However, many parts of the kernel assume it is.
Add new helpers for the kernel stack that can be called regardless of
CONFIG_STACK_GROWSUP or the kernel stack size:
- task_stack_low(): Lowest usable address on the stack.
- task_stack_high(): Highest usable address on the stack.
- task_stack_size(): The size of a task kernel stack, it is still
  THREAD_SIZE at the moment but that will change soon.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/linux/sched/task_stack.h | 56 ++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 1fab7e9043a3..4a808f9c4631 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -13,6 +13,8 @@
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
+static __always_inline void *task_stack_low(const struct task_struct *task);
+
 /*
  * When accessing the stack of a non-current task that might exit, use
  * try_get_task_stack() instead.  task_stack_page will return a pointer
@@ -30,7 +32,7 @@ static __always_inline unsigned long *end_of_stack(const struct task_struct *tas
 #ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long *)((unsigned long)task->stack + THREAD_SIZE) - 1;
 #else
-	return task->stack;
+	return task_stack_low(task);
 #endif
 }
 
@@ -64,6 +66,53 @@ static inline unsigned long *end_of_stack(const struct task_struct *p)
 
 #endif
 
+/*
+ * Kernel stack layout, higher addresses at the top. task_stack_page() is
+ * the start of the THREAD_SIZE area, task_stack_low() => task_stack_high()
+ * is the usable stack.
+ *
+ * Case 1) Stack grows down: Only the top task_stack_size() bytes are mapped:
+ *
+ *   +-------------+ <- task_stack_high() = task_stack_page() + THREAD_SIZE
+ *   |    stack    |
+ *   |      |      |    task_stack_size() bytes
+ *   |      v      |
+ *   +-------------+ <- task_stack_low() = end_of_stack() (*)
+ *   |   may be    |
+ *   |  unmapped   |    THREAD_SIZE - task_stack_size() bytes
+ *   +-------------+ <- task_stack_page()
+ *
+ *   (*) Depending on CONFIG_THREAD_INFO_IN_TASK, end_of_stack() might be just
+ *       above it.
+ *
+ * Case 2) Stack grows up (CONFIG_STACK_GROWSUP): The whole area is used.
+ * No support for partially mapped stacks.
+ *
+ *   +-------------+ <- task_stack_high() = task_stack_page() + THREAD_SIZE
+ *   |      ^      |    end_of_stack() is the last unsigned long below it
+ *   |      |      |
+ *   |    stack    |    THREAD_SIZE bytes
+ *   +-------------+ <- task_stack_low() = task_stack_page()
+ */
+static __always_inline unsigned long task_stack_size(const struct task_struct *task)
+{
+	return THREAD_SIZE;
+}
+
+static __always_inline void *task_stack_low(const struct task_struct *task)
+{
+#if defined(CONFIG_STACK_GROWSUP)
+	return task_stack_page(task);
+#else
+	return task_stack_page(task) + THREAD_SIZE - task_stack_size(task);
+#endif
+}
+
+static __always_inline void *task_stack_high(const struct task_struct *task)
+{
+	return task_stack_low(task) + task_stack_size(task);
+}
+
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 static inline void *try_get_task_stack(struct task_struct *tsk)
 {
@@ -88,10 +137,11 @@ void exit_task_stack_account(struct task_struct *tsk);
 
 static inline int object_is_on_stack(const void *obj)
 {
-	void *stack = task_stack_page(current);
+	void *stack_base = task_stack_low(current);
+	void *stack_end = task_stack_high(current);
 
 	obj = kasan_reset_tag(obj);
-	return (obj >= stack) && (obj < (stack + THREAD_SIZE));
+	return (obj >= stack_base) && (obj < stack_end);
 }
 
 extern void thread_stack_cache_init(void);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

