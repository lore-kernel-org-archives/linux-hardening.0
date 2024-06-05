Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9C19006D;
	Wed,  5 Jun 2024 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580212; cv=none; b=s0NCjbaLvYEFvipxrBbccxTGBFpI7Dp30wCNDtqllns8M8sTeAfz8YMja8POw6dxFBGQ9s3M/X/vQQfdDNsdUJr56nYtMzco1OXdahqo4Mx1tUZiAo4KtjNfu8GEJvQXqr4vp+LV3mymU61OgOvlq0gpGhfHMe2SSLUE98Pb/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580212; c=relaxed/simple;
	bh=M77RrYoGQJJU2kRPKFShDM2HV1XAifjZT53RIOfzF74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaOKHFSKOWlbv0LyrSSRUd3ge5crTY5Ndmzp2tiaBwvxU2g+OKucbUA4rP99TaQF9Ywy17KEKkmCy7/KHBjsnWYqve0XYkBAAWC7oYUbAV4utj92fQH8OCEwda6ZEV3J5tLiITAxleO0ycI5tRjfMNoD1BYIdDhXLKgqcYHlBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ewFF97Ps; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ewFF97Ps"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9889E40E016C;
	Wed,  5 Jun 2024 09:36:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TrvBtMIroWna; Wed,  5 Jun 2024 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717580198; bh=sVAlGknADMTqq51pEmOH4pigiZZfPcaq6bynh+gDEbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewFF97Ps2admHqn0lwLWa440X4PnYGLeGoYNYX4dcK9Ffj0KHRdbkYsE/JaDALfLD
	 CefvwQjM3WilXIaxwbfCdVG8ggK1za/38BRiA1TSgoBVcly0o03sN86gAolqs0ks5I
	 mK4+MzugY7Mn153ID+uwVxKwNuO7ykSNoaBNxd2qKQseNE0oipQ9IYrPs4sbKr+sVj
	 pZfGUppgHKl96FoMYPv+TgdJKn5tBTKh/9hIUWXpQU5rBcNALVg+sijB0EHqQepK6n
	 9R8QkNU4qWht3/JgSil5iNxwHqP9wL2PtH0ZHGBhzScpoC5Lv1TxhFv66eGZ9Qb2o2
	 PsZi276qQDkPlv5FYKVwNj4cBo+iABFcSh05SNsIp6YRDHd3Lz5fi7XiPzs5pP9rpc
	 nMD6G006T+1vANZ9tEzttPUiFXlrXFhBrnABKBEtc8oT6kjvXZPJm8SNrjvE0XbwDP
	 a4eYsTCmwx6TX4Kwa1u8FhBg0Nb12ARLZNuwxigMCCmZBzFe9SA92Vk8v7qExtpqcG
	 7kl9SMDpg5FqpA9jl9iCWlqd1DRDsbhVOu+YthBIuZjUUsIt4ui7zS/MTpVaO1RFmp
	 AranekvnxE5O06adlOeQ6k9SruS9M4coSTXwhIlewMZe47lI7Pf3wHceDoOwUeHKQ/
	 eSmujPG6Fr2RL8s6c1iWpPSk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21B8C40E016A;
	Wed,  5 Jun 2024 09:36:15 +0000 (UTC)
Date: Wed, 5 Jun 2024 11:36:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@intel.com>, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
	mat.jonczyk@o2.pl, rdunlap@infradead.org,
	alexandre.belloni@bootlin.com, mario.limonciello@amd.com,
	yaolu@kylinos.cn, bhelgaas@google.com, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
Message-ID: <20240605093609.GCZmAxidNIBP5bkDcX@fat_crate.local>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com>
 <87wmnda8mc.ffs@tglx>
 <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
 <87le3t9i8c.ffs@tglx>
 <0aff3f62-a8a5-4358-ae3f-2ded339aface@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0aff3f62-a8a5-4358-ae3f-2ded339aface@zhaoxin.com>

On Wed, Jun 05, 2024 at 02:23:32PM +0800, Tony W Wang-oc wrote:
> After MCE has occurred, it is possible for the MCE handler to execute the
> add_taint() function without panic. For example, the fake_panic is
> configured.

fake_panic is an ancient debugging leftover. If you set it, you get what
you deserve.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
