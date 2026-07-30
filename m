Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21337C103;
	Thu, 30 Jul 2026 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387476; cv=none; b=YzceRMc6hs+31C9Vy6MeiIQsfwW50YPaKelOH52Ne2XEWgAliO6IW7atPitep312TyeXCzNS90CMDog/UlsOybwAYC0xi5x9nTs7A2b6JPREOEF4rqydhY/nimOk+MjK7e1IIF0zLhh1sgf1p+JFS2Mi5LQivBr+w8m5kShyFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387476; c=relaxed/simple;
	bh=D78rMY22cbMCOTL3UaPXAfi5yme+fY0FrRRjTvHaRQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA3lmIw6lsXQIRCCGPF+g/F5aMuClRK85iXp37uKQJJs3+4CIJ3DT+4RtB35xmM8BcW+fYWh89F7G+YM6OybstZ5HHbuT5I4dwTWvIjxUiWFGc07s58cVOx25ujNXzCcVaE513IGu5FlH0Gjt00RkRamD/uNA5QMIxG7+Pp8K1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XbR2/qLo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XbR2/qLo"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C0A1C40E0171;
	Thu, 30 Jul 2026 04:57:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QHdv9Ts-tiBk; Thu, 30 Jul 2026 04:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785387461; bh=fPcxBxN8VYIYEsxzbabJY56k8jXeoXBBrM3KXlIToXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbR2/qLo8brIYBXUbDP4gRcsezm2LDXhRbfrBNrq6Ds3DgO/xhDErHGdCSmK08ETy
	 Pb432ie+u4OaGRWIiyEdDUgz/wN+pauVnwmaKf5v9Lw3CjIP/kJw1zcgm757PsV04h
	 GH5z00qW+yJOlKq8l+4KhDE6btAjRju0b2exKHQep8rKVUhWx+Sra0OpWAwG27l+SF
	 ACtPxwWUMH9gAOWqdqWRNd2ePWJ3FrCBt1HUXdLONEl+mmAqzDUM8FoGczAlNFqChj
	 0EPb4e9rlqHSTuTWphXaTLQl1J965Q1tRDAgV9B+dUVPDteFqc3+8dFGKQ+dYdsTJi
	 JR5MyIKyt0q+fBk/kqLvJRWg8zdSnK9NWT0KLEnVn7MBuqV0V+JpAbFbTI7z034/6i
	 wIHlj6K6ZG8Evro4cWTY474T/FydQ28PJlevW0PP75CH08cJROz5AZqOoyxOGHchaC
	 hfSUHpuzISnFoP1DZtVEPU2pZ3z+V2UtifVaO47pjRTGAg/nptmBDCJ//glbVsHx5+
	 G8/9Txf5WQRd4foHB5eOFr1pR0qICcBoy2Vyak5QMpx9uiKSKxL36JrIYIaPmQbTuH
	 sbEVXDHYUr5ETTWnoYfjuhPqon4SxWtTqbheGnaVHI/MeXlvg9c3/oOC6twfj8tyFk
	 blx51dDEEyumXz19leBtOjCc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3727A40E014C;
	Thu, 30 Jul 2026 04:57:35 +0000 (UTC)
Date: Wed, 29 Jul 2026 21:57:31 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ian Bridges <icb@fastmail.org>
Cc: Robert Richter <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EDAC/thunderx: Replace strlcat() with snprintf() and
 seq_buf
Message-ID: <20260730045731.GGamrZu-0N2Qguzy9P@fat_crate.local>
References: <akYJUdY1hVABUQH6@dev>
 <amppKvK6mIJRmoL8@dev>
 <20260729230035.GDamqGE9bKD5ncU6ZV@fat_crate.local>
 <amq4ej83V5e7BRqh@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amq4ej83V5e7BRqh@dev>

On Wed, Jul 29, 2026 at 09:35:38PM -0500, Ian Bridges wrote:
> On Wed, Jul 29, 2026 at 04:00:35PM -0700, Borislav Petkov wrote:
> No, there is no hurry on my end. I'm still new to this process, so if
> the ping was not appropriate here please let me know.

Nah, the ping is ok. But soon you'll realize that everyone is overloaded with
work.

If you're wondering how to best help out, reviewing and testing patches is
very welcome.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
