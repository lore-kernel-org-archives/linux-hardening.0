Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DF4248A9;
	Fri, 21 Aug 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325983; cv=none; b=mPj5NuqgV0UWAa3DsI4VsaFpqUQ5z6ULQFWYf1r4qjp6/pp4GvtahwY5fMEwF+QVU1e0bZ2u7FUQJ8/RxMrmPo4HVE8p+RpKLD+PmAXelvQCdJVmPOcVXOt62F1cVbkFHL0j1yqRQm9fWr69yEmlcGddsCmUmv0Slv6Oxd3oKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325983; c=relaxed/simple;
	bh=NlyqPliMgLZFrhUMwSNtsFMvckdrMCQY63SKTRwMVVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXqPqta9hQad3PUa3jBC3Fh40grKLI+kYH8BjE4XtqahffW2kEe3Liy7GRCTLol7siY1rfJUwiaR2SyoRpizoZrH+Z3S2WuqVduQPrYzU5jZvHvuM8fc/I2+jhrV/qxeSXTVwrHlzVw2rTvyXPGPM/oxd0g6R9S28JCnaddnfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0bjUzoK2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f0JEZNFv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0bjUzoK2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f0JEZNFv"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787325981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pdo8IhBXaBnNTEY+XmQRaFao47Apuwz3T89r6WYA1AM=;
	b=0bjUzoK2dPoNQGaNHO5qR9Us6ZklBRKzzJiqFi0neuLjuLgbA8CdH2TfnE14/QTITMCv7/
	Vnft2JVK4NrMyG3B4pL9TfkqFQPNz0CE58TK1cs1fJqDifOeGlydlH11SP1wDSGVQYU9VN
	JD2VLBQQVvLnUY2jioCg4eFCvv4SLfxH1Pur5b4g166M5wKcab2Xx+T4gKEUgz8B2fFIoN
	fqAZCJVaXwceZi3LvqQ2Uyks86vFGbQNfsQFMHqws86lhB3d5Lii578MBs4rS33496xl7U
	fPkoxRjysI/A1KDeoUvBrOKytCDhg3hhTwfNMkNEqvR2CFLqeKrIB1o7yswoJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787325981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pdo8IhBXaBnNTEY+XmQRaFao47Apuwz3T89r6WYA1AM=;
	b=f0JEZNFvuZfjVIIDVd4cYvaoZj0xHYvBwIj1O4Eh849ZkNPayJLFBSwuJ3/Z0GW0DbvZoN
	abZOIKakMDFkw3CQ==
To: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/2] kallsyms: Document why unresolved symbols are revealed
Date: Fri, 21 Aug 2026 17:26:14 +0200
Message-ID: <20260821152614.2202196-3-bigeasy@linutronix.de>
In-Reply-To: <20260821152614.2202196-1-bigeasy@linutronix.de>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__sprint_symbol() is supposed to resolve the passed address to a symbol
name. If the symbol can not be resolved it will print the actual pointer
that was passed. The pointer policy is to not reveal actual pointer
values. However for post-mortem analysis of crashes it is helpful to see
the raw pointer if it is a corrupted pointer.

Document why raw unresolved pointers are printed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/kallsyms.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index aec2f06858afd..983eae8d66f88 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -482,8 +482,13 @@ static int __sprint_symbol(char *buffer, unsigned long=
 address,
 	address +=3D symbol_offset;
 	len =3D kallsyms_lookup_buildid(address, &size, &offset, &modname, &build=
id,
 				       buffer);
-	if (!len)
+	if (!len) {
+		/*
+		 * Print the raw pointer to allow post-mortem analysis of corrupted
+		 * pointer in backtraces.
+		 */
 		return sprintf(buffer, "0x%lx", address - symbol_offset);
+	}
=20
 	offset -=3D symbol_offset;
=20
--=20
2.55.0

