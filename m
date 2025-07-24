Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AA2E610A
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365398; cv=none; b=JV+f4UEcVVz/zLMclmsGXGSpOZkm7jw0rxWRmiCcFqddFNfQT+oJaLVkzcTQ6jUWPSQEV4C86dxRPcS9svV3RnMyt2u4RuU22ca4ev8ES96CEkkygaq4lHOV9sMEI3iG16gczKNFBkjb/CpyXeJyMcvdm+e5f933so1PfKFr218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365398; c=relaxed/simple;
	bh=QpOyX3O1zVluz5hSldO4dnPU9Pz5bkE/gs9RkenFruo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLzkoW5cbgSRsbc2db8j72xvXSlBNv2tZddJK1OWt0AxSA2t1sFQ3XMrZEfHSqObxet7hEYa+SH35ebvQ8M3ecZVRgw3Uuwcz1X4cVLGsP3p27NXsxkWxviSmMK21B4mVCjH7dTOf/IqlWFRLB2x2a7h6uuh582Nfi0VMVuLpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhHBBf8J; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhHBBf8J"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b5e6bfb427so562169f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365394; x=1753970194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6EjHBZibILbBUp2qJIWYHcXS7kn/hLDSQS+TJg877Y=;
        b=NhHBBf8Jzh2UWPCgsbFcY8aPFwvtxFOq737cLLsrQCZmRgkKkfwMJqNysXsBL8QsXC
         qmzgwjtJVYsVGW89ouotrXqKPHH++Kh+n8fzAJGfeTQQgN3xUx8umehWdVe6hxnncmui
         vMMx7OFls9lkmSMYrkbutgmBveGsrwvyQbxtNkw54UmbUH8TGVbf+pntg0yVwqDgKKpp
         sW91XbQn7lQRduhAgmkL+m0wfWr/G35EOLGF3ls9tPJArHfaRx2kec+lQcZd5sYG22Ty
         VQjkDwvKt34FiJcreuIkEXHvXuP69LMFBp1pM/55KiGjJ4nmzQMUSN1xoQGuC6LmZbcE
         fGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365394; x=1753970194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6EjHBZibILbBUp2qJIWYHcXS7kn/hLDSQS+TJg877Y=;
        b=moXNgKZUVPVoAMu9PqRTEyeunT71FQGyRCmvAtztGMOrRx4oJVOIJiZiTb1mZTVklG
         dmFhhHTUkr5WHmK33wCxpwTdBaYVa+UxsYUUlXJrecLuIlb1X4HSwEi1jNP+Bj0rhfFP
         0RAs11cJIMQcZaBsPow/eiSSmTWtj0IvCDEXVCiFgLXSkMmogwrpHOzmE1XnHyWqe3Pg
         iA2TH8xSZJk//hvNeB9ngN5EsW7I0LgEQgIH/LckGoPmZb7yobnmd5AWPL+04q8pcN2r
         zBEc+bvtnf/j91gDSe/1liwkTVuNZCsSP1ooYThXWxhftSvFmJRA/Z0qq3v07Pd6YuDB
         lBiw==
X-Forwarded-Encrypted: i=1; AJvYcCUEl8WhzJAB7YoZAENjptW/qhrj57g9ENzonFRb9R3RTUqpRMe2pWOj1W4DkkNWk8HoCraV+8Hoo+oxe5lXfjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwajMMxyo1neFQdZnMUBZa7OYNeW6N4An0Zgw8A0ggttCtsU1DP
	CARqxfvcaXU5ObtrDpOVM903jUkcXRUR21fgC1KstbnzFUrpUtw3azWJOmo8bAQ6zNU=
X-Gm-Gg: ASbGnctPQWOfy0DzStCDRWtvThWllUr3RoabuOW0xseNBo3CGf+tpSBIaPJzhDGPVPL
	DFBoTCzUrVypB6+0ZKs7EsxHgeUuwdvxWY9G3MyG2r6hLsIBbUVrTCmrD3u2ydrX52+NBg1ovCw
	MzVVk1WTADZTpQ6kaBxHkfsZ6Z2EsHTiJwmNpoNnToBpbS3kK5T9ai5HUWvmBmnq0/klyVTz963
	OuomcJFNSKIOTT8gbpePW0/zhf/s87X742QuQ9uoYn5oGK8bXMdFQFwPzif99wCuZbxvO+x+wWz
	JINKL8h3UQG0Lq+Wq0qVXuwmq8KJ2jHEHGI8lkLX4JlpaeEHgM3LavidM0oANQyobZzSTeza1bR
	iky9zwYU7Xth6pYUGbtYSdRW6B6yfqP1ivKxYJ+JZsr0s4etZVaJck3RycgmrI4mvj7IxnAvxiv
	B+EILiI8q4OhgV
X-Google-Smtp-Source: AGHT+IGRlGdpZ28v11nrKuEy26SoaDmKeIQI1w12F1VyMMK6OUtkgi6ZkZkyO989nTl8PB59Q+K5gg==
X-Received: by 2002:a05:6000:290e:b0:3a6:d7ec:c701 with SMTP id ffacd0b85a97d-3b768f1ab39mr5321094f8f.30.1753365393821;
        Thu, 24 Jul 2025 06:56:33 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:33 -0700 (PDT)
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
Subject: [RFC][PATCH v2 13/29] kernel/fork: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:56 +0300
Message-ID: <20250724135512.518487-14-eugen.hristev@linaro.org>
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
 - nr_threads

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/fork.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index edc6579f736b..ae8ae9b9180b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/kmemdump.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -137,6 +138,7 @@
  */
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 int nr_threads;			/* The idle threads do not count.. */
+KMEMDUMP_VAR_CORE(nr_threads, sizeof(nr_threads));
 
 static int max_threads;		/* tunable limit on nr_threads */
 
-- 
2.43.0

