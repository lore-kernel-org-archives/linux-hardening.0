Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3425E80A
	for <linux-hardening@vger.kernel.org>; Tue, 10 Jun 2025 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749531909; cv=none; b=F2nCUobayW1ytSg+9ec0eFTzTNmxkvLXu7/HEv3GxFjWYWwk5FcWhithI5GsgkT1xygO+Qhm/cZwlH13tW3X3c66cjtTg9dlT2N1sxBC/VRyP1fsFaklu9Fb1EVZ6sK82TcqpgiZmPSZTlxfmI4IciZcPj3Thrh3XTmGo9gME+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749531909; c=relaxed/simple;
	bh=uyNqLoXucwkytiJ5G6V3n8mW9G9aw8BXAUcbIVRwFtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P6yuFniRQp6hGUKP+n0tTRnJdhyjJsGRlvUhoIojAsvEa98oY8fMPriika2IQcXY3/7WnY58aycxuc6f8Fw0PiHzfthT4Laeah3/p7aJ0RKNvRLEfDjq7zldee93VtQVxzRa5rH7kt5Z+Nd3C+6HS5DTwk4aHtYRjCSrzi4EeGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z+ahqp5l; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+ahqp5l"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso4268582b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Jun 2025 22:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749531907; x=1750136707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=imqHtGt/tO66pE6iWFuD1X2tjs5P6qkLBbewDhpPIyg=;
        b=Z+ahqp5lavby1uSVCG0DkZM1maM1W52PR/dBihhNY6ZSV/wbtYjAoBB+DyDlDtUej3
         tRFaesV5M/oLX98QqhMO393OSRgOjEKU2mugVNhotfPDTCUec+fCT+/1SZmcIw1SRZCS
         tYKls11klt774rEwHnwOiNhfi4WFwZevDbOYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749531907; x=1750136707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imqHtGt/tO66pE6iWFuD1X2tjs5P6qkLBbewDhpPIyg=;
        b=HSuSNKxbsxqP0w9oa92K9QgdW8OzysbH5syvSFxIrZe16nSF5dnIjjTJP6QRDEDTQd
         /hYWdljbxxuKq7xJ5V0ko/Ps5L3lH3OZPuRhxl+WmMC6TB7qW+9uDDyBSY3/pRzIYKKe
         ARb4qmbQZisBTmlfI+iC9avFE2KhIRExWrIj0YE0xX4IZ5wRr19F6mFHvPeYSqautgWT
         cXJuSEok7uMtUILfGyT2yp92NbTv7Q8YrtIUOsbuHZExJ1R33Pr+6yHIBZRMS0oPLgpL
         qpc1kKyTGMkbnkhurnNLIFMrndL17aXwzHGJl7SzhP0BSLseI4G9vHU+uxojE+lR4+Iv
         91jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpSIqpuggZsHqtkaEV+Wyhn8resXKDrkgue1Ww6LS1O5hn9c4l/k/qpvuaiCqnvcrF8HZ/wzYAoys1YZO9dsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZsR8ULsJ0yvfNjEXoUauZaTnqgzqAbAm0/oNk2M2yZYx5oeH
	eIiAeW7bzSbbIwcijQ3lGca0sx3eyAh//UGolz+cEfysCfRtr24XS/PP4W/4wGo7zA==
X-Gm-Gg: ASbGncsp0b61h5ktsu0YtU1FCUPTBMSwcwVUNw1RQoCbA/ziputPEUe5VTwrtWjMiD7
	Icy4JZszUoKRyJbIruuFf7+oFmXWVrw9Z1YM9dUvySnANNBVJRpVNbIsAwVLqppwzuoVumj1xxR
	Ra7rFelu9NRk0Aga5wj0D8Wlfnq8qVrLTA3IP2KTvJPWod9YXinJjWG81qtSv2iyiKw0reo2Yd2
	tVfbQLZi/rXvyjn0+te2NRQdkpVE4m//ADct2TzSsfHkW4wB83R59OywxAZk4rBSqr4lBA/GMi/
	HS/qMuq4ar5WneqsT8GzG8lthb8jU4otQEfEld3Jck2Eur1Z+8COP643dn6m7dSOzq841qPHleW
	o3EJMx5YKe7sQ3V+4r7E=
X-Google-Smtp-Source: AGHT+IEyvsBr6E/EX/tDQzT9qF/aIlLCH2bHJIt9wooBRZ+wpVSA3bPnKk7bwrMsUrtCyl1lykQxqw==
X-Received: by 2002:a05:6a20:4303:b0:218:11d6:b66 with SMTP id adf61e73a8af0-21f768bb26cmr3591721637.5.1749531907301;
        Mon, 09 Jun 2025 22:05:07 -0700 (PDT)
Received: from naoyatezuka1.tok.corp.google.com ([2401:fa00:8f:203:4173:c66c:ee04:82a8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ee6f6desm5222359a12.26.2025.06.09.22.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 22:05:06 -0700 (PDT)
From: Naoya Tezuka <naoyatezuka@chromium.org>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc: chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Naoya Tezuka <naoyatezuka@chromium.org>
Subject: [PATCH v2] platform/chrome: chromeos_pstore: Add ecc_size module parameter
Date: Tue, 10 Jun 2025 14:04:58 +0900
Message-ID: <20250610050458.4014083-1-naoyatezuka@chromium.org>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On ChromiumOS devices, the ecc_size is set to 0 (check dmesg | grep ecc 
to see `ecc: 0`): this disables ECC for ramoops region, even when 
ramoops.ecc=1 is given to kernel command line parameter.

This patch introduces ecc_size module parameter to provide an method to 
turn on ECC for ramoops and set different values of ecc_size per devices.

Signed-off-by: Naoya Tezuka <naoyatezuka@chromium.org>
---
v2:
- Remove an unnecessary blank line

v1: https://lore.kernel.org/lkml/20250610025152.3844404-1-naoyatezuka@chromium.org/ 
---
 drivers/platform/chrome/chromeos_pstore.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index f37c0ef4af1f..28e26aa99cdf 100644
--- a/drivers/platform/chrome/chromeos_pstore.c
+++ b/drivers/platform/chrome/chromeos_pstore.c
@@ -9,6 +9,10 @@
 #include <linux/platform_device.h>
 #include <linux/pstore_ram.h>
 
+static int ecc_size;
+module_param(ecc_size, int, 0444);
+MODULE_PARM_DESC(ecc_size, "ECC parity data size in bytes. A positive value enables ECC for the ramoops region.");
+
 static const struct dmi_system_id chromeos_pstore_dmi_table[] __initconst = {
 	{
 		/*
@@ -117,6 +121,9 @@ static int __init chromeos_pstore_init(void)
 {
 	bool acpi_dev_found;
 
+	if (ecc_size > 0)
+		chromeos_ramoops_data.ecc_info.ecc_size = ecc_size;
+
 	/* First check ACPI for non-hardcoded values from firmware. */
 	acpi_dev_found = chromeos_check_acpi();
 
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

