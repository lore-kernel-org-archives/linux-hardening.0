Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942E47424E;
	Fri, 14 Aug 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718949; cv=none; b=nkw7SHUKBVZtuhqtyTX3FR33WD7vQAJo3PwqhFCLsfiO9B4jCmVzxGA2w+KTecX+zXZ6QhAHrSb3XfRZIX+iRCcfHlyPO8Gyn2AJGZRlX4LZ8jDy9bKAAf6QJ+mtu3H7jOhX1i7sufHnUlKLZ1No2kYzNcU7FYBnydl2SWnbS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718949; c=relaxed/simple;
	bh=+fr8RZV46XEy8wVWiO+AhrOJCq+xb5t13cxpCF74HcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNaninF+8NdrYD170aFFL9rRVDSObZPmiQjxL9CWtLWlGyrXJ8WfpslTuD972v1VysJPxSwhc8lP8MMKP8yL/KRWcP2TE6t/wyqHQJ6Y2zZkpsc/ZHNXa8YhRt6Uf2txaPCGhGLML7zcSauFUX59U9KwNV+hv5zLEGqUXIWhwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=apjYaTeR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p8OlBoZQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="apjYaTeR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p8OlBoZQ"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786718943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXsO7Tw5Jdt32cHEwQa9lZY39lvveuyKQYw9Bls8lWM=;
	b=apjYaTeRIS0F3OcLEe65pOi5KvAKDraVw2rIxhdr4PQByIk9a0LBQKlJ29msrBThllxdPr
	zjdEzLzw4S3cmlyfonPPzyjQq8id215rveWHbvPvYpuA2t8qX3oohDqCZHsftH/3NuWFrt
	f07URECsuHxnhcCNU5DPwMdMoMhTzFg2M8949jLRbJgU59bWsgPz/CWDcjtyavebiM5M+9
	irNWw4KovF/3Y1xppKR6dJeJQwVUrsxJtKCNpYnqP0GbrocCsct4WaWVAF1KOGrIZHLAhT
	flywx6Q0lvBihOeazbMvg0FgXarYZK3oMvNIluBJhfUvyHbzZ5dvZhjX1kIVnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786718943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXsO7Tw5Jdt32cHEwQa9lZY39lvveuyKQYw9Bls8lWM=;
	b=p8OlBoZQpXi/thDkqOFA69RXjTlQTzKbAlW611bVdodcMKKNFHQwemvixP1uVD8TgzFNGY
	YQUTRgGR+JVxRQAQ==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 2/2] kallsyms: Don't leak pointers for unresolved symbols.
Date: Fri, 14 Aug 2026 16:48:54 +0200
Message-ID: <20260814144854.746840-3-bigeasy@linutronix.de>
In-Reply-To: <20260814144854.746840-1-bigeasy@linutronix.de>
References: <20260814144854.746840-1-bigeasy@linutronix.de>
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
values.

Backtraces used to print the address followed by the symbol name. The
address has been removed leaving just the resolved symbol. If the
pointer can not be resolved to a symbol, it shouldn't be printed as the
bare value.

Print "(unknown)" for any symbol that can not be resolved.

Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index aec2f06858afd..c70adaa97c24b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -483,7 +483,7 @@ static int __sprint_symbol(char *buffer, unsigned long =
address,
 	len =3D kallsyms_lookup_buildid(address, &size, &offset, &modname, &build=
id,
 				       buffer);
 	if (!len)
-		return sprintf(buffer, "0x%lx", address - symbol_offset);
+		return sprintf(buffer, "(unknown)");
=20
 	offset -=3D symbol_offset;
=20
--=20
2.55.0

