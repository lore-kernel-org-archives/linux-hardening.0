Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55312DEA68
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314753; cv=none; b=mv8h2WBJjeAZDph0x27V42bIARGyhYIUXWlYBqOenEgpgfYuDdL+TXj33nSK+u96t4gheLSnxzeI5jTfZUY0IgwrtSQVKBsRO+Rrh3kPa9VbZOn5uWcF5BW4zmfCk1xVOhuaYrvgFGlQJOlcC2hXsMdYF6hcazoUTDNIL7Yy2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314753; c=relaxed/simple;
	bh=GtU3BwmWr5r04fdNMr2P/dLekVQQQO6qKHal+CTJ5SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USIW0M0ASCrZi5/yhObZfZ5xMhlHrbzeDLkxOsqSLeiNJWPZNXxI/uDc4U6ZTrf4xnx0cnFpoPdIs2Dgt59J7irUOU/2m138zNJ6iL6wmz6ymFUVH+pQn3wdrRDxT2rphA2m2F+ujisv1yewLtMslyIK3HJ/g2gcEqUASjo3oKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNwhZezR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNwhZezR"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so173321266b.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787314747; x=1787919547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fqnhzBAbwr00r53ZE/i4Zlj1u/RNPOU76CLxr9WNMu0=;
        b=YNwhZezR8ocwMwWJaHMAFQodJ2N4L9yebtBvagvqG0eDA+HSiuCDN2FXKYgy/AYHOz
         5bp4eLJG/H1TODcwJd0fsKy6Ck7ZtUhymvlZz8T4S2kwUCDTyUzLS4rtioqrfvhIBwVd
         rzks+c60J+uE7DFjwbslhDmelPCLTJX3/JbYINE9/8nfgymYNkM1fnbZbRCJh5pQE0Id
         UbzI+0p6E5fBbNwIQ5061YSWlRsdXVuXFf0Pkl08bVra2aQfusdYp4uq8HpiIC5smzmS
         ZM72vCU05Ui4NvP6hdmg8+4a9xH8i2cd1KKksbWaM00icF1iIXNgWWMhwbtdfcUNA2Mo
         MKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787314747; x=1787919547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqnhzBAbwr00r53ZE/i4Zlj1u/RNPOU76CLxr9WNMu0=;
        b=TJhgwRvgc8kdCXNzihfsdteclt6gZE9hLiCfopqZaluxKM2VQ2FL1TmmniHc0ivzgc
         ptUDKiqnexKEnoBy8vct/hA14n1ssqrDuiz86t7hraBG7oP5fZHXmcHU/+6LTYuooh1b
         Eh3lwf4VIypH2AYoOKv2u1aS9QdGk+hs9Go2t1mS7C9jAolwlZ3LZwRTT9Rq+i2AnMNL
         EMyM7EMV1uwD81+Uk4s/ccCY8XeydDJ7YMw/v6FHHlbENrkuJuYl2EQxCSKI4kchKsY1
         /rjcapSvTIv1dN25KOp/GBCMe8uFEJVlkQ7wwUF+DeFIPvji/7bbC6Z7jgt0wOYMt+pp
         6E6w==
X-Forwarded-Encrypted: i=1; AHgh+RpooUOWmuVB4xk3shV1uenyrwfY6m3+q3gvG6NW05NCSHofwchaHB29G7KTX/uITd4OAf7ZD10ucMN3/MGv2Z8=@vger.kernel.org
X-Gm-Message-State: AFuF++kKQNBF8Aix/yvJgKEo/bDMjWsPs86xnyOj1HEmlkKIT0uv+KIW
	le1AmG7WAn0S7Jp6AaMNRZdTbZv0hA8DhgUmdsz4L/WsnEDjKYckmebb
X-Gm-Gg: AR+sD12ZmLn0WJhkTgbQi1BEls623q2SB1jnDIdycjcxmWwY1Pn5DOPkHBR83XVwbH9
	Inu4Aiofp0RNQZiqt0QcAHr3Yaom4GFpZEOXBFHHoG685B4LPRUCfOLiMQtxKPY6Hu4YpNIuRNe
	/6vQv0puxFcztJvSprAsNXwZnoWZeKuzIUJHkwdM4JKqibZLcQceFA3/WL0KZwM5ITYmW1Q3owq
	wxDizTIdcqzKjL2xPwVfBkC8u05oWO4awhVGPV1GV4lzpEA++BpNNrHQTRTznZ3mwOxOu54wyx5
	MoDO/FMuKtcpb6EK5B5M0tZePB2Ifo9cdm3Ly+JaIxnOu3kCdk6p/ZD63ZVq/4gkMUWyjC2xa1b
	LBI1G/6jnMlqwSWh7wFdiVFoLEVlhmzlktXTnqdntJeDKu80NERWzE8tyNw6RR01NIO6MGKOAm9
	HKYRzBdo/8Fgp0Dtu7X8DWenuvgicrAg4jA1A2AjPmCY2c89tDhtctswxJR5GKzlt3zStxbf/s0
	BfB+uWznPA1aAgAmjUE5hSF7ws=
X-Received: by 2002:a17:906:b849:b0:c12:6d25:2c7a with SMTP id a640c23a62f3a-c246a627988mr481735066b.17.1787314747295;
        Fri, 21 Aug 2026 05:19:07 -0700 (PDT)
Received: from [127.0.1.1] (83.24.178.112.ipv4.supernova.orange.pl. [83.24.178.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589d9df9sm447823866b.1.2026.08.21.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:19:07 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 14:19:01 +0200
Subject: [PATCH v4 2/7] dt-bindings: arm: qcom: Document Motorola Moto One
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v4-2-7ab02c0d4eb9@gmail.com>
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

