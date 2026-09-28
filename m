Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C04F052B
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617320; cv=none; b=eR4GnJGMTFwwL4MnC/LPHwGxmretChOQL0mLnp6FPo/btxson0uahBMsSJh+2J7FmgrNSnhizKhjKYVRh2LvquL/3niQ73rPyOPb7ucmp2Lkd7HRWe70y/v4+KozHSCejLfMDpzWK4ENnaHXgxaSaOPh/xa1UJR08J8krD5xhmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617320; c=relaxed/simple;
	bh=fxbdyOtQyXxGPt9dE6qJI2lO85bbyV/d17xndfVGn+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AWJsPFd3WOr+16+UW4jz6dKlQQFC+WClcPIT+on/gnv8GL0G8+T0zx6nS4nwwn4XxlIOzoSfu8CURYJqbLCwEKJM85TTgBBbUHiMxfnVTpUp6694gLrum8a+XgPanqi4aPsqgg2mtnJkRNI/jVjO+WYjSUeOzThIwc9gC1rIwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qx/ZR6PG; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qx/ZR6PG"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso35203545e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617316; x=1791222116; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ci6kw3U2QUuQ8iEQWyGnN3yV0fEIMUBiQ7ACCZCMmiU=;
        b=Qx/ZR6PGU3d/Y5pORJOfCc4fPIY3UCdq8sHmkmxRq8+Ixuqa9If/prcX2nGUH/YWDH
         V31xpP4upmF9E0oqzUsqtUEW6S7AwBYJbzNd79Aun/d4VnLJPljsWqbM97LKpQuF9xn0
         nilNyi5W3utDHtWXc1dQhqqK1TK1VdzvCtbb2fHaLEXRb5IF3P1frHpeNOBMwMvYUWFS
         kCjN11FjLVUZlqO5ikGhSMIewbkq3i7W3akEw/ShHOA3AvpYKLELmmIeTqZweVnAh9xH
         5kmmBTt1g4+PpwBSd5mPucc7ZUUncEgzMeWKMo1tLTSkdei/ZZT/KtXzARgcBHMFmIMf
         tLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617316; x=1791222116;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ci6kw3U2QUuQ8iEQWyGnN3yV0fEIMUBiQ7ACCZCMmiU=;
        b=KqeqgmUm+o9FoKgIS5lQrTdRME42qjd7rjjhbwFiXl/4EpZWllFsICUCD83GmxZUAB
         W1HOf+xdtXC0Pe0BkPAC2dHVRnKXaZ+80CPvbkz2FsRGk2HS3FaVNkckS8Z9Zswo2at2
         0Uz3MlWw2zXGenG1Tuitt3qHca8KYTzYaIkD6dHLVkrRJHDqa6m66LWzloBv4mlGgsWq
         VrYUCgxNZJx4yktktaZOJlr9PnsDqHG8wATDVIdcYkhE7Ya26b0VAxPJLhK0yRUKcKIM
         CrKAsyeOw+NxAoOucR0r3/etCZnVVfjdVsZm/JB8ZjKZg/6a9ExKovjCPgRJ0Id9KoME
         mV1Q==
X-Forwarded-Encrypted: i=1; AKwUvByDw+8/s0U0ke/IPNrURPTqFMtCeYjbmlvvj+Hy9NmB4zuVTziMYJsvtKblFY7M0dyDKODSC3mzd9NbtQlNrL4=@vger.kernel.org
X-Gm-Message-State: AFuF++n8QBLBngxZsHBfOrQ5C9wXmwhCy1brjq96DUJvOmJyR5Zt7vXM
	DI9L+haY8D8pVddWhC0Ioh3H1OIbaYaBFwyD/+DAh9ezb5QUpLLCF5k+RJp4onKgtYPCs4VJVNg
	5MIrKpGJ3RWH5mQ==
X-Received: from wmoz7.prod.google.com ([2002:a05:600c:787:b0:49f:e26d:37ea])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a16:b0:49f:eddb:bcb1 with SMTP id 5b1f17b1804b1-49feddbbe6dmr202116635e9.25.1790617315540;
 Mon, 28 Sep 2026 10:41:55 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:14 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-8-smostafa@google.com>
Subject: [RFC PATCH 07/15] usercopy: Don't assume the kernel stack size
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

check_stack_object() assumes that the kernel stack size is
THREAD_SIZE.

The allocated kernel stack size may not be THREAD_SIZE anymore, rely
on the newly introduced helper task_stack_{low, high}()

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 mm/usercopy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 5de7a518b1b1..f31a42b9f9c4 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -36,8 +36,8 @@
  */
 static noinline int check_stack_object(const void *obj, unsigned long len)
 {
-	const void * const stack = task_stack_page(current);
-	const void * const stackend = stack + THREAD_SIZE;
+	const void * const stack = task_stack_low(current);
+	const void * const stackend = task_stack_high(current);
 	int ret;
 
 	/* Object is not on the stack at all. */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

