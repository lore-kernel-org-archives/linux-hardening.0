Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856B2DE71D
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365394; cv=none; b=X+vW+WpXYjLgXUlPlD67e3eNJ7IJJXbxfDXaWF2NhFZK++92KCne8JATB6+kX/1Fl9QOKGrJoyYTDl/VLn0x+fiIHnXkJwbx0HN4sT+R/68rbtBgE5JhlnfQUh+XAy354hAhDjegS781/dQjuK9DCgenHmHuxtndJBVgG1np2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365394; c=relaxed/simple;
	bh=WYZcYfuknZj3jTFjyz/2YrsteC6Vf4UuZMKZmSw4y2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyTqFW5RzwKnEMXY+2BBJT1VH97s115zQOOuOeupJLLEmPxziH6OPx89N73zrnK4HR7295Z9LxXsrycUxb32ooyCcVNSgg/Tuj/wTsVixvN6UA4r/KLPrJYq4ovDYy1NtdrF/5ayUGBXB1bE/t+mzGySmqw1B3AqVNKom73r9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Th3aUFFI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Th3aUFFI"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a588da60dfso649499f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365389; x=1753970189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=754ZhLeV6aTccnAi72YeZAlKqe4sOON/R6H0mwMKOfI=;
        b=Th3aUFFIQkGTV6sknzNIOajf27et1WQfLB29fQi7HkufV807DZOWxXheL4MoEi3zZ3
         g902QOkIy0IAJTWMNe5iSjJJUGhTKHuis+4rkDDgWUm27kzTq5615hdX0D1j2gyCp+eK
         JFh39ehqr0lZ6HQkTVfimzsFXYG/ZBJZAkPt/FFTfoekOqtl1ud7Ru6xpM/402OFXp9m
         X9UfeqYaRwjAmhvhFYd2MPMKeq9sZTcWxGXXIrwQsMItziTSrEtm9pWWla2DI0cmEc69
         B2qYsUcWWtp123urQK3cXCBMbWlYXXo8Vvip0LCdwhqw7XcijWppADMQJftEF70WvlZP
         JxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365389; x=1753970189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=754ZhLeV6aTccnAi72YeZAlKqe4sOON/R6H0mwMKOfI=;
        b=mZfVlHYqW0pFMQzQDbANXCGV3TM2FtXK2WqKegJP1a/F0sR9Y84AeqrNH1dnvY5Y9o
         XK+249/Xfx8SK/beSGnDpaF4jj2N3WzNv9TZz37Yn2aUGHOSz0HCXMd5OOjULRkyOVP9
         rX1AeO/js0lXZezAIicadvvhmpHPJEs61zsZo9fwT6gcFDSBLTjZuE6kqx92zgdXiT2Y
         +mLja8v2Zz226O7i7wcaVW27Sot0KkEOjUtspFzfTx4vGO3aVOnuBp7SnMzHtRK/fxA5
         N9Vfah+c6LK76qaRYY4vTsEN4UMuYfjpmMnQwJ2gcx1l7l/hMJjzEGO4DVzoqXfAm0Sl
         KYew==
X-Forwarded-Encrypted: i=1; AJvYcCX6+dHQPreRhLf6lXu/Fp6F7VwJnMm6X2uCmH9GqAs/6DynV1SU+TUNocmBaKrP/hAcOKJwvyY0XHfOfIwUDGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyziAfYx5SSYMB/gyfTPPD0R74xswkRC71Uw3/mMH47NAAOjh7b
	lrkPYgD6dqp+qDIPDt6ENpCLOsD12MQbo1AV/R/ibbRakZk6PAHMbxxNJP6Zzm2QVkU=
X-Gm-Gg: ASbGncuiZpsT+1IbRkjE1caz/+O6DeyTjh29XBvdgoeYU8n8k7dWn7U7hTFubKzX2ZZ
	ItEq6gXr4VDgxApW9gbY4TO8xRNXz2bl+/rhZwtWaPWGt1P8U7cwbKU77mEJ0dyYLBmF3ZMxp6Y
	aFBgCLJYbAIutA9NszQiSHBvQ1lG/APKRE9zZ6AmI01HjWERitysxpZgfa13NiZB+pJxZZ7ut0x
	LdWKZYMflF0VK1pUo5UflIgdap1JSTXzcsB6CL8eR0MzAj7FH4L4mTY4Wg/8fP4JWClRQhZ94k0
	qNROOafxVW26Ym2/1OxsdP19V9xZc6N4o9mFnd7ycQ47jqXBOIP/n1coBb9lkG8AvzutUrSoEd9
	oDhGfQgnGkSwn5z3kRiRV9rK7NAHFdMjRBbmqai2x7oAskUcSmKBwgoik+38todqJM71ZIh2pRu
	UfY5MrEkALnOadxLdgDlGUmMo=
X-Google-Smtp-Source: AGHT+IHl6TFfQx8To8y+XEm2d27DSKV0h+MO3rvshokYEfPVyki8zgMiinC0EkzG8gsJheCG6bV65Q==
X-Received: by 2002:a05:6000:188b:b0:3a8:2f65:3745 with SMTP id ffacd0b85a97d-3b768f11dfbmr6433064f8f.51.1753365389405;
        Thu, 24 Jul 2025 06:56:29 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:29 -0700 (PDT)
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
Subject: [RFC][PATCH v2 08/29] cpu: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:51 +0300
Message-ID: <20250724135512.518487-9-eugen.hristev@linaro.org>
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
 - __cpu_present_mask
 - __cpu_online_mask
 - __cpu_possible_mask
 - __cpu_active_mask

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index faf0f23fc5d8..d48e4dd979e9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -38,6 +38,7 @@
 #include <linux/random.h>
 #include <linux/cc_platform.h>
 #include <linux/parser.h>
+#include <linux/kmemdump.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -3092,18 +3093,22 @@ struct cpumask __cpu_possible_mask __ro_after_init
 struct cpumask __cpu_possible_mask __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
+KMEMDUMP_VAR_CORE(__cpu_possible_mask, sizeof(__cpu_possible_mask));
 
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
+KMEMDUMP_VAR_CORE(__cpu_online_mask, sizeof(__cpu_online_mask));
 
 struct cpumask __cpu_enabled_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_enabled_mask);
 
 struct cpumask __cpu_present_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_present_mask);
+KMEMDUMP_VAR_CORE(__cpu_present_mask, sizeof(__cpu_present_mask));
 
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
+KMEMDUMP_VAR_CORE(__cpu_active_mask, sizeof(__cpu_active_mask));
 
 struct cpumask __cpu_dying_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_dying_mask);
-- 
2.43.0

