Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC03E121C;
	Mon, 30 Mar 2026 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909971; cv=none; b=D8HAngCWQjxTORAlscPhWghBgS4bwBoJNfQUsDvUgil2LUNq7/WjSshSdup6R9q0incHkgEO9OYiK5ubgWNFDW6It1o3V2r+sksptDZ5tzW8GZJ2l/SDmXf+KZa+5iG+JvYAC8feP4KzWYATwA9pd6cQQD5xVdqbTMg2oSWLNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909971; c=relaxed/simple;
	bh=jdjkreioV8YbkCiGcWDAD1WfG8Wax7piA4f875vZDT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOSuarOKwlEchHuCdREeCLnh879YmzexaV9Q1rzN9ZX0m3MzeRkKM/5Z1+bBz2BkU/WulKzs4zWcPLBVHbe0NGMROGAs21nRUBrTYuGTVF4ZNFfDVLQdoyWsow/08ZvxjBxqTPwhIOxR1TpLuJ7YvZRraMqVsVKQ7xhFaoRes7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PyjSUQze; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PyjSUQze"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DFB5640E0299;
	Mon, 30 Mar 2026 22:32:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uIGQGxEosGS4; Mon, 30 Mar 2026 22:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774909955; bh=1fUMdOcX13pUHoQ96h+XxkyebCJ4N0W0QF7Vz2ARt88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyjSUQzekUBC5mO16TYwfsDP81hd1Q6qf1fDFTEYsEZzrgH59sg01GNHxwrBsLxAV
	 f5UIalZWuEptBez8XCmzKKhTxmLPXtQrbtByX9v5+COZr6A9E8ufLOuoWSlgTONpQp
	 Z98dAMHR/Z2nFSLFuG2qPC8ISCODGQv7qyI7G4jf5Lsks59dV361XPmsnHJlKzQ/Wd
	 /Y5iFuRyKPM2Eo8yGIb5vHq35pe9vYU3qpzQrkdzUnIqH4DoneNJZG0mhCfOJqx5Dm
	 WPW4ShVD1HzM5+LuaC6SUV4SaNeVgAO7wyc5ynQ+4ELLppHLpiMJkhUmyodii6kezK
	 +QqsD2GPNigu4P7hB73LZYGfaftt+YbUCbJZhSZY1TAaqljgjyhqTP/CRvgz2O6+np
	 tnJVOkMY7h3WmYi+dmH2oA2JvxHh1F0ql8mKqMlf1YkTZvFbxcDUN5C8W0DZtDUCSU
	 PTEaPzUsL9vC3+XqTmjoHwEMC1aNy6cYaGSUY8VfQYajirodZiRVvODOz+5jw95qh+
	 vUmEVBGiZOaHCasYYMSX0OB5ouCp/vRpkJYPv80s6LziAnVJ7RDiEaKGyo7caASOEs
	 63GNaL8eTxEea8oJZhGQF5iF4+4DJ7/giIp5TZqFJfPjnI6V+0WYRxMVuRBm+hHob7
	 +vuimZKfdIdlTkCYdXG5hapo=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9B6F140E0298;
	Mon, 30 Mar 2026 22:32:28 +0000 (UTC)
Date: Tue, 31 Mar 2026 00:32:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] EDAC/mc: Use kzalloc_flex()
Message-ID: <20260330223222.GJacr59uiTZzPRYbWX@fat_crate.local>
References: <20260327024828.7377-1-rosenp@gmail.com>
 <20260330151536.GDacqTmBlWRznyeoMG@fat_crate.local>
 <CAKxU2N8HqFRT+qb5ctCVckC6c=viR7u+xyUaHgm-87C5=yo1ig@mail.gmail.com>
 <20260330211123.GHacrm-03xUU_3yX66@fat_crate.local>
 <CAKxU2N__gE-bWBU6EkJmEK2gR7VE=Va+oN6EB2hpJoHbUiYVxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKxU2N__gE-bWBU6EkJmEK2gR7VE=Va+oN6EB2hpJoHbUiYVxg@mail.gmail.com>

On Mon, Mar 30, 2026 at 02:26:10PM -0700, Rosen Penev wrote:
> > Oh, hypothetical what-if. Yeah, pls drop all that gunk from commit messages
> > pls and simply concentrate on why the patch exists.
> Not sure what you mean.

I mean this: a commit message should simply state why a patch exists. Here's
what I did with yours:

    Convert struct mem_ctl_info to use flex array and use the new flex array
    helpers to enable runtime bounds checking, including annotating the array
    length member with __counted_by() for extra runtime analysis when requested.
    
    Move counter assignment immediately after allocation as required by
    __counted_by().
    
    Move memcpy() after the counter assignment so that it is initialized before
    the first reference to the flex array, as the new attribute requires.

The idea is that when one reads the commit message months, or even years from
now - something we all have to do on a daily basis - it should have all the
necessary information why the change was done.

And nothing else. The emphasis being on the latter part. In this case, what
this should have been and what some tools can do when lines are magically
ordered doesn't really matter. The change must be worth to exist for itself.
In this case, runtime bounds checking, which is something we all want.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
