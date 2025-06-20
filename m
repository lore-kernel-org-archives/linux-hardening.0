Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FEC21FF58
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750400911; cv=none; b=mQLrRRm4WsFfYHoz4QWfdwMY8yL3aLVcBLQ3eJe9UWZsjduN3qJEDOeqvd6Tau0R+CU2BNKqCtldQi7Pfhdpy5aeI01VgzbMfMeQNSghUeBG39wE+pkWY4RfnCCROTVxpW23eDeum31LNIUy4t6XS65fI7pbuWSLrlLKoJRcGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750400911; c=relaxed/simple;
	bh=2AFaIWPZRedx7Q5HzhCbs3yuRCcoDXHqvr3dS0cGcPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aJ5chFCgR10YG6RVqb1V6BNPb/mR3+Hulvkv+axpYcmywKNggiMGNVbrEoVNvUD3uxqB9E8uRDVPBQ1v2c1hOHghCBaFRV6W69phtj7zQXO3hLzZxhEBqYoHkQfqfATfOKQZFxxP1xyaw/2fKrhKSVGipvvs2xlPMLSURKilA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dw1x6pZC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dw1x6pZC"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31d592bbe8so982807a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jun 2025 23:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750400909; x=1751005709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/E/aBc2e2AT3yv8e3js9rgirBkY/kk3mnts5DHmam8=;
        b=dw1x6pZCiyUYYN8b7lVuRwsoHay9C73AEOHOzFJSMmi7zMaQ6Axy12VQBR1aeGFWSI
         c32G465R5P3hA6roYBf1lajdFAht7LxAlruzZjuvEfiVy5oQ2adDVCBF4fTYHR7SA02P
         O1ijroU2RVa07L864gSWo5PzCydMmaBUvfBrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750400909; x=1751005709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/E/aBc2e2AT3yv8e3js9rgirBkY/kk3mnts5DHmam8=;
        b=Rc/SECEAgztrolMDTwH/Jdwg6Lu63vD7hkweIdAy0jJUHKn7T/pA4wjZNpLS1RIpQd
         9ntg5qPoMnujD5kotfcw9ZZMJmKBXpMXi3JLqHlT4WNk+6itrkqFUIn6V/j7ZJPPhTvs
         wqdTTQCnMuB9Rd96FV9jKmml126GeRoV6US3oRa6YH1U5fBN1HZPr91h3C5Yya7ndgi3
         UVXmKzEJdLSl6qdYayL91mN6t26cCYPEUpO5ZEjG2innNtQlDKWtL0pNTRzMW5kOJXkI
         io1w31al7E4MADLwETlnJevv+FqReHRVr7k8pr9btWZD/YZLf+af7ZkvLaWrPuRJefVs
         5e5A==
X-Forwarded-Encrypted: i=1; AJvYcCXwtcfxViwUwXE0Chj4TtPIFv0rfd5R0trf4DpIaqM1QHSpahrA4uSvLo29fdMUy8NinXxIPjn+mfU+O4Gx8Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjlU7OKREqNJ8AQuBcnEIItxYGklIfpByGeTkpGKlGzAjguw2
	5nfGd/uLGPx9NwdMBdR/NbR9fVQ7uIdMdwPM+zLivGU0FbrAGnUxYUIeCGdwnIHDRg==
X-Gm-Gg: ASbGncvgLXlRmLk/9Nzv6DzCSTi1/eW2RLBRXLqu101PfSQz5DTmNDaw9Bo7ajU0k4G
	CAhAamSDEftFbr+BnNSuPA7OpedUVfSG1AZiJNaYxMFgFREaqW7XifIv9uz5+Z42jM+Jj/SgleF
	lSRVCM9wEm3cVsjeG5Pr381giCUX13huUFEMqFaAALENIV0CNBSIarmEe3BoiKKC5g3W5Vt5z68
	2vRzpuIqWQIDeIsDGiGUa7GH/MflZY60AUf3fL0G/b2Upjz3GB3dgfduaW2fQ2xZeoX5izguYi+
	nV9dazs2rASqpG+o/9EpA8REnLqgsUORr9lBuLoumtVU325PH6PDFMJMBcRMAIoCnOKBS+HUVbe
	M4qq5X4dYBpdKoCQuxZI=
X-Google-Smtp-Source: AGHT+IGJPjXCxdFLKuGzej0hDCk3j8Q7GWXqQaXGEqJxWf+SYDAYvQaOgTuet4/X8KEARycL0FftIQ==
X-Received: by 2002:a17:90b:5148:b0:313:b78:dc14 with SMTP id 98e67ed59e1d1-3159d57b142mr3859178a91.0.1750400908881;
        Thu, 19 Jun 2025 23:28:28 -0700 (PDT)
Received: from naoyatezuka1.tok.corp.google.com ([2401:fa00:8f:203:8f2b:74f7:bc26:564e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f118eebdsm772427a12.6.2025.06.19.23.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 23:28:28 -0700 (PDT)
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
Subject: [PATCH v3] platform/chrome: chromeos_pstore: Add ecc_size module parameter
Date: Fri, 20 Jun 2025 15:28:22 +0900
Message-ID: <20250620062822.1018798-1-naoyatezuka@chromium.org>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On ChromiumOS devices, the `ecc_size` is set to 0 (check dmesg | grep ecc 
to see `ecc: 0`): this disables ECC for ramoops region, even when 
`ramoops.ecc=1` is given to kernel command line parameter.

Introduce `ecc_size` module parameter to provide an method to turn on ECC
for ramoops and set different values of ecc_size per devices.

A large `ecc_size` value can cause a kernel panic due to a constraint in
Reed-Solomon code library. The validation for this constraint should 
belong to the common pstore RAM layer, not in each individual driver. So
this check is handled by a separate patch [1].

[1] https://lore.kernel.org/lkml/20250620054757.1006729-1-naoyatezuka@chromium.org

Signed-off-by: Naoya Tezuka <naoyatezuka@chromium.org>
---
Changes in v3:
- Update commit message to use imperative mood as suggested.
- Change module parameter permissions for `ecc_size` to 0400 as suggested.
- State in commit message that the `ecc_size` upper bound issue is 
  addressed in a separte patch instead of validating in this driver.

- Link to v2: https://lore.kernel.org/lkml/20250610050458.4014083-1-naoyatezuka@chromium.org

Changes in v2:
- Remove an unnecessary blank line

- Link to v1: https://lore.kernel.org/lkml/20250610025152.3844404-1-naoyatezuka@chromium.org
---
 drivers/platform/chrome/chromeos_pstore.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index f37c0ef4af1f..a6eed99507d4 100644
--- a/drivers/platform/chrome/chromeos_pstore.c
+++ b/drivers/platform/chrome/chromeos_pstore.c
@@ -9,6 +9,10 @@
 #include <linux/platform_device.h>
 #include <linux/pstore_ram.h>
 
+static int ecc_size;
+module_param(ecc_size, int, 0400);
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
2.50.0.rc2.701.gf1e915cc24-goog

