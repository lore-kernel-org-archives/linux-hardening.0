Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA652D238F
	for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931862; cv=none; b=UE7jPmlX2bU/NEqVFYzaOVhnzdVATYbDrU3oHX/DJuYEEbnG5CC1RumZV0itH2Qz5ErCjz4DIWVINaSG36sMuCYFM1CJxat3+dCHNOFgClNemQIAKvptQ3dYCkzxD0F/Tn3edVx3V4FC84LCpL8LTzCxOkgOtgenSJzLbo6pb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931862; c=relaxed/simple;
	bh=afBbVq10j3fxbGFfay5iR2qaokXHgyQ1UN6WKW/T9ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxYKIudN2Vx6EcJNX/EM/6PqIdJSKHfdNgTM9lAe5cvOLZQ2c50DBd0oERfSmbjp+k2kjbtUzgUKPoervqa87410yj5k+U9/WvBEl6wwrYYfNeHjHM2FMwolz/1Q9nH/yBZpMtGtjh9SqsUdJqAQ80ze+V2pgf3Oqkld/iqJdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EZJwxZkG; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EZJwxZkG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754931848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CpVY826a4cvxKLVO9LiMB9JovYkuZkAnBIFJH30Z+Dw=;
	b=EZJwxZkG1v3gLPdBOP+BSQINydWj4qe5Y9M4KHRJu5Du7XCLtfPnBwg1lrIa5jgbtdD8Uf
	rmm501x89NomqYyMyV2mdfAB7D8jcvmHjVk9+wyrkaRvrd51SETm+MCIFT+kpvvTJFfZbb
	TQ0AxHsre52SVmgg7G/sZq64P14DpLo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-hardening@vger.kernel.org,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Replace deprecated strcpy() with strscpy() in vkdb_printf()
Date: Mon, 11 Aug 2025 19:03:48 +0200
Message-ID: <20250811170351.68985-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Use the return value of strscpy() instead of calling strlen() again.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/debug/kdb/kdb_io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9b11b10b120c..2062494c413b 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -732,8 +732,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			 * Shift the buffer left.
 			 */
 			*cphold = replaced_byte;
-			strcpy(kdb_buffer, cphold);
-			len = strlen(kdb_buffer);
+			len = strscpy(kdb_buffer, cphold);
 			next_avail = kdb_buffer + len;
 			size_avail = sizeof(kdb_buffer) - len;
 			goto kdb_print_out;
@@ -872,8 +871,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 	 */
 	if (kdb_grepping_flag && !suspend_grep) {
 		*cphold = replaced_byte;
-		strcpy(kdb_buffer, cphold);
-		len = strlen(kdb_buffer);
+		len = strscpy(kdb_buffer, cphold);
 		next_avail = kdb_buffer + len;
 		size_avail = sizeof(kdb_buffer) - len;
 	}
-- 
2.50.1

