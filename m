Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1C173
	for <linux-hardening@vger.kernel.org>; Thu, 13 Mar 2025 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741824395; cv=none; b=h3oYZ7exNAlpLavLtq/4XTp4y3CAiCcZad3yQ0M3AULxfnDUwFgp5rQxuhDrj5NbHfY2+GZo+OgfouWIZNPEIPDE5k4FLifDJyA1XMi0d9oQ0gic5d39PTLF2TUrKl6/P7LqzyfDavsa+YN6EFvevvOmYnd7nEo9mTZzV4lwLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741824395; c=relaxed/simple;
	bh=23GDT0Rk8r3jrPpap9e9b1IjBBxLwjDYfdQD/VF0D2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbwp2T0ZG9tjuMaZEBUh552RCW8dAiwyp95tRh8Jp21izuiOzSafDXklHX45gy5pH0O1qVrWfp/XshU0ev+Ylqe/j6YwvgUfWUPM16mjp9UJALEkYjuTN9BSRajgWjIyp6T8SHY407rK/jt1aTxikASAJc5eB+93m+UyZCCifXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mkHn3aH3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mkHn3aH3"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5b736b3fcso50838a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741824392; x=1742429192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTBXSAZcTlB0kyn5reMeVRSItQEZmzd639cfqrTnQ5g=;
        b=mkHn3aH3M2uC5/LU/AWh63mq41v8aULFRTIVrLUTUEToY/ze5BbQ9FEDQoMBFHjpUZ
         rEep7UJNXq4Jx7VpmKxPxw4HsWZrl59n1gicz4mdWuprgLTsib/L+0UOpTlSMj9j3onY
         FpYkUdId5fIiIbe4o/QUG91/C39BRcSazrFH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741824392; x=1742429192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTBXSAZcTlB0kyn5reMeVRSItQEZmzd639cfqrTnQ5g=;
        b=XnKrQfqHn+yPFur01bV+KOlNJ5SAD9HvOpb7DPI266qY2fZlOnGONp3w4/EQR5ekCY
         2UA9Yp0tebRqRucovAfL0oBwBu//I9Cr8tL2dnuf3st7QY8dIzZPsCAJG//K8B2anFn/
         WRUTN5wtrnlqFoqGe+LI9ea2x3VIDt6lVjX7XZ6PcleOUfsgnp8qIj9NN4PAa6csy9/B
         z3/ZSMqg7pN0YoH1CEqIp5FW3n3tbjcKc+EXNVVJ6g9vQyHsGURCT4aORuIjSqyKVrA8
         v/FzBed/XZSyj7zCiPbfUrqVD1ij3CeyJpRwKAydnHjzUcwGDAnBRB1ZOa7XiX7d0iBc
         eXaw==
X-Forwarded-Encrypted: i=1; AJvYcCV77Wc2YkNS/IVsVsES9T3X6epFx91v6KKg8opHR9YRdrt4QWAgQQm9uAXfqZRnDHOC9Lu6BvZyuNtbz2I3K8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMPTmTLuwAjXfOGP8OXeE+oEqH/Q/gRZTjlm1GpjzV0sVNlNi
	NZjTxM014BGvaHfUc3yRxos/qYxw1Bzx20MwtraCwaCPvJ79UsO0cbI4oWLQaw==
X-Gm-Gg: ASbGnctqdcN0FkPS/aRwg0E9RU5bnevZU/8hho5JZj4cy5dxFtdY8Fpx9gEM1d5GqCk
	DYGh1vZY7IhYqHNU/fbILthIGcUbU2f2SUKvNx56o8IIgyEvzwuytfny1xn45AtCQbRyPRXBJZg
	YBxhzU6jJNWo2e7oD46ctmrqzTrSwummLlPJSiLMOrL+kdXfAZNJpTFw/IE7QnyltyS1+BQofYD
	8HDYahsLXLSkLnbmG+p8NXFfBEFzINvPZw9is6t86bdh4hEpqftixnQzlXtIGEl+xyzHWoY7r4b
	Z6Wnigmp8TAP0qlUIJxQ/WJdm46vZoRxx7+EvD927E8mdtVI5R8KA6URv5t7CnisQWq4XqjsT4k
	M
X-Google-Smtp-Source: AGHT+IF2hsLGbRFexw4cBQVMbT4+nYhN0RM3ql6SWU6N3Q/kqXvpffne9qXzzhEiJHBV/0VVycU7Sw==
X-Received: by 2002:a17:907:3e8f:b0:abf:7a26:c489 with SMTP id a640c23a62f3a-ac2b9ea164cmr368075466b.9.1741824391899;
        Wed, 12 Mar 2025 17:06:31 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a3fc7asm7404766b.135.2025.03.12.17.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 17:06:31 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org,
	akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	svens@linux.ibm.com,
	thomas.weissschuh@linutronix.de
Subject: [PATCH] mseal sysmap: add arch-support txt
Date: Thu, 13 Mar 2025 00:06:23 +0000
Message-ID: <20250313000623.3192896-1-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
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
index 000000000000..8db637254de9
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
+    |     hexagon: | TODO |
+    |   loongarch: | TODO |
+    |        m68k: | TODO |
+    |  microblaze: | TODO |
+    |        mips: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: | TODO |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
+    |          sh: | TODO |
+    |       sparc: | TODO |
+    |          um: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

