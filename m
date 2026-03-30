Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413E340A57;
	Mon, 30 Mar 2026 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905105; cv=none; b=QLR1yhgRNLD3ofgnmG9vBh3UnkEej+HrS+JoX8IixI6WCmCgEqgxkIPP7D4J0C5DyCNlT4GFtNm7ei+HBHqzfNBxdC8LrZteAn4n26hxGADHw6GhdoWRBbKrcUc3OfnPbrueQosqmDp8MognpiKxlX0LoRSXinKUGsWXSORfGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905105; c=relaxed/simple;
	bh=GrSETUBm/T+yHfezOHOji8a0xnjxZkB6dAXqpNKjSYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igIKjNtCrO1tgeL38gRsqUENlAWm8+aJtKt3oRxVnMdCBEGydO1J7kcgdVirQJ6mUBpqaMU82vFsPUhUX+pFNm48psb4CpoLJyd77+oTyrXHD+dMsR+hgyrEFWAooK0c2E7f/USsIXD9Np474Az/qu7DYuK3kKAwNIsLMd4+ItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fqf52Kx2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fqf52Kx2"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 149E940E0298;
	Mon, 30 Mar 2026 21:11:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o2EZ2t7nQJYz; Mon, 30 Mar 2026 21:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774905097; bh=vr1x4XE69Zqm7fOqnjLONCi+6TeHgvBMIuAXFiIbhK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqf52Kx2JramGDAIxQ5FunOov1SFQsDlIAsw2QtKElu2t/xx7CtKm2jCqvRMVpxhb
	 OQxHQgyCrj4VpD2Mfn3T+y0SBBnTBEk4a0hot36zI9iVMGg8iootDeQXsMNWu68Iwc
	 EpAK58VdsjrqVQEZh0+NE6t/4JUloReUW4JGhQ2eN99sgNF6bKxe8Je4M5NfU0dMZV
	 Y11h04kGOkoSQOUa0XNyj6t0rEX8ZMNIZTAv7PXCHUDS71Ei+fQ8R84gr7PDfJExxb
	 83ZEkrwA0ma+0yq47wEMs/jClzA2vM/NIIDRkOHBeu7p+eehunUahSjNv72FBURwS4
	 +i2EMwV6DzByP2bvxSI1JtJ/tfIEU4AuD7CMrV8GAmsNhXJUhXKoRv3vgDqsqM7vXr
	 MEtb/8R27iQxsweODUCHDwBIc6rJlvP5weCS/EficCLbKsoOXe5VE8c/iRkKbbLCB/
	 EUm6/9Y9sT6zEOLg/ov/uBGZHzbJ2qX/yRQTndogjMAOhKqsTY7h3kYtHAvfdeW55j
	 Tn+CeYn85vGrnnIqHPTUXPkGiDAajiImriX7njnHRloZz/a1KFzgx0jbKpQzTZj2ZT
	 wsKgEuIbxol3QYy3URb7Q8AV3SgfgOcogUegLcgJXR2AZruMn3ddJWE2xJwyUeKeHt
	 +nRonaPWrtX/DWTTvg64KyBY=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9513C40E015B;
	Mon, 30 Mar 2026 21:11:30 +0000 (UTC)
Date: Mon, 30 Mar 2026 23:11:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] EDAC/mc: Use kzalloc_flex()
Message-ID: <20260330211123.GHacrm-03xUU_3yX66@fat_crate.local>
References: <20260327024828.7377-1-rosenp@gmail.com>
 <20260330151536.GDacqTmBlWRznyeoMG@fat_crate.local>
 <CAKxU2N8HqFRT+qb5ctCVckC6c=viR7u+xyUaHgm-87C5=yo1ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKxU2N8HqFRT+qb5ctCVckC6c=viR7u+xyUaHgm-87C5=yo1ig@mail.gmail.com>

On Mon, Mar 30, 2026 at 01:49:36PM -0700, Rosen Penev wrote:
> call if such a thing were to eventually be introduced.

Oh, hypothetical what-if. Yeah, pls drop all that gunk from commit messages
pls and simply concentrate on why the patch exists.

But you don't have to for this one - I'll massage it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
