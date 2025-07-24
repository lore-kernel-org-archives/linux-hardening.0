Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D12E889B
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365404; cv=none; b=T/X9AAOv2LrMbW452hXUQRJ5JGIEA7noMhCQ3WED7ILgUEfjATVuhN5elnOLrjriM3/H9GKG6NTyPNayMvbVdno4NkS63SsE2pEos5XqTxuQJmd8Zxp9uD9mAaCX7lmcCM8YWKOgcc6zlcHESZKH5Kh3KgfjAEEriWBmI3AuKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365404; c=relaxed/simple;
	bh=17QGeEGZ9coLnHYcyt7u8QDI4NZW28xAVJJwsgh3bn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLypHw5EIQb79gUJLVf/Ycx6bSahrA/23ftfci400rAUcd+5Ewg6Wlbb9XDrkIGnAqB6NvEAnFhtW03bSyQF7TRfrGfVdmI37jbT3AcawIE9NXGYD11XNU5FJRau/NW2zKS310gxhJoO6fWLcdMnxxa1ROKOU3f3WYdT48Y2CAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C6mxlAnj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6mxlAnj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45611a6a706so4974325e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365399; x=1753970199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJKFOh1t0BpMtsqdCvtkoNZefWX67AppBNjz3MRLfF4=;
        b=C6mxlAnjxxjv8X3k7Jnlv4sZr9Pj4TpM/k4nKrykg4D0lOJYUyc523/PaxPNtpEJL/
         TXdsZL+OlLgXOkacE0AtbuEMn4kpSzX+yHu9F2eDDir2xZ8YNwP7wPzFLOjiUvx0Xj9m
         LKLhOoAcHEXYVrjUsjP7Ga5v4BeuXxRYovBExttSURq+FqlMGJFitUcqGrI98yXatdGd
         SRAbA2++JzajT/CvO7GQWsAcy3obbNBjvf7AtoDaX7Ig/8krnLnaOT34aaaG16Lpv+dC
         GM52ktZzXM7zphMDsSTG9mUdN9y3OtIjMOOtcyA5x4tQcjZuMA8VQJ2wR3zQ+pgNFloA
         +AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365399; x=1753970199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJKFOh1t0BpMtsqdCvtkoNZefWX67AppBNjz3MRLfF4=;
        b=ig+ddUi5Jg8u0rjZm8F+nuEgRPMEfwccZMPiFmWehH0ixsBLlxbic0mWFSLC2pShlY
         kJtIzN2xhVWPjalJSUnsZJ7LMHKlvUqM5uRSvEcWkzw22XctvYmmoJMPoQ1UE5EbzLuy
         i5hRrGc45VFjx4bg11jYpZi9DN00IwAvk2TNFkv5aM62+b/Mwtals50JtdFSnAxKu/Fg
         6eFjvehq8qHKjKCyhbt/j89ZJ0UOpC2cvKusletnF3mOajkgdnK3sIC1b7y304zUwu6b
         69iVx3tr/hXtDExcZsXaAM4AHpHhuZyM3dSptwfRlHeDku0kM1VeXo7QKdHChjyM5h7e
         BUYg==
X-Forwarded-Encrypted: i=1; AJvYcCUvDaXyhf9ya8ryF0jm2tqvA083Pp7z/TOY/7E8yQQO8S0PKjV4nKwp+gOjDcMEIH7tlLpaG6aPUSHHJOcE95E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFAic99SPDxfnoMOzPSHoHt1TY+iqssQDkb7HlOqgM5mBswVhA
	rOBG0zLRJEHiQaut77UjFyo+Sk3CFAQN4NLC0c6Vqq96V1tqTzB6d/CXTe27MtxIGzk=
X-Gm-Gg: ASbGncu1tXFH+n+/GCSjAabtaq+LIyluL5zYN/m2oE0Su9hP0/Fn3bXJQHtI7UV8MMH
	e6AqhPi1LXfiy2S7R9V87SRJtJqpKRxlqbB/p9Bwfn66Wv86tnUNUq9/E3iSLoH1ihbcgPmOxqM
	q5kagU0u/bTpOhsxiFTRBxOVd5RV66Rqe+uYY4AnLpqw3HUQ9QjLN9xMK/W9xhsqJ3ZWbpnX+2d
	ny6T4fdgsh1QfhTBywV/VIEMQb3ODeOjCXur/xypmof6OrDVsR1Mp80J8EFHx349is8J02uHlBE
	ZzLk6dkTNNzha6n8bsEakauJbTTZqi0Kwjom8WYwAgtG9DJHpxiCt+prkg8G6l23JAhPYUDf3rA
	yjP4zAHwIHidRJMUsWNQVWQLS6VIMtZ8g5qNbYvt8iSP/uGmGTBrUoUOW6mYcBDwg7LD9zUN3oa
	3dh6RZ9bcyBvHN
X-Google-Smtp-Source: AGHT+IFBpfszojCM9BH8+214LoTonUL/68z7rgbLH3wV7lPKq/S6zSGoTIX7zNxB5lRzwaUzCOOn2w==
X-Received: by 2002:a05:600c:3ba0:b0:456:8eb:a35c with SMTP id 5b1f17b1804b1-4586ef5cdb4mr25803445e9.31.1753365398629;
        Thu, 24 Jul 2025 06:56:38 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:38 -0700 (PDT)
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
Subject: [RFC][PATCH v2 18/29] mm/percpu: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:01 +0300
Message-ID: <20250724135512.518487-19-eugen.hristev@linaro.org>
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
 - __per_cpu_offset

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/percpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index d9cbaee92b60..0cfe4d7818e9 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -87,6 +87,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/memcontrol.h>
+#include <linux/kmemdump.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
@@ -3342,6 +3343,8 @@ void __init setup_per_cpu_areas(void)
 
 #endif	/* CONFIG_SMP */
 
+KMEMDUMP_VAR_CORE(__per_cpu_offset, sizeof(__per_cpu_offset));
+
 /*
  * pcpu_nr_pages - calculate total number of populated backing pages
  *
-- 
2.43.0

