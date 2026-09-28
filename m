Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086364E06EC
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617315; cv=none; b=sVTr1nkfoLMi8mXxguXU8jXHQv6ivzz/L6T4wQ5Zt1maKuTT3W2jPBoYT00lWsxyx92fdT4Me903+RsytGotM500XAYymJCNxMjfSSNgRKjCDr2H8onLvnnPb4ZlnLkdN2+ZXtlj62XkHkGBjgcEAyuywqoT0idjC7aOl3pkKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617315; c=relaxed/simple;
	bh=4i8baIAc2dkPaONbaLPORXqEKtv4vzfNmgQCV2XNs9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ruxAZ3r19J/iYAmmFJBmbLct6qjSFt0sRzLdXpIBMo2OT1edocQGZwUOkHbCSbKayMdaqYVQaRETFx9w2QBHVhY57Ow2EimTx0zu+EFucjnoUqWh25F7sjUzMOVKxC0aXHh7ce/dzHghtxIUzuj1oN/PKs3RhCpx27Edcfog3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HLcXuZug; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLcXuZug"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e745d5dabso32461735e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617311; x=1791222111; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMttkoCzeXLC/JEGKL20pI+XNOolXdLvFIFeMj04zLo=;
        b=HLcXuZugBloA2b3C43tnwI7Qzd2sVPbUxdX7zXFeEmG12jO2VNPCXIqyGUvMWU2mS/
         NopYAG6zsnKpll8eoJfG+eCaSgVfT/mNjtbBteo/RwGwIKOEztSMTx/qYNRhoY/0RVzu
         0ZCBj4wQaRfgjTjJ8FfLuNkBDVo+iH8uvdddnG0QL6qE0+7Km/Ph1WEVvnfIjrzRA+iK
         k6jlFHpj7QumNTvBHQUxQ7lRAV0cZOcwtrs+X8iONyEL/H/vkRdqZfp65YFYjqVdNjWr
         Y03jyP0HUm5SUVva2B/U9njitjg+tHtVdRwgM7QYCkGSl2rgtv71VfqvhfNp5wTHpMO8
         85Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617311; x=1791222111;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMttkoCzeXLC/JEGKL20pI+XNOolXdLvFIFeMj04zLo=;
        b=y895ZEsQ3EjKJrNRdj6ttQN2vXv3Y6g0wmWuvcmepEivC1UA0SVnXWOO0ogNCAfJTu
         RXQW+XhaXI7EsMdV+nFTLnWLwGaRW2C6iuK/1FVLtewQaVfTnVpLONLl9931RUPNw/mU
         Nb7iDNxLXXVMa2ce2OoNtnV4x0eFUC/seB60hamCbgbHm6zrUwljoiDUG7tX4hLAS+/a
         6oCOE6LusnYC7So6Cp5mjojf37kUMDv+Ydn4vdggjgjp1XpitCnvW7E0YQTJMYStVdgR
         nLomXeNI7/BGhlkQ6eRkVqzkuIquGJ7GrWdYWRhMypAJH8iY+m6bXFhA/Eb4d++twxZT
         E/Mw==
X-Forwarded-Encrypted: i=1; AKwUvBzYvopqhW+nBjveSWm5aXK8NXwa/bUy6lLAKHNmkfy9H8MVr59Pw2p8UBv9naz/1WsPi25t+btqGQ4pxUadiZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++m5gIR/ei6CuXuOAUX4O4M9tNYwOzI6L55hfkKiiZr+qVwUODMx
	/pG2lAT/dKPF9Ewz97EZdbgRJJNKoW0hsXa+A1ZY4iIjrlthm0T2S3KpEc5oALCsZ1heBPsK+wu
	JanzIaIWtZAYoKw==
X-Received: from wmqb10.prod.google.com ([2002:a05:600c:4e0a:b0:4a0:107:e5c1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b4c:b0:49f:bd3c:bc16 with SMTP id 5b1f17b1804b1-49fe66f4c16mr231430235e9.17.1790617310870;
 Mon, 28 Sep 2026 10:41:50 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:10 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-4-smostafa@google.com>
Subject: [RFC PATCH 03/15] fork: Move vm_stack to the beginning of the stack
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

The vm_stack struct used to free stacks via an RCU callback is stored
directly in the stack being freed. Make sure it's stored at the
beginning of the stack regardless of stack growth direction, to avoid
faults on partially allocated stacks.

Signed-off-by: David Stevens <stevensd@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/fork.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ec4431bf309a..473878d7f62f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -285,7 +285,12 @@ static void thread_stack_free_rcu(struct rcu_head *rh)
 
 static void thread_stack_delayed_free(struct task_struct *tsk)
 {
-	struct vm_stack *vm_stack = tsk->stack;
+	struct vm_stack *vm_stack;
+
+	if (IS_ENABLED(CONFIG_STACK_GROWSUP))
+		vm_stack = tsk->stack;
+	else
+		vm_stack = tsk->stack + THREAD_SIZE - sizeof(*vm_stack);
 
 	vm_stack->stack_vm_area = tsk->stack_vm_area;
 	call_rcu(&vm_stack->rcu, thread_stack_free_rcu);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

