Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A62E2EFD
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365392; cv=none; b=lp12wzmD21jcSSA6iA1byZvXdVEMvFqA1nEX985yM7Dkk9rgub/4QeQv97bUvpDHBBHEtFb9gbOEnjOMb3rzdIwb8Hvx23hhQiStzvYa/+TRzvM00k26F6+l3DIu8e9oGHEbMvh9fqwIPqxjsHs2jyan5gYtKUF58AlKV8R7mvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365392; c=relaxed/simple;
	bh=MqHhOcNuXJ5oZB2p2GySncf4wGrMH13kPtoLfjjbjDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uh8HAqQfEEiS7pljLzH2zmkvA3ZxpJAqobhGdworRZp2yOa4KUgtsiZ2P2SiPRG167fP+gLbTR8j1+Hzf+p9KhE8Y9K0fLmQIAH/GPAAUNlEBsN+l9Odcr4KCrqM8nNor1YJvkmZ65rHMtZJbr8NzAXA7XJ1YN14gsmAXuoMxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o06eEJlu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o06eEJlu"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso10929445e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365388; x=1753970188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/nDqiXo0oPmiwRgkXmDbqPxo4RR6UizLNSv2BWaLmE=;
        b=o06eEJluMpAq6dy3fOCgn7NAaSzuSdLBhZBZaMD6U2xLGIldpXohgymHLeLK9+xWTN
         9+x0DVM9KcOW0fY4UPa1AaD5nV7oIzwVpF86Ej2cHoXm1zIYpl5+rvdOgT3Nwm//QP27
         byvBAXdS/Fi5AYtUoXybNwolzf07pLMWW2vPPD0u5s2YcKeuBP0MFfJcWjzmtYUZSWbZ
         m7kL2edMOTv0Q7FZaKNHgT8kD4xvBPzICoJsgGAxesIxE7W+mMeflzXYeWut6unLzIP9
         NnwKtQwIthA7zFhcSIuGq9GPzo7rCpXXzNpyZyLhxNRncTKJhsKt2uydcdTkW4BEbf9W
         bZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365388; x=1753970188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/nDqiXo0oPmiwRgkXmDbqPxo4RR6UizLNSv2BWaLmE=;
        b=cgEoMcFyGd/RtkhmiFgC08Bv1awReB/rAxyv2UzaWvt+iKZldHLpGctjywDteHt9OB
         3WiFW0GvotuWQMRkb+dXBIg9lokM1pLTBDBiXlL8ViW18VhM1hwfUa+T3h8zXo/cHx5V
         6bicAvSKtmkODQ+Mv4rWM3RZWMOOSAr7Gc23U6fBYq5ZT3adWWCjTyZ6xb2MEnlbQiZD
         12L4zXwDEu3V9HBHNJJ+74mc0CAgdwIf+yhDOi3fwLq/MQ38UZdp8HAWVTlcOo1RwW+J
         0NsboB+xwHeOHZwydDqaPRfkcVWDyrCXalRhH7cIjyiqrDnfHsu1WMu7GI+YKn706/kL
         pSRw==
X-Forwarded-Encrypted: i=1; AJvYcCVqGe9oMEuSsNri9tIf0hU8Grd1svkdu9nX0H/vuFEzzbNf6QICYlseSxAHCD7ZLP8+YMNmGZWXGPyhWa/W+IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TNQyOGFUQ13bW2kyEvSE/WInQzQGNwhIr/uLBFwpy35T+3CT
	Vp6Vvw8hjSl8HmbUx/WKvZad7KUnqoTeLcSlnbcSUugrG2q82niPDQlnmlRGQS6Z88g=
X-Gm-Gg: ASbGncucpYaItfgDSl0uVtS5CWxsJHpM9VlVF8lU8+nVb2mtJ7bSGvYvB+W3Tee5uLI
	8wEO0/DUk4GyplZ8LQDP7zlaueWa5+rZCicE7RBnRtgRYXl0picujEBj+nkDG+GA8w5/tjptJfo
	BqgTI0huX+ppsmfNfb5EpzJmeqemd9XMGSKfi22JllcKdVwqRPno5F3KH24WO5iBEW8IuK83XAL
	aYPlnyakB5CGeTgA19hDVr5GMfIFCzTlQclL7+sOzvCnEB0dVgK8OD7SlgHjiO3+FyhmJAhSb5q
	BxrM7bVMzTbrqZzKUulqvk+QmZSIm9+cseV/vWhtG+NlLxa5cJ1NG6ZB+Ga3SL1dECEDOAHYfsO
	mPSbSnzvQq5udkEFOOvWusWc6UHtOaafjstqr/EOMtGEQPKlkF8Rwhhx/scTs4xS5B6SkmCUuAm
	4cV/ATgIiCf/S1
X-Google-Smtp-Source: AGHT+IFsfIJWNObH04glJtR4VMihBKDX2X1KMe4027IfQD5dai+xqhfpETfw7nG5oExxx5Qg+IUmng==
X-Received: by 2002:a05:600c:8719:b0:456:2ce8:b341 with SMTP id 5b1f17b1804b1-45868d47860mr71077715e9.17.1753365388431;
        Thu, 24 Jul 2025 06:56:28 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:28 -0700 (PDT)
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
Subject: [RFC][PATCH v2 07/29] init/version: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:50 +0300
Message-ID: <20250724135512.518487-8-eugen.hristev@linaro.org>
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
 - init_uts_ns
 - linux_banner

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 init/version.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/init/version.c b/init/version.c
index 94c96f6fbfe6..f5910c027948 100644
--- a/init/version.c
+++ b/init/version.c
@@ -16,6 +16,7 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/proc_ns.h>
+#include <linux/kmemdump.h>
 
 static int __init early_hostname(char *arg)
 {
@@ -51,4 +52,7 @@ const char linux_banner[] __weak;
 
 #include "version-timestamp.c"
 
+KMEMDUMP_VAR_CORE(init_uts_ns, sizeof(init_uts_ns));
+KMEMDUMP_VAR_CORE(linux_banner, sizeof(linux_banner));
+
 EXPORT_SYMBOL_GPL(init_uts_ns);
-- 
2.43.0

