Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24DE3271F7
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567145; cv=none; b=SYw7b1qYcb3CLSICoBvfwxZ5zAEhFRJfqExnr97/QnZ6TYrOjpq/XF02FpxlGy2t2oNhCpxf3x7deUfN6YI9oVTMCPcCU+FQDhYhxLMju0DFglf1cUXbOQTxV0yXVp1ltKDe+9jOvh2uicOYK4BFfRX8cUGvdKcEIcpo3npIk2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567145; c=relaxed/simple;
	bh=JX9G2IddNBochneGYWQCKynmuHEMYdz6GZlhqVo2tUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fN6ZsKRN4krKXUiQD++qujYoEjPMuYnrCqg4ld/fhoBOZo929shfdjm49jk5gGfuKdAUnzlizYGOYQprHfwq/dBZVgCwe9g65iSnfLPGKgqB7W5Wv0BQu7+BtU/heENfUlC2nS5YTsWuCl8DHiLFKWiPTDe4RRbdA2d2j5wFmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rAnSdbFB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAnSdbFB"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2dc17965so5618251f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567139; x=1764171939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjJbR05GJTjvP4eC8iuNclWxk1mMm5RuLT4aWNn+uIg=;
        b=rAnSdbFBCLvJLjGUsRP/QcCxvZOZSBH0Zgq71o4AlrJ42jn5rslMLmFXW2AxVikkjc
         TCFSyFvag+KDqaGb+sGs6y6Xav09Zyp10l3ZPFhA94o2Ri3OzwIj02xzj+m0FuSPn/Gv
         hD1RwrF7bt3oyLRQ5AQJ5JdP2XYKa+DRSBQ8FahHCby8Rmw4HIxn1MEMOVXs7a2B6/2u
         EVKQhhdTnuxBtaFrS4GyTGu+YV6B791L869p/wQHxmNOdi+WqgZOXrqw3s6bGiwy5FTy
         Tw6bwTM4dfJLyCpzNUExW1r8gLRr75kF8oll6wI7RdBr3kTbO/KRsqKSb6aLjhuH5/bX
         l6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567139; x=1764171939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JjJbR05GJTjvP4eC8iuNclWxk1mMm5RuLT4aWNn+uIg=;
        b=q9RhJBUAejzTud9ngKg0JtAJyf5l8lXEyvVGrGyxhtuRr6xIQy+ruRnbfG3NGmqUQF
         etJENFAA2w5TG221TLxqcjml8mIom3lJ+oTB77YBBLj/CJXbMU0XbhhaBeuFLFcq059c
         kLA9BkYbs7omzJ8RbbFVCNyHTJ4zqBXLF153XkAM1NJP7OrLT6qDf8BAmlhp4959jXQb
         vdD+LHvDz+t3viOttfjWtaYjNUYXCSY5wWZ2jCov9VlmJ/7TyDJZV2b1306owh+4LRp8
         Z/reJArZN8U+X6vSYjPpTtjDco0bJ2sGG10W32xctnGDLBoxInSUJuqUCeIyk4OlSwz9
         SXZA==
X-Forwarded-Encrypted: i=1; AJvYcCVRjS9Uv8qv16HIPM2xhpjidj8qCdgJ9mVPDrO1qhtXS4UQvmzrpoiaAGpkV1RLWIW3CNNLaXvDokQjIz++v/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgO/bKsAngE2VlyDTaMvJWWXexoU+ZfPnbRTmUHfJhzSRCyT5e
	SYbuOcfIzsbTdVFeTdOtdiJ52h9pMcPSi9o4aoISJ3nnpsB9jKd2awL9K1t550v16Dw=
X-Gm-Gg: ASbGncvMeqrTvD4rCRUN4Z1PdKrKClfxPJ4HFz/PXpaVD9sEx31MZdc7NL6R/qc+X1o
	yPI4JPa9M73So3qRssF69eBqgsZl9WlXFMI0xNkvZkuZbllec66LRkldV8R9ML0W6T9dAEeei5+
	ctVhWQSRQxuktvD7XeVfIST/P8JkOeoSCPR3XiOhMbIpdHqGh97kHkffXHpIMoCgf9gy1cpkrM2
	xGLvUAosZc4WmbNieGVGN/Hz/qG+6b5DIKONQKp97teJl+yqLET4yC5R4r6h/r6MjvG3S1H8rVa
	PWPM1ndHR1hQi3JWWxjQHmULhvwB8Cpib3tmlMulwHYX6PQaP4L7w+6gF8Z+yoo7JPE0TeM+mDC
	gShA5FZgPVKxjKPPjYtJAb9FbN8HblycuRd7hyL40Wx6RYsfTy8c3ISfRQNpaVyaIBnqYOdPo2D
	FCaqogf+PBGo5P5kFxGHPkfK3G/SHTbQ==
X-Google-Smtp-Source: AGHT+IEyhedKwAlBM3EiuchJNsF2kJSsWS7yZo6BNIFhuE+C/7ka0URI4Q7HQ+TXxvH0Bkqj0xsuVQ==
X-Received: by 2002:a05:6000:2c11:b0:429:cd3f:f43b with SMTP id ffacd0b85a97d-42b5933e404mr19233459f8f.4.1763567139371;
        Wed, 19 Nov 2025 07:45:39 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:39 -0800 (PST)
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
Subject: [PATCH 13/26] mm/init-mm: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:14 +0200
Message-ID: <20251119154427.1033475-14-eugen.hristev@linaro.org>
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
 - init_mm
 - swapper_pg_dir
 - _sinittext
 - _einittext
 - _end
 - _text
 - _stext
 - _etext

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/init-mm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index 4600e7605cab..6931549bb7a2 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -7,6 +7,7 @@
 #include <linux/cpumask.h>
 #include <linux/mman.h>
 #include <linux/pgtable.h>
+#include <linux/meminspect.h>
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
@@ -19,6 +20,13 @@
 
 const struct vm_operations_struct vma_dummy_vm_ops;
 
+MEMINSPECT_AREA_ENTRY(_sinittext, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(_einittext, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(_end, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(_text, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(_stext, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(_etext, sizeof(void *));
+
 /*
  * For dynamically allocated mm_structs, there is a dynamically sized cpumask
  * at the end of the structure, the size of which depends on the maximum CPU
@@ -48,6 +56,9 @@ struct mm_struct init_mm = {
 	INIT_MM_CONTEXT(init_mm)
 };
 
+MEMINSPECT_SIMPLE_ENTRY(init_mm);
+MEMINSPECT_AREA_ENTRY(swapper_pg_dir, sizeof(void *));
+
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk)
 {
-- 
2.43.0

