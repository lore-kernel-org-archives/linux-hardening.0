Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41A42FCB8
	for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380969; cv=none; b=JkgNeFD2IJI92VYhtefis35Jo6JkpFeuFXIwDcO89zc4juciWH1anlUDU7/+e02OjgnCpgXzJbdCGdAdSYxqF/BbK5XTi3wiRNX6u+0s/Llvi3xCJKVzSRUFmUZP/smunicWkP44m+IpbLv7N0n/7VsbJAWfbdCq/qj8NVgitz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380969; c=relaxed/simple;
	bh=GvnbzUc8c9NU+oo1TqfezYXxZP2QutE76bVHLE6Elxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=km2GenPQo31180YpOPzLJGu5XV2fZFbkOeCbCXnomCbPgx5UNPsvaZrblEBSseih5BEr146lUStifekE3ash/slKzXrvNG9wJ0rUWM5WP39AQtvDO/5W1GPzp9En1+Eaxx/HGj1/y9HxwAEwIOD1pEsz3UxCfSBQs2MkVru+va4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3heZb5l; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3heZb5l"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495437bb891so676205e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380965; x=1786985765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/iCLTOXabaj4z0hqf20GvwqmNfb3co6JWnXenjDC6Bg=;
        b=G3heZb5lHuZFsxw3LyHqIqDCLEVaBl0V7La+p40ULfl/mL6BT5XmPyjlVrIk9ShCP+
         Pe5tvQighSX2/XPN7JbBuZQ4KaBOdScIW5PRnKDp0oI1AgNR3Yj2/hd+dVxxaLwYQU64
         BUl0IOB4E9biLkjNQgtblazMyog3Y1FRnWW6SH6t0HfCF3ndWnAIL7rIsYrm8HWk09km
         prdXAnM6IPPM71gnzXwl0umVg6t8n46HlesoaabW8dr1GgDwPetSPzKrUhhupqoq7595
         sMRfBdxHgrDxYgWrTLcatt4LQz4EjKWjBDm4Cxqq9HRBiDzbzRjtxVWxUVu2tKpiN4Kj
         KPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380965; x=1786985765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/iCLTOXabaj4z0hqf20GvwqmNfb3co6JWnXenjDC6Bg=;
        b=aRnobDvqpP28G5oS30CJrbPG8QaBD3IIGBmURTVoNJE/cPhjDUHwHd2qlS1Uj5jaAI
         7Jo516id1PZnMU2E+JgBoISIvLM4wblrSdsCED21oL+7aeZGGPOhYlzPu90f0RgAIQ4D
         BtzjEF6gmvEfj1sVMgK5W/Dgqi6TPPxu/6waFcLbbq2ZUqiOX4kc0m0LADNGClcas0MN
         +mdTVHTBgHfXPf8/RoSUxkLCo7ToMz1kRaMYNylrTDJV4+hfa8QCbwsGYByk1TAd0lY3
         3989LLX/VCFXfVdHteXzsFz7Wz566h5Wz08/CICJMi0vA3aJThH6lCv5kVS3+pRQGd7V
         JbDA==
X-Forwarded-Encrypted: i=1; AHgh+RpYtTUmQOElXIW/0w9daPNbSE7tf+LdJPgP5Uib9Xqk1fFlFX7NDwATwhypVu2qFhE7KrkDnnGxqtt2uaWaN+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5URYhszMP9KpdWlFx74fMHP7zqMzEmSBgl0+ErVVoJX6vkQ9G
	K5L8S36GRyEJJqiXfeacJ+w7GdEFZQ5RfTaI9AGBUbVSxj0z9fuvnSuj
X-Gm-Gg: AR+sD1025/FhngB1KXF+VEk+brNP+54+X3iP0bjdD4MK6FZh+MHEBpyeBjXrjMEQZxp
	fesobZAH7iX671CpSHZIdNaKaEZuKAHgZkGxGuNjabQ6rMV7TqfHRy4c8ZimwUpzmpxl3NUz9OH
	wBsWpasnH54XEGMxhQcausM17E/Rbn5QPv9mCh9OmQbFNJRIKKzZY57C/PivnBJY9SL4r+jrw85
	5QCibB2kqQ0ZTxZizVkIYXQTVq+5MrWFjlFa4hzvUQeSm3ubDTFjYOp+iAH2hSMkZ9F/AeI338c
	j90ZbO4qYi1z7tHIcxL7TS3ublnwYiqtR2VfHTLAkFrvQvt9k9I84NSoexTQhC2ls/f2hQbrBc/
	Q6T4oLns2jRnMOSrycoAuktizkMrY5Y6Q0ulF/DNmmroLARZB7nGs6gXwQWYmb+Zp8PGdxgq8D9
	oOQjHyQKW7ZXErSork/rOQN6OBVcJH8AxZ0MYmIEJ743cpHYodOOtgUMHRuW28UiuiC2vVzFE2v
	6YY3t1706uo5798cvTM4y0D
X-Received: by 2002:a05:600c:4e8e:b0:497:ff5a:38b9 with SMTP id 5b1f17b1804b1-4996247e640mr230932455e9.9.1786380965439;
        Mon, 10 Aug 2026 09:56:05 -0700 (PDT)
Received: from [127.0.1.1] (83.31.73.193.ipv4.supernova.orange.pl. [83.31.73.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm238472635e9.2.2026.08.10.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:56:04 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Mon, 10 Aug 2026 18:55:35 +0200
Subject: [PATCH 2/7] dt-bindings: arm: qcom: Document Motorola Moto One
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-next-patches-v1-2-79a779d76173@gmail.com>
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
In-Reply-To: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Adam Skladowski <a39.skl@gmail.com>
X-Mailer: b4 0.15.2

Add compatible for Motorola Moto One(deen) based on Snapdragon 625 SoC.

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

