Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8C28134C
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455896; cv=none; b=boFMZhnyPudGI71QXbE3iXGI7ocFD4hwGRPnm0gGID7aHovW9LSYNoqxWmwUBTZpdjzokY08oFqLaL+09sXLSO+QAGF5kuvs++MaSMkWmi4EB+9Gp+qQMmvHhNBXYpLXe4gc3GzMs0hEcwuN2EByxkLVuoxO4nuNKQq2ts6QLAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455896; c=relaxed/simple;
	bh=eKMNUVNp8UMGTQa3NsP+iAJSkExx3OGQxHufDdcpSL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ji533wDxMuUBOZj3RKj4F515B7wDNzVn7eVVrVaDYXQZRQunwKR2KS3khPXWCYLEMWus5RJ4KmtQJeYHD0ZfLaD0NqgGBiOWahW3txuTHrRjIU6jODem/1rwpbxC6n/R2hDc6XFmwLUGF+HQtkL4N+11PCOwJEQBPh5XjkvC2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xEm3AUDN; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xEm3AUDN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739455891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mGI8wtS2DOrObIqxm/I1fLkkBiivD5c0wK4M4TqD720=;
	b=xEm3AUDNgBrj+p52hVtsBlhjtjf9EcfAnTnO1s8r3MVBpyjmRSkEEQntGTFIo0/T9yISuQ
	Gy/wWa7EpGUwxOt5ea7Y5oy5HTa2hzJskP6cRZcNTPmHRiNbV/lmHCz+GRfFpyMJEr5JoG
	W8oQQFbydGb8zH7JdLbQ2hdknqCjycs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: mm: Replace deprecated strncpy() with strscpy()
Date: Thu, 13 Feb 2025 15:10:36 +0100
Message-ID: <20250213141037.50394-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/m68k/kernel/setup_mm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 15c1a595a1de..48ce67947678 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -243,8 +243,7 @@ void __init setup_arch(char **cmdline_p)
 	setup_initial_init_mm((void *)PAGE_OFFSET, _etext, _edata, _end);
 
 #if defined(CONFIG_BOOTPARAM)
-	strncpy(m68k_command_line, CONFIG_BOOTPARAM_STRING, CL_SIZE);
-	m68k_command_line[CL_SIZE - 1] = 0;
+	strscpy(m68k_command_line, CONFIG_BOOTPARAM_STRING, CL_SIZE);
 #endif /* CONFIG_BOOTPARAM */
 	process_uboot_commandline(&m68k_command_line[0], CL_SIZE);
 	*cmdline_p = m68k_command_line;
-- 
2.48.1

