Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F42E8E08
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365404; cv=none; b=mzt4VNOhiAljvKjCDK6EG2JM9xXCRnJzftJeAih5qD+C97LwFFmhwQwCCO5Ae+o77zoJ0IMjfdePGdVrD/OaBB8l/rrcS49mCMK92f83o+DDnYGgzfLc7uyYxZCe7U1sdlxqxHdppbDpWPuASxK7xZhfiMHJYPoLVGBnZv0RJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365404; c=relaxed/simple;
	bh=+cBbT6O+Tv94TMabrjEFapPNfjw9qG0Ap1lk8pPj0JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ3URfrfia2WDMLcpXPcUhhLIGdfdKBWK1/zUSmsd9mkY7XPgvEPg2xg68NRbUrNQQAkqn/M3cUbggWIELdE5NJLwS1PyddgdcPcN2hv9YNB1OoRnKdnGpD9kYDfcOUbStgV6TdpDK1lTJerGpMFzpO7o6A1RMgP8E72C2v++xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k8SJYDLa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k8SJYDLa"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso10931975e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365399; x=1753970199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYTWTc09XiaelzjVtYPzYhjlFtDK3ChqlxDovLkTtoE=;
        b=k8SJYDLaVrQBu7nJiAugL1b+RnxDGdXK2HghIEILwuyhIuapFZ08wm2arPcsVtyAGz
         lRDnHc/J8Oazdnt9gudw2jEdE9opbImrUxArZNGpi7AtJuWiI9nCbFU1rljwaD/1FpSV
         N1F6hBSBkTmBUfLKZ6grgFt69thIZNzcmZzh/yNZ13ktqFZwrbxS2zs26JjExJqECzjX
         WcLGXjZAlG1Ccx/JPMdpzJjcXbXG9u6cb68AumCE5jJxPEzGleBkQV5IcyWD1MrLStBc
         8kzj2RJYG6ld5yMvA0zKwyNVaEi77GRKspbDpkrtaXEuypVijf5rbr6mJAxYLAeafyQo
         8z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365399; x=1753970199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYTWTc09XiaelzjVtYPzYhjlFtDK3ChqlxDovLkTtoE=;
        b=ZT4BTGJwGRFT473CFbJZE29PLDkLTxZUG2SeJ3SfSdYz6nJzCFS6pWBaWxX79dODuk
         mZMNZvBk1uAeeYSofOB5GGp7TgrVtJp2beIo5bl71MEh9Ff69uhAmuq3RjXAv3qVfHDR
         YmqKuQIV7wZUDekKmsESJz928CZ42zfL8whDAEoukO8o1BsfM04xCbRj2MxQkhj4UM00
         DUoB060nkEbhFkJMFB6DQWwdkgYpQicshHnO/XXu6Y2bhO6L+O3jQS+WLtOEgrTQ25J8
         BLFpSpLzlQVP1626Me6Q6+K/j7NuhklK+W5lDNHW/I9QNbcb1fYNNC5rnLrHAvDyQXIX
         O2ow==
X-Forwarded-Encrypted: i=1; AJvYcCVOSdZBUNFl9kCch5mJa7RKH7LfbqVVzqLG348HMl/sSTwaXRp4qlbF4BEkDyH3X+PyzupKCUUg6dpEtlU21WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8D7c5rkKSXGfI8CIXezuHFekuMVG4g7Jy1DlgeGzncMQuOvtS
	bcalK3zENRqe6ee+5ZaPJ7zxbdwVwnj7ZQQ2wKKK++fA+m8yfiDuS3D6XibJNmM4E5c=
X-Gm-Gg: ASbGnctn1HxVkBJzikISiSFR/3yBvRMI/pdCqW7/TkLbPa+llfotxjgnCmNs16qB660
	PgLzO4P/E9z4NedMS8krzewQh+1NEsxGLi8YNkaAFLcarJSw4xxHiBML+jqHH+x/O/dLj4Fg4xH
	hiuAVhgO3lCrr6VGOq3h8/tSXGRfgp7VijS8WyWQFf3Ii15m7Uh8VBos+hVEoGg102jd+LFn4q8
	0lbOBP2mUmQUfhn4dpP14jDEHvGfoYxET3lcYbKgit+xqanVgSBild/6VyegNUtRHDGu/xpjVuN
	Zwwky5jxvaT4ErUD+7r9owCrDJU3e2CYWdtI0Myk8DnvLzr4VrXzKYdycwpX63qL03XL5P29Sj3
	I1NpncQpM23mksxvK7l+N7U1J0ozDnnNnU+YbdcrmEOC+jT/0eCnx4tyUb2QfJdHGLKL0LQdB9W
	vmKUnOkIF7nVxd
X-Google-Smtp-Source: AGHT+IFkEigCZ6sJ1rjDkc3I8yrqrXhO4W8lU33Z9QEAlANeXLFiBfl+v0dIWKjOVtP26nHzmGjQhQ==
X-Received: by 2002:a05:600c:1d22:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-45872668487mr2491595e9.30.1753365399512;
        Thu, 24 Jul 2025 06:56:39 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:39 -0700 (PDT)
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
Subject: [RFC][PATCH v2 19/29] mm/mm_init: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:02 +0300
Message-ID: <20250724135512.518487-20-eugen.hristev@linaro.org>
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
 - high_memory

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/mm_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5c21b3af216b..fd577f988f79 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -32,6 +32,7 @@
 #include <linux/vmstat.h>
 #include <linux/kexec_handover.h>
 #include <linux/hugetlb.h>
+#include <linux/kmemdump.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -52,6 +53,7 @@ EXPORT_SYMBOL(mem_map);
  */
 void *high_memory;
 EXPORT_SYMBOL(high_memory);
+KMEMDUMP_VAR_CORE(high_memory, sizeof(high_memory));
 
 #ifdef CONFIG_DEBUG_MEMORY_INIT
 int __meminitdata mminit_loglevel;
-- 
2.43.0

