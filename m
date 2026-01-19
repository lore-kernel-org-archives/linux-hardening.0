Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EF5330646
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 05:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800465; cv=none; b=BIK7AUNSBMk7Hd0YxAOr2/bF5ZfieK7iPOc16Kpb4gxNaD2N6URIjak2iBs1nDDfuBMlzmmDL1uRz+EasWBlEK1sDwQWjQCs7DDDrOEmfvyE5aotkp6HCRG+OShmIvRTtatU+5MOZqjHlLRbRfrKDfclzFbatWqMp6Q0rxLBWd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800465; c=relaxed/simple;
	bh=Cr5+IhCHxPHPW3626dojbnKDaxlXfjju7kU8t6CdTJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJlP4JW0ztQadplDHnhKEiodZ2QKJQ1zdRuhvwtUpY5noEzJcFs2Z8CXjy2/kFMxJ2gLxGbMyAvF5ce8V2uv3NPKrupPRGjWDxo7bqltya+PAYxeyRWo01dlfnCZwb6up2L1fPLrN+/95AY6+75Y/BxlKonEwtvMo3npxDSlsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwpQT16n; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwpQT16n"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81f223c70d8so3329384b3a.1
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 21:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768800464; x=1769405264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nclpl2L8R9cKrulz3mBbfGGvQIswT/qMcBsWKZFoMYo=;
        b=hwpQT16netUlyL0fXD0vEI5DTBT17Katrzf53jH0+xKmSh0QkE+/ORO3Sgp/u0ZK4I
         hXVhS0U2ZFAntCBiC6J4q3gu8hxQvkUeLFEh0zEr0MWn8OY7Xl8T7VbL924rTOPZX5fL
         s7lbSlvMbq/4Mt9dYry24MpZWr6lZ5+EisHkdh7rNf1oqSu0i4vBg15fmhnuWjioMFgF
         7pBLKp4/SyV+PrLQN8jO2OyNZXNJXkc8dDm2EG4oj7MTY4gYXfB377pKQhh3Ltrfh2dD
         UutjTUq7jdKRqQSwvt/RL3l1fdWKIWvp0KsO8/sIBaQ45U+uqLk0nOOWA4aWHWwue33Z
         LBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768800464; x=1769405264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nclpl2L8R9cKrulz3mBbfGGvQIswT/qMcBsWKZFoMYo=;
        b=Lid04uJE40Q60zeEn3Jp2OCZdgH+NkCELn1lMjgdrOQARfPaYEkFRKvUQmJUj2N1GU
         5WepM/wJxDs24P3D9T1tG+B2exgsayXdNSunYxjj3YBlQeQtoScvukxLaFX9pv46eWHD
         6qqVD4MSiHS2/vQXTYbB8rBCw480DhYWn+2dVKZmYbZz4BvhSTBAuI/pUhWoxpP36cbW
         KdM+mLqyafmZ+JXTfm+EFvIT1AcsGPekdulAzRA+sXH/TIm0YWEfKUY0a07ehmo4Rv8r
         JxP/2npbKbDkj9Sav8T6c3owyGA5DGyJBq30Hm5uBGkSx2w0lcYmqJCvZkeQY2fWPTWm
         EXSA==
X-Forwarded-Encrypted: i=1; AJvYcCUpCkEyPx7erF1haJSel279nHFv7I7AFNQXby/d7Z1LdZ5j2gEhfRGXXoNTwoxbGp4gg3qwldH/djYMjVRoPWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7K2FJQyLwHc/wPRcXf8CYqkXOgR6EDHyCOamTz1f64+6aOuZH
	OD+v4EksGRW05zA+aGM8g1K2G/qKiP6gLfx+LiJY4f3nqpX3dfSsrmELRvEZXA==
X-Gm-Gg: AY/fxX4qgWN3n7xNLrbxcW2PxsVShmTuZsKsCK7EFn+H495Coc92FB+m+W0TNztl/m0
	UPfw75sQLN8l1BfA/66q08sCAap6EkXHyCCJdxcbCfMSDOffpCQ4Wb+kMgzMLT72riCUPLb4znn
	bLXZktkhatn+iXTx4yHF8nzlmS2BdjgSoBeSQPGd5tofpsOf6L7TSYxdoP9WsydpsSYfXHgUsK/
	DTtdCIk3HsYoYYyehi0X99Lcdp9L8Y/SimPQ4xoENV2UkMYwcKLTsA7Q9dJdSDrGtZrnQvMSSgx
	8d/nIYOq5CFQzwAgfClcAut6X3LZD7dNzNnAmL8RHcynu4emZ8N2gJLt9jZ3sRvTk+OShllj3Wn
	M4Oev5Fo3Pjq73SSJthSiqxN88iTrheEGx6d97EGiePSejj2B3XesTMvFlNCRYD/WTiwH7WFI7o
	3UEVp0td0ISjjg7zTgX/LvXhHYBlHklQBxU9uIgJFtU2yKyWWGdNZZxjA/mCtY51leB5s=
X-Received: by 2002:a05:622a:15c6:b0:4ff:c63c:525b with SMTP id d75a77b69052e-502a1e5d13cmr132927051cf.26.1768794044833;
        Sun, 18 Jan 2026 19:40:44 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f1b872sm64030801cf.31.2026.01.18.19.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:40:44 -0800 (PST)
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
Subject: [PATCH v4 01/10] ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
Date: Sun, 18 Jan 2026 22:40:25 -0500
Message-ID: <20260119034025.58091-2-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119034025.58091-1-bavishimithil@gmail.com>
References: <20260119034025.58091-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a dedicated DTS file for the TWL6032 PMIC (Phoenix Lite). Already
has driver support with TWL6030 (Phoenix) since both of them are so
similar, some nodes can be reused from TWL6030 as well.

This can be included in the board files like twl6030.
Example:
...
&i2c1 {
    twl: twl@48 {
        reg = <0x48>;
        interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-controller;
        interrupt-parent = <&gic>;
    };
};

/include/ "twl6032.dtsi"
...

Used in devices like samsung-espresso, amazon-jem, epson-embt2ws etc.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 arch/arm/boot/dts/ti/omap/twl6032.dtsi | 77 ++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/twl6032.dtsi

diff --git a/arch/arm/boot/dts/ti/omap/twl6032.dtsi b/arch/arm/boot/dts/ti/omap/twl6032.dtsi
new file mode 100644
index 000000000..d599a2ca6
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/twl6032.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Integrated Power Management Chip
+ * https://www.ti.com/lit/ds/symlink/twl6032.pdf
+ */
+
+&twl {
+	compatible = "ti,twl6032";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	rtc {
+		compatible = "ti,twl4030-rtc";
+		interrupts = <11>;
+	};
+
+	vio: regulator-vio {
+		compatible = "ti,twl6032-vio";
+	};
+
+	ldo1: regulator-ldo1 {
+		compatible = "ti,twl6032-ldo1";
+	};
+
+	ldo2: regulator-ldo2 {
+		compatible = "ti,twl6032-ldo2";
+	};
+
+	ldo3: regulator-ldo3 {
+		compatible = "ti,twl6032-ldo3";
+	};
+
+	ldo4: regulator-ldo4 {
+		compatible = "ti,twl6032-ldo4";
+	};
+
+	ldo5: regulator-ldo5 {
+		compatible = "ti,twl6032-ldo5";
+	};
+
+	ldo6: regulator-ldo6 {
+		compatible = "ti,twl6032-ldo6";
+	};
+
+	ldoln: regulator-ldoln {
+		compatible = "ti,twl6032-ldoln";
+	};
+
+	ldousb: regulator-ldousb {
+		compatible = "ti,twl6032-ldousb";
+	};
+
+	smps4: regulator-smps4 {
+		compatible = "ti,twl6032-smps4";
+	};
+
+	gpadc: gpadc {
+		compatible = "ti,twl6032-gpadc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
+
+	twl_usb_comparator: usb-comparator {
+		compatible = "ti,twl6030-usb";
+		interrupts = <4>, <10>;
+	};
+
+	twl_pwm: pwm {
+		compatible = "ti,twl6030-pwm";
+		#pwm-cells = <2>;
+	};
+
+	twl_pwmled: pwmled {
+		compatible = "ti,twl6030-pwmled";
+		#pwm-cells = <2>;
+	};
+};
-- 
2.43.0

