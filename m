Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939482DCF74
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314760; cv=none; b=apvpmZM/MSA7lQjb3mcGqsgmCiEadtRJVNVZ0w3lfF/Bc5lvdualdV/DybY65pYAlqDHWGtdihRQYmz8p8xGD1r93QUNagGUaxdf9nnU+YU0f3aWiqxdB62sQYRi/xwzPRzHODDxIACzusvxVRsZ65sTibPH2Gkt7g+5D5JeFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314760; c=relaxed/simple;
	bh=aRikrKedr8rRD84dJqfsSjKHfSLi0ROhZlN789CUbJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryEOwedqchfzxHoV3cF5ii2CB6fFi4eX3IDFwQkUrCcdZIBWpc02Mcwc/M5ADP2ub7mPNnR6Ts5JvkFKt4/twp55VDxy1op4kE8UPL1I7aM44PGf+Yf9z/Q4qYaB5JXD0h0x+oAKX80g3T2K0SV2yQf0mCA91+ICJIFidTRqtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzsFfPsS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzsFfPsS"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a36982a875so1598422a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787314752; x=1787919552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/a/K4l60N8ZYR9C9kOGDnGGvsCsbHCt+W0MVudFPQc=;
        b=LzsFfPsSDbh9w2TUgMQkuyXX8Qp5waeEoHCYLzSeyQYzycvE9cFrkuq1xwFub7iMRT
         Nkl34CsP9HgorxIsHBxUYVN56dN7jCmrrQ1n7+xS3Sfy4gP/HdUeV3MEElZw1p1uhzZx
         j0TlzIpXE9TiOsUhAesneh5p/ammSDCyu7qdYOyufZA0Syk2DWEQKhl28g4010DuuYte
         Hj9nlEnjTlPoK3Y9kf2/Obv9VBDD9YOlMwWKu8kDfJhrCZYUZqzDIrpHYobhGC4WMxgf
         InwrgiS7ZtHMxDcof0cUdy3wJOeN0DwL+eHuNcXC6PuEAOvDHY6bkZEnazR6VnS1yKmY
         Zu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787314752; x=1787919552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/a/K4l60N8ZYR9C9kOGDnGGvsCsbHCt+W0MVudFPQc=;
        b=Ef6oedkXKUonmUQ0ov+HJcN4wRPtm22EnPaY1dHjNrFB5d2ChKeazwSmUeV/OkyrYH
         8U7ajOs9owB2KecN1ynBwf3m7n5r7nby9oR+dTgEQ/x6Q3VgqOxFoAXN9x/KwwAgBjy6
         b6XvjBdWX416b/QgXtFBLlelEkPLSj9AsrxABQ46UJPOje5qB45M6y97puiMtcQ1JHHh
         hThfhyqawPSp3vqqpbVxzU/NR3zJ92+X4k/1adhNIMHjCh3q3s3JAaIcMWqA2sEoH4OU
         Xa2rUz6otUiqYUKkeDfd3gGpU69rRuULYqoMkpvc5yMwV1lTe/b4veipUcsk36+4h3Gq
         8/fQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqq+g2HsNBywKHyThIz9ezENTtaRAIF6JccXsrhPoBszaDhL7rd7VpIPcbH8vxIT1d8ohL0tEbFyh92mNIoFws=@vger.kernel.org
X-Gm-Message-State: AFuF++mGOi8NOf154xSpEd2U0NCvcDpeey8MLdEUytgQoYlqpgsWHgUj
	sgc0N//wUP0y3LCZAWpDX1+9CWmvs4YlLUJrgimwfi0MwLukIgwAz+EF
X-Gm-Gg: AR+sD129QZ4ey6OUt/gVwzNMT6BNtQf8X4ylvBY0fEy6du/ov4imjDl/fnfxdBCL/pz
	bs/Cw8liHMWzFuK6K+SUqdmZtT1mDRNZqNz5/WAu2kT14zWVm+cCaFwImD+gkwXxvqX0fjgRxJZ
	4Go3RJceYFPVezG9Ej10yPNP1DY5bFXbzW3s66xGX68DukUGhCxkY2a2+h8d+cWu9ochFVb3Xwx
	lKOqheXXLVD2y2FvC3/bncMNfzAs9Nc9QyNwU3axQmTcshCVXDo2c8SQdWC4t7IUDElQYQu285+
	J6JBDrMSMi/5+sGtV0DM0AxdRXUF7K5ObHmSa9p0ifY6/wzdT7cmSGUb/gfkcKyWnQvDjx1ZZBd
	POg73uqFsz2W1MymOayemxbLAPb3vtAT1eHX+tx1d30LzyGX1LxgIrKEYUZcGe4Vdr7tATBhj65
	ISUmIcX6HWqMvc58qylXhKCsGfBqr0gE6rmdOsS7WV0doKJaIlJz/J02r50ckUrnh0CtLl4O+IM
	7gsZAYRSKMa6i3MHJaNeDroTWw=
X-Received: by 2002:a05:6938:a090:20b0:c21:2c32:e2e6 with SMTP id a640c23a62f3a-c246a60cfe4mr460289966b.10.1787314752276;
        Fri, 21 Aug 2026 05:19:12 -0700 (PDT)
Received: from [127.0.1.1] (83.24.178.112.ipv4.supernova.orange.pl. [83.24.178.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589d9df9sm447823866b.1.2026.08.21.05.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:19:11 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 14:19:05 +0200
Subject: [PATCH v4 6/7] dt-bindings: arm: qcom: Document Xiaomi Redmi 9T
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v4-6-7ab02c0d4eb9@gmail.com>
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

