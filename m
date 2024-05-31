Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6379DC7;
	Fri, 31 May 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188611; cv=none; b=QC5IhGIWWTXOzWCJKC2LI+qRnrgieq/xRxG+0nBp1te4fr5Fizqe+gMIyY3X+q5K7mTgIraRj4iJxPy4RWhiX7wNdmVSkO7aBt2VLAFXqDKQ7D2X2d7VmoG+jI7e3iEO5jLEeF+dovRy2c6SIuTOBQSzHw/sXQoZNSVod+aKR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188611; c=relaxed/simple;
	bh=CqlIzLo28saVuf9DPW5SY4U8PePcJgM43whMLoV3lrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYZ941sLRP4/Yw3wR0L2Ai/W94++8i8Z0Pe0bJXE8yHJG4VUS7E8IfDIL7HCqBhskOBeP1FmgJMONuYfErAOqIk/6qRXVSW+Auxcp/Hkc2wJ6nYT160EfxADYVftmDT7/L4d1EMbuhgzOFM1Cq0rnpYQPGdjDCMlysTcZRJl/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=exWSKQon; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="exWSKQon"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 45DB340E02BA;
	Fri, 31 May 2024 20:50:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id glGpxI6KoY2X; Fri, 31 May 2024 20:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717188604; bh=2eSJr/KNAbeYvj9YM7r9Ad2wggiAI2ZKgJwZBFOE4BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exWSKQont0SSjJ4Q+5EBEcsbrJZ3Y82KeK151Kt49xsWaE+8KHEzOEGWxPmDm0SUr
	 ejxfRJwoxK5jF/w0XDarZmUz9HZ3hh08Ma0VFfmx6NnHQvnXCvaukvakDRBnw3ioSG
	 dkCHJm7xsLaXpGUuh9fOIoIySoemnVTd/bBmMyQB4iY2y/O6EJGcIyvDfYS6Cv5N0I
	 j3hON/a4AT6Xj/4QWDe39scfvq8iUOzOrLF0ufATlBKTDzPd2wlmJQC06RmhBaHvm7
	 sqtD30CBDLVo7CHtt47ov8qjOrLwkSBzS4t6GrSn/U27BJR9DCLM/6HNBlLFNTjWHb
	 0VMY6/u06gLDQjSOtITh9T9dGULIWC+00FsRfU0UG9WLufO0kaj8qPrAiG9Vpol7UW
	 FUjeQ/R4Rw/CROk4R/s5FD3gi+Z0ENuDX6B7YJrfl2BP9985MQ4p5zhDctnElyrkZt
	 fvzzq0xnfl+MioiVyUhHYP21whoTaHqUJNxAhauGfmDXgNE0SziR9inRm/nuuuRWqF
	 rD3eITYn1WnXSA2iq1vL7oMqoJB5M/vq095HPhEQOa4voSKwb6bvMTSI6SuIZxPsLN
	 VyV5AdGzOBdFoKy0SnyKedwgJ1KjkewcLUxZ3Pq5Gf+nmfMQt9U8yAMpzob30qDgAY
	 wSw/pRhVixcRVIqP19cXVu0w=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A7C840E02B2;
	Fri, 31 May 2024 20:49:53 +0000 (UTC)
Date: Fri, 31 May 2024 22:49:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kees Cook <kees@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
Message-ID: <20240531204947.GNZlo367G0YXVbOk1I@fat_crate.local>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>
 <202405310951.56D9BD5C41@keescook>
 <20240531190816.GLZlogIGgpc5maOeLN@fat_crate.local>
 <202405311345.D91BF6E9@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202405311345.D91BF6E9@keescook>

On Fri, May 31, 2024 at 01:46:37PM -0700, Kees Cook wrote:
> Please do not do this. It still benefits from compile-time sanity
> checking.

Care to elaborate how exactly it benefits?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
