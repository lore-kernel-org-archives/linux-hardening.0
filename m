Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D8296BCC;
	Thu, 22 Jan 2026 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091396; cv=none; b=jDGIzV4gRO7Veni9r79EoHeSS1dx7Qyaf7w1j/3w6tHns/BmPuNcEEYg4ylWmCXGPn6L3wvUdbAj0q5vP9syL5XOCzq6NBgPHahzsNCePjslV4UTh/t6HTgzFdTvhIFrnijuNk6RYiQlAVw8G7Vh7xGTeiyw51oQAofBBsHW8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091396; c=relaxed/simple;
	bh=SZh4DhSrCZZ5UKYA95Zw35TEvcMnEB0+Nt+ie+sKyCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGRk2i9FjtaPAcMQCQkRQ5VS2p6DuQ4bW6Y9MIoevPz7v5rOYe5QqpIBL5aeORRAl7PXEDy6tJd3lzfcx+PxdTd3XP6pm+5/pohAQaoj57VS23mWZSR5/pKINuFLsy5d+UNo0bf6oYi+WIrO0Yckuvf3DW4Bu3SrqF6JqcPpLtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IgsxI8yr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IgsxI8yr"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 21CE740E02D3;
	Thu, 22 Jan 2026 14:16:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ikyRkQibUgcx; Thu, 22 Jan 2026 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769091388; bh=4euvMKc8KtfxXG5yeA8gHQMt678hhqBm5oh3AxOT2D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgsxI8yrunxbfyPA9TpESJeyEQ+FXVPUOhIryB0tuqYucYQJpgkuajMBv1sMY1ZSs
	 znHZklQYX6u5Fzpqg2PXfV6U5gphawRIqVgHpWanJIK68cf75ALvvP8IqLf487fBNE
	 0d+AgWioCkkJrmLlL4TrTd47tRb184liVM+MD6RgwX88LEmhAn6Rj4ahdaDw01yqPh
	 3vBnOWQFLMnxECvIyHABSG9/enGXRSGZAwU7PrXlrgwDj1fjYIdLOp7rufTgMqA+m9
	 6NysKqmDge2B/djjWT2UBfEXNNcM4RTWE6s2gBWEsgwjGVjqmEcRShlfDaKJOTgaiT
	 SKA/s9Shw9W1cN/64XxcUqmtiq59PX7z48/0S2X5owd3cjoVN3iyC9MaQrYL/N8AiV
	 9CTroPt+dnCgWgiebY3hcPV9efi53WHfD210v8y4MLQzHiUzgzCFpO6gbDQ8UU1bZ+
	 JmSAL3Dy7XpH+qxpOu7Q53Ezqj4/o14kaSGdVfcMGtANn7DmYMBNXY/1PZKyBCtVjS
	 hQYS4kRAbxaxQqaZ9fhbe4mI8ZzCS6vN9kPxIUWh7QUvBEkb3u1dSh+zQsVmBBISGQ
	 /y9md1rXmc091xz9aDc36vl/hLUNrImiXO7KOvdsUo/ZdlLngV1MubkXh/oYlTVG8C
	 KAlNNtD6+awItJgugNa9ZudQ=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D23B540E02E6;
	Thu, 22 Jan 2026 14:16:14 +0000 (UTC)
Date: Thu, 22 Jan 2026 15:16:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT PATCH 01/19] x86/idt: Move idt_table to __ro_after_init
 section
Message-ID: <20260122141606.GDaXIxJuTqPFyqmVJG@fat_crate.local>
References: <20260108092526.28586-21-ardb@kernel.org>
 <20260108092526.28586-22-ardb@kernel.org>
 <20260122130839.GFaXIhV9SPFzS-RDnj@fat_crate.local>
 <CAMj1kXFK-Xf73wHDnidhDdMpb=UrWaf3vQhnggmNqOJspKYqvg@mail.gmail.com>
 <20260122135831.GCaXItB6KFO_HRqGcD@fat_crate.local>
 <CAMj1kXEVEbZGaVKdLp-95ffFv_cy181sB791LJYptkL+ap3VhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEVEbZGaVKdLp-95ffFv_cy181sB791LJYptkL+ap3VhQ@mail.gmail.com>

On Thu, Jan 22, 2026 at 03:09:19PM +0100, Ard Biesheuvel wrote:
> It does. It just doesn't prevent if from happening for other reasons.

So this reads to me like "it does but it doesn't". Huh?!?

C'mon Ard, let's be more precise pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
