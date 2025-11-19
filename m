Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DB334C1A
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567131; cv=none; b=pe91Ldvd4AOEbmZ06QQps8ofs+VNwQKfehTd14yhPp4GIqsMjHHvecAPdPKlbbgnmtdgK021BEVHgCzlyckANGzF8OcCb1u8TlW6mOPHd65zD/J7u3dBp2h2WneTHG54CkLoEUL3rcMZAqMFiMDrcCJkK7ZHDRPpLV75+p4iH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567131; c=relaxed/simple;
	bh=uHw2K4abduiDzGpZ4eX0j1eSGliuYPoG3xQUhEMZuY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCkIi4CqV61qKcoPmGalZJK1iJ7c6r5gaiCnjpGlQmsXhQEPFhuDYyFKH3yBp5aEF5Tnd8AXFFqGoh23vkIDEPVuY4HtXoDgFY1nBfP+MX4lRO/X2W/SSTNNdak01zLAIJzm8wmkNhVK/6+6JEECOnNSYis04iINCOff6TDL5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=POzM0FwJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POzM0FwJ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c7869704so5169162f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567125; x=1764171925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3irtgR9V6ILkzi6aCmzqNOzM4wzsrVUTWgR/+hcFNWM=;
        b=POzM0FwJqd/SdL87jP2GMAUIGjXey4fOCpL7ccvdQFlLBGoh6TpPgeAOPAXKPy3rC6
         2f3BvlcDX4lGoOR84lem+RbdtLt8RPGa2tbgMBuPxaKNO9opaYqdf80cop3Q/VowQgGH
         YYkotKtpK0JABL5JcU1bH7o5RsJIPKV6mp4ED0W7ecl9GKcdZ79YCxbL0muGEPLcKqMz
         V6THVAxGDvUJThgal+ibL1TYjlGAVALilt5bF29kE3NJAqCBjI75PkcU1CeyuwyN4uq4
         O4kcmlKLnYIOJl89JsWU9g848fXyvYpsKSEPvVHwlzHnJpQY5MTIgruFA6oe0bBx7Hqs
         kNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567125; x=1764171925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3irtgR9V6ILkzi6aCmzqNOzM4wzsrVUTWgR/+hcFNWM=;
        b=lKcPEi/+uCq/WoJBWmzFBce8Z5Xx1ADE08tysR3/Tus1Ami/z9sz6VYgjx7ZPvVZhv
         6HsWgo+Y0jf0qEysW0Ez0zscbFLTlXLWh26mOEiRIeCVELKQfzCrixd7fhDnDh3w7/4R
         frpNPnIU6hnDox00C3eQfl/MuLcQpQzOP4zHQzlOfaqpABhoA1JhRMf6j+l3VrKHq9Q3
         nnhKRrze9K1pLBgY6kj8ZvLJGCYdRFAlLtY9x6inBg7BvCCCTUI+L+rFd9mATPHLoqcj
         qqv/gK60trfHkPdhk3w2NxPJz5YGfV9F4tEPCEcXvIAVgiSybLS4B+4cTELW+RRJ8f31
         NJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsj9mu88bgIzBkcUh+ViPl80BvhAbsjlM9jT60BFwzP071T4Bnt6D5e0jTOPEpiVQCkGm3SONTw8EcPQbXaNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59j7bWIPzKoecuUoqpmG1K9OOvayTNGfYoMvLw1anyLaiXnF7
	szlsDRmgted1aDsJ2qCMLrX9fWY68KyqUSJQ0eBbR8f9vxiyGbZ7xg19M5QD9YobA6w=
X-Gm-Gg: ASbGncvie2RdMKK73inTEvJrHjk+oRSyFCm10jiRtxKWNm5aRnL5k9VcqNdTu4Rsey2
	+BfXSSbB+u7Y2woZI0LoK0ppqMPLmVui4/Q5nfcvacA2q07nvIobzaRUxQyeQfaZ5/gJ0dQv4wL
	+yMwHn3bn/rXeL34lNe4kU26B9F7gtHF4ylS21flJaKfX4axxMX+kFViK8q/y5VGdA1T1IIO+C8
	6mjtwf3z0tImV697NdmBoD4s33n/mUfFyCRQAYpVgCpPmdAsRfFT1N6J2CDU4l9bCX69aplHOG4
	aj5OBqv191tPPS4LxEXoU4QLPuPLkcTwmWyS8x1wrGQrb8DtLOARJCXy5e+arfdNinE06TpdG4r
	4MawsA0+z2AUBC/xHSQlTth47w9xzcY0vECvCfUfrbosBKdaNUL0hQQ9x6aw8aGl8NhgG+UUX8o
	dOAor8A4qMmRrztC2J7sLNIO9nbq0rPw==
X-Google-Smtp-Source: AGHT+IH7OiMHuWdKqmUscjGj0hpAhy0+8U72IgAGXn7ATooehRTT7HxTJk0qp9VlE6dzqjBsHdcltA==
X-Received: by 2002:a05:6000:2901:b0:42b:3e60:18cd with SMTP id ffacd0b85a97d-42b5933dfdemr19022522f8f.11.1763567125510;
        Wed, 19 Nov 2025 07:45:25 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:25 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 05/26] genirq/irqdesc: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:06 +0200
Message-ID: <20251119154427.1033475-6-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - nr_irqs

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/irq/irqdesc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index db714d3014b5..89538324a95a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -16,6 +16,7 @@
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
 #include <linux/string_choices.h>
+#include <linux/meminspect.h>
 
 #include "internals.h"
 
@@ -140,6 +141,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 }
 
 static unsigned int nr_irqs = NR_IRQS;
+MEMINSPECT_SIMPLE_ENTRY(nr_irqs);
 
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.
-- 
2.43.0

