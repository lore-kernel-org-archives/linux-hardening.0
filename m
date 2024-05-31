Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF96AD59;
	Fri, 31 May 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191969; cv=none; b=geUZeM4z6GrvXg0K20ZeA6MVjAH7Ko1aKDoyzJMSTBkBGAJSVRqalJVEMIZDTWzFEx9CCrrXQZM4320t1+tiyJtkEMaJ3fSrDYszZiWkYSUN+sPLGBWghO3PHrTY3jIpDG8/V6dXv+zP2SB2rf39h2x+63zA+psZXF7V2iwgW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191969; c=relaxed/simple;
	bh=gghBl4JNIy95VfLrfwUP2Off8V0JTaP9S92vAyIBtpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUogEvR+MEuWjgBF3l/3KzSys+lw8trAwiDdlTq4pc1HhDoENiGX82RRrBTAjhjGxoSvEglW6GsW1LfjO+NnGYwL5lJS/7YdD41ouvKLfV0ut7ZzXUdOw/hAZwDle8J5rXPvSYF49lGLC1SHVoPU/CT+VUh36vpeRi8urGhlfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QMfXA6y7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QMfXA6y7"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E46A540E02BA;
	Fri, 31 May 2024 21:46:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mp9dd_f_l4Ta; Fri, 31 May 2024 21:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717191961; bh=EB3b0oK1NO82II0HvxGp1gnqwn/B2ARuYc6PW/E4a7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMfXA6y7f3Wu0gHnuLb7og3I+KNwp73rGCOQrSpTYXYF+Hg9Eu5qWu6GUrWIe6kj8
	 5aaXWWbU0YxSm+yLfWZp3CA4SS1Saw+W+8gkPylwes3iA3HIlRnWXo65h5pllRglXF
	 WrEwA4ELVEp21OMiFsbRw+6U6LtNqw0Cr4ToQJJ3kRNV29lJwmF8Qwbn1DcG1HwFWk
	 DZq3Dnbdw10d814C7kg0VqbwvXikIXFXBYcVNFy2t03hbl4gbj/ZTQqaDMDvb/7vbY
	 o0H3w5gozMLcYeyMc5R4irUnvw5xp/IzbFHXRy4uuQzBWABd1ZGYQPUIjpTmWD9i2G
	 qwHN7xOgE7eB0rN2f+lAXwu8jIgDexgZJcIEqf3TDblDhVFh7uoYK7G9S6HUz8tebO
	 a9rzJsxyiwC+0DUebmLkOEfHAP5Zj6xZvjrwEEhXSKtUO5fxd9PT7lSrhrdWE59Mn9
	 WfnHXtOvWNQOsB0RxMBXNIn3cKdpvFixSoQ4PK9uQcmLe+RXPWch5T3tTqr/Z/HR0L
	 pFD0mmxZx1SEFa8m9mlW6JjkXXoktNbYHCYpQCDNahe3+7hwSt16Dx+GYDLwcIhdjS
	 upNpTLaoBiVNfHPMMzmRJtw1u9n2kucfbWt7wJuyIqpbPP6x4D96mso/A7eUMNcPpy
	 y4/wWrdmJ9q8fAMUy+tJe2sg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAB5340E02B9;
	Fri, 31 May 2024 21:45:50 +0000 (UTC)
Date: Fri, 31 May 2024 23:45:45 +0200
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
Message-ID: <20240531214545.GPZlpFCaXtTGinbcfl@fat_crate.local>
References: <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>
 <202405310951.56D9BD5C41@keescook>
 <20240531190816.GLZlogIGgpc5maOeLN@fat_crate.local>
 <202405311345.D91BF6E9@keescook>
 <20240531204947.GNZlo367G0YXVbOk1I@fat_crate.local>
 <202405311359.EFC7345EC@keescook>
 <20240531212009.GOZlo_CV0lxZ1xviQW@fat_crate.local>
 <202405311431.BF9FE3F7A7@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202405311431.BF9FE3F7A7@keescook>

On Fri, May 31, 2024 at 02:34:07PM -0700, Kees Cook wrote:
> On Fri, May 31, 2024 at 11:20:09PM +0200, Borislav Petkov wrote:
> > So I get an allergic reaction everytime we wag the dog - i.e., fix the
> > code because some tool or option can't handle it even if it is
> > a perfectly fine code. In that case it is an unused symbol.
> > 
> > And frankly, I'd prefer the silly warning to denote that fortify doesn't
> > need to do any checking there vs shutting it up just because.
> 
> If we want to declare that x86 boot will never perform string handling
> on strings with unknown lengths, we could just delete the boot/
> implementation of __fortify_panic(), and make it a hard failure if such
> cases are introduced in the future. This hasn't been a particularly
> friendly solution in the past, though, as the fortify routines do tend
> to grow additional coverage over time, so there may be future cases that
> do trip the runtime checking...

Yes, and we should not do anything right now either.

As said, I'd prefer the warning which actually says that fortify
routines are not used, which in itself is useful information vs shutting
it up.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
