Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737620;
	b=MrsHIBJux2SQy92xEMYdR62VGWEvcAlhmL9b/4KpcR4MwUN7ctnicad+TuduSfvHA4Dv
	 9rsrHnBuxjAOQNDeTfIhM4P9ipy2qLjixT4YQoIlWWJzMU4NIPmszG5QF43I89JnVgl0l
	 jfwkaiYgfTgCeUasz0PZ3pCx43TzqhQ+NEiBCuI1tOLI2uzIdo6nx6V/5hNH6ejohqLdw
	 eiM1hISVefmdKMPKwTapqG0VqylqGVzfN0asMaxIdocudE5WWLv/lSmuWdKTn7ceDWwVX
	 KRXO5LfAg+NN6IgG04w8WYzM55v/dMMDaCYNsH0qw02qlUJ7/ZdbzMx8D81ARaKTbHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=nI3N8MrEeubTFBg+n+hiFqxjlTWdSSoRNoSmz7N6G04=;
	b=KllQqUmuu8/UhJVdj+4ruv6HobQch+WuiSjg1OFos7doR6PPnnLqjMQeUrWgyTNPb5yb
	 WGZ7qypolue/Bnh9PEP+4mr2BrGtcvjq1eqdmsG2G4AitKIoAi5+KPqzJgjbn7kD7wwQ/
	 uv/Uws7eu0ltAftukR8d29tK4cWUQN23jjeuxyF/RXIYaKvAmaEF4XIJ3XlcwJ8+GI8/T
	 sd3Ur2njMtkOzds7POT+7ITN2QsYjJYlG01o5gJzG8ckMidDKETIKEhrOAIz7ukSVOHyZ
	 8mSzRM7Lms7CwiU6sZK/VE9S28lNjqlvOK9ZOwsVUYi8DJXXMlz7fYhSjgebU3Bbt5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SqmkXSH8;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098C60A262E
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 06:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2098C60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SqmkXSH8
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso360024f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792737618; x=1793342418; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nI3N8MrEeubTFBg+n+hiFqxjlTWdSSoRNoSmz7N6G04=;
        b=SqmkXSH8V0CB7ATc9I8tjUfkkCmOXF6C/WDLEmPmui2vK93TYLJUor4xUni2xt8+h7
         9KGtee5fntj/3j97ygSJ8Cla/Tf2sOjXTnjSqT9ZKgzBk4ir8Sf+cFka2TPOd0y9JA23
         mkfbnoBd3Zg56D1HdGiUbAxpCwiRpp4Z/RNWWn/txCoCwDvJIeQjmJiCpmzGyEp4UcGX
         1gm/zvm/ERPgwugV5P0pwVB9e/i2JBkP2FCi8QXvhOVnE1W1owPe2iBPJauG1jks0/IT
         /xYvs+rQfruj2Z0BXBQiiJ3dNNH1DAdRRoD4zl/dkftaQcFmnuMagmd0QcOBLgbfrUgh
         5QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737618; x=1793342418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nI3N8MrEeubTFBg+n+hiFqxjlTWdSSoRNoSmz7N6G04=;
        b=ubq/bRZtLiURvBPPKvtRmZCw/axrfiSGynwG/VVC6rkasQx1po7kvBbGcsZqBv+BzN
         Se4IAG40xXvBLY0E0/9rVomzFEwB1IftRAq0ng2uTmkJ97SLbKbRq1quIBh1p2xAZbbq
         NGCiP05RwPv1TmWl3ZDgNB9OEiW/AhnPmF68nTVEzMu6qwcJMhwEBO73FrpDqoI/jjpE
         PPDT5qiwoASGWxNqvvqAOEdMGYbgtA4PQLwy3hbuXLEtTxE4/cjskQ5Q9OMS8cccA7gj
         n8KC1PpRZnG42cf2Ua69aBaI619YmlvLtIqEy0EWxCnYx2NWEdXNdzQ6bxmZPhKzD2tL
         GDZg==
X-Forwarded-Encrypted: i=1; AKwUvBz3V0ZJRQLFG+GJXmyyCiaGW5zMbTvoXIjOE3K8iS0mzQJcKPY6G3b4UyLZjA99X+VVCCURcMexdSSEliMGJ9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPHQgFfZS+suc2yUmFpkh9YuXJZRcSZVGWW1gTswE3bJF9R32n
	waM61pJ1i9Prf5Mn2371uQ154NlzPAAbIHCXiAV400YiKIqbGDC4/WleVm3sWIFMDVU=
X-Gm-Gg: AYBFou3rydXXJuYrhX3SLf6u+V/3hilWJ8FzY5hyTlDfE3tpzPThBBgnQzC1AczsEGe
	lxv4eZA0EQSa68tHGKvQG82ymP31is9z4gwlmWBv8hDunLc5AX0VXjsoxdJYIc+0kpUunk6PCer
	Z0ecdlOvKPRUvPp78+dSku0pAK9iW1KjaQUuSfrcMPpFZP7s1UWKIR/dyZiSpOuYdeDdCacPD6j
	abvoMOT2IBvjx/v8ZzfX1sQ3c1Mz/MSyNkiBTjweL3IOzQKpbtcsfsIUDME1qmA2MdEH5z73eQ3
	r4Xo597R1atCQftOzKICKEWKSklXsvLe1Ae3yPcjCEQyVID3v1hVbidZSg8k5uFsKtj9VaXVeQC
	DPyVKUlhssRMphfihbwxvjZCeYBjPgnA5fQmWUQ5tI0+5VPA0CvI33QqN5JK3wF5sIhKLYTls77
	lN8omfoZjGr2iJ/jbEOADEEsilIQ1yV3tOh2h5qBTWYi3hFe0pOyqx0iCE1A+YXeHD6hNOh2kgM
	254ydJvwDAlWA/erXjMCqqkmI5mSQUdYnEqvDwlHOT5HPCjsW5DMZhjAZLC7uBSj4J8ImRF4aGu
	mCCJZDwzGk/sNZPWZTRSvVBMCtDDgrWjP8GnChrXWtl2u3MO2WgU6EkJB3UIYmbq3+FUGEImb33
	JzYA=
X-Received: by 2002:a05:6000:258a:b0:48d:fdc0:7086 with SMTP id ffacd0b85a97d-48e3859a817mr1823119f8f.22.1792737618388;
        Thu, 22 Oct 2026 23:40:18 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz. [46.135.49.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:40:17 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:38 +0200
Subject: [PATCH v3 13/16] Documentation: accel/thames: Add initial docs
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
Message-Id: <20261023-thames-v3-13-3ab40aa17157@tomeuvizoso.net>
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

With pointers to the other components and how users can make use of it.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 Documentation/accel/index.rst        |  1 +
 Documentation/accel/thames/index.rst | 47 ++++++++++++++++++++++++++++++++++++
 MAINTAINERS                          |  1 +
 3 files changed, 49 insertions(+)

diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.rst
index cbc7d4c3876a..eb115413db07 100644
--- a/Documentation/accel/index.rst
+++ b/Documentation/accel/index.rst
@@ -11,3 +11,4 @@ Compute Accelerators
    amdxdna/index
    qaic/index
    rocket/index
+   thames/index
diff --git a/Documentation/accel/thames/index.rst b/Documentation/accel/thames/index.rst
new file mode 100644
index 000000000000..6382ff2369be
--- /dev/null
+++ b/Documentation/accel/thames/index.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+============================================================
+ accel/thames Driver for the C7x DSPs from Texas Instruments
+============================================================
+
+The accel/thames driver supports the C7x DSP cores of the Texas Instruments
+J722S as compute accelerators, for workloads such as machine learning
+inference.
+
+Each core runs a firmware that remoteproc (Documentation/staging/remoteproc.rst)
+loads;
+the driver attaches to a core remoteproc has booted, boots one left offline, and
+resets a core through it after a fault or a timeout.  The firmware's source is
+at https://gitlab.freedesktop.org/tomeu/thames-firmware/.
+
+The driver and the firmware of a core share a block of memory reserved in the
+device tree.  It holds the core's Ring, the queue of submitted Jobs in the
+order the core runs them, and its Fence, the sequence number the firmware
+writes as each Job completes.  The driver adds an entry to the Ring and rings a
+mailbox doorbell; the firmware rings one back when the Fence moves.
+
+Each file that opens the device gets a Context: a page table the core switches
+to while it runs the Context's Jobs, so the buffers of one client are isolated
+from the others'.  A buffer is created without a mapping and bound into the
+Context at a DSP address the client chooses.
+
+A Job is created once from a program, its parameters and the transfers the
+core's DMA unit performs around it, and is checked then.  It can then be
+submitted any number of times, in arrays of Jobs that run in order and signal
+sync objects when they finish; the call waits on no sync object, the fences of
+the listed buffers order the work.  The drm-gpu-scheduler spreads the
+submissions over the cores.  A Job that faults leaves a fault record, which
+userspace reads with a query; the capability query returns the sizes and
+addresses userspace compiles against.
+
+Everything else is done in userspace, as a Gallium driver (also called thames)
+that is part of the Mesa3D project: https://docs.mesa3d.org/teflon.html
+
+The interface is described in ``include/uapi/drm/thames_accel.h``.
+
+.. kernel-doc:: include/uapi/drm/thames_accel.h
+   :doc: Terms
+
+Hardware currently supported:
+
+* J722S
diff --git a/MAINTAINERS b/MAINTAINERS
index c63ab2d77b01..dce817531184 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8024,6 +8024,7 @@ M:	Tomeu Vizoso <tomeu@tomeuvizoso.net>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/accel/thames/
 F:	drivers/accel/thames/
 F:	include/uapi/drm/thames_accel.h
 

-- 
2.54.0

