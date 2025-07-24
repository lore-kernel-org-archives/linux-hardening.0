Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D51C2E4259
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365400; cv=none; b=AZwcmO4GFFlihzdLAVR/t8yygL6MIZJ9kIHr+85+5QbKOTCrbSRvstQTaCcHgKnLwWgXx80G8CW0NVAKCAIJ0c3H21fV1dbEDHb4qvik0rYHiyJzjnyGMB9/NMmZgC5xxv+k6feu563bh9sBHavZv60pABydfKpHYrvjFQrVkIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365400; c=relaxed/simple;
	bh=Zu6zHICMsbDr9iEKVVQXs5NvRmjCVnu1EFLIYvz+qoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0Bs//gvUIuthSTWtarVqQmhZ8la08jEh5ePrRFbP7EBrmsraX8/n7WjWAeQrse9AvzT6dEHKqGU8PavZ6vYgA0zDxg6Qz2RVP/ydLariflBSzTPA7wpSfF+5UAI0Tx4xSsrB9RI6i7BY91DZ6Ba6I2lVA8JXopDZXfD2Djm82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKo7RQFf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKo7RQFf"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so10432195e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365395; x=1753970195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQxVhQs93RF2j5r69/kyB3XsN/D2SLMeChyoBk7vwm4=;
        b=UKo7RQFf1yxGOBkJXGeh+sfBmBXkK1H+4dY0li35Yw+u8GlIDgctfLJSJ4gGAGBQ2e
         GpkP54mAuQWTEzVRa637gLECXTG4LBD+H2Zf/5hnwBXl+0qVNriDWLr6BaX2ks2iEWBV
         Mv0LJV9V0FGC4soAaRZCjk8RfDbvKEMAJLRjcque3PsP8alr8TJvWdUYjSqS+DRr7vxH
         eLswUfmFOgcFn+aCBJClnkAnPFfGh/e2rEOVqJpIN08L56pFgqzxoVpF4AU3+fyoZ+1U
         +4/H2qvGelbzeKomwnogICW0n8OA9YwHGMszLF3omZ4MskFKLs2D5R7Q/FM2tWps4Txx
         N1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365395; x=1753970195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQxVhQs93RF2j5r69/kyB3XsN/D2SLMeChyoBk7vwm4=;
        b=tYfyQLlHz+htUfpMjuxMjxFgE65ml7nIFNJjnlX7iA+n67AQuVHhUIf7QuOJzuLsFy
         dF3GfkDnfHNIlWTr6Qc3lElLSJytovXjrw0Qm0vOaoSnFavNLRwI6FZguuoxlJQcSy4a
         bs48G/cT2jsttxheD4YxEY43UDgtRcqzprvjY1e073BRuFYlmqT+wNfRCYZsTTrETl3x
         I0xr+hRk329+IdjBsJqrzzQKsX3BxZKIuvMsLkE2zCvmmoFraVPsqp0m+z82njoIB6QK
         6IofMvQ6PP5HMi0IYodeC5w9UDj5E+AS8/aD9eABIkokgcBSdHuFt0lKUb9gHvwT4U1J
         XXcw==
X-Forwarded-Encrypted: i=1; AJvYcCWpiCdINa2NgFTjqKHkE+afyXLj5bLw3PaCncH5poDXLytnAv7aaaqgplSg8x33iXCFKHdmL7fm9TvFqjwAC98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHhQolHpkEETKk4RsLDZRgZWbKTeqkH0YqWfXqHJtZRXpYLyj
	Z8MSGR/yLabMA8dBg3nJIrUa78ZVjG+BrPvVLEwzj5iX0gDW6NPJnShbu9I33KwuUog=
X-Gm-Gg: ASbGnctoqHgoHVu+0ITavvYZiBFyT6kHC9YQwDH+9qp5fyZBwlTU2f3puZsUhoqBYU2
	ImlxlIMEKXlGdVhM2u7Irrz9Hz1jH+EskeDTbYqOCX+0sX4MgnQq3gah0O1RXBSkcLt8JY862UN
	bs6+3tLQEAT+Lo2aSUXgRGXJYEJi/PvYKJlaOAhxorMO8nUgeV//mQU2cx7uaW803BFCt7eDvvI
	7edjbX+V65WLuV2VQzx1L9/0aDSK8j+qJKX9MVbkoKCE7tAV5qMn8l8g0YElQekzZDAec5FTvua
	X4yBemiCN7apNtRkejsB+voP/kd+74Qg0F7weH9cNpuhi2TgbwDiCPwzsjA1kDJoF9TKAizqw2x
	pRLzYW3Kz+zz0XhGYa7Vj4gosmRWt8AjXxlVY6bXTEO8em8F0yPyCdsnzsZWrWgO9Kk9usgXpa+
	l/+msI9atcaCFO
X-Google-Smtp-Source: AGHT+IGhn2BhSHWFDoozkG8rL01GLeqFkYg2AyJwTWU+9+XF/fbe0VNyrElgCTmDYeBHx6jzMQbcKw==
X-Received: by 2002:a05:600c:4e4e:b0:456:1bca:7faf with SMTP id 5b1f17b1804b1-45868cf76e4mr72058865e9.16.1753365394813;
        Thu, 24 Jul 2025 06:56:34 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:34 -0700 (PDT)
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
Subject: [RFC][PATCH v2 14/29] mm/page_alloc: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:57 +0300
Message-ID: <20250724135512.518487-15-eugen.hristev@linaro.org>
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
 - node_states

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fa09154a799c..5f0015e27a30 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/kmemdump.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -207,6 +208,7 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 #endif	/* NUMA */
 };
 EXPORT_SYMBOL(node_states);
+KMEMDUMP_VAR_CORE(node_states, sizeof(node_states));
 
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
-- 
2.43.0

