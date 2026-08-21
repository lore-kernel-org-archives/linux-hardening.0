Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C758391E72
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314757; cv=none; b=Ffg5PBFV+AaXisp5SXFYyXd4XNwlff6crwQWQpNU9a5ikGNckETclgfztrPcyNUsIu1cpMRSDGhtHHV15ePBkE7R0V3xwQcnRWWwIB2CsTSha2C3mEWyWOhUPoZwepF+JEF7aP6xgkGF91U2kwfr6RtBOxcBYBHeVUnngV2ki5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314757; c=relaxed/simple;
	bh=240qChyaHcgAIrUoo9v0o8NSZCJsliQZCuzI/589blE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxC3EeZXhjY/V/dh78KPR0eBhHPFsfJ2NjCmM494KEx5S2o2RV8/+MHxURtqPEgLR8wZsJG8aXDdMshv89+rckSL6QWcsDVdHcPO8hIcY9b6a71ps9PyCKfF6GXoXd7QGyGpPnRyttpgSzHwgjxKICtxxXH7ewCRyl+RS6WiA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i51hH9GB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i51hH9GB"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c214e625259so130481166b.2
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787314750; x=1787919550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=neXALKgIPT0rUNWxa1mqzXGbgJQcvVkrR3q/lkeSSa8=;
        b=i51hH9GBG06UAbjcFvvZoKxpUF1WLaz0xGL9Xsyb00KffgvLfmJ5ZvT6YO+gXLCcM+
         FZmxAtHq9MTZo+QEje49vThdm01JPhjsFzqiuu1+57EnToI7WX27sYFX6vt21JmN1OEK
         Qc0js+WBkskdM3YXyh04Km7ZkIfgEFVThcNINyX9/RyAaMXBgOBy81X9LhpWTGvYFM4n
         iP2iNtAjGYE95bUDMkiaNHyQ/rr5qktaT9uL9WJo5toYUc6Q5iGSH/fo11Q1SBdPc2HP
         lPz/CmJR4VVUV3D3TZSVARZcD/X6YMRFEYRlsQwqDMpDl6d7OiCb6jO9dZosAfwj0Y4p
         mi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787314750; x=1787919550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=neXALKgIPT0rUNWxa1mqzXGbgJQcvVkrR3q/lkeSSa8=;
        b=q6Wr4/95rBHBob+KXEytUbwDpG5Olrsce5i/g5ljLNebAGsrUNtLEpQJZ4evNP7vtt
         ukOJ6xCLklC+VcgQ9LQqJHgYKr14v9lU/eik9Io0Eq9iQF/V3UgAG38VRFml72UBKnJt
         mgVj4KhZOIG/7eVwfEo2ki/WDCdIWE2b0lDCIVVm5LpBcXpA5nS4bvXarPIWhCdJThfb
         2jYnHlTz245X5QS5sUdadix6peKTKKIF/QRUiYic7KMbmx9StwENSMmAtvZ18uRZhr83
         9Phxuelur+ltBKq84UDvdC0lD0JhboJmWg7fPAsX4GYfJ6DyL5b9uKb7Uo3Y23BaRNTZ
         LYcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9A+e0Y0ljx8BbALGqPEce3GNidFW8r4HaGw4vOmh44lLMd9YN7FQoYzuIMGRmRJg4OhzBD7hbIgsRGeTbZPQ=@vger.kernel.org
X-Gm-Message-State: AFuF++moD5JAhnZLhakgtrVgDx0beoYZ8fdiZ9PBjOyL2SuBBKUdn7H0
	KbjYmeuSxq76OpkzgJDnIZYf5NAJe8f4ICQ35qSfgYO0JL+Rn7E09jI5
X-Gm-Gg: AR+sD115FLHHsjl31+ZYlIJKulmplGyqwV81i0Ufw4HMqRkaS00/faazqjYnJq37mWt
	uDHoo5jXKUDk8tp9OHfpq7omvepiQ/WM1m6z6TsbPWmyqjbVvtWhRk2mOMWI7aMaMHV/KQUcU2w
	I2O2+TSjPFR+XXBTY2jmMe61NsiFATsKvqD2tqQvZrGPt/SgRU1UFwrD3rDEMhMdQKDbX6Sd5eS
	wysDXb6nJEliGsgBv9rkG2xgNLPqrZAaOXQ3LAR86cxXiXstKU8kfJ/pCij/UUF+kaOvNqxDT/T
	9Hkn5/DV1vrgEiTVDTGAGlfDpA65pWEpUOP/k5mN59a30INyCfSxp8wIWiqIEDI5+cf+DepDOKP
	QwHuI477Iz0j9Ots6FnEh5RqMwSYdnJy2LwiCifEvEc/clLgfKbirLdGRi1BhaM5f7Va1q3te2a
	j67CSnyOes2LifE5jdY+v9IfZ/mKG2Bn5+kcxSBWGZf/1rvb8DBUO4TbRp6VyXdzILKoDqCzThW
	d2t6/XRREb4cNR/iMX5r6kWCOPiNzS8YbTtRA==
X-Received: by 2002:a17:907:948b:b0:c16:6a42:c7d6 with SMTP id a640c23a62f3a-c246a346d3amr601838866b.9.1787314749730;
        Fri, 21 Aug 2026 05:19:09 -0700 (PDT)
Received: from [127.0.1.1] (83.24.178.112.ipv4.supernova.orange.pl. [83.24.178.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589d9df9sm447823866b.1.2026.08.21.05.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:19:09 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 14:19:03 +0200
Subject: [PATCH v4 4/7] dt-bindings: arm: qcom: Document LeEco Le2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v4-4-7ab02c0d4eb9@gmail.com>
References: <20260821-next-patches-v4-0-7ab02c0d4eb9@gmail.com>
In-Reply-To: <20260821-next-patches-v4-0-7ab02c0d4eb9@gmail.com>
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

Add compatible for LeEco Le2 codename s2 based on Snapdragon 652 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 289a3de1d24b..68542f76df30 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -348,6 +348,7 @@ properties:
 
       - items:
           - enum:
+              - leeco,s2
               - longcheer,l9360
           - const: qcom,msm8976
 

-- 
2.55.0

