Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9A2DEA87
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365401; cv=none; b=B8EjaZU+P1Hn/PJWZrjyi9+3cAluM+CNTDcXsoa8c7u9uT6uPOLKKRRr+CFsOvfe5VhXy1U2xhRYZxPFBTe0/O9Eu1T1cUCDMps/ySlcabUTyRVHShZfrWQ0hTBgO9tZ7aOq7bAjnfLBqU63pYJ+QoGjTfjL6fX36XrVdGbbSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365401; c=relaxed/simple;
	bh=kDQ1UVsh8/N1GCc/zzfiOopIyL3CRcZ04ezY899nhXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rib2QccYYYpgBKRlmje9YQz+UdKXRmIACJkVH0913nkrpFmmz1s9f3pNrEVSySZed1Ih/vvZ31y+MLYfReH+AePfy2xncC1/b2yFM7JSB2pw8sl+3KqE6ulIBKpNg2Ucvl8Bm4pFiVUnbz6k1Hcw6ZxVaYrj1T5tGpkYQSGzJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtHD+ISg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtHD+ISg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so10699545e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365397; x=1753970197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX4Svte8gqoaTLJ1gLDVO4a7qJdtBtTgEqouOAtsRZg=;
        b=mtHD+ISgSM+SUfi253ZtmszbOMyw9ORPp7cADqLUVvtUQSh+F2uKGW/HoI+6/G8h+b
         sgquvAhnD90ntjDcj493uMRFktkg0EB3wJdjEsJffTHNTqZvaBbR4T6UlnV63KAgJu50
         m8mhqe8AUSug1EtN8ewwaTIHIaTaMF1/2/ELIKaNg7AZaxcfN+A1nTo23afrhhqnk0mc
         yzsgOXEQE7HAgnyWUvWTbiCJPteSDFEDgILZsOtDaEweLOzn4WmfwXgGka8te1qf8YjK
         qRU+D/j+Wfz273ZqaD6mk4O8BQRoVRpM4s3MPjVrrTna5m6Vj38zKVqQHrOwG1Uq1xQr
         d6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365397; x=1753970197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX4Svte8gqoaTLJ1gLDVO4a7qJdtBtTgEqouOAtsRZg=;
        b=lrMLhG9bmuJVVkVn2gvxLevspmw0uoL0Urx08ekljse9SYTrG+EHbgAvfBrLSE0Gd2
         s8mli2J+tGa6dfQlPaJAwZvP7SKF4hpTyjEudSERHz9z2Rj0s2lpYFVE2NgBBHIzSSQd
         jfHwRWu+x85OqfVAX505pQiGwwtyoG2v9JisN9ZcM6sm0bQmVO4laA7uEzwevjjEvuuS
         y+j3oe6sqfGR70jTvQTTbvw4EQdq7mWvFgrzRR/cNOAvoKx6g2q3KSkaqSBuTewkW+qu
         ZWcUYYC0G/UOe9IB135RgKxew/f20DlcfwQ4Oi/SviV+H9YLSmuvSoPky4pHgG70CucX
         yB6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXe6GcOgX3N3vfUfTowmHtuQD3EkyJh9JFGHAADvSKySl7RdiYLOQikgiUOgB+8uXWQPHrFyHgswxEa10PKZdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVuiHqJnbM5ON+vgtJNljCAMSb7PrmFZt3JcgdsvQmGqFemtp
	6EX4DeElGfcf2ZASsJVgBmkIYm39ycrt7GW8MLc3JU++dVk1lFNEO34XHbrTAH+A4AyElifjmzq
	npAxydJ4=
X-Gm-Gg: ASbGncsjPmHgOQfZmA/v1lR1upLEynFRuXRF6qiWNjknPs73YDGl27PSkgCVZ4pN6W/
	tE9wcRLTmtfkPXa5IORkNeUv+2Co6+5Jqfh+sxdncT8pZBQ7xp7QTI3P5g2V3J3O3eZYhczB7Gc
	8Gdl1Tvn+ijmdXpwjiegSvo27NNXdJ085ekfpdFHIO5QpWFKH951q9OY3PSWWeTEus9A4GrmqK9
	ViuiyKfuFsDtwe6t5kZW8pup1hj7Ye5YtfxB9ZGH/g6Wmg8Bmo62mh468RqAm03Lp9UckVOPry6
	B/UvIV5lZ/S7vP1qQUWIoGXabS0xmuccST+nnNrnJbKgZ8eNVR0xXpIxdFsHrLEfAdlZkRGAfcY
	7+RWlGeSy5Is6O1gexFfikhkLAxK63Vpbw1K14GNBoaGdguraG67vf8TVXZuhUoKnT83MfhVgye
	0+3n4SDAYi+jzrAAW8t/vsMHU=
X-Google-Smtp-Source: AGHT+IEQVvnmK8e1EDhTYEG0c9433X/scuppejD17sDlP6XiymAvLgXWbUNkWttS4mn1l7PUSu9quQ==
X-Received: by 2002:a05:600c:6090:b0:456:18ca:68fd with SMTP id 5b1f17b1804b1-4587118251dmr22564675e9.10.1753365396747;
        Thu, 24 Jul 2025 06:56:36 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:36 -0700 (PDT)
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
Subject: [RFC][PATCH v2 16/29] mm/show_mem: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:59 +0300
Message-ID: <20250724135512.518487-17-eugen.hristev@linaro.org>
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
 - _totalram_pages

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/show_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 41999e94a56d..93a5dc041ae1 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -14,12 +14,14 @@
 #include <linux/mmzone.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
+#include <linux/kmemdump.h>
 
 #include "internal.h"
 #include "swap.h"
 
 atomic_long_t _totalram_pages __read_mostly;
 EXPORT_SYMBOL(_totalram_pages);
+KMEMDUMP_VAR_CORE(_totalram_pages, sizeof(_totalram_pages));
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
 
-- 
2.43.0

