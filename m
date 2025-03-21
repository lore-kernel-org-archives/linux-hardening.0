Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618061E5739
	for <linux-hardening@vger.kernel.org>; Fri, 21 Mar 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527600; cv=none; b=LSe0R+5yqxs/fovuyFG6vvun7QfuTLcy4cFD+aPXLHgrAJZafnYD3gxc30cNKT3NEGpzye4FRICSofnVjkI9eLfVGYBj8yoOMq02+U/dWL16VDIqb/XBGrtE3SseACY5jZWDqQ0DsTIsnuSQ5g71umAbM5jzUcf2zhZCHFFMWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527600; c=relaxed/simple;
	bh=9sel/TGeOHPtzGs+DixKN/Yb9nNk82f1qhbomy1ogYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKlCSTCfzIGr1x1xDFtoe1eu32ceqFa/CbW7mss5MctTyJd8OEpEyF4o54wGsDkzynk2lVokByLAKjc+awrv0YB5zog4qjs7mi3MTk3mZytbEFWd06MJPG8BjD4li2OA1vJ/9BRTB3KxNqfiFRiTI7qUbXTceZaaSJcbvqAuxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Oa2qWL4w; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oa2qWL4w"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e78378051aso279749a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 20 Mar 2025 20:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742527594; x=1743132394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ9H8QEyhvsXOExXNy9mh7yGjSUNG99AQ7uN7DVOsts=;
        b=Oa2qWL4w5KZGDu5n01O41VMTddhVeNA6B4wVGCTW5eLYHjjBBxLXg6JJA99m1sJ2qw
         6J49NWt1uz3varfwF3Uu8HW+gHXjU3gEt5jgolx59o59teK4KTver9CJJjRkMsDITly8
         BAIBnGDd+iHTWGVi+c4/NS5OgsgAKof4roQy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742527594; x=1743132394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ9H8QEyhvsXOExXNy9mh7yGjSUNG99AQ7uN7DVOsts=;
        b=HGMpjQ9cz7epQijN/deynOBSYHHEON0HxnDTp2bHt4zR4U0X2z9g60SWyXFr+QMIsn
         AxZH7U1QCj0zxRO0tIhuqsUZg1at43og7Bjr1/O1tkBxURvkVmalBIanynABDoZcDTo5
         1yetpsoPONnQ7QwGqLlLB6JEGaThyqszoF67Tk2uD687cGtSxqtvf+2OxwZwsYPFaUxr
         JNVrIyPzj67Ur6gPfdvEijbONbgbn5plrnPHlSd5L/zrpikqnngjRb16pN5oz7jJxt4U
         NL1olQVR1dj3pYrSbkkUUHrSvXRh6yd6/rtRo/RGEhZSXxG0OMNkWUHqMya1yzaehKqT
         qg3w==
X-Forwarded-Encrypted: i=1; AJvYcCUpr8/fpF3ltMUQGKKTPrQtc23acSKEzB79y+dgzGdVvAC/34nCTn71CaMaoMgvTgg3sUpW4IwwlMq+L/JjoHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ghKaQy2nG+wwW7o/6IwztyP3ElY3esR0XrZ2CsJoo5OoFk1Y
	kVg8W8/WneOCbt04IFLfXtwM4VanXxRpHC6kLNtUvbh+CxZiZ1PKizYCe8JwPA==
X-Gm-Gg: ASbGncsbGwbfWxXW0BAtRtAILryJpdiRWp7bQAFOgfHJTTxeEk02L01TGo4NpQ3jurb
	9TYOSrqs+5Mygp8YNZHr52bEFz4HPQD+7JQ2/MsnHf3EHBlHmqOss80GFh7SmQKa3YtfPd7CRFD
	0qPjxEp7g5EdG+mFn6ToHDpu6+cRkJcqAMNIAL706hFQHpUmsbaYreiQH+KeoWXe16p3j2ZxojB
	y+QJo57bpaz4J7yUba8jkYsGLH0L7CRn5alRut41jZr5iQnN+U8i3VBhB9IJsbHlR3f+NujdaRX
	zPFznl+yqmlGJExQNMvxEvLd74bMixOR9x9rnDnRTTJtb8PoWJkGR8C5ltmUuMfbAtk6lHWa7ei
	V
X-Google-Smtp-Source: AGHT+IHEiM4USR8v0yKc9mvlnlKTy1FjH278fWhQq4k3JCHnkCEvuH56Kwg39a1beQcxRMNG/fRxMg==
X-Received: by 2002:a17:907:d84c:b0:ac3:bd68:24f1 with SMTP id a640c23a62f3a-ac3f24cddfbmr63031866b.8.1742527594590;
        Thu, 20 Mar 2025 20:26:34 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3f24sm68463366b.57.2025.03.20.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 20:26:34 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org
Cc: Liam.Howlett@oracle.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	borntraeger@linux.ibm.com,
	edumazet@google.com,
	geert@linux-m68k.org,
	gor@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	hca@linux.ibm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	m-malladi@ti.com,
	svens@linux.ibm.com,
	thomas.weissschuh@linutronix.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v2 1/1] mseal sysmap: add arch-support txt
Date: Fri, 21 Mar 2025 03:26:27 +0000
Message-ID: <20250321032627.4147562-2-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250321032627.4147562-1-jeffxu@google.com>
References: <20250321032627.4147562-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add Documentation/features/core/mseal_sys_mappings/arch-support.txt

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../core/mseal_sys_mappings/arch-support.txt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/features/core/mseal_sys_mappings/arch-support.txt

diff --git a/Documentation/features/core/mseal_sys_mappings/arch-support.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
new file mode 100644
index 000000000000..433c71a2d007
--- /dev/null
+++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
@@ -0,0 +1,30 @@
+#
+# Feature name:          mseal-system-mappings
+#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+#         description:   arch supports mseal system mappings
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: |  N/A |
+    |       arm64: |  ok  |
+    |        csky: | TODO |
+    |     hexagon: |  N/A |
+    |   loongarch: | TODO |
+    |        m68k: | TODO |
+    |  microblaze: |  N/A |
+    |        mips: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: |  N/A |
+    |      parisc: | TODO |
+    |     powerpc: | TODO |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
+    |          sh: |  N/A |
+    |       sparc: | TODO |
+    |          um: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
-- 
2.49.0.395.g12beb8f557-goog

