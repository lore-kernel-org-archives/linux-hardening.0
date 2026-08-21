Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8B36F90F;
	Fri, 21 Aug 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325983; cv=none; b=F/FpHKRFEb3Uw42Uh5ryNAWizHCrt0/baB5abJFt7lkgQeT3F5poHfvV+45qYdb04Gj3UnVH33qkMI9/f4GyNeZnZvx2rmFgRvG/alfMOTTgtVKBAN4yuNEEVQnW5wDEWrfOioS14eScm2httVlWbaKr0+1G2HG4magBTJn6yCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325983; c=relaxed/simple;
	bh=DquXfD9Tt+0x3MTfcptOq/P/MG1QIM/Maip3YD3JwnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f9BBkfnKgL2JuGWOX7W1ogb7tu3Ww/UskFhUxSSisZZamDBStIdRE9F5xvoVFDh5JnV9l0OdAxr2NEu+pTC+SlGCGXGHc/PC5WJWvAasEnzgJwwmrJitM8m9HrQW1qf0QHKIChruDIXZyRg5T7ZHiyrFVqVlmwiugXAn31/p9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pmswm066; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aDz9bb9M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pmswm066";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDz9bb9M"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787325980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77gF0INbeIPBg1x8Zq6Y4appNBmm4gaznUcxQdBUVmw=;
	b=Pmswm066Jm5ywD7nFmb1kvzufWyHCWwDmhAXbvN1NLLAfmUAKKlgII5eSEn8o0/0WawE2k
	IybirZUSjYj0kMg8Gj2rqm1cSnO+aNThpEtnkP47+5h1023D3eYb/zXQa36gSKWoPB5XW5
	1OhsBN9G/ZQFU5cwR4hmgkbtKcVUPHmGuDsi6geU77uiSDwtJ7FVzMkoxzUFo0GbvnGqC9
	hu8ikKh8fLCKAgy7MqS4yxsvj5emOD306huaiqYhTlDaLZrzLD++9HfQ7/QGSqcJ111rYY
	Fk/Y3q9AJVmxWuSGt1TEkeZaiHPjv4zsfeAz2ADPk4OCExbrQDW1RPKZEZdiag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787325980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77gF0INbeIPBg1x8Zq6Y4appNBmm4gaznUcxQdBUVmw=;
	b=aDz9bb9M2buwBbLgbJE0weyBu78dhyz9rVcoVAk/97Npy4pduiLPsBlFuyHRowFSg7gyMm
	yw9gg6MlkYEiyYBw==
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
Subject: [PATCH v2 0/2] vsprintf: Don't leak pointers 
Date: Fri, 21 Aug 2026 17:26:12 +0200
Message-ID: <20260821152614.2202196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It is possible to leak pointers via %ps without KALLSYMS enabled.
With KALLSYMS pointers can be leaked if they can not be resolved.

The tiny series has two patches, first addresses the first issue, the
second documents why we want to keep it that way.

v1=E2=80=A6v2: https://lore.kernel.org/all/20260814144854.746840-1-bigeasy@=
linutronix.de/
  - For %ps and !KALLSYMS no_hash_pointers is used to decide if the
    pointer should be written or not. This aligns with the %p policy.
  - For %ps and KALLSYMS, unresolved pointer continue to be leaked. It
    has been pointed out it might be useful to see them in backtraces/
    crashes if the return address became invalid.

Sebastian Andrzej Siewior (1):
  vsprintf: Don't leak pointers for %ps without KALLSYMS enabled
  kallsyms: Document why unresolved symbols are revealed

 kernel/kallsyms.c | 7 ++++++-
 lib/vsprintf.c    | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

--=20
2.55.0
