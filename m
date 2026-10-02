Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220E3EB0E8
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944952; cv=none; b=fKLgeTdfmhfhiyp3tjtPzidAs5f8oObXSenboEROV3bBBbE+uCRYmCC+fhlGFiQjc17EVOAY4dD6Hq+sB9pvZd0C9QDIJXVQxWRCAHz2XYXWkSOyJsqZn2StjUa1b3fbZ7M+Er/SYPsvMqxdUaCLzAojfDcxN1ZfznTfL1sBg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944952; c=relaxed/simple;
	bh=XSRr2dcamW9s+xK37mZQf/IP9nzTt+hMu0KI7ww4FIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n0GNkl1AkE2y2wNG/AjBADZG/p/oO9jBYpP8w+Ht2l3HVNRBKfwTSTKjzJ5g0YZnUXeljqY9OzFLjxFz6akemJwxEK/sWifjTr5yh3cafko/a3DcDt9kP6JBz3evS7QPHRe0dkC6OSwfyDN/LaTxdVqKMSRYBUV2Vg68hvHp+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IiN0rBjn; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IiN0rBjn"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa4e4684bso126157255ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790944950; x=1791549750; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqiEufa+6Y7AKpg1CmFTqo5DDymUPYRzxbg/Z7GvGSg=;
        b=IiN0rBjn9n9NfYnYHd/bY0vueyAQWm2I1KrzKgjwaRfL+Ad2ElQt+d9eG+Xgs5NaQY
         S3kTwAODlyHmZu7TKsq9EHjXuO2ZocuX+UPxBNCgtsLH2peyfSEcujkXW9EF1vu80bUn
         DgCxvtTEfhe9Vfbr0knSmOAA/3NEM5zBy+HO6Ib7F/tI8Kkyl/ybywYaRRSVjssUtYMq
         EKTeAau4Cw27Yrmuh2B/Fx/Fjj6sq+jl8vPsRbNkXSAIvXh6vMOVeWVvQAHP00MsM4Zn
         eyAgrhpXUeUtStf2mEcgogJYpH5m74saKiQj/8caE6I+tc0Q0zMCAHWxFXSg/loxtWpG
         au6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944950; x=1791549750;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqiEufa+6Y7AKpg1CmFTqo5DDymUPYRzxbg/Z7GvGSg=;
        b=fLlynixLdCS/VmlP8oHv/biS+EigEOVG3469JmM69ywlWLn9Dv+ppF2kSuEtoN7NN2
         Me7+67gyggiCa1Lq3hwclw4saHS0htB/kTvuS6L4TsO3xJXI+Y1KKaAjmOYLh7SzQmlV
         lk5St+32QS4qEyN7xkcla1+tq4YpGu/mZT7Z6gznYaY3HZkSsweexy9UQzzGSl6MWqJz
         1s6hIY+WmIab7XHKSt5rPAJRjlCpzoaSPHZW8UN86c0OVwP4tpWxv5bf+voPRT6Yui8z
         cALsYIh/rN0J6irgZfTqK2fo/hKx2cE5LqfHni18y0KJd/aHtmrubSgksmb0s643TOj7
         x3Pw==
X-Forwarded-Encrypted: i=1; AKwUvByFyxT0QnW0tfnaL1EDVr/KW+zhSFmuzgoFwX94ZYP2nnqMDod4ZXxdrnwWcVHFNMRbdTgbIqCc4CNGoB8G2cw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI19cNAg9Av0WZu4NRw/jGzCTOIZX800TOQJRVGVUC3n+uoEiKP
	7FtGvWnCHGpBUkDFEb8qo1t/en5MPCSpdHcLkBFMlVWpr8xZCoTuotSaxxKVXBfIzJdDqFV8eh+
	h
X-Received: from plbko11.prod.google.com ([2002:a17:903:7cb:b0:2e3:180e:ba6e])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e892:b0:2e2:d77b:e586
 with SMTP id d9443c01a7336-2e49b6cee8cmr25721005ad.60.1790944949342; Fri, 02
 Oct 2026 05:42:29 -0700 (PDT)
Date: Fri,  2 Oct 2026 12:42:25 +0000
In-Reply-To: <20260928063824.1386524-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002124226.435265-1-morbo@google.com>
Subject: [PATCH v2] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Jeremy Kerr <jk@ozlabs.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

The 'data' pointer field in 'struct acpi_gpio_mapping' is associated
with the 'size' field, which represents the number of elements of
type 'struct acpi_gpio_params' allocated for 'data'.

To improve bounds checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by_ptr
attribute.

Analysis of allocation, assignment, and access points shows that the
pointer is never accessed before the count is set, which guarantees that
this annotation is safe and will not cause runtime panics or
false-positive bounds checks.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2: Undefine "__counted_by" and "__counted_by_ptr" in the EFI stub
    library as it doesn't need it and Clang is missing a flag to
    enable them.
---
 drivers/firmware/efi/libstub/alignedmem.c      | 8 ++++++++
 drivers/firmware/efi/libstub/efi-stub-helper.c | 8 ++++++++
 drivers/firmware/efi/libstub/file.c            | 8 ++++++++
 drivers/firmware/efi/libstub/gop.c             | 8 ++++++++
 drivers/firmware/efi/libstub/mem.c             | 8 ++++++++
 drivers/firmware/efi/libstub/pci.c             | 8 ++++++++
 drivers/firmware/efi/libstub/printk.c          | 8 ++++++++
 drivers/firmware/efi/libstub/random.c          | 8 ++++++++
 drivers/firmware/efi/libstub/randomalloc.c     | 8 ++++++++
 drivers/firmware/efi/libstub/secureboot.c      | 9 +++++++++
 drivers/firmware/efi/libstub/smbios.c          | 8 ++++++++
 drivers/firmware/efi/libstub/tpm.c             | 9 +++++++++
 drivers/firmware/efi/libstub/x86-5lvl.c        | 9 +++++++++
 drivers/firmware/efi/libstub/x86-stub.c        | 8 ++++++++
 include/linux/gpio/consumer.h                  | 2 +-
 15 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
index 31928bd87e0f..36248a13f15b 100644
--- a/drivers/firmware/efi/libstub/alignedmem.c
+++ b/drivers/firmware/efi/libstub/alignedmem.c
@@ -1,5 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 #include <asm/efi.h>
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 8e43eb3f418b..a97d086a76a1 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -7,6 +7,14 @@
  * Copyright 2011 Intel Corporation; author Matt Fleming
  */
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/stdarg.h>
 
 #include <linux/efi.h>
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index b2601e284695..e845dc2e7aa0 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -7,6 +7,14 @@
  * Copyright 2011 Intel Corporation; author Matt Fleming
  */
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 #include <asm/efi.h>
 
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index b800a6c2290c..f9736d2eff22 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -5,6 +5,14 @@
  *
  * ----------------------------------------------------------------------- */
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/bitops.h>
 #include <linux/ctype.h>
 #include <linux/efi.h>
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index fec561e3a792..65bea615420c 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -1,5 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 #include <asm/efi.h>
 
diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
index 5daa7a0a0e87..a4c9bf67d5e0 100644
--- a/drivers/firmware/efi/libstub/pci.c
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -6,6 +6,14 @@
  * Copyright 2019 Google, LLC
  */
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 #include <linux/pci.h>
 
diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware/efi/libstub/printk.c
index 0a18cfe32528..e2ae89a27b78 100644
--- a/drivers/firmware/efi/libstub/printk.c
+++ b/drivers/firmware/efi/libstub/printk.c
@@ -1,5 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/stdarg.h>
 
 #include <linux/ctype.h>
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index d63262d36e47..d370f0d79c07 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -3,6 +3,14 @@
  * Copyright (C) 2016 Linaro Ltd;  <ard.biesheuvel@linaro.org>
  */
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 #include <asm/efi.h>
 
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index fd80b2f3233a..b09a26aa51e9 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -3,6 +3,14 @@
  * Copyright (C) 2016 Linaro Ltd;  <ard.biesheuvel@linaro.org>
  */
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 #include <linux/log2.h>
 #include <asm/efi.h>
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 516f4f0069bd..07c9782e0c44 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -7,6 +7,15 @@
  * Copyright (C) 2013 Red Hat, Inc.
  *     Mark Salter <msalter@redhat.com>
  */
+
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 #include <asm/efi.h>
 
diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
index efbbfc3c2c0d..98dc3ee40958 100644
--- a/drivers/firmware/efi/libstub/smbios.c
+++ b/drivers/firmware/efi/libstub/smbios.c
@@ -2,6 +2,14 @@
 // Copyright 2022 Google LLC
 // Author: Ard Biesheuvel <ardb@google.com>
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 
 #include "efistub.h"
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 73f001114732..27bc0ccc2a2b 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -7,6 +7,15 @@
  *     Matthew Garrett <mjg59@google.com>
  *     Thiebaud Weksteen <tweek@google.com>
  */
+
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 #include <linux/tpm_eventlog.h>
 #include <asm/efi.h>
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index c3da05c0df8b..3112ab4b2623 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -1,4 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 
 #include <asm/boot.h>
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f4799e29f4cf..77e806c2b016 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -6,6 +6,14 @@
  *
  * ----------------------------------------------------------------------- */
 
+/*
+ * The EFI stub doesn't execute in the context of the kernel, only in the
+ * context of boot firmware, which isn't the time or place to crash the kernel.
+ * Therefore, disable the __counted_by__ attribute.
+ */
+#undef __counted_by
+#undef __counted_by_ptr
+
 #include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/stddef.h>
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index fceeefd5f893..2b80cf7aa7e7 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -667,7 +667,7 @@ struct acpi_gpio_params {
 
 struct acpi_gpio_mapping {
 	const char *name;
-	const struct acpi_gpio_params *data;
+	const struct acpi_gpio_params *data __counted_by_ptr(size);
 	unsigned int size;
 
 /* Ignore IoRestriction field */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

