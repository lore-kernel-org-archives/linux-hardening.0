Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71092836A6
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793449; cv=none; b=uXptOM56PM+gyiheps2ldmXVcm1ABV8LQuELtvWYEOyFuXHqFr3QITn87yPt0vxcLStHDsCuvsJzy5hiMbiJWA0j/vdZcksxCUrfl0Q+XP0EB60UJ+2H+0oruSW9+dF4CJtpMqT2ejoLyLR0ZwdUErwAmNBFUV7KfLSba8cI+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793449; c=relaxed/simple;
	bh=pi1fLBggw2w5nq+ku9XGxrPVz6Xc+gXO0i/5XkcUNq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKCVSbFxkCbEqmavdj53w27JWx0TU15887/FnW7pjOT5KsTfD84noUvuXYoVL51OZ34EwaWY2btOo2rx6DJSi0Nguo8KWkQk7ASSc83WsH9svL9dt+QpiJ32Kq8UC+WcxsFZXhqNtAuXXlHb3znbGUz8A+XcBgGmI0p1iXgIRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfqgrRkL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfqgrRkL"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c538d17816so522728985a.0
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 19:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768793446; x=1769398246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnop4z34aVye00gIQguUoewYT5lM9SytbUgSGtePF4w=;
        b=AfqgrRkLGoRNkmwLVnfl8C3uGpQtAF+rPrS+T5DRvSRev6mReTAMc4Ett9jYmZhCpF
         qdVWUEL5wRg+syA+lns13e6Wk/05wGkd7fkkvoDlNojTZ5AMFJ2nqJjV6QSztKv4iLMy
         e1ZbIlqSPutrpePnA3PZQosGNN6dinClsTSv2eKhxxFF28x1ILL6l1Xwd8Lk7aKurEeM
         vsBfP9FtuHmnttaHsvGS+E7xISe1m+tXAb4GuOnwv+xSg/Kr8KtsekanYclZZkX33BEJ
         QBv1K/iMvXBLXXl+KB+Kv+8KPrFasUK6DkA61w/hURKfTBW8NqWTogGuTymOMo/m3ELV
         Lykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768793446; x=1769398246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gnop4z34aVye00gIQguUoewYT5lM9SytbUgSGtePF4w=;
        b=l8Zmaz6Y7BJ/vHaoJE6NuicTQKhfcKpYrR4d6kEnjejIZqwEj3KZJNyk/0EfJrNV4q
         9tT/vtBoVaVObjxxtXrljbft8vMNPIb6h/sEHDMADNyX41bmAg3ov96dkII3EuRHCYu/
         p/gI0iujcf3dkvkl/88eSjZpgbdBZTmrQrp3FZCcHTaXNOaqeibX6rEyf12pBcI/ALC3
         O4+4l06rjAJDIm6CSkENu0gaaNHLTfH87C1Fedt+zK7aKgV3AAss3sQfFw7+ba5IC6i6
         FCuXHq2BD0KQkF7Q25GgEiA77Rv24Gb8PMLeUuSbaOdcKCT331h/DbxWL8fuuSP8D4y1
         Mq3w==
X-Forwarded-Encrypted: i=1; AJvYcCXcOtS0DnpM2OCnR537hldVB9pIT4nCUXAu7L0Puq1gA0NMIeiSEEjWT/aeNx92iTx0EnMc4JB5EYERZlDJClQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylgKowD6I5kIL+S4bEZGx0+ox14BfDb4w7r4KdcrWjMXCfhIrs
	rk6TZWI25z9nMOsXjDvLzvquvjA3tob6MYHLCco/clA2wlIY87p7cffI
X-Gm-Gg: AY/fxX7qtiOpTVeqJZ0eFUegYu0+O5bQQ4FLjNsG51ZkZNnSmd73PGvbjwgAZL2BfTz
	sCTlv/CtI46GuQCgWXcXfiAsrehGwmG4aUBgO7m4x3d3Ll2s1A0++EOo2sZ90FWeLXuvJuhemkK
	/Pg5g8AzSK5RIiSUVcTrLTsagzL4+dv23/WKdpERABmdCOFhpobhoD4iNDgrMU5JnuszdcJLmAk
	/tW1mdWWf9fy01OzjgnNfXQZiOLGQ2GpKtmmLMAH1C4Gv65BVqa/etQCVwAbqKNe+YuqooutDLm
	tnjYg459YA47ZAnxkNHDgwRxXfRVCZl57bAzqcbjMPNuh4GmuBHos1QK3FLr8TA8KnXw6oiVkGP
	b377dX3E9AGhmBHQiT65STElX9kphQAIaNfST/HL1Y1PvKbJZFOAls7EZac3QeCGl/oDhVJc3ea
	6gnXv+JZ+10gbE3F8Wan734/CYTosGM25r/Gyt/hpWiERb4oV2pjH5fe/3xoWOBHxJyqE=
X-Received: by 2002:a05:620a:711a:b0:8c0:ddb4:2141 with SMTP id af79cd13be357-8c6a68ec47amr1370029185a.24.1768793445587;
        Sun, 18 Jan 2026 19:30:45 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:45 -0800 (PST)
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
	linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 02/10] dt-bindings: vendor-prefixes: Add Doestek
Date: Sun, 18 Jan 2026 22:30:27 -0500
Message-ID: <20260119033035.57538-4-bavishimithil@gmail.com>
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

Add vendor prefix for Doestek Co., Ltd.
Link: http://www.doestek.co.kr/

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c7591b2ae..70a195fc6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -437,6 +437,8 @@ patternProperties:
     description: D-Link Corporation
   "^dmo,.*":
     description: Data Modul AG
+  "^doestek,.*":
+    description: Doestek Co., Ltd.
   "^domintech,.*":
     description: Domintech Co., Ltd.
   "^dongwoon,.*":
-- 
2.43.0

