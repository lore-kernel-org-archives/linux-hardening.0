Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64592EFDA2;
	Thu, 22 Jan 2026 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090338; cv=none; b=OMfSFRgYS1p2dqeNpLE+4KhzyJ4M4kWEUjoh1oalYorBJ9Ae4HZqcSRK1f+8UPWFMxNl2SGeFvYwAtsbiCYY368d5TyZfMZmEtdvA7XIVUR+wmCbSqoD4mNtbAF+HcJx8GdodDwY/wiiYX+PGB6hV/OXa49ZdmnQm87QFoBmjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090338; c=relaxed/simple;
	bh=BA5cTMo2CbmQeHPYvLarTYuHmVHUylrybgATyOnEcgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mco7KkLy7kp7alID7HL7EvqENjlGBeSj1peSyykOTxIbqmYfU+j87gjU2UeGD01SecPHbyalEjsawwHlxYOZZOmJDG4jQi0ZbJVOpjBq8//6TyKSQg87qLFL9N/0Sd5md10gGBwvxFu+ZWSnx6HtGBhT684aVjxMphAVE6szsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BP7zsIz4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BP7zsIz4"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 98AEA40E02D3;
	Thu, 22 Jan 2026 13:58:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ShzRnhewWz6C; Thu, 22 Jan 2026 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769090330; bh=e1SMLa4nPEDEXFFSYmr1ObVQq4xszZEmmC4Tff9ZniM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BP7zsIz4o1KrSxfXnZO+u28QZcEyfAdbRyq/DkLTESyor7jC975FGorLNmX4s2obZ
	 aZbBdiQ1BWH6sVd1S+yCe53qkTeJDmaP2vvFMiK2t52YU3FhC6vpMhM+peVFQlZReI
	 9cC8OiuxA1ZpqmsInp6K3ZihI7TwAEoE8UcCjVEWWhjbG+kWp0xrWFTA/pXVB4bQcJ
	 JQ5Mh7/vP9QLaF5m7n8StPjcS6AA8fk1ZzKsMogzBoni2VZ8rM2BcWwLW5Z6qWK4fT
	 FF4bqytSNeVWFJPG/zeN8y1NBv+0WiDtpzoN8eXNEUvaTHpuUeaKdhd0FVAvhU2gvb
	 oWdISrSbWNovUPPqeHwTynKYBMW6GBadX5QE4xiGOyig2BerXdFzO4m1J+TJNXDX8E
	 VyaILG/9U+yF7g5XJo7xks8vKK8GYPrSv9KSpbwirRcZQ7Y2ovzjHYhUtUqgPwk5b0
	 NStW+tEI+f4PP4QUG0H8bkjZibCY124RuRfBTVfkSS/X5lVZvNzhBq4vetDQ4KGifY
	 It6hGdE9veeXKy8ev1TBpng1QDa1xGpNno36CtlWBuyWSLzSXFpRLXf35epsnSFM68
	 Jk8oFX5SnU34jjhrbDhRP48/0fkB+Ei8WqaGfWx6KTuB5KiU9qVbknczoQqbCVFEML
	 5BR5uCYCd3yml5xGMXic7Iro=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id ECCA240E02E6;
	Thu, 22 Jan 2026 13:58:36 +0000 (UTC)
Date: Thu, 22 Jan 2026 14:58:31 +0100
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
Message-ID: <20260122135831.GCaXItB6KFO_HRqGcD@fat_crate.local>
References: <20260108092526.28586-21-ardb@kernel.org>
 <20260108092526.28586-22-ardb@kernel.org>
 <20260122130839.GFaXIhV9SPFzS-RDnj@fat_crate.local>
 <CAMj1kXFK-Xf73wHDnidhDdMpb=UrWaf3vQhnggmNqOJspKYqvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFK-Xf73wHDnidhDdMpb=UrWaf3vQhnggmNqOJspKYqvg@mail.gmail.com>

On Thu, Jan 22, 2026 at 02:48:14PM +0100, Ard Biesheuvel wrote:
> That is because the init region is between .data and .bss, which are
> not 2M aligned, and so freeing/remapping the init region breaks the
> hugepage mapping of the region between them. This is addressed in
> patch #3.

Ok, I'll continue looking but this commit message should not mislead in
stating that it prevents the "breaking up large page mappings." I'll fix it up
if I end up picking up this or you fix it up in your next revision please.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
