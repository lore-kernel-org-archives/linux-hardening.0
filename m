Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9D27D786
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 03:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793450; cv=none; b=H6LLS7DropunDFOwmlCHp6T0AsTIo21fVEMZZnsg2lI75AUBZCUCMo5HAIZYoByLXuOt7VCmmHAz85OZgA7BmeqbMseQ3Ws9YxMhW2LwYrZMgogJIzrjyueA1JKriZLeFUHdbVh/is52XtIGpWElJdlEU0vFVTj1hLo+UfUl6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793450; c=relaxed/simple;
	bh=QtehmTlxVE2ImMqTMUlN+wssHL5rLi9pMI7VHV6x+J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Je626TtpyOjXjzeAb4PARS7stOnS6czAJHqPY/D3M+SSKzJVQ6OwZOZeseGPpxQIruUrnEmeC+bIIRWutg7X0swgJvadJHOypPO5e40XuMtR/fK4lcSBPJ/RmCzHSPPEvPnhqzTBPizFQ3+NxI7rEgwRNpQWWbXagMmA7brNjbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0ivzO53; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0ivzO53"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88888d80590so59941216d6.3
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 19:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768793447; x=1769398247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hq1Jil93LKWD5SqiddgyBykMfT43TbOI7JPjGrETyE=;
        b=N0ivzO53nkFxHh3yaSkbLQjkCtKfFOof09VTSNOigXmKAr6xgRNE2linhP6dP/rIaS
         e1A1S2wwPCmkRpj78eoI5Awt47QjbDK74xig07J6iGnGAGrhV1MN3b21qTv2e6WfOaFB
         F6TODsoql6wPQFTmlt76QpS8Iky19GWZiJ+8n8RjPrFqJAjdwW5mn3kJBf3mefFENAC5
         +Edsbc/BhFeiqS3XimIs48iy8m/p/DzEyPnRDdUy2lREVnu0vXI0qE4bkoS2ZjyvV2hk
         buulq28P6VcJtn6Lj3oUk5O64dEskSuz7BH4rHpYFWqw5fxiaT4Z3+abwPrS3u/BDM2v
         Dpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768793447; x=1769398247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Hq1Jil93LKWD5SqiddgyBykMfT43TbOI7JPjGrETyE=;
        b=cLlXbEptPjSeXmcyMJzzRLsAIjKvwDkNmQi1rL2LsLmXVB8l0Os67GwICeD6i2U/y6
         CfyG+pgdIcIBk5CkHDoI7J1Znwng0xRoQMjdY5jZ0o4Lnp/cqyoFOYdToEoM2rR23Lp1
         lH6Edbx30Hz6TW1Yn5t7RVJnrtrZospd8aSdHRrWBAZwGViLVyvZ0xWjNH/L3IawQ+j9
         xshticgP0Nx023t6Wsnr+0/Wy/smgK2nut62LIPrZiZuxoXgk43KQBilFCGJr2C9VBdW
         R2PpZ9XANhRBkSMBlPTBEGUrCXamH2uoUwCQ6R2zY7uU/6PoIA037w4iMxKu5SfPiKrQ
         WCEA==
X-Forwarded-Encrypted: i=1; AJvYcCUKXyGnTZQErBkaBgkMU29QBcCLYg0v4qNMuYYpsHWAK5wy5btqqhcAw9f1xG5/PTUVKcPOVCBak+9pMRpdmyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWJ8lFdpdhncXRAmd72Oy2jCbOqjJpZdGyzadRAcSpLhzgqwB
	hB4nCbFVlEN5e+wGzSFs51HY35rdZoMt99hJ6S2CnOHc78Xqrp6oa9U8
X-Gm-Gg: AY/fxX42JbIeTqF49o4xkeWTUqWfHnrJe21zpxpmN3w0nJImsI50BDu3Pq3pRRfTx5N
	5P5jfoKceFBZS9GLecl8UmnnY4HckpgLacf42dRveIxf0lOpq8DzO2FfCgQDZlSsZK8uAzgRkEJ
	inns7jm1yOo5aUI3CU6vCQNnIg7qFQG8dUcB1ZsJB9osSC81Tp0RNJcHsX7v+lm6INVfzvTxgWj
	0SXgeGBpJR+7Z5vlF8/qaZ1Zc6m+U17/CgRLgel8949mCT4uUxtGpyyut5N+e6TkmuHDACtvDaw
	BV2guQr+VCZVQvCe4TmHSJOQI8Jc/xaH1n+Mr8aKRQaKp6/Ft5/P/1gnIWqa2kODt5VEhxc8mSx
	icvq5htP+FaHDcwD04Q9ckrsOqyr6lOejwIYTI1DMXTnlWJdBK9RcY0/jG8t+g/ZcxKrkKQG+bL
	OhMyiqLqq8JzJKBz7geRWtqxCjOfu5abwjiKICMCpHi7kUGDEHvQGviCDvoAhCZK85MRs=
X-Received: by 2002:a0c:e008:0:b0:894:565c:98bf with SMTP id 6a1803df08f44-894565c9997mr6435226d6.13.1768793446858;
        Sun, 18 Jan 2026 19:30:46 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:46 -0800 (PST)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 03/10] dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
Date: Sun, 18 Jan 2026 22:30:28 -0500
Message-ID: <20260119033035.57538-5-bavishimithil@gmail.com>
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

Add compatible strings for the Doestek DTC34LM85AM Flat Panel Display
Transmitter

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
index 4f7d3e9cf..3ad01645c 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
@@ -33,6 +33,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - doestek,dtc34lm85am # For the Doestek DTC34LM85AM Flat Panel Display (FPD) Transmitter
               - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
               - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
               - ti,sn75lvds83 # For the TI SN75LVDS83 FlatLink transmitter
-- 
2.43.0

