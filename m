Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3747463B9E
	for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761281; cv=none; b=RbjDjMdYnqFBkByO7zdSkCZBwwOk5RfVYPuF77DJowRikUtnKqB6cS2nqkQF3YEpEQGbIBVMOh2711qUNNyJP/yukBrmRKnEi3yITuDlwWL0Vw8NFxMH6xFyBUucHXyvNoefcC5ikQFzvW0aS0PBbsU6J1PR/2u0KMlAR/dG0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761281; c=relaxed/simple;
	bh=2+O3WABopMW3GnoKX0HjL+BAqI96gmmbfVTAAvDLcgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6C01YpfVO6WCbqad4LGoB4/3hJA8QpdOXWJekOGNseTIcBjM1C7r4Sjd3n9F7OiycI/SHaX/PPWffYNuFWx9cfSSQs9PmIbXSMdcsCqXtxpE5zDoPqjz/FEo2D0qB8fzxQvrtNfj+uQbtDTC4mrcKMeZy8Gj3u0soOgtQ0Rj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aMJtpbSb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aMJtpbSb"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c247f6687dcso151237866b.2
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787761275; x=1788366075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A/o2FgUAsfo/UlLxRJQ4K5MewR57krZglChd1nkAI3M=;
        b=aMJtpbSbSMSm/Q03/E8yCTjchaZsjMI87yLUtE77orb9fRE5gMy6awZHDr0j0DWS5n
         hU8tPlwGmO087zpzmEjaSjzcMrmbfjWPKzuwtQB7d5OP2rbMW3OCPeGdohh1FnRStI8P
         Ovu+HeE/43eLMwpjtFk0BnMArpoB6sgku3aqV6lJ3utMqV/5CMHB9kl2VXi9uVKd8QdE
         64KbNpKnuX7fjSiTcb3OTIdzqEQaAtSFeGc5O347WWbEWlk6g2tAQeB2GCxF9lHGJcy6
         cW2oHvj/U5YCQ9Emddi461+OFMcDuk3l9O5CQS0S2oozekbaPoPoF6g/63hM1QhUuvzh
         GxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787761275; x=1788366075;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/o2FgUAsfo/UlLxRJQ4K5MewR57krZglChd1nkAI3M=;
        b=GccdRTSqj4+bbRs5OVp2EGkdzgu8o9Ln3FT8phtAesbeVg8Gr7DpFebUYN3y+S9MHY
         R4fxbRPtmvJ6LfTvCikoopSu6uRLlOVvfyyrXwSMMsbiIg6Iip0j26p1tnHXncr405Fx
         jf8UFa1u/t/0NiOMALA9sLRK3D6RRc0wokRKAQYYiz/m0jTA9kFwR8wd+m1Romd5tB1O
         PT+hNfuZ2IscgM+GwkNAS6/D9p2adn5wrk7zaVi8DrM6j7HZkCHYGpfK890pHrr+p7+b
         j6Vg6lJEt5TPx8w7zHqKkbxjaK+d34NH/MeGFdVkafHuQOFywGZFi37o614i94ixyGMG
         OCxw==
X-Forwarded-Encrypted: i=1; AHgh+RrIKP01L43XmTXl6W7mi48HIGA//qSwYtWMlkz3X86udru6KfRuK1mwMpMXMqHXSvvMqVUKBIFA/QLEjtWGEGY=@vger.kernel.org
X-Gm-Message-State: AFuF++nCV6nFkIy2scknFpb2+ZR2RezBP0aPLR2eq0f2w0sPbueFdrGZ
	QQmcUE4bdkJxmK7k6pzPLL+Ncv9AxwuKH9wBOdPHbjcgPqs8QsNUJCfn91MTN50RyWI=
X-Gm-Gg: AR+sD12L01HgN4CDDhhx4zpwfjFl49cEFTPOhWkfEupazOs5fOsKrDPVrLZ0MalcWDo
	qBth7F/UwqaD0Rz8PZx8WOOrFC7EP9pbOGxqxkI4WcQ7E4n/vBkCuMrBfjQe39QYZ+9ilyOCFx8
	iEGuHNOqu+rE0sy6hgkxTyPiVxMKhL1lLQ5yx+PAwIlS/ntCMK3zGXt01f9muDhjGCTwcbKKNvm
	uIuSQ0XblL7BZr81QSCsg95xP+SWIQMCiR3fJKZin8G0AK7RhOnroS2lGKezRpV3JqjZ3rxiw//
	IQBJVoPVqW1rVauSmwX/vFetSCJEXAWXMzWvY9E1QV/mEAYtHhpA1bFTIIisX1k5C+lqMyExeKp
	qS2VKcHkhU/JodspQtFZ3xFPVb4hB+9iNLKjAIl8TrplmeYWj2YV1g9Jwoni/i7I9soOF+CGHGs
	PDKqBjIGVBYzkt1jgLRAq8s1oHES/u2THmIpHcE/gFrnT4lScD4NtcqyuWnPIdcg==
X-Received: by 2002:a17:906:6290:b0:c25:32b0:e56c with SMTP id a640c23a62f3a-c2532b0ef77mr267399066b.4.1787761275095;
        Wed, 26 Aug 2026 09:21:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2533945d0esm67762266b.9.2026.08.26.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 09:21:14 -0700 (PDT)
Date: Wed, 26 Aug 2026 18:21:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] kallsyms: Document why unresolved symbols are
 revealed
Message-ID: <ao8SeCCG65uwH-Tk@pathway.suse.cz>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
 <20260821152614.2202196-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821152614.2202196-3-bigeasy@linutronix.de>

Adding Linus into Cc.

On Fri 2026-08-21 17:26:14, Sebastian Andrzej Siewior wrote:
> __sprint_symbol() is supposed to resolve the passed address to a symbol
> name. If the symbol can not be resolved it will print the actual pointer
> that was passed. The pointer policy is to not reveal actual pointer
> values. However for post-mortem analysis of crashes it is helpful to see
> the raw pointer if it is a corrupted pointer.
> 
> Document why raw unresolved pointers are printed.

> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -482,8 +482,13 @@ static int __sprint_symbol(char *buffer, unsigned long address,
>  	address += symbol_offset;
>  	len = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
>  				       buffer);
> -	if (!len)
> +	if (!len) {
> +		/*
> +		 * Print the raw pointer to allow post-mortem analysis of corrupted
> +		 * pointer in backtraces.

This might be acceptable when the system is going to panic().
But is this formatting used only during panic?

> +		 */
>  		return sprintf(buffer, "0x%lx", address - symbol_offset);

I expected that we would replace this by "%p" so that the pointer got
hashed by default. After all, we suggest to use %ps because it should
not leak pointers.

Hmm, I see %ps or %pS used by many interfaces, like procfs, sysfs,
ftrace. Many of them are accessible only by root. Maybe, people expect
to see the valid pointers.

But we do not want to repeate the %pK eperience here. We could not
reliably check the access rights of the vsprintf() caller.
So, we should agree on the default behavior which does not
depend on the caller.

And I think that we want to reduce the risk of leaking.
So, I would use %p here.

If some callers really want to always print the real pointer when
the symbol is not resolved then we might add some modifier for
this, e.g. %p[SsB][R][p], where p would mean plain. But I am
not sure if we really want it.

> +	}
>  
>  	offset -= symbol_offset;

Best Regards,
Petr
