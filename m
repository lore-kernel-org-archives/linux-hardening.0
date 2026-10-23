Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737585;
	b=2IFEg/mwZOiKNRf8a52fm5CyUflI/j38no3/VAZDDjsjRNLS8M9VKZ5wcE+3ZycJPlQF
	 kVhwREDZEMJwHkQft50P1hUDsJkRhkXbjpDD/8r32j34WnecsyvZrnxjBKGDJdOdfpezB
	 DPp/gznRSfx0pT4k54TXjMUjGUB7NWJTeJaGRiS8A7B74+fUjOGB5vkqEGX6qhhGRl12b
	 lpNKfWI7WYjXSvXubkS/WJ2AKjsvvaP/0PdVR/Z2lo0Ot23ogyAcCTNV/rPk0IOqOZmqW
	 8h+Vn12ZiPio+Kddwn5lBkusJ4z3o5rMCeSGBcEq6ph4IyylEy/ymR5nGD58VWAjekQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=zCs0TMoU/xtdfW2o//Qc3w2kO9KE9uGMF0SrdJknZZc=;
	b=pcVPEy0Sx+1O0mWF+AF8Vtdg0mdgd2kcbb+qdB5OZt99sA5STCHN4At7GpxghYnI6AfY
	 yZBY7wj+op/1+wXPnz6sbRge/+rxoDzmIAuZVPz6gE+r2EG8mzG1wu4Rq8miVK9kt7gzs
	 djctqPlRnvepYmXjf+qJ9kMBbESa3rTf5gGnUqLGu0KhbmWeGJUCxRf1zLza+Ky6jD3iu
	 AyRP0fSLe2mCtabz2A+FDCSAvm3NDG5j2FQZVM2agOQwzuBPzkjvJ83qKB1lHBof59xBp
	 OfgZyBfjDOFUSmJ/5QkQPa2nvqSeIE1+cBP2PgpgK+PPAtp2/jKApTAYaeVmmZXwS9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5gmrOYj;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F228606A324
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 06:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F228606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5gmrOYj
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e00eee27dso280741f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792737584; x=1793342384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCs0TMoU/xtdfW2o//Qc3w2kO9KE9uGMF0SrdJknZZc=;
        b=K5gmrOYj3tl5gpqCrSw9ozcnETPEC4k8tihxf6zDQDJzO6W1ugLAFbGbsv9Cz/MxUB
         quIUfAE6oCPFSLcX8P+JtzAwqC/EvVQVqVldkQtMgEtTOx+hyvg8NvWOS4XYCf7ud8/o
         Gzc0esoT6mvjMChNOgbAm9m7/Zm3rnihd7W0X1kADDuHzZZYih0caal6tQPHJOejfhVK
         K2BbjC/G+1p6cfFAnupiIBsCBTQOgMBNzgIf/8rwbqnvo+qua43tmcZ9lsB9uE0vJbXz
         TBLYu0YNtvQan1lTxqxqkmOEetHMR1uVhpgkfELL7ASKGJziVeEfwDGBOoqAdY7h9Fsl
         950g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737584; x=1793342384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCs0TMoU/xtdfW2o//Qc3w2kO9KE9uGMF0SrdJknZZc=;
        b=OybM1m76gYc1PpnpMuluhIntl12Gr7bCqhFfzU9AAYoVBQegVd/uy6pIrC/zvTZyhR
         UImL4H/VzolMwgcLKqnHc4JcleHTkwaUcchnUSMwqab6w6M1t+b1b/9gi+lbmME4JCsT
         7jdkzpFBU/NbtXp5HTkM3Q/c0ZAyoxIdqlGxjQGE052iL4Fihg8lBpz1IN0RdmGQ2lOe
         kusBl3RywZ5nq8X+5WZ5O8U+pkFFDkiLVszb/mJMc7/cV6+Vn8g4nLTtWaerkutsrnhm
         r0fOTsvH9s9sZMZkWBXjikGWsX2MNhbc5kcaSbQ/FvzwmpFIf5TOpJgYkTitCFX0xRFm
         KtfQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1jANt8LX52vKzh++S0Hx1+EtcsO9+RIFTD/pWUHzSTX+kzS980agFp0nIWF1+IHUmW8zYzGE8ijvaLEgsQ7k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOrRJOQOgGt0GsgJOjVdhmKImIIIdPF37ZhAQnN2zem9ir9yFg
	fb3yM1zmw88BWUFBdd9Ztkk8gateCM1D/lZL3MbPbSsiNsPav9ihMqT4vvY/GBL71QQ=
X-Gm-Gg: AYBFou1RRoUQV2qYsg3A/zFwIs9R3IrJE9gKGBvb7E+H33GP8th6xBFwM7/BD0QhQwk
	XXhbQSf+k4svssR2OENHMAAm2fRBvm2grDOeYtU7WGpXBT9aQ5PIZyQe7uBXcjUMTohdXsuqW8j
	ZLGePGf6NY1JZCqZjzOBJPyMIdwFtoVFKugX0KkhvHQ7C6tBYozzDXskQDvKKUYGZOuf0rRhiG4
	sFeaqArW95Lhrw5pne+31sbucEbv3l8VtzwZVWuYG96eEFn9Yfa5vloKxJFCgP4lLvfLuKpCCkK
	v7kXgbptOIu94paCt7bul4pXpgzR28p2pu3y3/CKlxThOet/kyEMtIcaWGdu0Jhpo/K3crntgGy
	jaote9B4qlS3bdCEFw+Gfy2NMcv5NQC7r/lF4DtvOAGWRaNTYZJoUvJqTrXjPVZdPKy9sUCDCkX
	NJyIW/ALJqtmL0flxJhIT97Ia3OdRG4P4NIlrpoBJbpC7BjHtRGObKbihzqkmxj5E/pslQnvoWS
	LqgxRkNS7nN28bfwJMXDZJoYf3mwmmhodDwkeh73sau920wlod0vFmymZ48mdzPSj+4Y0PwleTm
	05kmysPOWtW0KcAZ9FzukvNzEWjBVLKDGCXszQizeoxeaavUeJg3GxTJFr+qhGMG7/OJg9PDavu
	lUNg=
X-Received: by 2002:a05:6000:15d9:b0:48d:ff0d:cfa5 with SMTP id ffacd0b85a97d-48e385b9322mr977703f8f.47.1792737583628;
        Thu, 22 Oct 2026 23:39:43 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz. [46.135.49.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:39:42 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:27 +0200
Subject: [PATCH v3 02/16] dt-bindings: remoteproc: k3-dsp: Allow a second
 sub-mailbox
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
Message-Id: <20261023-thames-v3-2-3ab40aa17157@tomeuvizoso.net>
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

Allow specifying a second sub-mailbox that could be used by the firmware
in addition to the first one, which is taken by remoteproc.

This is required by firmware that doesn't use rpmsg for their
communication with the Linux kernel.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

---

v3:
- Initial version
---
 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml        | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index 278b88b7f906..d6319c8e96f8 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -51,10 +51,12 @@ properties:
 
   mboxes:
     description: |
-      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
-      communication with the remote processor. This property should match
-      with the sub-mailbox node used in the firmware image.
-    maxItems: 1
+      OMAP Mailbox specifiers denoting the sub-mailboxes allotted to
+      communication with the remote processor. The first is the one the
+      remoteproc core uses and should match the sub-mailbox node used in the
+      firmware image. The second is optional.
+    minItems: 1
+    maxItems: 2
 
   memory-region:
     minItems: 2

-- 
2.54.0

