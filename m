Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA51CAA6;
	Fri, 31 May 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190435; cv=none; b=jpXiJoyhh7KWAraqY0EPunPSsZxdOCABoiQWiSEFSlHBkj1PnL1BAmNOh25x4bdzQukjELlgfQTLr6re38/KdW7R+XmT7VOPjzwhwa3JQu8p0vTtBSBzvjeCZQuQesbKMoPnc1nHWQxP5QJoIa4KHC8kmQEORtBNeiSk1cEbkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190435; c=relaxed/simple;
	bh=DYSIAFngwhG4d9k8FbXoD1jdg/3v/GIty7zsCQvOhJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WihFjczqZe7tat1KXG3PD6vWxjWLhOHVunXMLNiR+7G3ca6Yom4wPjFihxq6HbpbsBN+KJf7X1W1LygXX1JNE+h7sHDnsnwedY5wv/u6uAH2MqBrh8yNcfVLKqFVwTfPJQsbVGLhOMn4NSyMc+JbJS1QwfksgsGqKOmiV5br878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hTaeYk6A; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hTaeYk6A"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9CFE740E02B7;
	Fri, 31 May 2024 21:20:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zIDDVK4B_qjv; Fri, 31 May 2024 21:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717190427; bh=tHY1hcVxCcJ3Qq0c+H5bGa1+YZfmU+M7Xl3/p2DIUBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTaeYk6AyvfPvE+7dWAnYrlEJpabckfPR2IFRUV7MWXhQXzwWmyAPipyIn25WQGrq
	 YfN1dgS7k0tNp9oqolrTAkIyJSPfWGDoT/I0mm0/3AX5+lsc05oqU1ibyyBcpMRSG2
	 9aOFeqnQa26loXt9nUtnn5SX7PWv/jTo2/YElkJEp9w+WcSVp+cTQ82YqEnkcG0yFG
	 vuhkTUS75NAMqlEblf+T4gdVe2tireUE0+vbbKDDE64XbmGIR6JaLf4wYr+HgC64Rk
	 lcmAOEDt/crzdzN0LuRlyxHTwmQi1KY0zqs4KILdyB9OfSwaLA8ZCNPJRib7t0Zxyw
	 dXtPYsImuWS459i3/C/jP8YzwNV6XcIe9XJXP7QM2kR+Rr4CCgE06PIEI1LuXCLuBC
	 uCRxzBLqlRarTZcrJOuoXEVITqovObIQlSXSsQAMkmCcQuu6/qJgKyFDolMl22MKY+
	 JQWKuL1eFgCzFN3vQ579cif293o8oS13m4/jCnIoTlEY4oTQniYgZQoJs2poOmMKf5
	 8J8QzruBWhvWYXsGb6ddk0NRoYVA8EWKb1vMkp0pUq4S6+cvL/HooJKJWE0wu0bf5t
	 qHZ0mzjMlfxecPI28JYIM6TgovEczZNBcf72B4tBl8IzcBH3TsvnM2hcfzuzsgJDjk
	 XpMHsJLTw75g1rwcrN2ur5MA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 038DA40E02B2;
	Fri, 31 May 2024 21:20:15 +0000 (UTC)
Date: Fri, 31 May 2024 23:20:09 +0200
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
Message-ID: <20240531212009.GOZlo_CV0lxZ1xviQW@fat_crate.local>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>
 <202405310951.56D9BD5C41@keescook>
 <20240531190816.GLZlogIGgpc5maOeLN@fat_crate.local>
 <202405311345.D91BF6E9@keescook>
 <20240531204947.GNZlo367G0YXVbOk1I@fat_crate.local>
 <202405311359.EFC7345EC@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202405311359.EFC7345EC@keescook>

On Fri, May 31, 2024 at 02:06:48PM -0700, Kees Cook wrote:
> ...
> or refactors and forgets to change some name, etc. It's all for catching
> bugs before they happen, etc. And when source string lengths aren't
> known, the runtime checking can kick in too.

Aha, thanks for explaining.

> It happens x86 boot doesn't have any of those (good!) so
> __fortify_panic() goes unused there. But

Exactly!

> that's a larger topic covered by stuff like
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, etc.

"... This option is not well tested yet, so use at your own risk."

Oh well.

So I get an allergic reaction everytime we wag the dog - i.e., fix the
code because some tool or option can't handle it even if it is
a perfectly fine code. In that case it is an unused symbol.

And frankly, I'd prefer the silly warning to denote that fortify doesn't
need to do any checking there vs shutting it up just because.

So can we aim our efforts at real bugs please?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
