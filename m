Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF992C11CD
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 03:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793455; cv=none; b=c+xXTTEqGPZRE7+p3yWZrQqv3gLaqJkpSet0sj5el0F4r253w1PUQyo6ZIdo79bUY8ovMtaFr8dIZlYMmK9LOwoa4t/bmxeyMK10iVc1rWKf5ROxd6c7zOfPFRGvwzJigGGL/Epa1BDnGF2foO7ZDBPGAV2gZDxjxYszd6kcqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793455; c=relaxed/simple;
	bh=Q3APeXQDiu6Dq0YbUctJvWNTMdYSUA/70lZgJEy7pCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVAaMk6meNYnduFxPgk/7TZ0EELCfYUnkpX6An41YRIXowk46vIuX5sA+4KOZAFybXWYeUyiM6FG/X1gOgk+d9t5JQprHi0z5eE9XqRFpv1T3ikAPBldNQMfovYPzcm7o//u8OsfhFIH9Hqka/TT2waAv6VB4D+4WKYO0mLzXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctGfwPBd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctGfwPBd"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c6aaf3cd62so276819285a.3
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 19:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768793453; x=1769398253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiNtJwtw05QrNdGwEwvWFIn9UYOv/0m3Dr4ujrTo53Y=;
        b=ctGfwPBdcvMDrGDsfWYHtMYlcSDhX4WNYa6JCQ70eTIiJeoi/ZiVrfHESNzb979W7H
         y2FCjGyZTGCbgG4IbyzDjB3DiuXIv6f716EnAsKZq+xY3H1uEQxxlF+T0jx7bg7uCto7
         n1mq/JfMf3SyxdHqN8It/9hbCOM3qTVlVg/t32wanvMv8a9WVJJPZbK5adq1dP32hFMC
         /+C3n94/D7eW0Eb1M+CdB7plcm4Xei2BDGYOo/+wl+fouhRHPfZu9VxyxB7NVdV+4+Wy
         Hn7iW529Oy0pWhHHN4Ih9jq5ZmOUiC/nAMsirMwCPqvS22BpV4kfl9h1jErS4eHfmBPl
         eRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768793453; x=1769398253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xiNtJwtw05QrNdGwEwvWFIn9UYOv/0m3Dr4ujrTo53Y=;
        b=QKQAM6E6qFXcahorwDThPOQ0AurNk5hXjzCkhztq60JZHTKruPaZq8+QlZlgkl6hyj
         G4/cpHfIIpQEX4n1utQFbjLBq+xKr29Ie8XS4OE48oxKtecoY6DCinWFJF4PYfSmQ+p+
         hVA6WI+YOxf6oNyus6e0CDzGB11tE50EWucnr1cU4UzVnYLSQukfPLNmVwJ0la267cPP
         OFKS0OckM8H2G0YP+jBFWWcSl17d/HLCcIufQuKhRasqs3/B1C4B9vL0U13CHsLoL6My
         sEnDM6mlaZdLDOBFX60DAw+u40DkI5xkP1WzAt/fPrBqs+LK8uoiTgDtHbwAY3wV+it3
         z+kg==
X-Forwarded-Encrypted: i=1; AJvYcCXL5gvOGgO3Qrl4Lt9vo9v9szWN17HjRAY5W2y6loK7fN618DmQyobjQbk6K9kgo0tveGQ18tCu+j00IzpWXVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7HT8TuYGZ04utSyHJy2ha8fZdP2VIDqzSAo20GNpwWFTIHNyP
	IGKxr99xVMJfE1rgWkLJ3hqJXr29Bb6XxCiurISDv1HzcEAmBo4DtF3N
X-Gm-Gg: AY/fxX7Jd+dWf/PckrKqx+8+X1QS4zMvAnSql6X8drsYoto7mITbfKcJCdRb6McoPF1
	/pi1osCVkvIngwO5DdabvkCmtXqr5EGO27KBlW6E0rpJGXvLLKTrYLRElMEWfPT6fOb7TgkAeGc
	s06uOUHbTV3ifTrarI1biKLTRLq9b6B3DBCD5Mp3/Kw3THjr3r+0EI7gR4lg97hovDWabIdnXpV
	HCAuBKbhmwl/kv+I2emie/ZHgVUrd4OeMgQFimCePUuuIL7fRBf0WP6qJs73bZThe7QnpHB1TIE
	UPSMjZSk4yKY0YMdIKM1yUVCavdO0BHvAfZwjfqFCi3LsPpRszEl1j4ipXThQV2g53in79AG3L2
	jsVSt9qevVpSmX9ShOIUWlRLVfW1/O2DYVNVsR9knEU8c7aWfW3VZ4k6ZDpFRwZZEjp/8oMrXUL
	vHMpdBSihvaYJwmQFaPIsqPjSMx3TZnTHv0+rQto3ZitnOmb+hXWaz0AFixckBAoJNvZI=
X-Received: by 2002:a05:620a:448e:b0:84f:110c:b6e8 with SMTP id af79cd13be357-8c6a678b831mr1437612485a.68.1768793452693;
        Sun, 18 Jan 2026 19:30:52 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:52 -0800 (PST)
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
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 07/10] dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0
Date: Sun, 18 Jan 2026 22:30:32 -0500
Message-ID: <20260119033035.57538-9-bavishimithil@gmail.com>
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

Add samsung-espresso7 codename for the 7 inch variant

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 Documentation/devicetree/bindings/arm/ti/omap.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documentation/devicetree/bindings/arm/ti/omap.yaml
index 14f1b9d8f..d8774c676 100644
--- a/Documentation/devicetree/bindings/arm/ti/omap.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
@@ -144,6 +144,7 @@ properties:
               - motorola,droid-bionic   # Motorola Droid Bionic XT875
               - motorola,xyboard-mz609
               - motorola,xyboard-mz617
+              - samsung,espresso7
               - ti,omap4-panda
               - ti,omap4-sdp
           - const: ti,omap4430
-- 
2.43.0

