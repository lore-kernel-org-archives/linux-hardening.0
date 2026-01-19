Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453671B81D3
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 05:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768799060; cv=none; b=hTFlrXwARpljjnro97OwrOuYwQgf87F+SEauL73K1a6x0u+SERvy9pUiMhBw6y1RKrU+i1PvW0N8mdmjDC3K7LpiZITf88CIaQcDLFDFiFFolqggLFVMDOEpkshJC7xleEKSSRHA6ab665lQl708G/A1mAuvhAXDu7X6XKdH4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768799060; c=relaxed/simple;
	bh=XPqSO6ltsflLuii08AxfHx9bR9Jyu12AqRI7lojBLBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4SdmUD5nGnRXECTO9z/Vil6RHzOburuzWeMfj+4tg2aZJo1V/BbH0aDeb2QnlUvDI1JaELevN195ZSwQDVXHO1Pr/XBdPlVY51h1PCHB46k+FM2EXjgy2iGzMzkVmt/89w675Plru4+9RyX51jF6jbZXLPGGcuqoBC85nnAm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xww/JQYv; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xww/JQYv"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8907fb0188fso41950266d6.1
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 21:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768799058; x=1769403858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcbVa3268lyqxBGM305ylj+tBhZM3T/QjOKg0r4LL34=;
        b=Xww/JQYvixd01fcQ8H7k1MeraXcTyGCvRosqGgu2A/ASeLb2Me5uyq1TtIFAY5sukm
         pHQeCu59Lu9o+a2ZKg0X9Wj/Xyjg32uj38+c6VCJVFs6HvOWjDaz6tbFCl7GI90Kg2Oe
         Mc68RKOWbpxwkey6bwpiJVPjf7nu4m4yPElo5NoyrU6LR49rLdaRJSZqXzzTDha96gsf
         ufvPdfxsHqhXRRCRcsNZBu67Pbpk1fPAxbZPapt0KSp5gngOh6lg3qoH2+xEGUSZ1+wg
         /v8EPGfcP2ZXXD/20+XwrIC4TBoQp5wJboLdzbH2UsdDNjoEjo8lZO6I41Sc5QQSxLKr
         WoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768799058; x=1769403858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcbVa3268lyqxBGM305ylj+tBhZM3T/QjOKg0r4LL34=;
        b=GCpP9MMTeDGTu7EHoHnZwSHR4I9jyYDhPgJdWAzxu2VDJWjf51I7B0UrsR2kgUkPfU
         vt4YC3sB6GEseH97MiqrwWAzT7fGZQzh8Vo5/iXZMCawXOdsgaiAmngbcFcKGWIe5fNU
         Ay2oOFwfnbfCLAVsrC/0Cq8kwxFgt+l1xntr4HHWOjDcIE5F0GFQkB5ZrJxLyIQHC8ty
         hf7BsyUTFHKKrXImEL8ZvUGbew+JctxFb8Tkf6rOpjn01qhjBYFCuQZwKdIhyi6YWy83
         JXZd0yBq9WQqtk0i88+NQslhotCKBBmhbGMwReOlAlY9FS8JWNjMhZVx0RQINqATEEli
         w1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXX/f63jg7P7avim6KdoRdLTH8bqwf+1sYR8eStnp+GPtF6unY20UMIKWvIYX60nE0LyJdWE5WKPyr0KC452b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzsi9Uw90INxpFJFt/D7hNwr+tw4pWxTmCFFdwu1zkRSs+x0V3
	+gjLCbRgk0WaNa/bcfroxdidO+q986ZWoubU9iDyFPn2ExEllD1e3PZP9IT97Q==
X-Gm-Gg: AY/fxX5TIejENdjyWNK9+LHLKJAa/Lfq1W0f7ZspfLGepA3VK96WAND/+nwQqu1fxe3
	IdxUADg8SWPjm18FOfrahFbD88so+o13OhJYPmEXlw/doi5CAz2zagtm+nB2if0EpsBNYbe+ay6
	AXZEwBodQ1G1XRY5CUirIgMg8XBOxb5wHeSR1Nmc4YS8IWytlFM5uuWn+C/2N39eBYolSeuVweo
	TZa1Heae6kq9KjM3eOI9gaL98SCkdhShRCd9wPqBBHXiKZIEDzqRnsZqjd2mFz/7XuP6hENfFlP
	AuOvKAUajkKMcjTC8TCkgzDjEDaebdgQ4cLz6pOonoCGF9JKMueJD/zHxcm11iBGA3rup2sgFlO
	Eli0A4ZXHahHH6m79Qu374yrKFC0+q5n7dUo3WzeEQa5kAQfs7OWY3CXNjc7AtcTQc7OL6rl9Pl
	DpwJaCpzXWrhz8cWzO20AN55nu2D+QK6bNMztmtDpkrKClA9W+wnPj/jGWAdJYdxSDTj0=
X-Received: by 2002:a05:620a:4490:b0:8c5:c9a0:ac28 with SMTP id af79cd13be357-8c6a68ea37dmr1331140285a.21.1768793442571;
        Sun, 18 Jan 2026 19:30:42 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:42 -0800 (PST)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	quic_jesszhan@quicinc.com,
	bavishimithil@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	thierry.reding@gmail.com
Cc: linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-hardening@vger.kernel.org
Subject: 
Date: Sun, 18 Jan 2026 22:30:25 -0500
Message-ID: <20260119033035.57538-2-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119033035.57538-1-bavishimithil@gmail.com>
References: <20260119033035.57538-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH v4 00/10] Initial support for Samsung Galaxy Tab 2 series

This series adds initial support for the Samsung Galaxy Tab 2
(samsung-espresso7/10) series of devices. It adds support for 6 variants
(P3100, P3110, P3113, P5100, P5110, P5113). Downstream categorised them
based on 3G and WiFi, but since they use different panel, touch
controllers, batteries, I decided to categorise them based on screen
size as espresso7 and espresso10.

It adds basic functionality for both the models including panel, drm,
sdcard, touchscreen, mmc, wifi, bluetooth, keys, battery, fuel gauge,
pmic, sensors.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
Changes in v4
- Fixed syntax in doestek vendor
- Changed - to _ in node names
- Removed address/size-cells in chosen
- Added pinmux for i2c-gpio5,6,7, irled
- Allow sdcard to poweroff (reg_espresso_external)
- Changed power to key-power
- Order alphabetically in omap4_pmx_wkup and omap4_pmx_core
- Use generic node names
- Added TODO for future nodes
- Fix touchscreen values in espresso7 and espresso10
- Add dts to Makefile
- Commit message length under 75
- Link to v3: https://lore.kernel.org/linux-omap/20241108200440.7562-1-bavishimithil@gmail.com/
Changes in v3
- Use device tree from the correct branch
- Fix commit subjects to matching the subsystem
- Add Doestek vendor
- Add compatible for LVDS encoder
- Add compatibles for 7 and 10 inch panels
- Clean up device tree using "make CHECK_DTBS=y"
- Link to v2: https://lore.kernel.org/all/20241030211215.347710-1-bavishimithil@gmail.com/
Changes in v2
- Fix node names in common dtsi to have - instead of _
- Removed import for twl6030.dtsi
- Edited dts to completely use twl6032 nodes
- Fixed typo ldosb -> ldousb
- Link to v1: https://lore.kernel.org/all/20241030194136.297648-1-bavishimithil@gmail.com/
--

Mithil Bavishi (10):
  ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
  dt-bindings: vendor-prefixes: Add Doestek
  dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
  dt-bindings: display: panel-lvds: Add compatible for Samsung
    LTN070NL01 Panel
  dt-bindings: display: panel-lvds: Add compatible for Samsung
    LTN101AL03 Panel
  ARM: dts: ti: omap: espresso-common: Add common device tree for
    Samsung Galaxy Tab 2 series
  dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0
  ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy
    Tab 2 7.0
  dt-bindings: omap: Add Samsung Galaxy Tab 2 10.1
  ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy
    Tab 2 10.1

 .../devicetree/bindings/arm/ti/omap.yaml      |   2 +
 .../bindings/display/bridge/lvds-codec.yaml   |   1 +
 .../bindings/display/panel/panel-lvds.yaml    |   4 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/ti/omap/Makefile            |   2 +
 .../omap/omap4-samsung-espresso-common.dtsi   | 762 ++++++++++++++++++
 .../dts/ti/omap/omap4-samsung-espresso10.dts  | 104 +++
 .../dts/ti/omap/omap4-samsung-espresso7.dts   |  70 ++
 arch/arm/boot/dts/ti/omap/twl6032.dtsi        |  77 ++
 9 files changed, 1024 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/twl6032.dtsi

-- 
2.43.0

