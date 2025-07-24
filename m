Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AB2E4259
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365394; cv=none; b=rZ0/ocXgQEf/dv4/eEDT3TOxqBZYfV5SGr9C540hTCxAV4TluHpovhXEqn+kRBYgweQXf9bdlotwR7kjVrglrbtduA3M+Y/z2V7raFUQxLgF1m6GTUmLJ8rOqG2sHM0lleiCiUvp/2NQqqlaUIqoTRY4LriZE7BNaWqrECgIbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365394; c=relaxed/simple;
	bh=ghY+GwpjKzXQo2zgURX2uB3oB2874ijEbWShVaN08k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BteS5ddZDzowvJQ1hia9Q4ZYPV/3ATo53E6YKIdUkjL7QofCilILhVcb3/N+2d9TsU7kQ4+YQi2FI1kpaGwneGLURWN9Bet7/kHU/1aJB2lUmdnH7l0Bup0PryExZhQoI+RpJQdt5dDIA2CSDF7nvOyGV1lQW/bljkrrt0YaB4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rEOHDd7Q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEOHDd7Q"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b773767fddso160214f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365390; x=1753970190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SReSPaHbR3saXb697Yp9wPF5rwCm4qBMUK6NGh7oWew=;
        b=rEOHDd7Q8N2mYG5T6Unnixnoe176QqAN/bsTATidQzaTXYl8x6Fl7kfvxRo+ZWK4pc
         qMPiNcCtEXI/oOonec1lsGzrOXHoDqJ3VDuKDkuiRI9iifVqADHi3VMHybE8rEeRnfT2
         craY5TpZD6e5/X0OKbBzvy6zU6R5MiPYMHWfNs9a8ertibJByaQ1NYIaJ6koM5ZnZ0Sn
         7NpwjIqHtMAAtK6Y5G8b20QQ9wWOoneaAVnyoKgbSWe+n7xqx4hzWKiNTIIeQU3fJn6l
         eshPWsHMwEdHl5/6TtzTyIIVGndSQqVeaTyF7w88+qvU/tpL7QZ0qI2fL+YnilChs3qE
         Y+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365390; x=1753970190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SReSPaHbR3saXb697Yp9wPF5rwCm4qBMUK6NGh7oWew=;
        b=ad9sYANhQ83x6OC90rEIxTRv9c19B2LOelrY8gZe7H5o3sJh3S6uYy+FKVEudlxDyu
         G8BiizMTs0kHu8RGBJmMvhNeUFWHAr8iVnSj0RytrhDQ3r9W5XdOXy/OpRYyPg0JPESF
         8s4oLlzUIzmWs3HGKhY3wtK6hoUpMef8wbgpFbQmh7an8BoOr6Fq97MHM0w4K54mBOY8
         2B+8RNttSZbQSnZYz6FGEEd/Dmd104Hge4gvs9Y1l5bI3mRwJ1273Eq3fer9CtLjM1GQ
         GvEgLRdEIVt76tc+gGZ/xnqhBTGLePQTVqmBLLx8R5vWWDUu8qTR2oubdJdfRN/26rZq
         bP8g==
X-Forwarded-Encrypted: i=1; AJvYcCVbNI1pmKv2v/bAfSynH8SuAPDgEhJyva+SBmeZL/0Prs4ZAjtXmyemqOdr5WaU4DtbuJlvRZeBgYuzpDkY86Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YygdzCsCc0bYOEJabh3orpAa8zOJCwJ6AHIhiKQuipCdVqprYrl
	077QPTvtzDMUaWONnyrnGtMRqdz4xNZ3dCDf+rM6JwDCVLvYo3zStIC/hv6pidBiuK0=
X-Gm-Gg: ASbGncsv5ucNpYYvvtG540hgT0QzEGoU+NUt/uSBgvd3lpP7U05nBT+77jk6lgsAngC
	hB4/A0qPCVTAetuLnHLZDEzOyYOFPQa5BI/tix8ZpSXmESATQQn5lQTNiyseEr6ON0P3ftSd+qX
	Pzv/Z6HfDadsE7sYM95b0+FBb0zwHjnBmelnnDGFOc0yLMn4iDO7/tXMkXz+qUu+SWbzzlGDVG+
	YEDlTbWZrzPLUZr74oVwGx2lRdusFd/dm1so+ueVT5oZHCqJquvdb+5b8XxQslmpVbtbrkGBdEh
	s28ZnPmqaDH6dqrpTcy7wKQAQD6zSPXNcRBq8zSqieJROp/cPmqRZLqyEdZqH0qgdIWfrCzav/e
	ZGC514WUBiUyd+KM2GD9njEmASTfrv9EC40Q5aDHatLq31MYiVYRq1QoWghjHIq2fxx3WaqWJQT
	SqbvhdiFqWCpnz
X-Google-Smtp-Source: AGHT+IE5OpzTZyLft1dF8PAF1zWD0A9y1GJkIKlmiY5JcqmC3+aHq3C9hKZiU8MWr3uj6ilv3EjyHA==
X-Received: by 2002:a05:6000:2c0c:b0:3b6:333:256f with SMTP id ffacd0b85a97d-3b768f27e15mr5395112f8f.58.1753365390310;
        Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
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
Subject: [RFC][PATCH v2 09/29] genirq/irqdesc: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:52 +0300
Message-ID: <20250724135512.518487-10-eugen.hristev@linaro.org>
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
 - nr_irqs

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/irq/irqdesc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b64c57b44c20..6d11b85be2b3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/kmemdump.h>
 #include <linux/maple_tree.h>
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
@@ -140,6 +141,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 }
 
 static unsigned int nr_irqs = NR_IRQS;
+KMEMDUMP_VAR_CORE(nr_irqs, sizeof(nr_irqs));
 
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.
-- 
2.43.0

