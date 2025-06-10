Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266425E808
	for <linux-hardening@vger.kernel.org>; Tue, 10 Jun 2025 02:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749523936; cv=none; b=VO5EcyKLSECy/vBw+VlIieEJJtv+ujCuqyBwgGDqLK5xDAsnYGfgmzDcI30fu+xnGTvahkOQLSR2b2+oLgmp69pEkCgh2Ilsw8EGMjQgZkCJ/dNVoioc1vdKOz9WTVQSF6ZHD9qWjUKkUUN/foKhKbOo3k/9Zkov1+jH9WQi0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749523936; c=relaxed/simple;
	bh=BJSAuM/KEuH1gidHkhv+0rdYBs0sl4fswnQ67X/V5y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fDCs2CjP+Xv+NKbxLMlTvNt8T5GWBs0hdhQPU8vmYRdZb89O3XyO4Xm/dILUh0TFAkUwPtIYmgNHlWagMDPrstgovkAkCXgj6bHCPzuZZASgL5+udnniN+unelLu6axlmOU+Tf34taR0PBEFUAMEntcFPQ084uEY672eyRJRYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QLWe4uge; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QLWe4uge"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2363497cc4dso6321475ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Jun 2025 19:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749523933; x=1750128733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm7rFkHvnvV5pN555kvAO+KRnM6aiD+6xk7uYMzjvLU=;
        b=QLWe4ugeX2+zvNXVl0saAH25f8B6ENIKkDorKxTErK5J3QH0T131mP8i4QyF7wp4gE
         5aDl+5U1fMvIo5OVSXit76CWa5dZwuSlNVgOQ4xsFUn5jBhgdDrOoypZjkSVz2NRIAi5
         +Rg2woHIuDv+0U01CNu424kG2Wq9/mjnPFIa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749523933; x=1750128733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rm7rFkHvnvV5pN555kvAO+KRnM6aiD+6xk7uYMzjvLU=;
        b=RMbI/LviPIlc9+dgNaan7ZXnI0e4RiezyzirDov7flw6GcqeNY0d1++FZa1MjWTO8p
         eQNKnMB+TsFq4Xgjwj/wo0YLnTQ/0Od4NXIeTNXzRndlG+D093GJbnplWGSQ+MTmBvmM
         pZrF950HMk9sHw8y1lxiNZBg9+n/x7uHkf/Z8JI/T/39ZKgLuzoZRp+VsNu9SoQo9ckY
         nvT0+8kjBvDoMakGVfarSTWj6fhSRQmqK0Kb1KA4hdahkoaxeTHQPuQiAzEuVfPjovPD
         9em4JZNicmHKcM7p/gnq6FteAa7dl6+RFOaXFvyYrMNvIUBjaxWVmRaOoNMQ8O7HY3qB
         4UUg==
X-Forwarded-Encrypted: i=1; AJvYcCViwZfMeostKQhtW80jDnTLx73ivjt+3tfFl/cOO8EgQhQTnJdVxl28QsH3jjgFAGdHyvNPaDN855VImOvEll0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxapH+cfGmhMf0RFjgWVPOuJ9JRRyBn/sAW5BeeDKNGq8UAHWSp
	wEB5Vm2tPRYK41Ricz1oFJkhC0WtUHLKBL2xzVKXiHD2A/4+hc87ddecnX9Am5WMxQ==
X-Gm-Gg: ASbGnct/7DleloPebaSlan6yl5J9u3XbqrNR9KXoDIqjJ5sZEvmIQOhv0iqQUHjE+tB
	TOKEzp+YvGeCdCtAspG44TJ4kJ2lXRRxYaX6HPO5iyy6Abhti9ldGkYI/8hbc5flk1XMRZwJa5t
	d/y9nkmGuywkkgW8WDUyzPB0oDA+4Fcv8b6PQU+y8CWPO65x5r74Ecp5vAcHJn1EbX6XsMERi09
	Uf0N7TeVQzPScVbNZZwjFfxI/PLYl8Sg8dPRqnGjuWPl3ZRhSys0C2T5HbDjIk5H/PM9CmM1bR7
	nkzdP8l4okJLDz8v8l8ACqNSIqAEXC8Cp/n4qv3cCIOSz1tbjW99k5pcK4nUk15nRN777qydYUf
	lCQU8NFmmtDlnEl9uiO4=
X-Google-Smtp-Source: AGHT+IGm82o58ZVjCAo3PybTPYdGDfXUbsMi8+8LjHbWtOpjdJXIBSCQJyWdYXNP2Z2kXvDi5YGUeg==
X-Received: by 2002:a17:902:cf03:b0:234:9375:e07c with SMTP id d9443c01a7336-23601dbd9fcmr242591495ad.46.1749523933313;
        Mon, 09 Jun 2025 19:52:13 -0700 (PDT)
Received: from naoyatezuka1.tok.corp.google.com ([2401:fa00:8f:203:4173:c66c:ee04:82a8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603514230sm61107305ad.245.2025.06.09.19.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 19:52:12 -0700 (PDT)
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
Subject: [PATCH] platform/chrome: chromeos_pstore: Add ecc_size module parameter
Date: Tue, 10 Jun 2025 11:51:37 +0900
Message-ID: <20250610025152.3844404-1-naoyatezuka@chromium.org>
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
 drivers/platform/chrome/chromeos_pstore.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index f37c0ef4af1f..255818f24c2e 100644
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
@@ -115,8 +119,12 @@ static inline bool chromeos_check_acpi(void) { return false; }
 
 static int __init chromeos_pstore_init(void)
 {
+
 	bool acpi_dev_found;
 
+	if (ecc_size > 0)
+		chromeos_ramoops_data.ecc_info.ecc_size = ecc_size;
+
 	/* First check ACPI for non-hardcoded values from firmware. */
 	acpi_dev_found = chromeos_check_acpi();
 
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

