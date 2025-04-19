Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69EAEACE
	for <linux-hardening@vger.kernel.org>; Sat, 19 Apr 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745064049; cv=none; b=Hsgak3IB4+QzsYJTiVoxPwSG4ybfDudg0KzV851XRQyvwRnFIIBS43Y1w6RyHU1sC2RZw9URlukDyzlNlOqtvoc4gMUrIYSux7hCy9xDC82U7GkwzAkVkNv1lNCRPoEzFVAJN6zAsmHKo3tJWBec0QhE43Ami26X1Hvv+tQSv2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745064049; c=relaxed/simple;
	bh=S/JogNL0Z5r7fTN1TYZJwx0JV0BnRDzijgIYGg3OcAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUd4LyjwU882OEKMOuGDdOX25XKyLFmJBxaIepBVVABONXlqksRjm5Omoa/ksYRX3NAK0Vr/ndJijd+8Kw0x2dHkPDaKBTMONExE4bLOrxwo4l+5CVqFAfK2R8xRjG4kTvP67YLc/ceRuzHsnvYeLjMCsKECvEQEkRZ0T2IIFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=but2MW+d; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="but2MW+d"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745064042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AtQwAwd4D2QAaXwT+fjX/n4DbO60dxzK1kBHI70Rybc=;
	b=but2MW+dKMSSeZZ8Nec+C/7lyAc4EvHBufP8jRjrk2y4ZGz8uJwkDiHEZfj3ygs0x/sOWg
	CHVqw84fEzIV2HeGQ8PTfOMXonxh6XJ7T8kb3ZWpvrxaKZzN7Am2wWVg66Ri1GVk6e0jfn
	h6rsU3XmFf5raFZyra5g5mjrL/xq7W0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: Replace strcpy() with strscpy() in setup_arch()
Date: Sat, 19 Apr 2025 14:00:04 +0200
Message-ID: <20250419120005.177136-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Since the destination buffer 'command_line' has a fixed length,
strscpy() automatically determines its size using sizeof() when the size
argument is omitted. This makes the explicit size argument for the
existing strscpy() call unnecessary - remove it.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/alpha/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index bebdffafaee8..8b51e6ca83d6 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -468,8 +468,8 @@ setup_arch(char **cmdline_p)
 	/* 
 	 * Locate the command line.
 	 */
-	strscpy(command_line, COMMAND_LINE, sizeof(command_line));
-	strcpy(boot_command_line, command_line);
+	strscpy(command_line, COMMAND_LINE);
+	strscpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
 	/* 
@@ -511,7 +511,7 @@ setup_arch(char **cmdline_p)
 	}
 
 	/* Replace the command line, now that we've killed it with strsep.  */
-	strcpy(command_line, boot_command_line);
+	strscpy(command_line, boot_command_line);
 
 	/* If we want SRM console printk echoing early, do it now. */
 	if (alpha_using_srm && srmcons_output) {
-- 
2.49.0

