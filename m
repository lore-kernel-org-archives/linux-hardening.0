Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737582;
	b=fNungGHWkZdjZL/Ihb1EOBJrcpRExbb4cqqR1oYiUqEy0/U/esaiTnmlESN+eDwuSEkH
	 E5/eiKSMCkv7vR+GhqezXpbgjHq9pU4I0BBL+a8QR6OtjTJILL2iyp9+c6PZ9EgjzaWfD
	 NQ90vy+YtQrwMKdmr2bxwj2bAxP/VaRxyPZ+YfWqGn4cPHuRIY5Vmz1DAweAtfH20Vebb
	 uCaDvdzyCvUj3XK6Z5quy/yeJ1R8pbBjJbANV+MqF5wbiLuecXqTOCCDcITv+Wc6rNf57
	 hArIkSXO0gCPx8jH0Ay89UavCBWwW5bTpc4DwwX2poYZLx9Z9FlFZXJJrmO7XkFeVkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=e9iXPCmoOhpVXWg91psYHS0PCZjsptq0x3nugAHkv9M=;
	b=hmGEAdUpsODl1ZEPKjCRNYq/JQyLz+z39NrhlgQSTI83HCCQVod1Iyr6At9UPMcrIJtl
	 zfKsIUWlivYudZsWavmJYI9wKYa3UvBwI4ywkzeJ1c9sVuTrf5xfKJ1mdK7NLPL6s3gws
	 7UyuBFCUvxeLKVHGsu6Cu4D7I1uLfpA/R1qmvR+xXsQyz5qlQOYlhzT8IhcuEqW76nrhY
	 Ahy8vrTXNWD23NmcTmOdt+YmLdDdNQ+fLBzCV8Ae+4ZFmww2naTu9chmrKpe3ybvBF1LZ
	 VYSrvOvoRRigIH8MVghJJyVvcQ6W4aOCqjhcOgdBt+KUt6NJOGCP7fqNx2Y0ivgNzYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UQBmNYbY;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D26606A33C
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 06:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D26606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UQBmNYbY
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso5493285e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 23:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792737580; x=1793342380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9iXPCmoOhpVXWg91psYHS0PCZjsptq0x3nugAHkv9M=;
        b=UQBmNYbYzunSxlqefzQwlfzStDGIZ+9O+P4YzFq567SYqEcPNcMq8eNnih7hPjpmBr
         L8WJT1AH4QjhoiQQMwDxZpUja1QV5Z9Ndg3UInkU3QqkE0YIp5iop6LEpyVEeZg4/YBl
         tXWfus1Qe7w0Sl4ZfuPeTnaMSaaqm+V6iO9niRnGMaxDhAClo/ysPfkoj5EZTd4LVDWa
         4gnW+muQvuA7dEkA0uG5vZtwvTfZqtrmbYW44dkV+3KdX/fyWsQlPG42WUq0sMmn6Zsn
         hDCsNHwA+T+Sd8M84FGeOgCphhp32Qe7uNCO/Tggh7L4eqFsqZvaJvekyhQhS0RrFsL6
         t3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737580; x=1793342380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9iXPCmoOhpVXWg91psYHS0PCZjsptq0x3nugAHkv9M=;
        b=I4q9mwYl14TRg9vIF2hVf3lqIDn+nlM0Xlv5DImD8zBkmHMS2IE2KmpVSgKS48aq14
         6n8iFKPiYkwxgFRGlWXD65Ab7x0aMydjpwnAuKbnx8YvxXLft7y35Cz7DRlt3kj9z1HS
         SBHvlF5Ze6iH3vyuAVMQReIzD96soG1942dcc3g68H0frz/ldWZdrvkDALZGvuC8FIKF
         5QlukPnhUrO34KK+AFG1iSZCtm8qiuIDf4eCJ7S0H8m1eMLFk4TsS9edmo7l0rGp4Oow
         cWqwcc7S9u3vOksQcP6DDsf9MJ/nTPy87ZILAncOCHpfpa04H+fhaimbeT/51dThSrCR
         YgAg==
X-Forwarded-Encrypted: i=1; AKwUvBzmpKHRuIWlu4MFVi4Bsc0OYmEJle9+a2KmjjvuK9pNfmX0pAg6QtqzWdJs68ThUmJ5IS2KqTpzehLh1tlJdCo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWWjnrL4bhqKhAbl+e1qxw1Nd1Bw1VXvv3NI7gop+Dk/YQHaII
	05Q1PojjogKsul8bDtLEZG4EJ2KhuJGoDrMTuDaxgsgnbaD16ktkCpRCOyzBZl64w04=
X-Gm-Gg: AYBFou0M1dsnhlq55bUwouLccHGmXKthjioKbECRvhYdZKGIiFiQaQXrnVg/dzXziMS
	5thrfObrZBYQihRnMVDy7K9UL2xY0S3C1s8Pq0hjn59xmh2Pqj/DO2YJD+HO51SYOE+VMfm0d6T
	/lioEESxYNwuM0uDLjKnA5K0T51irUEqWt9UK3SKFkxqQ8uDk0iP+b1XPLZErjWYelANwZGFDFs
	T/NvD7VMSSs4xZq+frYVMVXwImOaEcVQgMJwnq4DPlTSjOk8O6Lw7xkw3hoaK1GuSYMCe8pcBwG
	WeszQZ6tQttcEKlE/g51J8qyrD4H+FhG4KjHeUvM72vp4nV2wbB+4nJxwCH03GY+XrFmIfvgZYK
	0IYUDuG5No5iHqVZO8j3e7D5Zn1iDgwtTKzZ9SWVnqmhvaGdnGQMcPuZmS/J+3wlzGL2AFyKN42
	pO2DnpexQX2IX9D8mZsC4IcnBxYJ91oj3/oAmZhqEQAEAgejp6UmN1GjW2SP/uM75gLTrFwx5PF
	QJ6VXbnO4oP5WR8+1y+aoEJH62X/WONewIEFkTG2OCSIpg/hh5exN/lZ6NP/eN+hgWMpcBAvcNk
	kenLhOE+25C/bArRUtDG92MJOe2kCBo9weDli1i05bPlEcu+kK0Uu9I9m+8xalGtpQuo/iVgThC
	owIc=
X-Received: by 2002:a05:600c:a46:b0:4a1:db17:c7e6 with SMTP id 5b1f17b1804b1-4a211c50e30mr19135615e9.2.1792737580211;
        Thu, 22 Oct 2026 23:39:40 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz. [46.135.49.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:39:39 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:26 +0200
Subject: [PATCH v3 01/16] dt-bindings: remoteproc: k3-dsp: Add the L2
 auxiliary and DRU regions
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-1-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2

Besides the existing L2 SRAM region, at least some C7x DSPs in K3 SoCs
have an additional region called in the documentation "AUX L2 SRAM".
This is just some more SRAM that is accessed separately.

Also add the memory region for the control registers of the DRU (Data
Routing Unit), which allow starting DMA transactions and polling for
their completion.

The two entries are optional, so existing device trees still validate,
and are allowed only for the ti,am62a-c7xv-dsp compatible, the C7x
generation that has them.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

---

v3:
- Initial version
---
 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index 8b1ed384ef22..278b88b7f906 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -122,11 +122,17 @@ allOf:
     then:
       properties:
         reg:
+          minItems: 1
           items:
             - description: Address and Size of the L2 SRAM internal memory region
+            - description: Address and Size of the auxiliary L2 SRAM aperture
+            - description: Address and Size of the DRU real-time register page
         reg-names:
+          minItems: 1
           items:
             - const: l2sram
+            - const: l2aux
+            - const: dru
 
   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
 

-- 
2.54.0

