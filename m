Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2F34887B
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617321; cv=none; b=fwscLEr0ldzxt2OsoRo/DmAVFwJcEkGbaVRA8X0yN/c25MlwfKQoHpuaBRj7oRJPDgAVCP8Cv9CGvmmZWcJvAB+5yKedSacuOqFPevP/02xNA9JHV+lxjlgfVKehgDJGdZnfMCwjjOYJIR3ffQxS+nE5ZQS6ni3U7WpmZJvBuRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617321; c=relaxed/simple;
	bh=OjWnAwqkXs+i44MTqOp1Ck5J5mQ7pY35YplCenpi9Mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M3eAv8CRnmI8IZwyxGMXsTCL+5sOo/4YaFM1376bRSCetToyteFy1kGELmi9Ixj59hsIE43fCuqQDLpWpVO+EVoRcP9GKZMsiFCqwLFT7nZIbbHE7fHFPwHN350VzCZqn4wrRdB7nKajLnsEq01t0Z5DHJAxYRhJzmRG9ngA1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhkNQzfK; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhkNQzfK"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4888382a9e9so1863752f8f.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617314; x=1791222114; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUO525MYjN5YsfP/KDhp3xMzNW05smVZVp3S7wkbxmU=;
        b=GhkNQzfK74LzqYlGLXENrhteifhPIk5q689GbRVErIK6osnD7gRq0aQRMBfmIShMpQ
         4Ri4wNOvGKjiPmcy82hoDGOtSmm/jb0mjai3bAA8rMtjforAENUVCiHsqeVlqTsb1tla
         h5tuGcMopU/6BwCqeXoC560cpD8SEr3va1g8x9Edo+wF1W7RjQT9tPh9JJTM/me6kpQX
         ESg9JTeJSaSoQp6fuhvb4S68T59Xge0lm372Ne6i5yrJZtH2NRc5szRfc1v0dhzkdqk2
         aQ160AT3zR44ZoMFJZWSK5ahbM+0wbeLjxmITmTyK3nyeyNFywbChkSEOI3xR4vrOrF8
         QJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617314; x=1791222114;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUO525MYjN5YsfP/KDhp3xMzNW05smVZVp3S7wkbxmU=;
        b=E/YhJm7kopO6mWZXhdAWgYnOIsCbTuSg23vCuvnth2zRIVwbVkHe7XhBTnUEldqDy/
         umVI+WrUU806jiclb7eq8Tw5JRwnX8zkexHD2U3sXyxSa9g+WGCV33ACyAClj95+BaKq
         6MT1vfq3ffY1vuHi3I2AcuHKXYs8Dme/cl0nEvCN+JA/NTHvRV8RW0xHY0YPc6V3aydw
         jKHb2hhrrblMVROwUsRoYTHgCBydKbfGHrfizmeali8gw66bPfbsliLTYYmWpFF0a2HF
         RcrgrnT8AO09YDJ6RtWCaUF21Bty043b8YKed3u8ninfW2ql03OzkhriU19Ix0BQjovq
         ckIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjX5MKUcdUAaDC/km+vdc8ziAI6qtPe9YzlYdNZCjmIei3bSbb1esDMf6ipoTqUYU0b0iSCHYH36+ZcwF7fkA=@vger.kernel.org
X-Gm-Message-State: AFuF++kNxPmvpM8UdgI89Nb9AIi1ODqSO8SUCHv5rce2S7VQmiLgX+A/
	wu2mQ4mGyfhE2zDdCEWqs7Rgchy/maozrP1V5hi2ZB04T3q+FNkmCR0c+LkbqfWD64a4jn0Kzsi
	g2CNeWUjfLp6DgQ==
X-Received: from wmgb3.prod.google.com ([2002:a05:600c:1503:b0:49f:fec8:8e56])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5487:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-49fe66ee809mr241216335e9.22.1790617314094;
 Mon, 28 Sep 2026 10:41:54 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:13 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-7-smostafa@google.com>
Subject: [RFC PATCH 06/15] exit: Don't assume the kernel stack size
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

check_stack_usage() assumes that the kernel stack size is THREAD_SIZE.
The allocated kernel stack size may not be THREAD_SIZE anymore, rely
on the newly introduced helpers task_stack_size()

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 424c44a42a4d..899d3bf048d4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -883,7 +883,7 @@ static void check_stack_usage(void)
 	unsigned long free;
 
 	free = stack_not_used(current);
-	kstack_histogram(THREAD_SIZE - free);
+	kstack_histogram(task_stack_size(current) - free);
 
 	if (free >= lowest_to_date)
 		return;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

