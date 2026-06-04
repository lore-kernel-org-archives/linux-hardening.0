Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F89E477E4B
	for <linux-hardening@vger.kernel.org>; Thu,  4 Jun 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579157; cv=none; b=Liopp1hDFHyKQbNfCh5OiaAAKQ++N0OgQMsVWlDnnvDQ4NBVhsN4nKxC8L251yTYyepKAJgBOabIeEPz5tNpE4S+T8Z6IYvaG5O7diX73dK9CP+NxnQHufaeBzTQlchPYcaUQeMsEpv3Lji+LG7x0/xSLTfZ3sjM6kRMa2EmegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579157; c=relaxed/simple;
	bh=RbWuypist+88Gm8+XX/0JfPKQ08Vgq4ntejnMJhib4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0CAAJsJJuFXJcf4/kIFKB67Zy/sZ/RXqS0hCjARqQ72WNPxrgU5NhXG5PcExERkRDaIIBWGr3U/fvjFAlFl2OhBjcIku4Mxeen0NGYTJnPpHUR4EF0MrgEv0P92/pFMvyLfT6+EeSZnjvj2K7IrF7P3dHG8/z7yRPdE7lpCwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qkOqwoE8; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qkOqwoE8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780579143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=us3y2v5MIFW+xn+uaJOmyFg+OkwA5K0IadmA3HJ/f/4=;
	b=qkOqwoE8LjDRLqXwGYtUlHL2bxoEmZAPCDWm7EDRRbffuJOWkh1tiqJlL1h2aiH1tViUdi
	VjGUPdMX7iNnFg/w2A6Zt4TSZwyMB6HbUovjKA+y4SVN5GVJO33KtN8hx+EL6RapsDZ4aW
	8EnnTZw553PFhNCKvNLrZs9jEOXLYyQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Bohac <jbohac@suse.cz>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/setup: replace strlcat() with snprintf() in setup_arch()
Date: Thu,  4 Jun 2026 15:17:53 +0200
Message-ID: <20260604131752.1327556-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=thorsten.blum@linux.dev; h=from:subject; bh=RbWuypist+88Gm8+XX/0JfPKQ08Vgq4ntejnMJhib4M=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmK1QyWU4Kulz24KhTVm7tzr31WM2NtwIXvb6+9i4i/p v78RNCsjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhI3lVGhisR/44tLr54NmKq Ao9y8e4lDitfn3iuPuc0y83Vk/UEnvcxMrSuczmS/OGFzN7W1v9FwXofLr/Y/WjXobeRge073/0 tuMgLAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In preparation to remove strlcat() from the kernel [1], replace two
strlcat() calls with one snprintf() call in setup_arch().

Also drop the explicit size argument of strscpy() to further simplify
the code since strscpy() can determine the size automatically when the
destination buffer has a fixed length.

[1] https://github.com/KSPP/linux/issues/370

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/kernel/setup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 46882ce79c3a..b11b0ce31a27 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/random.h>
 #include <linux/root_dev.h>
+#include <linux/sprintf.h>
 #include <linux/static_call.h>
 #include <linux/sysfb.h>
 #include <linux/swiotlb.h>
@@ -915,16 +916,18 @@ void __init setup_arch(char **cmdline_p)
 	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
 	if (builtin_cmdline[0]) {
+		size_t len = strnlen(builtin_cmdline, COMMAND_LINE_SIZE);
+
 		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+		snprintf(builtin_cmdline + len, COMMAND_LINE_SIZE - len, " %s",
+			 boot_command_line);
 		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
 #endif
 	builtin_cmdline_added = true;
 #endif
 
-	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	strscpy(command_line, boot_command_line);
 	*cmdline_p = command_line;
 
 	/*
