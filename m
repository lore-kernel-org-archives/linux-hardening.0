Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9E48AE39
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312215; cv=none; b=cVFFXEYMmOv+0X+/+kwYJdlha41jGTqLvnmL5SXFGDQzm4RfUlKobir63ZgXSoAqiz5zOXi7j6Pb9nR/wf6mcRtXTFh7MDy27cwPS9G7y7wn5nc5YyHu6ywXwewfAYwJPz1LRnV20+EFzN3d5QgGc43qyOKoNvlzdgY5z3Rygkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312215; c=relaxed/simple;
	bh=aRikrKedr8rRD84dJqfsSjKHfSLi0ROhZlN789CUbJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJU8SWyDfno1zL4/46PIhzW0DcsvG7n8hxu13MuMgBcoQo3IcEbBHOps0qCoVJyl1+hmVEfJ7lH/c7oPsPE62RzLvjSJlfZw1SNJRJJx1RbbgbU/2H6Y0tdEc1K1d7rr2nYbp7P1NW6oyECelXrs968zxxKzjssxte2eWCX84Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrFkNb2y; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrFkNb2y"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so1602273a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787312211; x=1787917011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/a/K4l60N8ZYR9C9kOGDnGGvsCsbHCt+W0MVudFPQc=;
        b=MrFkNb2yrnREKPLoofaLYbdPF3eSLc6z0drf4TGInqntuKYSeVTppHpl+PLKfTAfMJ
         UDJ4L0/uTAq5htHaZyEAU3imO6M3X/b+1FED34nrJzP9a85pgU9r/tkC09X4RWXn2YMS
         4FuRUaUyY7q/dtI8djMUWgKo8bIxQ0o4LaHg1NCP0dv0wGecSUEbSblMXFl/GrqYcJpd
         W/1RKsOcxIfaqrBJodZsNaY6gti16TGCy/pTW3jLWFaQ1dkp2cuVyrycLaKCnFuk1OB0
         Yw45xuoTTujBAXVwMrC7mcaHbS/oQKHErwvy4dAaMDf13gB46kHf5BuW6gSdzI2KtLqm
         INug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312211; x=1787917011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/a/K4l60N8ZYR9C9kOGDnGGvsCsbHCt+W0MVudFPQc=;
        b=dmLcXssRD/2Tmdk+QtInj6uXDR/yaSPXsH7WQ48BqzYL5Mrf8MKis1l0tS3x7aeUwk
         fTwd9XzqxZ2Zdcmxpg6wsOJYXl/A1HudJGQnTe5q0DUOhh25Qb0XteabgLnEhE0+2UHP
         OjLi/7jwl1I9qC8RmNWzuPisHm6dunymZwflsMEspu1nfUTUFNAeIrXbm3KmvD1W1Dso
         Z42VyAC36VKZ6gfxfZRg2mWVIvxjWWhB64G6NunuAvKDINK5ji3k5m1gRoR0Z3fxD2AQ
         RGP2rmmIIFbji84aBOflMaexHGnyq3gSA9sojAXP3IbukvsxmCJT5/xWA2col9m5tw+Z
         a3iw==
X-Forwarded-Encrypted: i=1; AHgh+RpUyEM4Ii0COiDN934nXX7QsM4kWB4Rslc6/FIxStU0grsXLcLlyesU1bqx8ZzkkuXYah304LVPztSkWXdbIgk=@vger.kernel.org
X-Gm-Message-State: AFuF++l5R9tAIi48TXjARXMrnDvpbu9CURpwsRi4006u7JtRroKAYZS0
	L0nYMfon/YJh1VIKrjmaUFVNMOVk9Mmj5YowmV0FR57dIxM7qc2nRkUO
X-Gm-Gg: AR+sD10CdCxP+IZ9P1Vgwa0zRkEyFoFSlJaM3nbEHkm9Dcys0qPZd3QScCdIWxPT/3F
	L1rGx4nQt7sLaTNTz0uHdccALaFZE9aNxLLd2YFsDulk6qb8zvhBvZzeYMfaqJlnEAfZs2CjLGE
	yB/QwQEoKqKtHIQPrjk8UN9Gv0v5ATnHSQT4qNshPdXP3Y33L5R/KEjjB5ik+9QjuU0Gq9iow/D
	4XQ9O0YRmOGVhmygJSP14zFr0e8YSM8+XU9ngEwizxjENAzKlhzv+AESF5Rk9eaIWk8qKW4gU3H
	8fd5xgyLv/BJGjeVX92mPlEEQO5A8AaER/DJNybW51kWOrxHwPBkeMwPdIWw+JT/8pWO5aA7u3P
	+La1vnddlvnqeSo3D52mAEIZoo4LzudLE5HnPAHP5IXtNlrPHRq9v+iL3IoBLSE6s4B+YgvDryS
	Z0NA5ME1bOT8Cd+C7CcERjgfX+n0Yt6vRJdMOfzCxlcMGYB87YsphS3/UPR4hYn7mbe98SAbnmJ
	wHH1v21yJGYsZBuYkzSo7SP
X-Received: by 2002:a05:6402:270c:b0:6a3:ee5c:8800 with SMTP id 4fb4d7f45d1cf-6a42f1ac2edmr5170860a12.8.1787312211244;
        Fri, 21 Aug 2026 04:36:51 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c3491sm6204661a12.10.2026.08.21.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:36:50 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 13:36:33 +0200
Subject: [PATCH v3 6/7] dt-bindings: arm: qcom: Document Xiaomi Redmi 9T
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v3-6-cd64bcef6e21@gmail.com>
References: <20260821-next-patches-v3-0-cd64bcef6e21@gmail.com>
In-Reply-To: <20260821-next-patches-v3-0-cd64bcef6e21@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Adam Skladowski <a39.skl@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

Add compatible for Xiaomi Redmi 9T NFC codename lemon which is one
of variants of Xiaomi Citrus lineup based on Snapdragon 662 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 68542f76df30..5363efadd4ee 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1035,6 +1035,7 @@ properties:
       - items:
           - enum:
               - fxtec,pro1x
+              - xiaomi,lemon
           - const: qcom,sm6115
 
       - items:

-- 
2.55.0

