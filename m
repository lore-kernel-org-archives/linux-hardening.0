Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737623;
	b=jAr5kuCnu70rivwOiQEIgqB9sBeC0aAsK/QI9GaqACy40XP38z9sOdWrrnA1FFELcsuh
	 FPrdqFFz7W0XjY8iCQkym4CofNJZGN/hG8j346Xm/Lm6o8ceXhU05p77slX5oYXTGLYIT
	 aoJqFnWxk/LwgVQ2Bagxq91D3zRNcW46akUtP2rldh05lP/lEhRngttmM/IoySJaoI8eV
	 Ill5hS9/F4RUZJrW3GF/niaepAcRFq3D0G4OwfhP15LzOwvrtg7x9ItTzpCTBlTVXZeRA
	 sCCnJ+dlrIsnbpNQz/YiBx1Lf+iQ18bB5gYSuV3xTMtHqWreKTRzBgJSkBC8R3z4T+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ZJFWHzliBTc3+ANTD4MSj5zAkBWI2RhH31jFlttP6lk=;
	b=omgTMJbdLfBhkETAQmfbfiDbvMhZ4ebYKIOA2YZr02p7NYoM4IsEYlu0E+Lvk1pMHMTe
	 Gd8bU3YZL/z2EAzC7zq6bGPkzma4LgbL2occvuWN4FnrebdiGo7jfNvxjFOBN4Da8fHAD
	 xM0JpX+pFYP53EPk0gPVviCIKSi8/xyOh9RgJS1vkGhpuYn5qApaNRE+MhA49km6jkck4
	 pe5rGstcjSp5snkSAAvQvSkOyKNaD5dLBej9K4l3NoXL/Fb6nsIGmAj+6wnik9iOvtKTn
	 RhpwhhuLK+ZIEQ2d9FEQd/dh5iVywj4oCiibhnZyXyBuxW82zJTXeSvJwzibaPAfQBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DN2UseK5;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BBB606A337
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 06:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28BBB606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DN2UseK5
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso280631f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792737621; x=1793342421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZJFWHzliBTc3+ANTD4MSj5zAkBWI2RhH31jFlttP6lk=;
        b=DN2UseK5Tk7tpK0k0ilAvJ5iPN1z1bIqKoeOYiSmWhwr8mI2ztOOKWIv6vg3YA5Kc/
         ZpD2z9k1omHwf27KRlVTolgVSfCJ3WIAYx3SmBWp66BvUXoog22YH6DsxvULX1+5mXzx
         TXbAO1qIW+DoMhi0O+rPs81IsXVgOMGTbDiulAY1hgmdH+NE9yCgqsex3kOgMJ43Ccds
         oNVnLwj91daLr4UcGCYKRI3esNiZDspUFFJgoGOibch4yQIevKCDAoygMs7xerCQiI4o
         zMsOf0vzZuINYvfijCfKlE4shlnhuQP3zJhJ5HAhIlR9i2sBJVXn72szUIQk/Vt9OO20
         +S/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737621; x=1793342421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZJFWHzliBTc3+ANTD4MSj5zAkBWI2RhH31jFlttP6lk=;
        b=MAm7RQUCgoLcWJh4XZ3Zac3iLnPUWbWhelTrhF/xBXH3B0DYFG2AkgmcqRe0gr1ONG
         3H4jKFgpuScbrdYMztNS1bu6HVQdKTmZPtBk4hH9xKY2PqRghfcsQCQHCRYLsKJ0ITCl
         z6yBIdOEHPpkLBXcKs5DMPNIeuVUzBY8S6BNZrtu2QiWwmjXqu4PzDaWUDy32QtOmT9K
         gjA51NL9TNA2L6rEAZJj6eweziNgmYld/VeNII6havi4kwdMep4HDEiEZbviC2ZrEKhY
         PO01O0U6Hbi8AGYeqiMhVMCD0mIxsTzXShLB+paUpeOvsz8MibnDVLpDtEs78m5ea/ZG
         oQbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzN1uaVVqhCKY80J58SK9TTnckNSFklx1GCrAhZmaQWOficYCsVm/FJxDkRd+9tA2dqnzRzUNaR17hip5EWYvg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLN/ALA2QAkTQ3XCuVmTJ1PsMrJhBCmGzAie3f6Im0xg5f+hacx
	tzRCCXU4qyWlTpy/0tQI/agRY/ZtIVL+OXUPdU/LOcEXYIpFAXjVQX8YQ4V+UFB8ILQ=
X-Gm-Gg: AYBFou3/q4kw4fRebhnSniRu6siQgVyszy4PNkck97jCDQ3vvHhAEKUQunu35ArKixz
	eP3eqFU0k1nEF7fKoot7k0VAqS57yaBZVw7jMhfktAlPbzk33/SAwTOzrN0fZM1ZofsaOfRYqUs
	bTxO6OtBl1EBqv8C81iPNoPMk941R3SGfsE2ufSoCRKZCV8zHV3Ci7Nz5n6hRzaicpYhtnQDGzp
	tWDeDkHi73q3myoBo4IifIXqddUcp//Isi4R3KXLnnxWuRFNP8Ymt5DzhArfy4RZeLGHBc1MfuF
	IWsOZejvgrOHCTFQiFx2/XSyDe6dKIXAHh6/FLrjlKjKOBFqB5h274x46IZOiJKT4TE9AL2kbvD
	wDfkzEGx4VWEnfmEhYPFlFqunGy6JhAEwMDllPS+ltQYQqvTAfmfaBub5RltRHQZSv6oPtyHZcd
	t3emtpAebXetV8cwa+qAoJPb1rX5C65Qx9GU13J+qQrdWEplpgiIKT8fS3WBvVRazoQXrN55TX0
	CLMjKL5FX7is20r3ar8MREUypb9LSCDJ+fY3zEe9TniKPOKbuqaTEd41o4AIpyWTANg+Xx5zvNr
	Eize4Te88QLnA8j61vcakcijMwiNPSea1QD9I/IqTOaV9VwDy2FxXtguQpvHWxQopP+aSVWC1ly
	pV/E=
X-Received: by 2002:a05:6000:310e:b0:48e:f14:61bd with SMTP id ffacd0b85a97d-48e38588967mr1965340f8f.14.1792737621324;
        Thu, 22 Oct 2026 23:40:21 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz. [46.135.49.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:40:20 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:39 +0200
Subject: [PATCH v3 14/16] arm64: dts: ti: k3-j722s: Add the AUX L2 SRAM and
 DRU regions
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-14-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2

The DRM accel Thames driver maps each core's auxiliary L2 SRAM and the
DRU's channel registers into the Contexts it creates, so the DSP nodes
carry these two regions besides the L2 SRAM, and the bus gains ranges
for them. The auxiliary L2 is 256 KiB of SRAM in a 512 KiB aperture; a
read past it faults, so the reg entry covers the SRAM only.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 16 ++++++++++++----
 arch/arm64/boot/dts/ti/k3-j722s.dtsi      |  4 ++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 5a5b9a1bfd9e..b6c951a1dd74 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -385,10 +385,16 @@ main_r5fss0_core0: r5f@78400000 {
 		};
 	};
 
+	/*
+	 * The auxiliary L2 is 256 KiB of SRAM in a 512 KiB aperture; a read
+	 * past it faults.
+	 */
 	c7x_0: dsp@7e000000 {
 		compatible = "ti,am62a-c7xv-dsp";
-		reg = <0x00 0x7e000000 0x00 0x00200000>;
-		reg-names = "l2sram";
+		reg = <0x00 0x7e000000 0x00 0x00200000>,
+		      <0x00 0x7f000000 0x00 0x00040000>,
+		      <0x00 0x7c460000 0x00 0x00020000>;
+		reg-names = "l2sram", "l2aux", "dru";
 		resets = <&k3_reset 208 1>;
 		firmware-name = "j722s-c71_0-fw";
 		ti,sci = <&dmsc>;
@@ -399,8 +405,10 @@ c7x_0: dsp@7e000000 {
 
 	c7x_1: dsp@7e200000 {
 		compatible = "ti,am62a-c7xv-dsp";
-		reg = <0x00 0x7e200000 0x00 0x00200000>;
-		reg-names = "l2sram";
+		reg = <0x00 0x7e200000 0x00 0x00200000>,
+		      <0x00 0x7f800000 0x00 0x00040000>,
+		      <0x00 0x7d460000 0x00 0x00020000>;
+		reg-names = "l2sram", "l2aux", "dru";
 		resets = <&k3_reset 268 1>;
 		firmware-name = "j722s-c71_1-fw";
 		ti,sci = <&dmsc>;
diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index ca10c6904b69..6c0d2ee94290 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -185,6 +185,10 @@ cbass_main: bus@f0000 {
 			 <0x00 0x78500000 0x00 0x78500000 0x00 0x00008000>, /* MAIN R5FSS0 BTCM */
 			 <0x00 0x7e000000 0x00 0x7e000000 0x00 0x00200000>, /* C7X_0 L2SRAM */
 			 <0x00 0x7e200000 0x00 0x7e200000 0x00 0x00200000>, /* C7X_1 L2SRAM */
+			 <0x00 0x7f000000 0x00 0x7f000000 0x00 0x00080000>, /* C7X_0 L2 aux */
+			 <0x00 0x7f800000 0x00 0x7f800000 0x00 0x00080000>, /* C7X_1 L2 aux */
+			 <0x00 0x7c460000 0x00 0x7c460000 0x00 0x00020000>, /* C7X_0 DRU */
+			 <0x00 0x7d460000 0x00 0x7d460000 0x00 0x00020000>, /* C7X_1 DRU */
 			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
 			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
 			 <0x06 0x00000000 0x06 0x00000000 0x01 0x00000000>, /* PCIe0 DAT1 */

-- 
2.54.0

