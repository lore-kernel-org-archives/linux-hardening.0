Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF82E7F01
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365402; cv=none; b=RP0rtLjAketEqwJUZPOvCZRwtZfGPBRnM4pxO+m6CcIvYwc+xxg7vvJXJACt8TtgSB1bwwaDt7yji13oNNaqIIYZRbVfqie0DCUb4R/6pM52U6N+IMN74PfiZA16ltxePz6mizjULBN1ArOKyIH6M/UyVj+jpItvAAWP9ts2RFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365402; c=relaxed/simple;
	bh=j52yzR7Gpkc2C7QzVnAL6OhmqWFXWx3JwzJVokNsTms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akaXtgPPmpZc45JQ2tRiKcFWeH73JdPgbm4tfZg/DaeGBwenU/lwqSU2LF8jrvZ5UP2hTdwA4u0ZoNjNgMy634vJRCUCDuKN9CoVlXLnDqtkCBILEfJ9fN+kGP4tCwgMpEKdZwGuFxhxby/TMjTybL8kST/mL4V1QFQWwiftwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q+n07aCt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+n07aCt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-455b00339c8so6845895e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365398; x=1753970198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phPxbutaSa2cHj8lQiAqRNXIpOiUr1sfgJg1sLmhr6Q=;
        b=q+n07aCtzLI5b5OprZDAIq8uAz3mWb20L+1xonnsPcouJj98jigrLf3qnMfoFVGfjI
         OeM+S05Brccvs8IcQCcBzyyTuTZArzaZr8h9ZMfyRrLigg0kpO725gQN5XC2ZzbVUM7L
         y0SjDNgVhz1kD/1GqaIOIxzY9rvg50jLnvwQKhgCp4qLn+r9PwtjQG5brJ+1iI2y9KoD
         kezpmDXrZh+N2x4Ohl6XzyCKFMsfeS0oratUTsc7VHeirpSYKt0fwdUtrXfb5e2FHUE3
         cs7nx92cEbIVH0knZ4w6CwYkO9geZwstvRoJzP/BrqrH7YGor0OWRBqmLrF6Bzl6P2Wc
         fJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365398; x=1753970198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phPxbutaSa2cHj8lQiAqRNXIpOiUr1sfgJg1sLmhr6Q=;
        b=C6hQXWDcWCKERUV8dJsOan4/SfmU3jH3xbZSk9BOBySkb8dFw+GpFNC5XJiWwySe1r
         AvTJ3HrnDJZsohS84fipC9Oso7wAIBwLtcPBnPZQN1KB4nBKogF0bRSUZvm0o0MjnHcY
         kzIb15CwNTXzveVpc955oG73xjZ97v7XLHrdPrJFwLD5Nxe85mE4HusVNbocbmaalM4B
         Ggf99d4jUNuDW0jkxqE/i1bBkDKEV0JZFnf+E0l5gaYS402Msd/3pB7ySTk5IBueRRrj
         1sb30Z1R5gQNf/aRGzrFPFD7pQALgBvoa13zsDHpWWzYtttYTbFLnWgejIQhQq1hegpt
         WhLA==
X-Forwarded-Encrypted: i=1; AJvYcCVggONckCrGlDYLbR1RbLR74CKMNHkTDnrbAsysK9v4zgriDeyrb87lxKciwiCnoPbMGB9rFT8+UHG+W0yS3ME=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsj/38AmPN9S/IHFTogJocc8BFTOPRETaxWV/bjK9sNjT2ndE7
	REacgd83NhHN8CgyZWv5yVwhUw4GhiI0y/QyID2egOrrCY+1HgW1SdmzFxc3VVx7xGk=
X-Gm-Gg: ASbGncslOaqrvA6vlPE7WfbPd9tJfMCjQtP3ulnGvVVUAicpsKYFiVmKRxn1LQ1aI/8
	GB0HBhkz5B53tDJB/Licn3m3dEZs/iPqzz9R5iXzohZLJnrWLyQBsut4VLQLVWGlttr/qzsF0Z7
	YN+LeurW9OgzmxIDzb5RDspepnkJlpcfoyIUuoXIoreGc13GiFW8oQ2Zb9Rsxoo6q3qYpdLGdUc
	mA8voIbqhX6SrRGV8Za4/l4DQS3pM5unhqKsjQguwUK9GAJusMlT9pXxkyMVR69jrhcbVfP98Kx
	d3yHHzQBoPJdnddoqs/u2s+NBZejJGFsDrZKe1tUlECOqqOEBQCwtBXXP5h1eyqJ2mAEfo+eWQw
	xrrklet6VWF3WFaI5FR+0Bby7vvU+lRVnrO4ywQV+Y36BxAh+I2z8tJHzbPhDZqIxrJxgFBOcfM
	D0CA9NGQdv/dAC
X-Google-Smtp-Source: AGHT+IEzG7rA7SjcU5/IexjXqSf6MXBAUKpIcrbkFM4DkAzOo8wQtcA8euIhs0yEfuaDr3L1GJYTKw==
X-Received: by 2002:a05:600d:d:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-45869ea827amr55222245e9.4.1753365397698;
        Thu, 24 Jul 2025 06:56:37 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:37 -0700 (PDT)
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
Subject: [RFC][PATCH v2 17/29] mm/swapfile: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:00 +0300
Message-ID: <20250724135512.518487-18-eugen.hristev@linaro.org>
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
 - nr_swapfiles

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/swapfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index b4f3cc712580..ac5a2307a278 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -42,6 +42,7 @@
 #include <linux/suspend.h>
 #include <linux/zswap.h>
 #include <linux/plist.h>
+#include <linux/kmemdump.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -64,6 +65,7 @@ static inline void unlock_cluster(struct swap_cluster_info *ci);
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
+KMEMDUMP_VAR_CORE(nr_swapfiles, sizeof(nr_swapfiles));
 atomic_long_t nr_swap_pages;
 /*
  * Some modules use swappable objects and may try to swap them out under
-- 
2.43.0

