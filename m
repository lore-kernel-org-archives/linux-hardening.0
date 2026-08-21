Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E14347BA7;
	Fri, 21 Aug 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325983; cv=none; b=pYuTWzYApM4pKFbgCIXnxmefkT2DFgdV4CHbVJKfRreZVSq9qcEjkzu08rHgnM4GW9s6GwagCvuwlT5w6rQu8QW2nUSzydVHdU9V+bbRzOybJQDiXovjLL6AOfkmZP7BodNGkgTqJ9S+O1No0N+Opy1qLaB8VRtRv5PePIcAiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325983; c=relaxed/simple;
	bh=Q8M3NdIgEcTNbXuTEWQEFmx1XZFmpTcaCIoEipr94T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ed7lj2CtJMNPwj2944JdUQiXNHx/JQw5bTqmEZScQwqlE/OTogjJ33qSAtdtjORai3Eu7uTOZBI0f9rUELqejqDAQ9UnOVlVPAeAK/o+4/XiCYRlLD1rZaK/jwIOlCcxccF7irAHcl1IfWPgyZhKw5M20GB3kQh6DJeaz/WBjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mqtLGG07; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PgzwJFaa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mqtLGG07";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PgzwJFaa"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787325980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/iuh5RZsY4AOt/uEGJGrI8xkUFQR2iSL1PP5CV6cjQ=;
	b=mqtLGG07HQwyseCEQ7u+88i9iWhyGojtS+R3athbvPWQeEcKG3D0xXdWmt9tcUINF4/K1E
	B2qSR9vjt8mHf26BPZ13oQpOgQrZQUhUl5i9YtSBEW4MsIvuXHy++w9BTHbvg+Tdvt9PSR
	2i2y5anhsovutm1lL/KxMhzVQRRrGdb4GAAeCIb3eFxJavA9dW6S36589/5TvmYS+8R4XL
	z+vh/0zWAD9IxqLJP4U+nnkpBHUqS9IrUNjh9TnhJRxCJdQTwS5IHo/3IfxR16hnaTka7R
	gmWizClBED0sY7NElE5p+/QnhmIKrPZLSzqbqRbEbMSjBMv1rr+Ty5l7/YWKEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787325980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/iuh5RZsY4AOt/uEGJGrI8xkUFQR2iSL1PP5CV6cjQ=;
	b=PgzwJFaajh/n/QJFiYAXSc3nBsEE9QLC4vERDdy/+yDH6M9Ab9SVvir42pcfl9qRRX3jN2
	LTE13ne+1WmRTbDw==
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
Subject: [PATCH v2 1/2] vsprintf: Don't leak pointers for %ps without KALLSYMS enabled
Date: Fri, 21 Aug 2026 17:26:13 +0200
Message-ID: <20260821152614.2202196-2-bigeasy@linutronix.de>
In-Reply-To: <20260821152614.2202196-1-bigeasy@linutronix.de>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The "%ps" format modifier prints the name of the symbol which is more
valuable in terms of debugging and does not leak the actual pointer.

Without KALLSYMS it will leak the pointer which is not intended. The
default policy for pointers is to print a hashed value and not to leak
the actual pointer.

For !KALLSYMS, print "(unknown)" for any symbol resolution. If hashed
pointer are disabled print the bare number.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/vsprintf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2bc6ef483576c..fcb63f22b1997 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1008,7 +1008,9 @@ char *symbol_string(char *buf, char *end, void *ptr,
=20
 	return string_nocheck(buf, end, sym, spec);
 #else
-	return special_hex_number(buf, end, value, sizeof(void *));
+	if (unlikely(no_hash_pointers))
+		return special_hex_number(buf, end, value, sizeof(void *));
+	return string_nocheck(buf, end, "(unknown)", spec);
 #endif
 }
=20
--=20
2.55.0

