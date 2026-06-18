Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113943ED5C3;
	Thu, 18 Jun 2026 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777418; cv=none; b=AtGnd4Ewihd3vHoOpx94XTql26cct/ImlLhoBblxr4M1o38mjNXiQOitPMXUxCjxTuNeTZ49DoFbsAZYZ8pzLhB8dxeEnMnp9B/zcrBzQUHRd0ptcf9+fsdxJzF8CgaYupDKyUFxWx4uQyNMMltl6KF2iPFVxx7DFg9nmpc3v7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777418; c=relaxed/simple;
	bh=EpOWZFxQ6DR2wo0/80suRvf7rRXPrra1FlZB4nPAmzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uNrKFSA6gTYrC+xYcmgzRZRX1vtP1xzuc1q+pgu8MZ0UCA4R+SFLJCQc0vtnqxCrUDr7XvIgpQ9LrQDrW7tsnyqWxwMDQTlLfz3VSEA1ANpw6Nl+CYBNf0tHlpVGzTcCnL1c9Urrt9aBQqY1lLmPt2WXEFVozDxgfGiKOnDiSi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1NMPembt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1t8yWBLO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1NMPembt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1t8yWBLO"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781777406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpOWZFxQ6DR2wo0/80suRvf7rRXPrra1FlZB4nPAmzE=;
	b=1NMPembtpDTYGl6thPo+enIfhwbmgN9zfWBCCzUBiJ8vEgnczsHmZCUCnyhgXpsz5AHASG
	hOWzWxwLxAw4Dr+yXal7LnNj0aaZ9fyoj0WAIK8gcE8g+OAhu6zjNq2heZwXNNbdoibcKe
	7SEOuavo74Y8Hlo2skOhA0tuyb5jgf8TiJkvSTM4OmL8ZyIQ8MUCFpcUpUj0OmoOPzd5GN
	A0LXfpjLiJBGOI+5cDQAp1zX9YU6cZ3EjxxFiE88DejWyrcmlrj+hs5PHXkbDxhLjUpC+s
	bEvtBDinr2VzdWPZrAzYSHRqaT866ApBI0TjQZjpUNEyXjYLlNIrPHqWhfoMkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781777406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpOWZFxQ6DR2wo0/80suRvf7rRXPrra1FlZB4nPAmzE=;
	b=1t8yWBLOSem8KoFjo66ND+1WVCMTFUT1x9tpZSwC32Jv0XYgRpPWJinyWTbDCYAj9JpOBV
	hXP6aVDA96uk5iCw==
To: Kees Cook <kees@kernel.org>, Paul Walmsley <pjw@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones
 <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>,
 =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, Evan Green
 <evan@rivosinc.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] riscv: Add kCFI type prefix to unaligned copy routines
In-Reply-To: <20260618081252.work.711-kees@kernel.org>
References: <20260618081252.work.711-kees@kernel.org>
Date: Thu, 18 Jun 2026 12:10:00 +0200
Message-ID: <877bnwtb0n.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <kees@kernel.org> writes:
> __riscv_copy_words_unaligned() and __riscv_copy_bytes_unaligned() are
> called indirectly through function pointers from measure_cycles() (via
> compare_unaligned_access()) during the boot-time unaligned-access
> probe. Under kCFI, an indirect call checks the type id stored in the
> word immediately preceding the callee against the type id of the
> function-pointer type at the call site. These two routines are defined
> with SYM_FUNC_START(), which emits no __cfi_ prefix, so the check reads
> the alignment padding ahead of the function (zero) instead of a type id
> and traps:

This has already been fixed by commit f2abc305aa93f ("riscv: Define
__riscv_copy_{,vec_}{words,bytes}_unaligned() using SYM_TYPED_FUNC_START")

Nam
