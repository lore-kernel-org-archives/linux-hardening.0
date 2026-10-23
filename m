Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737626;
	b=WiOnnHMy4f9flcDr6IC8w7sVwmzc07gSs/4m/67q7SJGtyQ2CDYLHnRidcJDG9rZVYRb
	 1KNaHALmwKSPE/CdjnKvt8o0SPyqoRsWSLOB8otItpx7lELw0vgw/G8cqseXpdgh5fwrL
	 EXRaqXnZ9N2JCReEWFp9iGc1BHEJxN7YzvAul3vsT1EN3YGsm8ZMCPXb9oybo7FLPYn3v
	 0L0NQW0N3UmKM6iegBac7v4owfCfigBmW/OeLQOkscW9Ek18uviZ4Pb2fNl25ZN+yfKwS
	 yRx8NNoiKJLmXoRiK5AxzTCTYe28torBQSsVDirz5555TDQZd81hbEz2ZrLDdtOmWJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=4UoeFHsO2E1Dm3EPGxkpKrzw1COi+rNj0JGJlw6wJw8=;
	b=1ympwu2/46MdO/2qp8semyfOYL2c2jQ95C1w7ks4S1/D4Wwkn24ORTE9TYScH3Sn4uls
	 a14zVCyfpKiRi7143JKVToJbctVU4IxwUz89jJAMQSm7S3jUxZpauBeb3nU8QuV0sIFH9
	 vhxLSjjnyqgxRaRDu7xLtH7+eu/GfRvRnmLY8+F0PiVAJWzGp54Q3b31SBpwfFG0m4J/Z
	 xzqT1roi+NYN2Kv+EhQCLT9tOXG02ZmY218pej5yqAKfUrDvI2J8ZJYR2Nail3WQdK8Mp
	 YcsgiG29HqyEmnSj3PGcrmS6bRw3jEA2evaqG25Pn1yRgln6P+YcjNpLf4xxJL25sJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nFvP+We7;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2660A3806
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 06:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0F2660A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nFvP+We7
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df54150dfso228341f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792737624; x=1793342424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4UoeFHsO2E1Dm3EPGxkpKrzw1COi+rNj0JGJlw6wJw8=;
        b=nFvP+We7XiupT2noLK/fzdphPCutvS5h9ja53Rm7jDjlMjuga21PPGPfl3QjU/ECb7
         vJXjzgQQeHxBnTcpUCcDz9Mkzk1J149NiWxkGB4xjLLXKDnJufFFaCU+5G3nko0GgXB0
         p4oO49kFqiWVFd2j4tcut2GOmsdVA4DYdJYWI0HSTZX2HY1wTTai3F7dSrdaqCV3ZQ7R
         sxqKvZlsc7pcylJJ4PVh82aybrbqrD4CanpDTI8g79zfZb0x4tUAx9b9dY8phosjMRNf
         zP7C1OdO/tgqr/6IKB5+tnOqKqj13NexQpJdHS14JPGE4cAzw6Y1th+arl9wwks5uVeg
         Gc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737624; x=1793342424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UoeFHsO2E1Dm3EPGxkpKrzw1COi+rNj0JGJlw6wJw8=;
        b=LQ7wsU1u6J0MUVRX2h4if1kJfARDUCihHMgVeqdlYZhvI3nNa7E20z/O1y/zVOOJA4
         KNsndG79X6oKzqqu+e9zZDf9pyfQ6Yh6Wo4NspozXJRhTc7oEA3JchwLr8ejoopniaBx
         dEIt2egK/Q7fshvMUhDTnpgvO27bKjWPy28L+n56MF3+M5nreWSGRE010StS7STC6XQe
         MqOJxJaPQTd2x3JWDfwuaVP6Aja101/9VA0yNEzhCJLdy4R24u6sqUUNmpFN9/czJpSH
         oPC3ozNgneaA34VoyEcN6YvWs7GO6LAd6qiYLo2+DhxWh4nErGDLoO0Hsls/B/IHiKJZ
         u+FA==
X-Forwarded-Encrypted: i=1; AKwUvBxeFl/KOvensvmDFMigxQQPv1SMHlOQl7lIQwv9GtnBWezERWB9y9Ty69Quf8gDm9vs/6CawQdnHQDT1+My9es=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/IXmD3mOne4UV7Rvdtg2We8ZJmNiZwXummzrHu24gHz8bo0I0
	dHI4TQXLMRhV+AoyOMpQLrMUpAt+OCJ2h8j9qV4YDID5kbgzkwE25S/9gMDkHvqtEfQ=
X-Gm-Gg: AYBFou3fPFNrBZ/t0XRkcowz/IsZqggMPz5VEfGJMt9pZ6FhwFBEQco0+tlwMp2SWC6
	fK3bgddAPTW1iMGOGoDCxeX/qOdgAMXNdVhOqzruvwbylxoYsGkYFr8w7zdDs7nJwIWJjQAmGOD
	kKMIGevfw+iioqF1WHOnrDzw9DHAIh1cxyc3whROsvfMUrLtf9c2mccWvzTPRbp2KGkphy0i5w6
	XIvSRpABNuwaVCaX32NUizf5Za7uXLRvUJ0U0q3UJUR+bKWGmvpYl24c+DtgzCYeTqKOn5RnOFy
	NxIXGgomt7ozBjtZfKr5sbe5dflMqRFpqrn2RVRk9vFIHdydvjvpoK3GDOk/xMI7yLtO8xB95RH
	3J9jbEDhFZr4rEM2Z1z5BQMABk+Xad70yck7Y/lIdz9KxCJwlTlVIruoq4w2+LoWqpbiAlRBjI3
	jh7DpS9Rmnfnm1AJlAU5KV5F1Bn6K3gR6uggpDJrFR+/HsdoP8mkSz7iJgiACqd5u8lZhiiEmM7
	s3PwPVkvD5obTV/XDDIbsiByvVdffS6F6IU9PzcaKGrkGqkn9RPRC732mn2E0a/jc8Z9WLl2xRy
	gmQblPDeau9e7dW5/KA9NWksfRSlYXQnwjgC5vQJmHdGGgVBpT1gQ/3XCcZWbTVj+Q5h76Zilan
	btXPstxolGju+QckQov58xzS2
X-Received: by 2002:a05:6000:4910:b0:48e:1c2:55a1 with SMTP id ffacd0b85a97d-48e385c0867mr1563144f8f.52.1792737623908;
        Thu, 22 Oct 2026 23:40:23 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz. [46.135.49.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:40:23 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:40 +0200
Subject: [PATCH v3 15/16] arm64: dts: ti: k3-j722s: Add second submailbox
 to the C7x cores
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
Message-Id: <20261023-thames-v3-15-3ab40aa17157@tomeuvizoso.net>
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

For firmware that uses something other than RPMsg for communication with
the Linux kernel.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
index a59c3648d805..611220ff2655 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
@@ -86,6 +86,11 @@ mbox_c7x_0: mbox-c7x-0 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
 	};
+
+	mbox_c7x_0_client: mbox-c7x-0-client {
+		ti,mbox-rx = <3 0 0>;
+		ti,mbox-tx = <2 0 0>;
+	};
 };
 
 &mailbox0_cluster3 {
@@ -100,6 +105,11 @@ mbox_c7x_1: mbox-c7x-1 {
 		ti,mbox-rx = <2 0 0>;
 		ti,mbox-tx = <3 0 0>;
 	};
+
+	mbox_c7x_1_client: mbox-c7x-1-client {
+		ti,mbox-rx = <5 0 0>;
+		ti,mbox-tx = <4 0 0>;
+	};
 };
 
 /* Timers are used by Remoteproc firmware */
@@ -152,14 +162,16 @@ &main_r5fss0_core0 {
 };
 
 &c7x_0 {
-	mboxes = <&mailbox0_cluster2 &mbox_c7x_0>;
+	mboxes = <&mailbox0_cluster2 &mbox_c7x_0>,
+		 <&mailbox0_cluster2 &mbox_c7x_0_client>;
 	memory-region = <&c7x_0_dma_memory_region>,
 			<&c7x_0_memory_region>;
 	status = "okay";
 };
 
 &c7x_1 {
-	mboxes = <&mailbox0_cluster3 &mbox_c7x_1>;
+	mboxes = <&mailbox0_cluster3 &mbox_c7x_1>,
+		 <&mailbox0_cluster3 &mbox_c7x_1_client>;
 	memory-region = <&c7x_1_dma_memory_region>,
 			<&c7x_1_memory_region>;
 	status = "okay";

-- 
2.54.0

