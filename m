Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53774E8DF2
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617314; cv=none; b=Ymi50VJsmXP0TjevwVTnI9lro28KAjj4eRIb6qVlMFm938IUnGW7g9U6bxbCEFnldS437eDSryTck7Bo57GtWwBoDYwIj3GAUvvGI5DXI/SI1shIWo8nUIPmnA/Fz8QsDS7MFAtc9yJoq/tsY2OTZ6hPN7wUL3MRhRg0KzN1nUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617314; c=relaxed/simple;
	bh=ps8Vmpk8/Dvb3HvPEQ6r+gA9DsFwPpmM0auDoTT5Hck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rO4cOK0HYLkECgZnKSbONdV3INjylPpsmZIYT2fe1yRIEwWqmEr0cB8LW3YarIADPee6G53XyTwffVzGvLAzPFcR4GoU5TgPZ1DD9YcXZs33o9Czz1Lpwge+VN0IyEbyGD4CBSzLGQx7SuyfN9VeJyOW/hgKl61YA8a2Ut1SXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQ2fSWEm; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQ2fSWEm"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6aafdd5a5f6so2747654a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617310; x=1791222110; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tQQXCFUTzEuKqqGshgMGPB+3UWOKCHMCwqurMu3nBP4=;
        b=bQ2fSWEmzZ9zW4RPf8dbVeEhbqHUGuKVnTGanb//+7Ny1zSGO3V2gfWIzIVSQb9wHX
         CkXileWTB3aRfAL1e6N1z/dFnZFOb+/eyxUqzZVsdIDGIFmIJ4vyPPq3jneu6UkM9VHJ
         RoadS1TTDbZv3UpZTWzlJ6ztT/kDnJgNFtrBMbHePy1zRSzbxb0VBZYtOEiNkicHDeAH
         JQB8uqIotPU/LIguh1S4iEPrsfeZmHLBeK0Zc8aCNfrBEpFAUHGpaW6tyUEV3OSOpvAS
         ouO0C1hgSQoQcn1fk5LhOiOtgy2rzHGBYED7ZC50uUhjB4bg1RzpC0o5wtEpDTDnxdN9
         NEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617310; x=1791222110;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQQXCFUTzEuKqqGshgMGPB+3UWOKCHMCwqurMu3nBP4=;
        b=kTXb8TfD+2ZcmQoP41IOsi5qFQNOQdcv6qLrIrmpLJ3xDeYPP6c1g8mfRkOORH/n/I
         mty6HrnaYUN/vvqtNPnRGuc55ZBUKgNVA5BVyJtan1DiwR4Ad+13Z1xNnxymyvuVRebf
         EpGAlDyDFh0yY+G2oqlAGdVNHpUaFeVBuP8zBEC391gOFqAiQsTzznoR6bFKbsrGiaZe
         q0nyxu8n19aTIYQuaPsAG6VGx0hS19rwGawbGR/m2EJw9Cn0onKrF3L0+W1tgVLi9ist
         RQubHBHp3sm0jy90a7hUUJl5JBVUanLnsUi2HXT3WItYVOR7x/xCCJRz3pQQ8RRoyXOy
         Qc/g==
X-Forwarded-Encrypted: i=1; AKwUvBxJEYhvX73FYVc7kMRclcD89M3qXEcD8RQQvc7koX5aqMoMwwrTJkofa2/Qri8+XL2wC7IypkZgWIwwoqYVCus=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuS/9wrw/RuWSdrbQ0HjG9Yr/GyL+vw3RVyALC3cw7G1+fgrWh
	ap8KJ+UmiRgXW2PqX3lSQJW5T3+dLnePCHsp7CgEm0fmsIzQNvXoYPaiBwAWirKpdzJYC/1uLg7
	EW9P35Z4RU/i6wg==
X-Received: from edfz6.prod.google.com ([2002:a05:6402:a406:b0:6aa:1383:f342])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:538b:b0:6aa:fc60:60d0 with SMTP id 4fb4d7f45d1cf-6aafc606c77mr6303087a12.33.1790617309305;
 Mon, 28 Sep 2026 10:41:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:09 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-3-smostafa@google.com>
Subject: [RFC PATCH 02/15] fork: Don't assume fully populated stack during reuse
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
	David Stevens <stevensd@google.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Stevens <stevensd@google.com>

In preparation for partially populated kernel stacks, don't assume
that vm_area->nr_pages matches THREAD_SIZE when clearing a stack
for reuse.
Note that the VA range is still THREAD_SIZE in that case but it
might not be fully allocated.

Signed-off-by: David Stevens <stevensd@google.com>
[Resolve conflict and updated commit msg]
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/fork.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2065693e762c..ec4431bf309a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -335,11 +335,16 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 
 	vm_area = alloc_thread_stack_node_from_cache(tsk, node);
 	if (vm_area) {
+		unsigned long offset = 0;
+
 		if (memcg_charge_kernel_stack(vm_area)) {
 			vfree(vm_area->addr);
 			return -ENOMEM;
 		}
 
+		if (!IS_ENABLED(CONFIG_STACK_GROWSUP))
+			offset = THREAD_SIZE - vm_area->nr_pages * PAGE_SIZE;
+
 		/* Reset stack metadata. */
 		if (!kasan_hw_tags_enabled())
 			kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
@@ -347,7 +352,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		stack = kasan_reset_tag(vm_area->addr);
 
 		/* Clear stale pointers from reused stack. */
-		clear_pages(vm_area->addr, vm_area->nr_pages);
+		clear_pages(vm_area->addr + offset, vm_area->nr_pages);
 
 		tsk->stack_vm_area = vm_area;
 		tsk->stack = stack;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

