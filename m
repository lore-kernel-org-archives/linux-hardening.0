Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53762D7812
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793459; cv=none; b=G1MZvz8P1xuJdBgwgiUp/Y0T/f93pNN8k82ZLsHxzffWm87/Zjl3hjHIwArWG+FqsBtoeKpQ5CN1UOAPRghZRtO22mH8ulYMBo9iFpt4QQTh0rrqeJblFkTouCFlscJ4kOSjzLxOnJ9YQmTZRyxbh/kTaNYLsxfM1Da8vw9jN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793459; c=relaxed/simple;
	bh=sYgVWqZsv/TROqvYUD+azJpccjPNPUbbOaignxHHa3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqUQwW7yWg9+49n6qxbLpim4XMpPxklk6PdEwUgZYisShhLLDUaANBT10JdS2QXQRW4omdNQ6c3R5yxZDgFtHah9Smzs3EvDAJi222Eq4Sdm6CJRtO8dyPiVctHIv0Y11sumhKoiqBhY+Wbc0Eqr/MwE6WZgWDtgGTqqNbbyxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY4VtqG9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY4VtqG9"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c6a50c17fdso298386785a.2
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 19:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768793456; x=1769398256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJZwBKE1B5fG1xmzuppeSdMMZvJUhNtvUP/Jy0XEbK0=;
        b=YY4VtqG9t0lbCjFKDbjmXsBlMhEoaYTGUD9H0HtzmHPhd5bMXfpLXfjkDfHafeU7HB
         ymycm0kFihWdsE3LMOR2FY8n2Db9Wdtn+tfZwNLyZOTsAv6/oMzSWoRLY8K/xspcHpGI
         oqtlFyseR3UpQlI3og912lhQ9iftK3aAciFZHlolnvB+XHurCLGhqyBdTXW2RHjDVSUY
         mIuq19R1v0OsHiGFsvlg55W7Sh27cgqHR9QYaulLPk/ALfdXu6JjziCnGU90anK91x3k
         fq0jmqrf7ura22p/A5DBgR9/PBIFyQFgrK3mntpXhjdYnaENvtVfwjVBTqF+uKWoe1CQ
         kI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768793456; x=1769398256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJZwBKE1B5fG1xmzuppeSdMMZvJUhNtvUP/Jy0XEbK0=;
        b=Ppariq/ixgSy3mjt/DqqaAINV69hF+R1Fm7pDt6d4Spr/920U2/iZARYvHUnMljSM+
         ZOOHAZG+ZNLbPPWS0KlVVuZh6/qm6V8Oa0c1uj85T8qT1zXP7dQyFxwJ/caCeBy0kkrK
         /EoosOVx/IK4mLB9Lke+4520ItG9sX7OFp+/eIhH3dxp4g26N4Mv3D6r0mXasrT/1dVx
         qe+go+F4ZyH345T3J4J46z7CcXVhTNqKPAghc/M7vja+J4gbCw2CiJ+0+IH4+goZPHA0
         cmpO9zrh7aqTqmfR4rjRhZD55FY85H+bfQWSSZ+MlvE4ARgCTvhuQmo2SZWSkZ5dAEdd
         rTyw==
X-Forwarded-Encrypted: i=1; AJvYcCWg+XDh8Qzf+jDZVHTHxO6ovxoUS1YlEdSWt4NhmexHbGE1DY0ls/DX8c+1HLzGi/Bhsi9fjEzH+eQUXo309yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+iXOrMimzZBe/Mpf6daKiS4Za4DdscdJO6X4ngQZrsAGcwgL
	1XBoua0+fNB+bBkWW+9L/Oe0OQyLncGi+fedUVRKKfrH8rmvEmmLWQhv
X-Gm-Gg: AY/fxX5K0cPuI7C6QRMTzy7ekn2u8Mp+31kCxBfkIjObH6Wl88ak0H46zI0NE9UXcvr
	st2WkkSSwK50SP9XzP93+JU6aDCu+aAgB/3UG6QVC8EJLTmpnfPYx5+wztqdK/MA5GwtWfoKDb3
	0sFNgHAfC+YIIuVZnSB4F8uBzPBn9v6VSRVvVcfGVRgdiTqx7ByiOgjpB4bYAhLr4eo28iOqO9A
	t4m5YgnproulmpGw/lE4c3Pw75oG+KLgjOIONTtxs59yLSUvhHKJEw28Gt/PD/JwS1wilVSljiC
	7mcyBUc0MZ9Y4qRNtKT12Tz1FV4Of9dRTXAuKZVfgCj34cCbxBqtVcZQLl4W4PXHMFxAS27+TKn
	VlNLBMb2qg879cmFxgZ4MfeNwz/oWqGnHZGD+Gh4MB2DaoxWJu69gcuAI+O3kibzdr5etJ+hLHB
	YlZxvyTJulNs0tGkCmilLeEs3aMDuY/aQzMHSzXz07nMJnJByQbjMTy4uL+lA0KXwnhMk=
X-Received: by 2002:a05:620a:1a1d:b0:8c3:9be4:b209 with SMTP id af79cd13be357-8c6a68d8c70mr1274200585a.20.1768793455695;
        Sun, 18 Jan 2026 19:30:55 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:55 -0800 (PST)
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
Subject: [PATCH v4 09/10] dt-bindings: omap: Add Samsung Galaxy Tab 2 10.1
Date: Sun, 18 Jan 2026 22:30:34 -0500
Message-ID: <20260119033035.57538-11-bavishimithil@gmail.com>
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

Add samsung-espresso10 codename for the 10 inch variant

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 Documentation/devicetree/bindings/arm/ti/omap.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documentation/devicetree/bindings/arm/ti/omap.yaml
index d8774c676..f694dcbf2 100644
--- a/Documentation/devicetree/bindings/arm/ti/omap.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
@@ -145,6 +145,7 @@ properties:
               - motorola,xyboard-mz609
               - motorola,xyboard-mz617
               - samsung,espresso7
+              - samsung,espresso10
               - ti,omap4-panda
               - ti,omap4-sdp
           - const: ti,omap4430
-- 
2.43.0

