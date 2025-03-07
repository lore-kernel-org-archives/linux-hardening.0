Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977F20B1E7;
	Fri,  7 Mar 2025 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347399; cv=none; b=N5VMcjc31+TIeZZEGGYa8BjyV36C3xMGGXCUoZVxoR6Df/xRrhHngHYxXpjQ2gYiAKIEpWS+rn+zzRnAu3zn6hgqTR7K6W9Tap1HVaUAhfGB1t3PzV4S39RkwnVfxRQ5MkpCVcioWk2qCkBfCzrpHa/KXNjRxutSeFcUXP/gAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347399; c=relaxed/simple;
	bh=frKnkQy/LC+5rDryWP+aI1GdvKut7xWgY/QlD4eNFIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nqE01sy2oI6zJ0dShLrJLrNRFbrncUNjesdfuLni5JqOAkNi/9A51pWtt+6gIl26uu3fV8kbBpfmoloJ5+M4kbO4oMe7CP1re6FJ8qRbNMUmh7yykOzQB6X6AcWMrYa/GDf5tLCmLHvU5CYM1b3JukOw9nUdhSmKtdaZS2/Yf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CRDW09PH; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CRDW09PH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741347395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LC7r6sYmPfDmNPmeRYyM+gMuDZvM+Kz64vck0/coqbU=;
	b=CRDW09PHwQFwHlVVaFpEZ76JVFA9sppJquPWHtfhwEAU6i4VdMnfWkCRVegJUTWecP9ULR
	0vjYns9q6s0karcHrkkw7eXIenOTexZ8uZgo/n8+v+1G6l5MHsDHV4FwTQWMNaYYg54Uq4
	bjGrnzFDhoYpU/3nXdjyBuotxVzeA/I=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Replace deprecated strncpy() with strscpy()
Date: Fri,  7 Mar 2025 12:35:47 +0100
Message-ID: <20250307113546.112237-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers; use
strscpy() instead. The destination buffer ownername is only used with
"%s" format strings and must therefore be NUL-terminated, but not NUL-
padded.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f..2b88c91c89e3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1189,7 +1189,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 
 getname:
 	/* We must make copy under the lock if we failed to get ref. */
-	strncpy(ownername, module_name(fsa.owner), MODULE_NAME_LEN);
+	strscpy(ownername, module_name(fsa.owner), MODULE_NAME_LEN);
 unlock:
 	mutex_unlock(&module_mutex);
 	return fsa.sym;
-- 
2.48.1

