Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737628;
	b=M538KizOoFLtbAKVIdR6Ej4Rs0W15KoWedja1j+CR2diMQUChA5B+LHMUMez5B962vPH
	 jbzq9GgGv0uhx8MovvIHim0+fbQmmXpd3bfei/uT82QXi3HAQJx/lVaMTLPuSbPqqN6FY
	 WTcwTbqred9/0n5C9ro0jk3n6c59OTaPRAt+sgf8XrqD3JAGZ1l24AtQmPfhZFctvl/rb
	 FnPBn8Ou/69uUj6oTeDjFNx6bms5+KLouteWCAq9ZRIon2eYuzoPctgwBL/vJII9C+Spq
	 TNematVj4FOiIg4DBJKuxhgMYBYHlfiwG/7ede4Nzvc+ARU3Ypoa3rPw+Syp8vhEazQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=qBC94N5Vlr3FlLO5bq8d1hj8zBP4JCR0k1VspHMjzxs=;
	b=KuvmM9pfdG1NdcNPdyN/RYQimSTSQEwVEciiYNB40GTvLDL+GmGmHlyHG8oprSd29hAU
	 g0/zh/WwpVNpONR4xxS1qqTv6/yHyucp7fml5GRc/iK96SLgp18KYi+KIoCWV7+pYEB0M
	 1Gj4jlcJO8uITyklyDC89E7xIDL7WOZ79eXq1Tou1A93Y8rjz+tsjb02Itr1WlwJc1M7w
	 dQUFieF+KmOBRIgK+IAFi8gfMJBQTgLH5/HxpHVbxJDHEcFLeytdNVv+U7vGEUWDnr2n0
	 lfjkUUrWD1WAoib/aQ9PDYaM7yMGwqjj30NoSnho4HY3Dpz2t+oGturdeGTG2BG702Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D8JttAdU;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC160A3836
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 06:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24DC160A3836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D8JttAdU
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4be28b82so396231f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 23:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792737626; x=1793342426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qBC94N5Vlr3FlLO5bq8d1hj8zBP4JCR0k1VspHMjzxs=;
        b=D8JttAdUXWMA+C1tKErktnwsZZCy3HIUbjnaGh5X7r4L44Zk6RhL8BtNIhqkRk/36D
         IhFbmfHjF5EfcEOihgCUgXSY2+8D8PaXFo+uQ02UUPUUAw2gwAFF19tS0ABrtWDgGPoI
         HeV1vZ9M/nK1FKD6a9Az0iXO04LSuORvWofVstmgcVohmcwvPiihakPXSW2lCaaAmIrM
         44okde0ifL/bu5PZilTkScI6CcMm/uxQrgXHl4ejdowMVXSXesaaRI4KV1JkxQwpFHSe
         lbUVCuoQoCWi6cHLQQoVeoYI7ZAz+2azP2ToWhFHPNSGGzAZ6OxQW0g+zx6nEOJIwLvb
         eWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737626; x=1793342426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBC94N5Vlr3FlLO5bq8d1hj8zBP4JCR0k1VspHMjzxs=;
        b=ie1YtdUbSC0/PwYRdv7cvqy1WmFfkd/NO/jO4h59To2+AiCRRF37Hd7XcDqWE//MBJ
         hyzR7CLIJzZLjoUJQ2x3TWd9F+2TiKQQpClN1qfmiIsadv2y9/TvJq1tYRe42/eJaY/z
         rgLG8JCwZyA07RPdGGBUSXnpPCMN+LppT2RY4ANjLkqt1A31m8G1xRPf3WkbKHAAU5+m
         tZKgGwc2S6UozodI50Vw2L6WXuFxD4WchWCcp0bnpCLo+vofjaVHqBljFxAHyXjer7KR
         4TwGP4IVH0yQcCKwTuMxBiu6YuECLEIZLk8CbGDGQN9/pFCD6YbjEfpAJviyodVmyuP3
         /ykQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHu7/HeJRmFdGcZOFbd7vNlGr0aoPYaDSSkw8ICnHkr0BCCE7HXCRj9vGgTgH6c5yfFAAXKqRWXmqt7G9o1yY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6GPOj0Y0oBW18GyxwU+5EK2sRRonablgvBIVW0GtrDlavok1o
	E6iD+w6QvwUfspoyP+KbZ7pNg61+WqF1/I3/y/sIeCw331JucyPUxlu98NBmFijggoE=
X-Gm-Gg: AYBFou3dZXbB+tDx9guhq31Cm72Jt+bT4D6UlavNnpIhA5HA7DzO7KbKsZr2UgZHFre
	MWqdn31u0ZdBt9AkxUxcyFgwLse085g1II3WPD3x4+X68QPMAX+sKKF5J0tOxb1PKVzIQp/t1h9
	Kkc876U5/o2rTTiR920rZtUTipVPBL2ZsQS0LNQpibNI+kEX/oxmhSScxSv5hO4Mnhu71Pkbl0v
	BKiwQzJ97m6WjhheH4sZRzWwKVQgyYACiLwYck/URN/3vlbeBy27lFgC+GWcIiOmomvf0Pq11Ds
	KQPZFKdyOp9RbzXPLfgQ8emMjtYp//FYFo0CFuPh1VJrjLofZWCdpvwtm7mwuXTbZ81mPghU6el
	IGrCSidZweDNqPLzePUceyPlicV4qgHXhG1ahcw9bfbS6JgTueqbVh0c8Uuq7enlVzHwczefV3n
	bNIGwGhvrZGsEvg/UWX08AjwU/1iGBCSsTV7Llbsb3WqIEECzZkIlhrl8pni2iQNxfrk4gNMN/m
	+z2qbaJpudTTOtOs9VtvD/aFFY0g6j/D/iJ9k1o95YDkCK2TvlGlqUmNKhMgTGVwdKcEE6jJ8cq
	bUvia5HvepRhgI8llNrfQyd/ypR1XFkuGvFKrJvEtS1ssxbnqYNrs42xPvRsGumYv0z4nhxqqfh
	kwqA=
X-Received: by 2002:a05:600c:3486:b0:4a1:722a:d2a3 with SMTP id 5b1f17b1804b1-4a211eec13amr18677595e9.23.1792737626234;
        Thu, 22 Oct 2026 23:40:26 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz. [46.135.49.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:40:25 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:41 +0200
Subject: [PATCH v3 16/16] arm64: dts: ti: k3-j722s: Reference the power
 domains of the C7x timers
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
Message-Id: <20261023-thames-v3-16-3ab40aa17157@tomeuvizoso.net>
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

Make sure that the timers are powered up so the firmware can use them.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
index 611220ff2655..7639081dc913 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
@@ -166,6 +166,14 @@ &c7x_0 {
 		 <&mailbox0_cluster2 &mbox_c7x_0_client>;
 	memory-region = <&c7x_0_dma_memory_region>,
 			<&c7x_0_memory_region>;
+	/*
+	 * Both timers on each core: core 0's firmware drives TIMER1 and core
+	 * 1's TIMER2; two entries also keep the platform bus from attaching the
+	 * domain to the K3 driver's device.
+	 */
+	power-domains = <&k3_pds 37 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 38 TI_SCI_PD_EXCLUSIVE>;
+	power-domain-names = "timer1", "timer2";
 	status = "okay";
 };
 
@@ -174,5 +182,8 @@ &c7x_1 {
 		 <&mailbox0_cluster3 &mbox_c7x_1_client>;
 	memory-region = <&c7x_1_dma_memory_region>,
 			<&c7x_1_memory_region>;
+	power-domains = <&k3_pds 37 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 38 TI_SCI_PD_EXCLUSIVE>;
+	power-domain-names = "timer1", "timer2";
 	status = "okay";
 };

-- 
2.54.0

