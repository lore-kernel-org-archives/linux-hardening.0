Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6343400998
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218976; cv=none; b=iI2qykX02+A/jaqetYXVhrpF2OedbG4FoWXummxCb/Y1aYpd8yEThRBrLzmBbQ2XyT6GdSzDCXiRXO/PneLITrH7/wH3avdluTam59xzUZ7rP7ro/NRgNjvw4KjGLOMmmz66MfRl3HADfr6ppK0dp5O1u6+9nNFFoDZsaB6pMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218976; c=relaxed/simple;
	bh=GtU3BwmWr5r04fdNMr2P/dLekVQQQO6qKHal+CTJ5SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qly8oKZiKBTbqhSujBIEJGVf5dJ+p1BolTi1AqwDMKM2Aca4SEp83si3Uqo9yNQgmaSZ5AT4bOzkHdl2qdPVneERhf1OrVxdbU8pHqkOYZTh40C599I1/urlvSrEokP7yJaseK/jscjly8XvXT3u7Hb22zOu6y3NeXqmKVEaPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM5d9LGB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM5d9LGB"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-481412f1828so793794f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 02:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787218962; x=1787823762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fqnhzBAbwr00r53ZE/i4Zlj1u/RNPOU76CLxr9WNMu0=;
        b=CM5d9LGBNnoOLGIelkhbE8DCaEqrbzoXekzeZNmuovnTSzU5eKGG7fU1QrnLyQx8RF
         6awIQQ6L0ly1N7czyIKur5Q/L9Y167uNPqaUVaNHWHtf8as/t47eYRo+cgr6y45jzBn7
         PUCocDwP6bUX92vluTph7926eCdXTSeh/qApGimNuf51TnuVqJ3I07QJYQKActhQfO4T
         1+oT9B26cPpgD42k/CDymak8f2SebW8rKapUtvJOrbP08i8e/B0MvXCHdR+tSkgDiPYA
         cKMxjDJeGlEYdx/xfu93JharKI1I6lMz34qmO3JtpeJTNaxssz+yBTT0T2Sr9pQAYPI7
         Jnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218962; x=1787823762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqnhzBAbwr00r53ZE/i4Zlj1u/RNPOU76CLxr9WNMu0=;
        b=UId+kuccD3JmJJSDe8XySBx6dPVxfJn9FgqVwzmatw9WEiIivDgC4z1lXdGH8P1k9B
         EwLB5stcD85x84yet7VFBNvjf/dKA/jFDKJnDRm5lgBXGUKPPAmldsgksv4cVbDKI+Rx
         XAkGBRJn2rjXZRWJ4nUcLI5Fpw6m99LP3S4tYjUB+M9m+rN2lbnqfxDT7D6hCbH5YCLK
         sd5VzhVUzYogyBRIwqaXsjejfPdLdbzRaFbRNmvTs4+h4zN3YlagmAjceCHieEY3ItU7
         z4CfrgJEN/SmxL93eyNquI+Ix+e1C+F/p+wtgAAHA5Z5YjcT8jYkh92+pkbRolWPRXL4
         JBVA==
X-Forwarded-Encrypted: i=1; AHgh+Rr19iJxMTseLUsNd5YkR50D7mz8PgqMQ+HczZYOSJolGGuOm/F1JDJ1hAGsd9M5nT44D5AqJpaaRgU1BNKvi2o=@vger.kernel.org
X-Gm-Message-State: AFuF++nWYMJDWlmHUs+gTnGBHTN5tdVlyyXd4t9YUzcvOxJ3qGdyAchF
	iLUlqRwmh/3fl5ISnWs/QwcGWOAe077ebYO8lpCRpN/YeInJw3jZJ8+Y
X-Gm-Gg: AR+sD12c0fslvR/gupK7Oi13Lbvw6u9HPtTsGOPvYzgfb7D11Zzoo6OGbeRKM6RXhdv
	q1GSWw9DfXYtPY/xUSbhVf8H4bIZdPRct0lwWLD1thQGvHM0AHH+OEdOoDxA2EoQd7fld4YRg4a
	H+0JDMDdraQweYalqCrXpFR9k4ywb2FSRe4KVue8M3vxMBus0FSkDFLUPLKW6uDmQ3cFqfz61qF
	3blKvxNX0O+z2FK2Bf310NvbOGZzJvHr0hmDlu5Zf4pYKaMKMtN/89cFuZ1jjlmci7PsW8oAexQ
	kwiUYEbK2Y3jmxqUDpMhHTPsLfwh3+l+4Qx2xfTOlPRssraWHQFEAJGxDqcI1MI2GYSCRirkIZf
	bg9nUpeS7dTcHmZj1Z9JROgVMpm0Ag7mVyCLi0HBgqkNFo9ESw4yLCrBiU50MEg7lzI+HVA16gE
	pK/LIMgZT0vnhTSnl2g9Wx7O5r06xfU9pDLOVYWdsRLrIz6z9iiCQGhmVLpXZk+ghzx+hxo21J3
	E2D8GA70yRzixSC2u+o/dEwqQtRDyih43s=
X-Received: by 2002:a05:6000:4610:b0:481:5276:e4e3 with SMTP id ffacd0b85a97d-482b1fe2fc1mr21405564f8f.19.1787218962119;
        Thu, 20 Aug 2026 02:42:42 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b144173csm11788090f8f.6.2026.08.20.02.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:42:41 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Thu, 20 Aug 2026 11:42:25 +0200
Subject: [PATCH v2 2/7] dt-bindings: arm: qcom: Document Motorola Moto One
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-next-patches-v2-2-7130d68183d9@gmail.com>
References: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
In-Reply-To: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
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

Add compatible for Motorola Moto One(deen) based on Snapdragon 625 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ff8a35df7862..289a3de1d24b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -292,6 +292,7 @@ properties:
       - items:
           - enum:
               - flipkart,rimob
+              - motorola,deen
               - motorola,potter
               - xiaomi,daisy
               - xiaomi,mido

-- 
2.55.0

