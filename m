Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18D2E5B1A
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365401; cv=none; b=lXAp2dJjHthRGdW6Qg5fMzFWYtCfoyr8c/0Lhl2j1zvjLQAQkjdg6BqIk3PMbBVlBiMDV6IkH/IB0yfEv5VoAG021MIQX9js0gkXq7kDMVOuxKzPaFjNEH7/cQZCLFukZz+XHsALuxFn6ClgrmI/p18Kls3ATnN+2BJXwuDbO3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365401; c=relaxed/simple;
	bh=IV84GkIv57xHF9DSEvVSmOlbKrWfdF7K1awiWUW2oPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6LVlnLyKtN3UeW9ifY3MB5KTlkLImufdkEUvdyuXmkIJC9zHacItvRf7vKaBy5Wh7Hl4cRFde7qbEr/2JRoaTKZ/Iw8J81LNc64h2JIG8q1qgBRuGhnXk8yDjAtHHt111UQKoE1CD/3ftuyd4X9olcDXUsxDT1W2g5OL/L+syA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/jVAsrS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/jVAsrS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45629703011so7323615e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365396; x=1753970196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf/VqrIHQh0utzrTdiqqaO7yt4rF9Ojfq/Zu+7lemII=;
        b=s/jVAsrSDhWtyo9ZcV5kEKKw/dVAaBJ/nYU0zR+1TTbAwT6C90R6q4o2Fs7FTNl7EC
         JBz/zNnGUfo0C6rjn6bbYNcbu0h17l1DCsyIswwpqRE/Z5YJCnvklYzvHRVr7lDcjmK/
         GDb7UtK5YfwNF6dr2d7lJriWdesbG+04Mp1FaNrZo5ptMuWFm+WWlilSdR9E9Y9TXk5L
         Z24L7aBFpqgoH9WNId2cx3yqQWpySBhKUZFcsPEZpgj6KtjqgWBiLwpTykACJL2KYoW1
         w0EaD37ra0WKDf2vQ68AkDd3tApNxU7ohBQA3Kg9ZgN3ECcv988LGUYKzeUHIywN8eb/
         fBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365396; x=1753970196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qf/VqrIHQh0utzrTdiqqaO7yt4rF9Ojfq/Zu+7lemII=;
        b=PRncop9LmCuZiWPXU+rDesjZBJrdl0cOxsoRthJFhUOGIOrbTqDI84jDC2lBFlUhKL
         HnFegmJpz+YseaHcQv9fBmMeewlbd0+gowW526+H7Kuxs/nnfiZXCA0Zii9lthBW072x
         nBKHwdcl+kF9qz0vB4N3wMUuVfhgVdcOSVxiPjeRdiPjrVOlJiLeMaEYEwopr8WSneAk
         TUU9+blNY3TSsd3yoojMZchHlf1Bge16ilEWC2blZRJqkrRrs84z2JP0AT/kyX5kG/Uk
         3mvapYNqeC9LJ5jn/gmq0TyDalB1aQfiMWluNvsZywI7x6wRwH7lmBNHm7So+CnRJdt3
         QQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVocxdbVzXe5H4Q+egsvhfH9GfuEWZkqaeX3TzZ15l0vRMgH5XC/pSRS0tgXKgGdh0xdDWT7Fy84C/bsRunl/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/gcB9tI36wP1+tr7LrJP5xngMQ/iTIOGS3xyZDWhgvwflfCS
	bMQS3qWyuUbG3z4Ti9cAHGg+c/YPQxxj2gaQ44RpF2Bwd1IK1UiR445+UZEmAjIG0Yg=
X-Gm-Gg: ASbGncvnY6mFrXR5srV5AhQ/nYh9wSOVPgzrzH4U5Wg6KkbNEmp81+VpDUyt/UnSeR/
	ndQoUeU3aYey3xDzBma5w3OphGxdDE6NkfLZMGuCKS1OxN7H44R0jCMl4qdFI5cwAZjclLAX0Ab
	E0JyQy9ZV88+yk7wOyiKoFrekkz7Dgqu55M+DgJfFzmNcZuGuJIqI862NjzK+5d/ZC1tya+WiOW
	HgiUK2bpeef/22g5AWa/wMghRwdMB6KOGYjVtpl3vSrcHhqu/2Bhxgf4HDBjm9NjwTAybNGLVaG
	4xhZSS37bAC0tX7DC04vCAJzJQ8YxQCeBx6WpO5L+pvUben75kiVxKtPSWdRTwf1sCzpD/nrPlk
	U6c2vhoHj/tCe9xjGrpNzyThGnCM7Dk2yYDhUgC1OdC8vu3DIvEbnS2vJBItq6fkpNlNgSeNGed
	eTBB6vKL7q3ayO
X-Google-Smtp-Source: AGHT+IFzdwFCiaRsVqkw+Vzf0TWhLQA78AFXGtgtYDTFYK39RF9ZemaLlLUrmcl7qJaLyA5hKTyeLQ==
X-Received: by 2002:a05:600c:3b28:b0:456:24aa:958e with SMTP id 5b1f17b1804b1-4586a8cc2famr61338095e9.0.1753365395873;
        Thu, 24 Jul 2025 06:56:35 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:35 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 15/29] mm/init-mm: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:58 +0300
Message-ID: <20250724135512.518487-16-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - init_mm
 - init_mm.pgd

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/init-mm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index 4600e7605cab..2dbbaf640cf4 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -7,6 +7,7 @@
 #include <linux/cpumask.h>
 #include <linux/mman.h>
 #include <linux/pgtable.h>
+#include <linux/kmemdump.h>
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
@@ -48,6 +49,9 @@ struct mm_struct init_mm = {
 	INIT_MM_CONTEXT(init_mm)
 };
 
+KMEMDUMP_VAR_CORE(init_mm, sizeof(init_mm));
+KMEMDUMP_VAR_CORE_NAMED(init_mm_pgd, init_mm.pgd, sizeof(*init_mm.pgd));
+
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk)
 {
-- 
2.43.0

