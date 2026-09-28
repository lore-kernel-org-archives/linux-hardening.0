Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F174F3EA9
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617323; cv=none; b=n1vmrNrhaLftBWmmVVUrpovFUD2x4Wr/vi7BAS+1rRvEvEk+qGhg2z9icZQLsqj5txxObHlICvDmJgeHmqlGy2RILPymJ78MCm85PcB0NGQjqFaRpLuOJjYr1DHw897TJ1K9YNbJ6c+L7DrF16YgRh8kFPI+lDf8MBgoVGZkqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617323; c=relaxed/simple;
	bh=ociixwuu60tID8XiJyfQ7GPM3G87cit0sEXbMZxlYyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HTAwebRnFfcqVAbzW0shYWL/SeUkbkXGL610Ly5FRHdkcxxvyZhwx9RyQCW0Kwz4jrvsekwsTL+dsuut93Iugq4KnueStBjqj3oc8WX50LYrTqy18A1u4jU0QtI8LDNeEe24omYavNN2vIEsEV4DZE87IXFT97BP0n2qeCZ3HPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxFgw8+P; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxFgw8+P"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-487038bc9b8so2350069f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617317; x=1791222117; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/9CJBbG35x+y3Ddsn+TP4ZxkCLdkVf/5InNQKQpJMA=;
        b=LxFgw8+PGVwCl/rtilp2YgTd+lm5bphuVLYTvSzDjbybKVBAtR2fhEieRGMaPnS9oA
         LELLGGAbOO/ZDVLsbHPGHpSi8WVQnCVNBSbZX/PLAWSWmsdCHA1PShpCO8C4GMIZcb81
         YI5q0Ua17GwIlFJ1Kir4nZxIuL71augnOZ6lDu/y4OOJaJZ96Aoj01B8h/TCNCWgl5Kc
         4q+pMl4I64HGZKjkaZQhTkF8hle61VBtzAQ4XFO6tRkijwHKolgeZtVQm5WW3rwFZ6Jd
         +cRJUiC6YvxrJYeXje1dkjROKmwKFx2aNJPtYCAsLjmd5nxaBGAIKddh6i2QcgFDqnMH
         IcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617317; x=1791222117;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/9CJBbG35x+y3Ddsn+TP4ZxkCLdkVf/5InNQKQpJMA=;
        b=tOxSyr0thg/M4xUPgq58WUiOk/AXSdfnTA1JQcJwqfdAimBDToBwiEwyWR+zN4ZQTp
         OAiQjt8yNU5g6ZAc7p+zziA+wm8nMZ1ut0q2ro5KgMJKv4sEXQ/90Zo40TiAX1FOGJf+
         XHLCrPmFT8l16orhw54dJq4JH5FdbnsMHQ5FwdoTrCANtPtKhrUsRe6kB+sb2JBbOezz
         7BUjWpzGj0Xt/S+FtM2KLVRhGZ9nHx3cfIlXspuHRQUv7+b/Vxh8nB+3aBhjjVRWafI0
         azbwVj/CCT7aMssDeJ0d8KOB09w980Y8yQ9sUNRg+jJ70HYKqRxNReUfZzYSn1UbBB7E
         zqjA==
X-Forwarded-Encrypted: i=1; AKwUvBzz+eNj3fCZvYD4bCOyOy8+9ZW2PwR+52dc7SFC5QKkbeZB30zaTyVGac2igLH8g5PIpiuTkTeIjc3aGd4vz7M=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/ADeD5Znad9kl8/vnoj7HuNd+Um6yPt3aGnvZ9TKuq5+plglq
	6XDQbKoqROobKxwVsDaA61RPw6Ydj9gQGcTaQX/SpfWAzjVpOyiR2JNOjlosNj/EARzGovyYT8n
	n06qbmXRfeJ6Wow==
X-Received: from wrck15.prod.google.com ([2002:a5d:524f:0:b0:489:bd7b:5942])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2010:b0:488:7803:c1ef with SMTP id ffacd0b85a97d-4887db496acmr19692502f8f.48.1790617316679;
 Mon, 28 Sep 2026 10:41:56 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:15 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-9-smostafa@google.com>
Subject: [RFC PATCH 08/15] mm: kmemleak: Don't assume the kernel stack size
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

kmemleak_scan_task_stacks() assumes that the kernel stack size is
THREAD_SIZE.
The allocated kernel stack size may not be THREAD_SIZE anymore, rely
on the newly introduced helpers task_stack_{low, high}()

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 8fa409a4f9fb..72e2c628a20b 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1749,7 +1749,7 @@ static void kmemleak_scan_task_stacks(void)
 			void *stack = try_get_task_stack(p);
 
 			if (stack) {
-				stop = scan_block(stack, stack + THREAD_SIZE, NULL);
+				stop = scan_block(task_stack_low(p), task_stack_high(p), NULL);
 				put_task_stack(p);
 			}
 			put_task_struct(p);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

