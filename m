Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737588;
	b=Prkf5Azj3MLfZyd3meL1/RAeaYRFXbYwtvZbpUn0hVSg1kvHr1VTjbIBfy+/O4el4iiQ
	 VSPWnahWtqFa1XVrR9woaAJtVVfAfQOwpr4ARtZ01SRv5C741LoZEiGt27WUCHvk7p8XZ
	 A7Z9cOHjydKgb2ThFapY/6aDmH0kT7pqc4rBc6usUZeiCEhb0yyUphUB64PjQbFDpM1Vp
	 8GtG5kJis3bNltFKJ9hccfeMGV64E3UMbfG5zX/3xWkR0AtYAogkRF8YUKhGVroqtX3CW
	 M7fylUVjO262UEOyXmmVHFl1oihcL5LMkp7i9ISW5ohw4+OSnSvoimWIVjv1r2rfRUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=zM6qRbp5A9CbBlh2Bu/tmcTR/0lPEgQHJG0kewWnWN4=;
	b=ePFUcGcp90Hd4FMObMqi875jSMivsX2YczJC119Iad1Ze8W8OMiY+DJDO4rTiJBFR0yE
	 o1TraQUcN14FDGXEUhIbn9x3FUXRPtg4fcLfISDukXxtyq4RwiTrnCbU9bSGLW9qNF6eN
	 yulwgu/qgb1qIo49LCOsbYNdvMaFRSvZmVmenDFs/qiftg9pcFKSWHpZGB8FO0VrNXmqh
	 zF9h09jKkHjQxZph0X7EhuR07xgRO5xBX5DL1BVn/6Cp1eJajTRPFReIUTyVwCcwPkj7Z
	 7fIXzXoe4SVM8G8eGeYH/tMLKbRGT5HRdAMvligno0OxR5J2xgedWByDEOzf+pzOl3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dTYQCezJ;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68C606A329
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 06:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B68C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dTYQCezJ
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df54150dfso228065f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 23:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792737587; x=1793342387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zM6qRbp5A9CbBlh2Bu/tmcTR/0lPEgQHJG0kewWnWN4=;
        b=dTYQCezJmgcg9GGfQwV8y0d2iLfg6yCWGHqDKMyjsr8yZxOhyUsBMSf/ZNFgwODWF7
         Ca65GerJrzoQMUWzaApQ6FsH021ecFKPP84Vo4xTo6/rpTav2Td2W5SPBRlg3hXGl1px
         xP9Z4zO5uXlxiArcnHL2bAJmJPkPMjMl648DPWqdP90u701pWOiEyM5G/1muxUzPFpq2
         GELahv1hSqryhdLHy5UgrSQvCjuip2O+DMxqQdyrDLqCzm8Xny5XxFUUYZp9tLCW119v
         aS17giMu5xehA1z1L3jBEqcI0NZSj+ukea/DASddTVYuvZWF7/0CR1CzHU/29htSAxpq
         Vazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737587; x=1793342387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zM6qRbp5A9CbBlh2Bu/tmcTR/0lPEgQHJG0kewWnWN4=;
        b=odXemfio46o+fzPXBPwvZoeeFIVCUIcD83ZEqiC2rxAU2qQ547WSmLDe4FyXZqlcRt
         iWgMr1WO/zf0tKIKSRZlCyTeaJpAHxrSMEPD35kX6T0Gl1VYskJ0b1W8qz0ou3f5HELN
         jyhnK7q36Em1n4zn24a4qv9Em63jS5JRS78kzP0zcJB8Lc4HNiBsi9Vc4K2mk9qLTq9W
         E79kTV28dh54yFDzBbsMtzDMJ+oNVghnn+ZxYqLfEafiqO+Ldni8VM9AwFGqKESBNkJb
         VmCvTGq5wLyaogKt2OjNGExtYd6hDxoym2EvmIO8maGvKNmqeUrSAbqMhekGSmUREL09
         hI4A==
X-Forwarded-Encrypted: i=1; AKwUvBzktAj+gt+zggYyAJ8BCvd65AELhcDsZ1ZN8vD62J9YhsyDu6fzkpsGW5GIjghUufKbs0t7j7lDUCMVxb1F/TE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeXRWZzUdh9B1ngjF0c886jxxSMataJYbEnwOJX+xQwEzq0S0f
	263dChlmcS9BJNnsP/NC6K0isnzwXi1vgEUE9ZXvH6lUy3C+PK8y0hx8eYYBWoG0ZKQ=
X-Gm-Gg: AYBFou3V3QpUOPjws5p22nTrWE5rrBJfz3sa9Rk/4eUY0GsUQpNDOHoh0MI5n3Jwusx
	V77pQCxIhrFVGG8Cn0sPwaflndMudiFPbxuDPpbUKYYMs+6oNol2ShK26rHyAOZZoor1Qe6CQla
	6m6VR7uSfiS1tQ/OwxJ+XdFIn9v70WcKWbQndv4amwy3Mk+72RQ+ulZ1C0ai5TvfdWd3oPkP3AD
	rkaTLMc+hLMCA40QZrYvRRhiB0OGuAwqThGHiQUWJHchEtH/sWv5Rt3mTWR8WQB+vzu/JjKxbNE
	yoS7S+7hgxFjwEjB6NaJnwdTzrFkQqXYLGnoPWNfcarX70fhKpmPW2+OGvrnM4xpmJ4qAKSgRkS
	cQ6WY7aLC1nIK/dO/tQnmdkrViHbfS4ja0qWv51d1P3xlrTt7IazEj3QTuB35WNo6VleuSug4R8
	LoEPrIza3LiYxw3X7kmmh73sTtWus2d2G/C/lPqDubG0DC2g1GBFw7GIaumQ0LG8TkxZpKTP5Zo
	0VKc8ziD36AecN+mDK6Fx2/l96Ah00wpaDHVkMjvxPfeJu/7wsQx/sxwMQW/KtCQnbv2ppARPyg
	09SjTi/fRlRhrKOISNJUpiiQyhJejH7n5lB05vA4Ai+1+uUlAYPwQPmJwzx4Z8S1tA7F3t7QTIL
	nvGc=
X-Received: by 2002:a05:6000:41c9:b0:48e:dee:52bc with SMTP id ffacd0b85a97d-48e384e4205mr1725429f8f.0.1792737586551;
        Thu, 22 Oct 2026 23:39:46 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz. [46.135.49.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:39:45 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:28 +0200
Subject: [PATCH v3 03/16] dt-bindings: remoteproc: k3-dsp: Allow
 referencing the timers' power domains
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
Message-Id: <20261023-thames-v3-3-3ab40aa17157@tomeuvizoso.net>
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

A firmware may drive the core's timers, which need their power domains
held; the remoteproc driver does not hold them, so let the DSP node
reference them for a driver that attaches to the running core to hold.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

---

v3:
- Initial version
---
 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index d6319c8e96f8..80eaef0a19b8 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -76,6 +76,23 @@ properties:
 # Optional properties:
 # --------------------
 
+  power-domains:
+    description: |
+      Power domains of the SoC timers the running firmware ticks on and
+      times its work out with. The firmware programs these timers itself
+      and makes no power request for them, and the timers' own nodes are
+      reserved for it, so nothing else requests their power; a client
+      driver of the firmware holds them on while it drives the processor.
+      The processor's own power is managed through ti,sci-dev-id, not here.
+    items:
+      - description: power domain of the first timer
+      - description: power domain of the second timer
+
+  power-domain-names:
+    items:
+      - const: timer1
+      - const: timer2
+
   sram:
     minItems: 1
     maxItems: 4

-- 
2.54.0

