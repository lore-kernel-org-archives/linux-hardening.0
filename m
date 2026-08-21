Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE662ECD1D
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314751; cv=none; b=rR/pIJSE0CscKBthTNuzEQRJ6rqa/axrIiJ3cJiYeziV9uRBwFYVKLj6wuq/7NWZMRYmxNtiMg3OPJCHaVmim8so8RVdmnQRo10YTOPijWCJ4a/MU3CQbx/UaHDUrWyexlHYHy/1IKQYS8GjN6tSUjCZvHVWnl+yZp3TJ/u1o78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314751; c=relaxed/simple;
	bh=lvXJIYHg+Za7wwIfyKwrdptP8jCEhBX03Cv8tnpa48U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYwhJfLY8p81KWNPjYVPOIbHRbDsBBH1aEOf/AYWnMK8q3Lt5l0Leq6sSri3nPcAHByy5fpgG/UJLuJh6taSUcHbhgVBx0N3YtNlCHWLcdK/BSDrJsCDrff3ovGBaXSozTqCLesEw3++ERy7eegr2+VtnOErQaOUM44Ur5G7dfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry5RQ+Gi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry5RQ+Gi"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c247f6687dcso59832766b.2
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787314746; x=1787919546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pna/XzfqXxr5JhHe4C9RpqDZzth/Iq1szA4HTr9J/M4=;
        b=Ry5RQ+GiVl+i0Vu0KH1gppmtZbaWyxWzd7SCgbWFpeSpsEuWwqdoaBSrMNBSs7fccs
         Qc75kWBwhiZhP8A6T+rxEak+xZitkxkVomsAluDaqrEXmZ7vT/zxZGtTIWkLlzKX5xnz
         DUkununVm8K+hL+NPxWoE5oEg+mOIfsAd8dF1GB+smUrhCWNTN4m8CUWl3I4OVRxUanf
         wIw/SwY7giWoFx7He42PYU4UsnmRFzWOegs9CFJSTfXVtd0krTu/mxyG/hYhaTgarn4e
         twrEReNkmCHVzx0YDOgD1ysdx8tcYh7h/GX6ugM1Sei83wtDXm+FfFQJL+nZJhjpYA+T
         hmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787314746; x=1787919546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pna/XzfqXxr5JhHe4C9RpqDZzth/Iq1szA4HTr9J/M4=;
        b=WOkLcN56dhIDUy8IZhe1j++Fw6/tBS7hFfVxgbnAkYmKUxrmUvlXQNWvlsbh8F2R8W
         LEbOq75ijkM2J9VzsCy/bftrGdAol84zfLT36cPazCuNoyk+SjLhm3u9JPS+iPtQkf2O
         DUHWF0ARvEbojec2Tli2hLifT0WZ7QR3YRszdyA3IUI/H9LKtJRgZVqNK2F5ywxohupk
         4BsGfjYrSruvvjistQlGN9Y6xPFKzPQpn+RJUSijrRZi32SSHPHfuIYnlLczvsC6wIaO
         f0wfXeLTV4DHxku8afZIHVIpCRZSsfeHc8h/sAy1q1Ur+oImM63pAq649SZ3XeQwjeWu
         eC/g==
X-Forwarded-Encrypted: i=1; AHgh+RrylaZyvzn8rNmB4V4QvDmEs2c53nBcSJcKYypTjp7guHVzF+od+gGw/HGSRPBq97o37z7eb4rqlkoWC3nI+hg=@vger.kernel.org
X-Gm-Message-State: AFuF++m14uWuljAdpR0p8yQT0PuZQG9K82gWz6xddH8H9uWuUpVWYs/6
	SQL5nCLmz92BMkEPo+ljy9Jcd95BBxBszo2MB285FCSK+IXdQLDu5wek
X-Gm-Gg: AR+sD10p3I2J19Bp381tIQopJdul6/JtPpSSWNGqzVcapGtPHSPlyRh2K+5W47ZeUg5
	TsotQuiLQKwXvFuQB+fJkvDLUqo2nJ/n3CqhyEIxEG6I0GJNbCC7OtY0pxunsMJXPDPTa4p4RBo
	28NYDe4zpwgI7JPWXrszk3n849/JeEpC4/Hb0QNHv5VRMG5orP9TH9jPX4tpD3Ff7dyHm2pZawI
	WlZKE0P2pY9sc92enYRN+nJQaLPkq9f49RZkMctGapRJkd7Q/rSMCPwKfqH+3q1CnSPT/vmZWBp
	EQyOrPXTVKzOcvDmDQx9HxLH72K54XqM9RKTLhSozs/DKjbT9SONSse3DoiLuCabTgKRWyEIOx1
	tHnRZM311SwCvcG1vT3wJ/G6x5C5utdHb6VaNiITLEpug6WHj4//B7jLoG8RSleRPr6yTu0hHOe
	M6FH4aidzhg1Yi/ztzkjay3XY1otdA4+D87s71hnRUAERsWNYlyDoAms0yn6fRMB0FsrtQMyMdx
	rZJpCL1xrIxtLStHYQZqAilWcQ=
X-Received: by 2002:a17:907:d649:b0:c21:818d:e97c with SMTP id a640c23a62f3a-c246a2ceccemr629384466b.2.1787314746167;
        Fri, 21 Aug 2026 05:19:06 -0700 (PDT)
Received: from [127.0.1.1] (83.24.178.112.ipv4.supernova.orange.pl. [83.24.178.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589d9df9sm447823866b.1.2026.08.21.05.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:19:05 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 14:19:00 +0200
Subject: [PATCH v4 1/7] dt-bindings: vendor-prefixes: Add LeEco
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v4-1-7ab02c0d4eb9@gmail.com>
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
 Adam Skladowski <a39.skl@gmail.com>
X-Mailer: b4 0.15.2

Add vendor prefix for now dead ecosystem company LeEco

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 136681412501..dd0762d3334b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -947,6 +947,8 @@ patternProperties:
     description: Shenzen LC Technology Co., Ltd.
   "^leadtek,.*":
     description: Shenzhen Leadtek Technology Co., Ltd.
+  "^leeco,.*":
+    description: Leshi Holding Beijing.
   "^leez,.*":
     description: Leez
   "^lego,.*":

-- 
2.55.0

