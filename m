Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E54E50AD
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617313; cv=none; b=cj5LiqvlXuFKHAIxr0RkdT5Y+s7Ze+Q//nEgEDLMXrosTAbp6uscO1Lr2QxUN1ldXaOgeoFOnCLaWl9+OTfD/mEY5Eth8UPwKqvvvTA9qvam8xAk77Qya+QZT2CPU/WunV76YXotaBiy0sG0M8wM7esLIw0pyIWKntWn5CCsRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617313; c=relaxed/simple;
	bh=oBxdLKzu1tEOdRfcRuf4qFtiL4lcXsW2YMerrRbbXZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aApZ+xDcDQfBfPFmaHY6C2RswFC5NdMUVIkGfdrXUxqTYZsTgzyboUZlP72kaWxoxyINKuX93hwQSU2LWi0fgvSwQRwQAmJP7XY6KNExq52xX2BD3w7JrDxQdztHpD734hQQjTUb7HjnmMUTAp+4O/riiWbfL3yibGAXlM/5mxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7iUmNHF; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7iUmNHF"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4887b0303b0so1873951f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617308; x=1791222108; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/R3jIsuFxLI+ycNCkUkycnkKQylo65Jf0ypcBShLiJ0=;
        b=K7iUmNHFkvdPI6eeZM38hawvFWytRuLT41xJ6X7TBNoi36AvY4jOHai0Z4KbPAs3Dg
         7roEu+nfr8sL/Gcv5LDCwSU1X2RO5Jo3rlZ5KZZM5kxWc54puzp4yx+wQXHDDJHjXkHC
         BJDf4rugv2dWNDx24YC3NmrZRtxqLDzpNDGZu+T8k340d1JDALDHyMdAJtRReoqNSNkE
         Cr0fBH1coDzPKGA6vb5jtz2IFEW4jCfFMWUjLBN+Z86EtdC1orJZqweVM+UoqU95uO5g
         Zb6NGP7VqdXKPGTic5NrSzOYT1/KeH/ul5kvdbcWQFBQIk1ybk8BisiKzAnP2LMaVAq6
         5xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617308; x=1791222108;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/R3jIsuFxLI+ycNCkUkycnkKQylo65Jf0ypcBShLiJ0=;
        b=gUPqiYaqF49Qgv3aJbmoGolB+cR/Xf474BBlbGppgxgrioi1KtF9cLdLNfpzIPOpG7
         4Bci4IjI4M4HUlKPcpCRjCWk3W9DdzohqnDfcRBW3O0O8IvXlCyWlhdJJoDR/p9CUJ6a
         WNQPPEkYvjb9v2w/HNkwQXtjDnVxb0RvCAvwq5kAu9WNONPRk/hOk1ubnZVovuQM/q4f
         MGSaUdngLss0xmS+xz9v2QKyfUlBU7WQR/6PnOPDFH1Vdlqdx6Gwj0XiQOlwM5xtdkL/
         clUB6Gu7m3tCmTLROo8rUP/09b9wP3CuoLpOypMftQAiqWucEYGU+pm4c3sm0S3vrlct
         Tp6Q==
X-Forwarded-Encrypted: i=1; AKwUvByjUXh/OgUcRsccSaepP9eR7evShQrEPjz4j+TcDonGltrsD2gxZHzl/GRKySmbroxY/EfsM8jccpI/bQSsX8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n06LfnoF+Vb8yICiiez8GigDf2jMUuaEoTEMvAkvLBftUkJBg6
	IMGL2ku7oJ/YQxJSE4Uqv4gv8tuVi93OVrhxRyxSaE4dgo4GKsRPpNtZflIdEfT3LMQ2IrK0yoq
	/X3uEbo+QPioLzw==
X-Received: from wmoy19.prod.google.com ([2002:a05:600c:17d3:b0:4a0:23b:31a7])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b1b:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49fe66c8a1emr263025785e9.2.1790617308191;
 Mon, 28 Sep 2026 10:41:48 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:08 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-2-smostafa@google.com>
Subject: [RFC PATCH 01/15] fork: Remove assumption that vm_area->nr_pages
 equals to THREAD_SIZE
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Linus Walleij <linus.walleij@linaro.org>, 
	David Stevens <stevensd@google.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pasha Tatashin <pasha.tatashin@soleen.com>

In many places number of pages in the stack is determined via
(THREAD_SIZE / PAGE_SIZE). There is also a BUG_ON() that ensures that
(THREAD_SIZE / PAGE_SIZE) is indeed equals to vm_area->nr_pages.

In the next patches the kernel stack size will not be a compile
time constant and would be less than or equal THREAD_SIZE based
on a command line arg. Therefore, use vm_area->nr_pages to
determine the actual number of pages allocated in stack.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[Rebased, also skipped intermediary helper variable nr_pages]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Stevens <stevensd@google.com>
[Update commit message]
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/fork.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5ef413368912..2065693e762c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -315,9 +315,7 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm_area)
 	int ret;
 	int nr_charged = 0;
 
-	BUG_ON(vm_area->nr_pages != THREAD_SIZE / PAGE_SIZE);
-
-	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+	for (i = 0; i < vm_area->nr_pages; i++) {
 		ret = memcg_kmem_charge_page(vm_area->pages[i], GFP_KERNEL, 0);
 		if (ret)
 			goto err;
@@ -488,7 +486,7 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 		struct vm_struct *vm_area = task_stack_vm_area(tsk);
 		int i;
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		for (i = 0; i < vm_area->nr_pages; i++)
 			mod_lruvec_page_state(vm_area->pages[i], NR_KERNEL_STACK_KB,
 					      account * (PAGE_SIZE / 1024));
 	} else {
@@ -509,7 +507,7 @@ void exit_task_stack_account(struct task_struct *tsk)
 		int i;
 
 		vm_area = task_stack_vm_area(tsk);
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		for (i = 0; i < vm_area->nr_pages; i++)
 			memcg_kmem_uncharge_page(vm_area->pages[i], 0);
 	}
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

