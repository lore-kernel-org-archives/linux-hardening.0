Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81528642D
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793450; cv=none; b=osTFcdm/++0yYoZ+vdAAWBcgov4KE2oO/SpJWjG2HNt2Xak6yePUejmsVbnkHmzM5amN0vlDWsEZ5jietw/R5cmihPm5DEwq2Ph1+Ikmryvsyu61+eIAfzdkdOyB6QiT7gExeTLPbUahNUES4VRh9YXZfLT1tXKu7kLYcPOtOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793450; c=relaxed/simple;
	bh=eLdlv9TEAKtAVrbAkOJSd2uzG1zAErgJhfjsS5MIxoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrAomBzeHTj3uRLQc2myBekhevc3EDsSD8D9/dqOL54XWGekHUk+fHEpjg3R6/6CKUvCKee18+obdmFNuECcT5gEaywFRAbBaHbv3at5Tq/7RBQ38zIsBjlGS6DSXIAxIadYiCJepjeHYVrDEbFXk8dGCb4LzlYeNSarzlck6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp8uDvin; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp8uDvin"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a288811a4so40642956d6.3
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 19:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768793448; x=1769398248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT+OlgLwisjDHGRQGA0CO4AmF6Wqh7tGvnECOOk06AE=;
        b=Vp8uDvin6Vl4VNt0Bsp5GIT18BgI1C2ommmoJ4zIx/ZkpRfx0lwl4mfY1eCreZKJcH
         mGONuCcyjz1MYS9mIoMFbMTtHa4yx4NDNqYX7EhimdEEm7VJ3wOksw6booBT0spT0agM
         YJ0nNJCuxXJZbm4diBU/xRzKPYqSaNMllEfI1Neo10wAjYQ+K2XaMGFDKpIpBhjmcjq+
         0UIigk0Kym5G1XdCb/o07jqq9hb9BntzU5QLLPSBCn7rwRjO6ogImtT0RhATM9J9g4mB
         yc1deJ8LANj8bcI8CJxSh3Isvo3JuTtxmimx6sLThkRDv3YmyeUaSkjw92uCWRf1MkBl
         FZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768793448; x=1769398248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xT+OlgLwisjDHGRQGA0CO4AmF6Wqh7tGvnECOOk06AE=;
        b=PbW15JWHagf6LCmDjFmYXX00zMHenDv+g1+r2LzA+DDOhsdJe1aDELljYWqvAZwEZE
         uGh1/f1ndG21D3hMcoVOS+6w/eT1CXR87KnOqqrhNRYoVN1kViQNyek7imGWz3S1WZxA
         yiYinI9AlimJdF0QIGO1qRorAVnZCksnHJYamQVUfE+97SHLSkzNihS58XKIXPebWimO
         l4VmKtkSNmtDYYzRmnAsxUhVjK13lJ+VjXjsAq9C8jm3ZN3HiiDF3pMILyqP0tl2ZYvm
         fsk3rhEU9DZTe/vqZS/pmq4kL8bwVwqFcx2B15TBvAmXET7SBH81/764UilQjB0cHQwI
         YAfw==
X-Forwarded-Encrypted: i=1; AJvYcCVV9RdqPvhNSHWsqpSckR27yw8GxspbgudvAE1PRV/rvKQiPSltEOQ2KN8IA7jSkk6cb0Uo7I+OenQcuLanpwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAsPzt5CFxFI7HJ67FLLWokGNcsKSEoVFl/K6oMR6yKe/H/ZNf
	fwCrqvcdPpGtengpEQTZMYoDzRXdGedwnj1/G3Q2JPqQrg5gspEpQL7D
X-Gm-Gg: AY/fxX5LQLZW5+ELdYJlACmvQnNvhdU8pHS02/e1Ad2lLOv6qUQ8XDRLHnwmWdxCw0t
	kC9Lkg2FMTVSZXJ/F8Mmdw77cpLDkwSBz/5mR8E2ky5oSOiR7mm0+yyQEzqyBXkd/aeTKFRoJj2
	qYm76D4tpRhWYAUIFYrTVxEw3JugiqchqGp3t3eYRmcQL2upOpEYWbFIwyTqpMd4pOonymoFoU4
	WIbDAST89VlMF+fUHNmud0ql3Am9Z4CYGMwslOGXmplpwEjHibZZXSJkqIo1QeyULyPL21aVY0C
	/+FinEdKn8HuqclV8yQB4hrwusbjVdxNKkWXKDzKsUgqahYgg5Svn2Hz8GTNMTeAQETBfp/Plp3
	Yp2iasMM3ci402iSqL5DD1kvbMLhKXU8QkQPlPMMArkSWf4SSf8lfqszJ5ilHBNPWu3wKvMjwCq
	1OrdPRfNC0D1Ff0s6jgYBdEeHomDx2cRMBA96aaE4LoOoxDhmiW2VNEw0FP2O/CJPlO1s=
X-Received: by 2002:a05:6214:1d25:b0:7d2:e1e6:f79f with SMTP id 6a1803df08f44-8942dda1871mr127151346d6.47.1768793448154;
        Sun, 18 Jan 2026 19:30:48 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:47 -0800 (PST)
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
Subject: [PATCH v4 04/10] dt-bindings: display: panel-lvds: Add compatible for Samsung LTN070NL01 Panel
Date: Sun, 18 Jan 2026 22:30:29 -0500
Message-ID: <20260119033035.57538-6-bavishimithil@gmail.com>
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

The LTN070NL01 is a 7.0 inch 1024x600, 24 bit, VESA Compatible, TFT
display panel

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index dbc01e640..68c16c1ae 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -58,6 +58,8 @@ properties:
           - hydis,hv070wx2-1e0
           # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - jenson,bl-jt60050-01a
+          # Samsung LTN070NL01 7.0" WSVGA (1024x600) TFT LCD LVDS panel
+          - samsung,ltn070nl01
           - tbs,a711-panel
           # Winstar WF70A8SYJHLNGA 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - winstar,wf70a8syjhlnga
-- 
2.43.0

