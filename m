Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5E13A3F7
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800643; cv=none; b=NccZ63WS7lZx3+BxxfiSR7DqkylMiTQblS16PGzRoMyAb25FrG5vkTHc8r9Gl8BqAlLx1G8ztvKibFCpROMUnOXJEV2nrr8EdrYM2u4r+WSbMkMtGBZbNJz3yNQrnUw+R9hTT0e399W/5CetOpwSmINfvKrtKi1fUoO2Vm8t7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800643; c=relaxed/simple;
	bh=Cr5+IhCHxPHPW3626dojbnKDaxlXfjju7kU8t6CdTJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LasPpDyMhqE54Z/wHpCFbUIjM/3xDvEeaiSmsWtUXchZjDHjTVV63HkmGy17z8MW/lvC+F86uHzVYz2J3wD9HRVnlXnzmOKwWyNut1wWTNZFX3/y3u7n3pj7Y6HG6P6DQ4UEXbGMJVtMrgOJ1+UzMUQI8hQHtgpnJMPppkbo4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSSBEbkk; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSSBEbkk"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50146fcf927so42827991cf.0
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 21:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768800641; x=1769405441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nclpl2L8R9cKrulz3mBbfGGvQIswT/qMcBsWKZFoMYo=;
        b=fSSBEbkkkRzd7RCiYZ8tEBS4wmanVLgxThUD/zwI85viv9ZxZLuqPgGBRbFWG7SwRD
         K0ro/gr1bTzkR5NSFRZ7DZU/uodSCePPTmawwrmoh9L39jM369iMWxOVhADOuMQkyfaU
         jpGbGc0QB7jSZDYR/Pb5mujnm+vREoZgBOLbODKitX2aalSuNARxUa/igPoNrlbkKrYV
         deKckII9Xg2/D3h1EZqrSK8KuruEuC5aMDym2nLjB4KKEk9S+jEz1D7M8DADOfTf7qQh
         rmo+PQYqqnxuOP9DgRYoxuVsd1CJL+okJ5KIREk0FftBL2cZNoTKLFeEZThgodPgcFpp
         DZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768800641; x=1769405441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nclpl2L8R9cKrulz3mBbfGGvQIswT/qMcBsWKZFoMYo=;
        b=ui9QCjO+ihETSwG2QVn172sHD2XF/OcTDmvrCqLEVa4t0n1Ui2V57QWzCkAEtq+PNQ
         24L6wWlI8NZgCOwTVg8WUPMlolQIq50rlKbNchBkUH3SVZuYiB37YRKAhO6pegxVKEEx
         3XIPsp0xUAlIf5wC+Nl58pOLTHyaNmkNeDKXz3d+vXqTA+zspvY28fAg7cakAiU6z/pP
         4r2tADUyQ3k2+E/H2v9qY4yT2Ccq0nb9Q5BT0Nvi/M+ue9AJ4bsOx2uoKgfIDnsQFtji
         owHtVvg+MNdB2JyqaSq+Bmk3NtBQSByotDKDS+urJ21MUUxXixH2YHHALPwl3SPeVDNq
         IePA==
X-Forwarded-Encrypted: i=1; AJvYcCULnShZcpXh93kxeIJJTsofuCqYHXVd4rtCagc4cO33F/tThkymstA61FS9RDl+Ot05e/64wL94irhj3GmsrxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3IM0JmRg6mlUJuGsYUWknZEPDeQG9R/4jWY8FVwlEfAxjqs7m
	/eXZH7Dtlo9cG/b5E0R6TQHcOcKLBHWnTmQPPyR9Gx8tT+qvfzgMBbAm8V1pEw==
X-Gm-Gg: AY/fxX4M2dy4CoCR3Mr1I9VQBwh812pcvwht0VGVVFjBgUYkGXTuxXAqzWVsimEZddB
	KxJc367yFAWvE9AwSpnj+I3qiEm6J7R/EeXIYbmBZ/qBKLjKWyleFEdCy5GaAKHYv0UrVj1VaEi
	xne6QVo0wuN3wLmTuorAtCifCUcYUN9SEN84qO+gm4MF4GaNCVM1xNTzTJBW5zIxa8JwVK+g/qg
	I0zzqd1AV6u9cBO+HwVUk8chUjPXB7L6JvwTBjm79tpLkX+e0fbuFtQmhVej8+oPwjDDMPlRRRD
	J31H1iVBgeeuJ21MHcXFMlgp6dVuVClKKBP6AyQoej2Hj/eBn1W35vWoHODzogc6NrQyR6pj3wk
	IXWGpwlCe0PHNfAPAOWrw6PUeaYsdbYoS0NhzyDf7FZ6jMryhAiZnqCpRcg8YwUM0uhWRkBbVwa
	NLJhrkeYXtdB91c1Z0Tyi8H5KdIKo57rnvgCTm1uFVh/5dwpzBK+MTHBuy34j33Wn5eFI=
X-Received: by 2002:a05:620a:450b:b0:8c6:a587:377f with SMTP id af79cd13be357-8c6a58737e7mr1680298485a.36.1768793444229;
        Sun, 18 Jan 2026 19:30:44 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:43 -0800 (PST)
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
Date: Sun, 18 Jan 2026 22:30:26 -0500
Message-ID: <20260119033035.57538-3-bavishimithil@gmail.com>
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

