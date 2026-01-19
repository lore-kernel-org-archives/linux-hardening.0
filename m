Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896F279DC3
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 03:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793452; cv=none; b=NB+mis1hUtqxF1muA77PFQMOOSnbbJF9IM8aKFc+k+NORsv28ttoMbq1OAcQkONVIGxWME0TLvLbUY8T3LQvbPESnU9EkeL1MnrFpexUZSaHSxnCxwhMAdj5ffjhTQNO4EzxbbxwTSuLS74kg9wYZm8qnvTjNNZW5FDdghUQy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793452; c=relaxed/simple;
	bh=5HxovrdF1LsVk8dy4niAUAipDGB4bXXvyb7MpvuxIec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlzSTxzOPZP/Tm+1HyueJ/Fy0CumaxkiCbCRz4tEPA/5C5Ok4OfgnLsq96wWuEIt5QoH/RUBBgDhcGxyaYPGgP8NXv/40Isxt9HiW8HXATW6ah+2Wn+peYTEkMKbmbnegdoBTYFj4Q2WjfH+nbJDkccnDJz3IiVIUy/1WWvy8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnRch5G3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnRch5G3"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c6a822068eso346198385a.3
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 19:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768793450; x=1769398250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NkSp3Qp2ev5DvLNgpn6PFK/BAYbn/itTgc2RCCe8u8=;
        b=gnRch5G3HvvQvowU7nsX/AwgITvYYUlgysrpu6cCbXTz7Yrd0qtlLBeYbCcZO7v9Ae
         /RLAp68QHxroPX2PU+md/EBJuINMseyBsaHkmgE2r+FGy3HwH7kjqH1BysaEKtqdDe3g
         oy2hBxe4mDgadgelw3HobIebwAujqQAORDdd73caf64W1+6zPTAgmXRVo0j8ZwYtNUJr
         ZLw7CoAPjVKzZ08RgP4Ov8qWFHMCBcWl9ejirE8Aa+WkgdtCIf0efJiXha+InN4QVmyV
         LX0wSxQsAxBldcI6WAiC+SY7vW1AOT0qzolDRP2B/0tzI02/BsJWHcw7dXeNLzgQi9Wy
         THhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768793450; x=1769398250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NkSp3Qp2ev5DvLNgpn6PFK/BAYbn/itTgc2RCCe8u8=;
        b=ZHGDuN7m/EPYGU11i41w+1JTW2kJhocfAg7g8zBs5cBl1elJUYBTkw/OjnQlgts87Q
         MCzfvgmqgSEH8HHbgeUdSkjaW8l7mNwuqmXLnMElOig2+uHnhsqXEVfFAlzICDvAR76k
         2YzgVGpSM9sScv5iWynkuBl4ENQPhcsPfZ58eQUcyOmcU6Wkypg8X6K4hq0fuJBGVrEQ
         PB9/WM0hYXH9y/sYOgsWhHw8kX7t+mBAcC08sQQ6Z8ul1rqj/4N5aTLQtNGmlCuImksR
         MPbODNJRiIMelponpSHUjuRiZWe8jvbRBRd+hzTR9Dn+n5yGUXrRO2SHuzpzVO7LbTX6
         vbrA==
X-Forwarded-Encrypted: i=1; AJvYcCVtaeN0/YBHiJAxkTspjMg8kWuP5gD7EYhj57T/ptrmXtinln2Hev4IAsrVEH9Eu0FPFgbwC4rYWliIuQvsMM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpWhHtrg3lKiCro8B07deSounbZlsGncWWarGOcOVNVZMSxfG
	Fq/i5xGbXZwH3ANQSaeHjQhBvurRNxE2dC5GLLQIDYHL++5NFGHQL9ga
X-Gm-Gg: AY/fxX4u7Z2mWwEeWxAx0nFvNjXx0VdRUwoldOvauuwpGgMi2LvFAx6NpdXXKos/6+3
	05B/XKpoLAxKT4Y9c5osING1wylVEa5/wjx1u5aOq+5rRitbKuXBaCfKNdbp3MAl0dgCvIzsqZG
	goTryt7VwQxs+2ksYZI8BPjkLB08G10lra97xerm72+dm3KMdWsFHAgIHnUnu02/qhmkneHFvaK
	w2aAqMGrAjQaC6PPF5I1wZGfoTTRGnf72M9Kmy35ZoLBrqnBPUipO+AFIzv2nWTlXvgH3OiJCED
	AfLMAwN0dLQmsnAPZscEZgR+KFcZAF+Mcc8HboO4iN3SI/0mT5XsmfU9UThi5ti5XkWJw4rjHUE
	UVXCjPxL6q4oB1kPm2uxKls7EzR/GbsxHZymplZE5pFxxOd7w0EHCs4MwpkFAVnPxVX+MkKz6NY
	eBHlBmPH3IxsYwnQUyxY8e0ahTV84+soPuadi4azKxTUNEQFzg/A5JCrDS9uVkwUc3AE4=
X-Received: by 2002:a05:620a:4729:b0:8b2:e8b5:1ea3 with SMTP id af79cd13be357-8c6a68ec4edmr1367928485a.28.1768793449722;
        Sun, 18 Jan 2026 19:30:49 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:49 -0800 (PST)
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
Subject: [PATCH v4 05/10] dt-bindings: display: panel-lvds: Add compatible for Samsung LTN101AL03 Panel
Date: Sun, 18 Jan 2026 22:30:30 -0500
Message-ID: <20260119033035.57538-7-bavishimithil@gmail.com>
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

The LTN101AL03 is a 10.1 inch 800x1280, 24 bit, VESA Compatible, TFT
display panel

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index 68c16c1ae..b31c67bab 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -60,6 +60,8 @@ properties:
           - jenson,bl-jt60050-01a
           # Samsung LTN070NL01 7.0" WSVGA (1024x600) TFT LCD LVDS panel
           - samsung,ltn070nl01
+          # Samsung LTN101AL03 10.1" WXGA (800x1280) TFT LCD LVDS panel
+          - samsung,ltn101al03
           - tbs,a711-panel
           # Winstar WF70A8SYJHLNGA 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - winstar,wf70a8syjhlnga
-- 
2.43.0

