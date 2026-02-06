Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE735CBAF
	for <linux-hardening@vger.kernel.org>; Fri,  6 Feb 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370122; cv=none; b=m0oVyiEYZ56Z/jk52f4zdKgW8fhsOqbZbiEMnm3wEA3alFU3wf9tdiMAytwNw9BWEoNhGgMabp6+M5reH30u8K++nzHDVR9Shc3p9H2ZQgp8smppJZnSbzddelbD1YgTj2DzFKY0pynArjuh7duYmTX3CBFn5tVAIhmO2Znwd9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370122; c=relaxed/simple;
	bh=zxnWFKojQO6aFxUH+flhLRJNy7Of3GO5/A4vWbmORUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebSWFxgY1cTOpmtLwr6d6etlQIfzNpIXtyPBxe10Ixhr1/LiCaTL49YhcmGxxYJ4ab4aXmSHhnNT4PqREADPGbGWUSskrkbenFrAXZlmil39zA2Gd9rXycGHkaoy0Do03Qfebc2PaSHG7oBsDtEzywx89l49joxA6KsF5HRTW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PLPmOquR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PLPmOquR"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-482f2599980so22153915e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Feb 2026 01:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770370120; x=1770974920; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7l0eS4ZS3Hx+zo3TMXCKY57/2jbb8XJIpZBlk+Z8Kik=;
        b=PLPmOquRlqttTDpJlTcWj0yxpCyLhnXDN7i12F8mxfYHkL0CQznOgP8rAMFrJqI722
         5FFsIakeIDvnzQVVYZBXk2xpxLR/LYPbJg0P6KIyRipdx8aNGNRsjGrr1sqOLoa8BGyE
         gnVKTM5nMb+Jan4dQH9F4eHCXaUETJzgqMbu6h6ThXODjm6VwcdzmwIlBzWo1OAb/3qM
         6xtFw7NASJOBVdutsGusc0GIgogP7KGXP69xlQXsv4icESCYs9BkaY6Se2rfm+Hv5Oq/
         UP+q17zYzs/DMFK72W6d6qrgM/jQFD6FEy5t5TPIysovL16FaBDRg74quAsUSnpL76HY
         pEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370120; x=1770974920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7l0eS4ZS3Hx+zo3TMXCKY57/2jbb8XJIpZBlk+Z8Kik=;
        b=O0C5To9MZY1qjXwoVuvUHXd0mmeoVsRFcYz3JXkQRASrgQ/87OzYzDpv6Pe4SwtgVd
         lYfOQGshOwqS+NFNBX8+TI/6/Y2XHIxIPB1JJn95FYkVPCReoslIS37vtSZpyQL873xp
         pmREXVhIdnISF5Dy2sYGV12LfojPiYgGd0C0YY1SiobALH/f3J+WOoXR2bjy1FPiLm5i
         WcRlW1VPyszsrPjuOzoUJAF732JnKBQPKtLYo2WW76H5KYEhIySHJSlNc06kcX1uBcin
         +JwHtJ4OJPIa5Ll3mZZZT7LF3tA47B/O4C+XN3JqOYGrMAljmuVLB/4AbEljLUSghE0k
         awQA==
X-Forwarded-Encrypted: i=1; AJvYcCWGdrhYAmm6mVp8NTtfkvXihP9572Y851HKHByfzM3c3r+iY6umBxpoa6BS3pJbDWAYIpxNY/itnGKTLMdKRzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDl6fFsSpopPCevsCoBdsd1NlLdOG17gb8lNt5CPnot2pFFyJh
	UXYlh4rDanVgSNqHTQSK2eY7ZhF1aGSymAzoYBYtfBYldVJhA5haneMl2QhenVbuhaQ=
X-Gm-Gg: AZuq6aJJ9ZfVH5nmy/Xs7MTmObID1PLJESFUlBFlPx6lSFIdrUX4RMKqizWLqyz8vS6
	D+hYzn0UsK0WyX4C9S/7mVgK4Po27WrzTrss5WbKcTaBT/3KiOqd7umY1/m7TWy+ynGjGwEcNls
	cruZTSPe0eCPdLxX3U14o/ceDnrlmpLaEvvqlz+hGWc0pkxr0J6CCz78qI2zDNjqRuqGhZgcqap
	+DFegnJ+AEZRyrZUJgVVgaKBiMdIea17tLksqctcxyIqn8QQWDCHGUC6p16VRM6+J5iLaNzTnWb
	RO/mrKS6nmbj/bS6AqPq/1fZAJ2kUySeJuM9ahPCk5tTYFuSc4mWXMrai34oSBH8CfwIK84GqRs
	oK7fSoZ+sa3WRaumBwujNjYDaB7idJPV17n1hq9wJgMSuD2+IO/NmUMz1K1hFhnayzobh2HZIQp
	+TK582yEVz0Baq4BeWcNvAHluF
X-Received: by 2002:a05:600c:5020:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-483201e72f5mr28128425e9.10.1770370120138;
        Fri, 06 Feb 2026 01:28:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832039d238sm25524675e9.0.2026.02.06.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:28:39 -0800 (PST)
Date: Fri, 6 Feb 2026 10:28:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-hardening@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] vsnprintf: drop __printf() attributes on binary printing
 functions
Message-ID: <aYW0RN2R_8zngExH@pathway.suse.cz>
References: <20260204132643.1302967-1-arnd@kernel.org>
 <aYRapf5K8wFGEO8v@pathway.suse.cz>
 <4637e47c-61b0-43bf-996e-6291f2b49f31@app.fastmail.com>
 <CAADnVQJ5uHCVm3d_hO35cgrrcoLYBgk9x5iee0rNXBqKkHjj4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ5uHCVm3d_hO35cgrrcoLYBgk9x5iee0rNXBqKkHjj4Q@mail.gmail.com>

On Thu 2026-02-05 07:58:10, Alexei Starovoitov wrote:
> On Thu, Feb 5, 2026 at 2:13 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Feb 5, 2026, at 09:53, Petr Mladek wrote:
> > > On Wed 2026-02-04 14:26:23, Arnd Bergmann wrote:
> > >> Fixes: 6b2c1e30ad68 ("seq_file: Mark binary printing functions with __printf() attribute")
> > >> Fixes: 7bf819aa992f ("vsnprintf: Mark binary printing functions with __printf() attribute")
> > >
> > > From the commit message, it is not obvious why reverting these commits
> > > won't bring back the warnings in the modified functions.
> > >
> > > My understanding is that the warnings won't get back thanks to
> > > the commit bd67c1c3c353b6560 ("vsnprintf: Silence false positive
> > > GCC warning for va_format()") as explained by the original cover
> > > letter, see
> > > https://lore.kernel.org/all/20250321144822.324050-1-andriy.shevchenko@linux.intel.com/#t
> > >
> > > It would be worth to mentionin this in the commit message.
> >
> > Unfortunately, I have not been able to reproduce the original
> > warnings at all. The va_format() warning and the patch to
> > silence that look entirely unrelated here, that was just the
> > compiler incorrectly identifying a function that does not even
> > take a format argument.
> >
> > I'm sure some other intermediate change managed to shut up
> > the warnings, but I don't know which one. My best guess would
> > be that 938df695e98d ("vsprintf: associate the format state with
> > the format pointer") made gcc no longer warn about bstr_printf(),
> > but that predates Andy's patch and I can't easily revert it for
> > testing. Checking out a kernel before those patches does have
> > the warning on va_format() but not on the other ones.

OK. The commit will include link to this thread. It should be good
enough ;-)

> > > I wonder who should take this patch. Should it go via
> > > printk/bpf/tracing or another tree?
> > > Does anyone has any preference, please?
> >
> > I think your tree makes most sense here, but I have no strong
> > preference.
> 
> As long as it makes into the upcoming merge window any tree is fine.
> Let's go via printk.

OK, I have committed the patch into printk/linux.git, branch for-6.20.

Best Regards,
Petr
