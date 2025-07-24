Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786D2EA462
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365410; cv=none; b=MteK5uM9xFXh6AM+2TFaag0kRv/fM3QteUOT3fVazKvtOHdW4EvI1+0KiL005sAPg9kYG7Wm2LIurTNDO7xV8NJ87dsLGnwakohGTSMC1sfcFpfzJ8yWua/qUmXuuEEDz7o+zBYwuiJDWCtjkzRvXOC0d1H/HaykKEqn2M06DCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365410; c=relaxed/simple;
	bh=X7sQWVi2ES5AdRRit9jippI6XjHYlOeEQQ68I6dFb/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzMWwCIiAZ7xD73xa4/Wmqj9VtfWjYlzGhi7maKl0n5GkiNn65bZaB40VsVMujS8+tJqdd2f2tuCNvswrT34UaTNOIdz9GOV1izOvu/mPtxK8I1W2+iDuSyidvkPzcTpqHI/cIUU/m8huKM2M2t3u+Zy1HZgRzGdgaDvYGwnpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hDK8xxre; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDK8xxre"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso11044425e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365404; x=1753970204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io4h5WAIvfQT3VZkI4AOHF3Wp3PwROfn1AQPtlUH1DA=;
        b=hDK8xxreujp3pWqlOMBgHmmfxII1+ZylRyCnatQz8Hk0KNv42+sXlYYp46lcSWd523
         4LuB40mwAABhQX7sjVmSidiHpqHylox331Mjz4+Lchqvwum1GNawBGl4vQ57S7M+BsH+
         vZkkP2Mv1RO4CpOAvit+S8EBWTHEIOFr3SehSdTDrky7xm0ndHSqS4Cov+H+OZSN1Q92
         o77CgsrPAOIQ51h59pGKu40MHnFCuMgl6JMJhv6JcB6E3QJZqv1yx31SbUUXPSj0Nv+s
         NwxZaXNRDj4Xckeql1Mrll1FKb64A8a/27wwvKfM9If0OvfszU/UF6rmMUUqGVbUJG/9
         acsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365404; x=1753970204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io4h5WAIvfQT3VZkI4AOHF3Wp3PwROfn1AQPtlUH1DA=;
        b=cQKsUvChsdpTZczuzT6bcDkMQy1EE1FGoz68zwASEm6HU/gbkjsyZEeZLAUDkcDL2+
         dfeXoEtysk86dfp7D0iAHKJTdXjON+PXwRTjIANXjRpOyx+t7Pqkgn/bICUVKCY2WXSL
         gyTTUAMO2YfHIKdubKxUNYa9JtSGQOyLdGWmETEZtOKuKQPBHW6FNTmsS6u2BGFO9drC
         yGjWNM01LizcrztJW77iOPwcMxNgIG5K5yeORxqjlInFeLm8+WAcf+9X67rtP5GNc88o
         +Ivk4iIiJeAtn+3A2Ts57jXjlacWzaVJ4qQ8DQ1wHe6C32oEo1TDwVvgC6M26RdIWSYn
         ntFw==
X-Forwarded-Encrypted: i=1; AJvYcCUGB7f8d9X3XPPE2/W3USZ86Y4TQ2onSHNGp3Q4yP8JOEBtZ8qjha8vzJ+NRwjBk+OsOzW10CCbLLAumaPs7+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yympwa3lUVMZxN9svkB3/qSIZhWgoVSt7iTHRhNpuHj1xZH+hLy
	Odo6zan+26xe3+ghkMug6mHTWdLPaTnvLxBCJkBX2MofIhjbiUBdgjwdhwlXcSRJ71E=
X-Gm-Gg: ASbGnctbHkawhArYn4GSfmkOePhYYWf0Wb/kg9BZoRXDK1Wpp2FSdKvDgmb+EhO8lKO
	buA0k4fhX4+cElnasc1FOJsxcADwuB4hcfJibLRKozQzL6QDbXkOugyU20/rAvkAQzisdR4Tx7l
	Bkq0Lk5nkC11Q+pOeDvzJZp48G/fCKoaCgwJbK95S/Nfqe4szwLbEapZy13Y/mzEruDnq5ZC1Vh
	eXcQP+tdIdQPTU7RLvxEo+U1ei21kUzu3PyI1j17FwPEe8tgvLPVb/tKQWGUiUnmWvgf1eX2aef
	khpViQHdUB2/IEemgWhNrCcUVqF1LtNWZrXroV7UbsPVNQxOm54RoWnLfdzOYBAhAlsU4IkW/L0
	uTQBR7vExyCmc4DmOmEwY+o84CTsBrmWAQfW5fnrqRo60Jt4+QNyKKSCdN/oYbOWMSDpCOrHZ4R
	+iAiu9a/nB0FJC
X-Google-Smtp-Source: AGHT+IGKgu4NRvfPslcwd+sSrmwQP//isSIOnofkVKYWLLSsjM6dUJOy4a8soeLJ5d7o54vF2kp7ew==
X-Received: by 2002:a05:600c:1c22:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-45868d31a2bmr69596125e9.18.1753365403699;
        Thu, 24 Jul 2025 06:56:43 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:43 -0700 (PDT)
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
Subject: [RFC][PATCH v2 24/29] kernel/vmcore_info: Register dynamic information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:07 +0300
Message-ID: <20250724135512.518487-25-eugen.hristev@linaro.org>
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

Register vmcoreinfo information into kmemdump.
Because the size of the info is computed after all entries are being
added, there is no point in registering the whole page, rather, call
the kmemdump registration once everything is in place with the right size.
A second reason is that the vmcoreinfo is added as a region inside
the ELF coreimage note, there is no point in having blank space at the end.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/vmcore_info.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e066d31d08f8..d808c5e67f35 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -14,6 +14,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/kmemdump.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -227,6 +228,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_VMCOREINFO,
+			     (void *)vmcoreinfo_data, vmcoreinfo_size);
 	return 0;
 }
 
-- 
2.43.0

