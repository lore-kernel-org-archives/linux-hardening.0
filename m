Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2C35581E
	for <linux-hardening@vger.kernel.org>; Wed, 17 Dec 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988891; cv=none; b=S34o7A17yXKrNHwDQWtXGyTDJQ56846KuYo5ZEvB58noS6cqs/GgKtSwS2uAsHFc0bczjrgIYlzRrks1S+KsGdv8POB60y8/Ji+CIRXx0fp7EWV+chzLqaqrcTGHIpk0yuIGtOsHy6PBDAVY+0LdpF+1C0552NuyuR92U3+Kxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988891; c=relaxed/simple;
	bh=hHiQ13HsCnnPciHjNgpzJZ953n8TCFCJOtTwd/r8PoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8RZeH3flq/4R0pmSYI4lGQVWMe4utNRSEfGPFzkKrjLyKsRsK/Tu2ubEut0okp17T/6lr4+G9IKF/6xxKG0YGuRrexroXYzFN2ce6F5KDr43pVXvJg+4OpboKyUa01T4rIPYylaIgKit9Ajhc+UTBFfYlf3Po/URG/VK1Q9aHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZMi5D8fu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZMi5D8fu"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42f9ece6387so2359773f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 17 Dec 2025 08:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765988887; x=1766593687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJElybK4r9OmuCr9uVdpcrBwONyPRzk09mZYQhniuJw=;
        b=ZMi5D8fu2ODKZpQGF1dOBw90mD2ODR5ig/yMm0KcbgkCLTaKc7hUdNzas614aB0+la
         ZOdRXudFavbdltCYbV90KhV0AHlhXQJxomZOFxqwm0qWWC8ZkUIuNY/2sqzcBQTKu2Ot
         cOU16w/Gfn1W1aGN6SzYtljEtJhE/vZgvFjnuLZhshDu704kAWXtENMSMFXK/VlE7OAa
         2yFeN5Xyrl2iRm4AxNUHHMO1O91lyN8wpDgMflZOcAij5h2ZNP7fpc42mSmyDC76ekwR
         /jJRYLBKKan1IUtLdHd941qEcKgshI3HNqBM5V1tl3mvVQwng89xHSnW798Vu6HdMkf3
         U0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988887; x=1766593687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJElybK4r9OmuCr9uVdpcrBwONyPRzk09mZYQhniuJw=;
        b=izJQ3hnc+9HnsSQhonrU8pdPxfQMWYUvjmpEorGHkF2YQItqhqbO9ZL/NxgcOBqfPU
         75WU8NZK5D+5o4i6wlmjqVtRR4L/0pRlVxv78KstOaDI/Uo6yh+vOqeWL09+KsvdGHUM
         nSxbwuufaNQLfQtRgM+QkuqJXvXNVHrIDKd7hK1vLaG0nEgsmE/YNNnuYcayYPC/edbT
         meYxWR62idVv2rwDrU8Ya4oHTjBP6bNGUp5gHdHybRaz/Ixjos0tBSUumWXQ88OaxGnp
         Wjh0EP4JnrmiolAUMsY23nYfTYmcyvXraFWXlVkDI0lakJGd8fEOYELkLPwRPiAYVgeE
         FjZg==
X-Forwarded-Encrypted: i=1; AJvYcCUrL5HYeRG5axsttHzBnJE+y6OkaonpKQ95uCmtQUnSrVvWw8sldl9H8nu6v6D1Jo9fxUJZURT28SDmNzABE20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysWZJFEITvf3wGAjuQ1NjqfEfKlmKJ5KXgHb9nYHkMEGlSrRo
	jwq9qkoXpHQoEJBZX9eTdJ/VaDWpjXrvuD/XdiFOWNgJD33sMola14H3Y+oEJjbQvRA=
X-Gm-Gg: AY/fxX6hxIdR04cHe1PgkRr/xx1YuYyIMWlZFg28WzxYDRwi10zeuH1/Pbi4sBIGjLq
	M3Zq42x3tir/z+gZ+UXpIWwXmFdVMNLq4jHZDlEVt1570vI5TXs3etINPgwYUjOQy1xOZO+ToGY
	ewG7na0VTDK2o4r2lCMajyYJ8rW5AOAKPzPuSqaoGPJrao5FTeTITRjRA+kd+mQNyWF0+oqLSrs
	gxPqWHaEv+vnqRSbcHQDDYte4rdxVijkbEPgtGisD2DOs2AAx5jxnsV/OVKtRRUaceVLq/c1fxi
	+f5WuRsWXTJTIwBRhOjQ4Uk8n+HcYUQcnZIc3zgbElkUKDRsAmP/PVuROvwTZAHciHc5CxbbTu6
	sCHYwgUR0NoOM7TCLueXHvvomHO/E+zXwSRF/YNPzcEtx8+bMIi8yoFtqoZN5ZExOyh7oJkF/ON
	TUc7Eh+GxULkPOFH0IjN/+agwlY66t/qI=
X-Google-Smtp-Source: AGHT+IGbhlvyzEjuDTSV+fNvDCFi8GKeD7MdXF7NnWLDDEh5pN2MML+EtVLT61FA020HJ60pRPL1yg==
X-Received: by 2002:a05:6000:22c3:b0:431:656:c726 with SMTP id ffacd0b85a97d-4310656ca9dmr6412349f8f.3.1765988886936;
        Wed, 17 Dec 2025 08:28:06 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeee0esm5728364f8f.29.2025.12.17.08.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:28:06 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 4/4] blk-iocost: Correct comment ioc_gq::level
Date: Wed, 17 Dec 2025 17:27:36 +0100
Message-ID: <20251217162744.352391-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217162744.352391-1-mkoutny@suse.com>
References: <20251217162744.352391-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This comment is simpler than reworking level users for possible
ioc_gq::ancestors __counted_by annotation.

Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b4eebe61dca7f..c5e09ebae5ab0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -545,7 +545,7 @@ struct ioc_gq {
 	u64				indebt_since;
 	u64				indelay_since;
 
-	/* this iocg's depth in the hierarchy and ancestors including self */
+	/* this iocg's depth in the hierarchy and ancestors excluding self */
 	int				level;
 	struct ioc_gq			*ancestors[];
 };
-- 
2.52.0

