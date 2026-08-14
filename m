Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C83C1D58;
	Fri, 14 Aug 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718947; cv=none; b=hjZX8X+HngdgREXDrr2Dlm+EtRR9bwIuXKX7ozAH5leagcBTOz2El94OS7+e6BkbfOrsKK82pChE8JVREtGQkSIgwQ9ZoNjPcWeRRmoe9fcwh3IcE3H/WVuVSFBSJa/GGE0m8O4k2eHHlB2uxhQBb+Ffebn04WVrSydKWHwC/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718947; c=relaxed/simple;
	bh=a7tH0ZXKLXHbhmxOJi4YLz2jhji46x7jgm2ItsTIH8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxtT9+1ZfAWHnxKWaRtOmBm0s1TrhdiIIxUW/vFq8iJTRIRtOA4o6nYyRTGAnnlUMCVVeVGV48DxrNahz8suLCx3z7J6JSJD3k5aVGv2/Lzz1d9uGaLp1U3oN3li6M09o+gE4I66K75LZPStnzJ1WoD0hQcAjWpAYPHNWm/Q4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wpq9Tn1A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=749zgNZw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wpq9Tn1A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="749zgNZw"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786718942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZPICZut8K0k5/EIzhQmHLS2BTbL07NPnrwU3NVfBnF8=;
	b=wpq9Tn1Alyiqq+iicCPahKVmfk/Qojs0R4CUJUPRjzxEWfVMnyD1UyJhFOcJDfXW8EbwfF
	RjDN8RC0SNedhcr8lmxyz8WYGxrRr9jJACqZOEJ0WvYY1Uagu2LL7p5mQFNcQ2PCPyAZtm
	LUY7GbAwhT6wpHsJ0GayIKl9+QXVt8lXkhfhN0fI2AsBnKpAW7RBYmOUkZ9+1sd8BYjBKg
	3imzbaP4Usb/MbUDjO22fGaWkKG1eXQRZvZJ9FD+ztCGPZV0SaJ+YW2yFIebG6CfKL6i+A
	BZu5NZzS64nHZNGKZyfLFs7gADnAavtYHQwHRACUX3KJ0NndaYGhpyThb7FuzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786718942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZPICZut8K0k5/EIzhQmHLS2BTbL07NPnrwU3NVfBnF8=;
	b=749zgNZwOw2+tGX4i4Nugx2DTl1tdoZWEE6xbAaQdFMF/xyTNDv+JNBSOIYdXe4GrTl2Ep
	UQ4vn7ciF2z1tVAQ==
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
Subject: [PATCH 0/2] vsprintf: Don't leak pointers 
Date: Fri, 14 Aug 2026 16:48:52 +0200
Message-ID: <20260814144854.746840-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It is possible to leak pointers via %ps without KALLSYMS enabled.
With KALLSYMS pointers can be leaked if they can not be resolved.

The tiny series has two patches, one for each issue.

Sebastian Andrzej Siewior (2):
  vsprintf: Don't leak pointers for %ps without KALLSYMS enabled
  kallsyms: Don't leak pointers for unresolved symbols.

 kernel/kallsyms.c | 2 +-
 lib/vsprintf.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--=20
2.55.0

