Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D021C9EE;
	Mon,  7 Apr 2025 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046984; cv=none; b=fTVu8qFYUfykxfzvHSw2q7nR6zNMRptukT9mp4nwzfleUzybgICy5MMMeK4tbRHDD9ebZNCUaP+BpGintDAsoDa0FusiTxL7MhSCmCDvPFdwRTzLokZtLddEzWS/1/ItCTOWNm6q/3AMgGtIxm+uZCqv+GLzNBB5yOdUqM4p9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046984; c=relaxed/simple;
	bh=Y56DO+aQRPCY5yQB0R16rZt+S1/MCsRiFYTZs4yOjj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jE6G0wzgM1gO1rVbRzvrUZ/Ens9SDVHEPIR66jkKi/GB+DByqixAvuX/TnSVhwjebEmFIyTsxp2gKTREmRQ3rtqY8cqMBuj8sFmdwbBP+p2VZ0PBnNj45yTxsM1FHwfcFJr41b1hmXP/K/mulajELiy4mYCBmEmWg73J3OlqHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1WfzKgK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1WfzKgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9697C4CEEE;
	Mon,  7 Apr 2025 17:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744046983;
	bh=Y56DO+aQRPCY5yQB0R16rZt+S1/MCsRiFYTZs4yOjj4=;
	h=From:To:Cc:Subject:Date:From;
	b=E1WfzKgKCt4SgeEDDWwUT4E4twz9yGyxdTp6+8MqGzG8jUWUQC1lA0w351L+Ii1s/
	 XW7sYkbn2Ft3jg87GRZwD9m76n6RbRgKq3E7IN+rjAzar5eTCSe8vXTVksrxJpgPNC
	 6IXO8mYNuAPe8wiSeayjuleQeJ0SphxcefYaUXbT1nvqY86XlAKI2jBBMq63QifsbZ
	 z07VeixjFhsHWE5liVXTD64io/KnfOHK0RxgzT9m6ly64VOBHwLKwO8JY+LR4QP3Pi
	 UW878es2wOrQQuLZ/VNruWrbOSggUflFVs8rpc8G7rP2bDHEQ7j+mPxpBuqvxHStWa
	 zxHFrb8lcFiPg==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alejandro Colomar <alx@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Alex Elder <elder@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] EISA: Increase length of device names
Date: Mon,  7 Apr 2025 10:29:35 -0700
Message-Id: <20250407172926.it.281-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3862; i=kees@kernel.org; h=from:subject:message-id; bh=Y56DO+aQRPCY5yQB0R16rZt+S1/MCsRiFYTZs4yOjj4=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlfuOt2Bc6I5BYwuCsS/WcnD8Pj3/Nf5ixSVNtw8cFZ8 f8Tlkj2dpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzE15WRYaLU4TN8HEc+L3wQ yvo2PLTmqsuyFNmXhy8XPU7OZ37CKcHIsN1llu+qQJtTzZtSIx8d0Hjl9Pbr9OKdAf8v2bw83ca /ix0A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC 15's -Wunterminated-string-initialization warned about truncated
name strings. Instead of marking them with the "nonstring" attribute[1],
increase their length to correctly include enough space for the
terminating NUL character, as they are used with %s format specifiers
when showing resource allocations in /proc/ioports:

        seq_printf(m, "%*s%0*llx-%0*llx : %s\n", ..., r->name);

The strings in eisa.ids have a max length of 73, and the 50 limit was an
arbitrary limit that was removed back in 2008 with commit ca52a49846f1
("driver core: remove DEVICE_NAME_SIZE define"). Change the limit to 74
so nothing is truncated any more.

Additionally fix the Makefile to use "if_changed" instead of "cmd"
to detect changes to the command line used to generate the target,
otherwise devlist.h won't be rebuilt.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Alejandro Colomar <alx@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Alex Elder <elder@kernel.org>
Cc: Sumit Garg <sumit.garg@kernel.org>

 v2: crank length to 74 for full coverage and fix Makefile too
 v1: https://lore.kernel.org/lkml/20250310222424.work.107-kees@kernel.org/
---
 drivers/eisa/Makefile   | 11 ++++-------
 drivers/eisa/eisa-bus.c |  2 +-
 include/linux/eisa.h    |  5 ++++-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/eisa/Makefile b/drivers/eisa/Makefile
index a1dd0eaec2d4..f0d6cf7d1f32 100644
--- a/drivers/eisa/Makefile
+++ b/drivers/eisa/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for the Linux device tree
 
-obj-$(CONFIG_EISA)	        += eisa-bus.o
+obj-$(CONFIG_EISA)	        += devlist.h eisa-bus.o
 obj-${CONFIG_EISA_PCI_EISA}     += pci_eisa.o
 
 # virtual_root.o should be the last EISA root device to initialize,
@@ -9,14 +9,11 @@ obj-${CONFIG_EISA_PCI_EISA}     += pci_eisa.o
 obj-${CONFIG_EISA_VIRTUAL_ROOT} += virtual_root.o
 
 
-# Ugly hack to get DEVICE_NAME_SIZE value...
-DEVICE_NAME_SIZE = 50
-
 $(obj)/eisa-bus.o: $(obj)/devlist.h
 
 quiet_cmd_eisaid = GEN     $@
-      cmd_eisaid = sed -e '/^\#/D' -e 's/^\([[:alnum:]]\{7\}\) \+"\([^"]\{1,$(DEVICE_NAME_SIZE)\}\).*"/EISA_DEVINFO ("\1", "\2"),/' $< > $@
+      cmd_eisaid = sed -e '/^\#/D' -e 's/^\([[:alnum:]]\{7\}\) \+"\([^"]*\)"/EISA_DEVINFO ("\1", "\2"),/' $< > $@
 
 clean-files := devlist.h
-$(obj)/devlist.h: $(src)/eisa.ids include/linux/device.h
-	$(call cmd,eisaid)
+$(obj)/devlist.h: $(src)/eisa.ids include/linux/device.h FORCE
+	$(call if_changed,eisaid)
diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index cb586a362944..edceea083b98 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -21,7 +21,7 @@
 
 struct eisa_device_info {
 	struct eisa_device_id id;
-	char name[50];
+	char name[EISA_DEVICE_INFO_NAME_SIZE];
 };
 
 #ifdef CONFIG_EISA_NAMES
diff --git a/include/linux/eisa.h b/include/linux/eisa.h
index f98200cae637..21a2ecc1e538 100644
--- a/include/linux/eisa.h
+++ b/include/linux/eisa.h
@@ -28,6 +28,9 @@
 #define EISA_CONFIG_ENABLED         1
 #define EISA_CONFIG_FORCED          2
 
+/* Chosen to hold the longest string in eisa.ids. */
+#define EISA_DEVICE_INFO_NAME_SIZE 74
+
 /* There is not much we can say about an EISA device, apart from
  * signature, slot number, and base address. dma_mask is set by
  * default to parent device mask..*/
@@ -41,7 +44,7 @@ struct eisa_device {
 	u64                   dma_mask;
 	struct device         dev; /* generic device */
 #ifdef CONFIG_EISA_NAMES
-	char		      pretty_name[50];
+	char		      pretty_name[EISA_DEVICE_INFO_NAME_SIZE];
 #endif
 };
 
-- 
2.34.1

