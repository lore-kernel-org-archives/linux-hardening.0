Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610420C48A
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768799876; cv=none; b=BE3Sit2CougL7r/RfzZdJXn7PFuereqZM2jIbfFupgejENFBvcZ8VG1XX33QlempJ5yMeIFxaBcN9Bwz2U9pTK9d69e0sAlFOnZgyK18bRBzGL5cVjX+rW9XH4YQH5rIlicUjybvgJnhgNXR7FrRcKQpH5ExF+NqeF/kZOg24FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768799876; c=relaxed/simple;
	bh=Kth4TdY7BKRrFKvA30wZ10JzAU9o9teCxEq+81T6jOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQNocfBVXkLqmMASDUjBz9wlh1RQaiDhL55z9ffBVvxHPzYqre2OqImzXiMvnPHndmZlYs5lF3uBb3Flr24yooWYvUn62blpmg8ugQAe7Z3BdTMxh38nPsCFxj18a26ggP9WJ04tEl8leG053LioxygZnp+nC/bvYr0M0UYVh5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAtQRyNU; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAtQRyNU"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6a822068eso352779485a.3
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 21:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768799874; x=1769404674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=knOhHJnYgS3NfXJV6CmNIci8LqgQNdPXN9K0tc0/Z54=;
        b=bAtQRyNUGmC5JXB53120zBC1UR7KeHEjVp0iRes/LPRHpgeXg0b/l1mRc9iDoHvLvH
         Xd7nvrHrD+jndpyMgJsRciIOIVh2XP/bCK7vNzOdRpBxZXmLlm53zqbztYNNpxwZDK3T
         jCyxMwE2I9wSoUAkHCKNKdOJqjL8CatZKatbX4ngHlDYnmTfN2OKc9zd41mnRGU6GTuk
         AtHJ+Ch6zn26zD5CtKLAK/OWMDCAY5WS8gQM1ubvxQ97IeYH8q0YdWwjMMNKg7g1eSPt
         Jr2HgpkoZIhtrJNAkPf1w9EDBB78GEA6IL5xrT8IFuZpjBS1Nf1sfDmH2UVuhxTTH6Xp
         kLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768799874; x=1769404674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knOhHJnYgS3NfXJV6CmNIci8LqgQNdPXN9K0tc0/Z54=;
        b=RAtAdhwcgjU6ImxATipKRmjdL4b0f0sfL5krd4DvJ3DKe5FR2QGD+aGCRltRvUg7Xi
         BnmZsfba0ZktNJwT1BF5ZJe8zIOdqryXt0pbnAORJWDijgU99yucrGly0T25MjiHn2ge
         GJuREvKFku1kOnB//WdrtiQp6H8Pnx3l6cCsJgod1pQJywmvW7sDon05mUF2jbdES55m
         3iz6xUDxb0hrA24QMOot+L+I+5ooMDU5JkOSS5UJBURIpp5RmYmu8n+AQPZ2GX8If5kl
         ycrfAQQ3DHkFFOZsInMooaWfIH3WIk//P6wDBvY+lp7AAMWVfGfo2sMhjU7Gk1V7f8pV
         5b9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3sDVwNLG7C+1uwDwDinsfUABTCng02OfcDeg4xTOr8dLAfjdMKcbXUh0EvyPYXsuxuDKuqQPoGdgEfd5duPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHLgTeX90n2csjwUXCNVa/wZ2qeZCty5WFAYZN6X9K+9GueXC
	QcAeq6ofVsg0IqLtMFiqN37LtBV+kZDM93yF2E+19E1N+yYFo/3uG5IsC/sAcw==
X-Gm-Gg: AY/fxX6+kENBD+0iGUNQpaKm9JUU6C1JGfPBEns1caNZt5PXr1oX8UOJQjG3Eh5tdDf
	9Vs3Gp6W9T+0bdCIqY4325Oib/pwfdlVv/swNLrRZfUdaDCumt0sG9VPtTRBlaC228g/ObTJzqt
	PN7AhiaCa/iyL3ozxzUQ69/tDRDxysxon7XpZqd4PHciZWGMUyE7GZY+nHev3O1dv7EBSG8DyTx
	dEwKzBNMpA+9w0AWrTmxP3MC8fTqpJ7oKWhuePJTIG1HuPYPoQfuEk8Eu0lTAmSnuGVfROKMxRZ
	xt8WQWacIf8tTj2DBm4A6QynY4K90CmDwfoV428phnr6ajwd/6BsEA9ytS45FypRQ90tKvvf2cj
	E6mHVHomo49Sgoxf8ntoXxhHo1wMlvReL63t+ZXrtcZ38Gzui5UGMKGwJx2IR5Tpf8SIGUHQRzh
	Itp2JDr9h1C1JLCa6QMMt7bwI9j2eFuQEQ4p2HO+UncP0LSDairIkCOGfWM+9th3fA3RI=
X-Received: by 2002:a05:620a:178a:b0:8b1:1585:2252 with SMTP id af79cd13be357-8c6a68d35f7mr1336428085a.1.1768793440895;
        Sun, 18 Jan 2026 19:30:40 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:40 -0800 (PST)
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
Subject: [PATCH v4 00/10] Initial support for Samsung Galaxy Tab 2 series
Date: Sun, 18 Jan 2026 22:30:24 -0500
Message-ID: <20260119033035.57538-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mithil <bavishimithil@gmail.com>

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

 .../devicetree/bindings/arm/ti/omap.yaml      |    2 +
 .../bindings/display/bridge/lvds-codec.yaml   |    1 +
 .../bindings/display/panel/panel-lvds.yaml    |    4 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 arch/arm/boot/dts/ti/omap/Makefile            |    2 +
 .../omap/omap4-samsung-espresso-common.dtsi   |  762 ++
 .../dts/ti/omap/omap4-samsung-espresso10.dts  |  104 +
 .../dts/ti/omap/omap4-samsung-espresso7.dts   |   70 +
 arch/arm/boot/dts/ti/omap/twl6032.dtsi        |   77 +
 arch/arm/configs/espresso_defconfig           | 7506 +++++++++++++++++
 10 files changed, 8530 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/twl6032.dtsi
 create mode 100644 arch/arm/configs/espresso_defconfig

-- 
2.43.0

