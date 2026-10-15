Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE31414400
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049605; cv=none; b=pH7+6tLCH99Gn2WF7Z9ebi9dJmMNs3YNlol0ae3FjFQDzAIpdeXkvYPj1ere+vlPpR3/e+FVHz4tVQejdhUQZ+ShZBTuleOXKkuZkgtKNrNklCtZpBAM5zl5X4lonnwRlglj5mf7QHHNVBT6Q/L72xUqmdmKK658MLo2FtHSK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049605; c=relaxed/simple;
	bh=Vi+rfJVvIqgKkcyz2ICIQLL5bR+7LUh01MJ2ti2Lny0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ObVTEsgmJwqggg9kGm7AsSDZHFuBM6083Tca6sr+ZoZRcYdu7GiJaei7ulMJvIZhicJW2ap80zakRsfp9hSguUDBYm5ZKjk/chAZIjiZAd7PG8jcR86SkiWVJnikOzNoUteF4qFfyqEgpqaXddG2IGa7t9rBB5I3UXiuMnENyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PHNwUqV7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a37jq287; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tk/KcdEa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1ohB1UH6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PHNwUqV7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a37jq287";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tk/KcdEa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1ohB1UH6"
Received: from murzim.nue2.suse.org (unknown [10.168.4.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9A481F7D1;
	Thu, 15 Oct 2026 07:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792049601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJbTsvcvsb0G5y7w606tSXjJzM1A5bxV6bfOl0odZ0A=;
	b=PHNwUqV7JNPF09xsv1EfDTwOy5Dln5CNj7kNDsq576U0s4lUxYZb0KUDqe/nM0VduhIJXQ
	3wEBpiS6oGHMKuRazcMTXU9dwuGm+D8obLGMriyIlSsntTJcDjf5X3FbxeqFr09C2Dt4rh
	vHTbFDpYxVpZjtOxt2lA8H2UKMIbZmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792049601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJbTsvcvsb0G5y7w606tSXjJzM1A5bxV6bfOl0odZ0A=;
	b=a37jq287UxZrbI1F8XjsUxg//kWYsU+JoWPmQcWBUipUBSGX76fPC6mjizL7luXonjeq7D
	aq1ZbHoid33gZyBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792049600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJbTsvcvsb0G5y7w606tSXjJzM1A5bxV6bfOl0odZ0A=;
	b=Tk/KcdEarawHSUGJ5O55WuWYYbUabBxigrgmo+dj6FwhRfoZaryJs9Hxa1iM+HkeVWkIf4
	6p6YUDAFsq6CZKRqp8XPlLScIJYJD+PBrXWgI8O4HCKAqAGgzSU6fn1I2On+0fJbfw1LPQ
	M9NzbelsFmSYmJ2tTHFR8LdZmkLIea4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792049600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJbTsvcvsb0G5y7w606tSXjJzM1A5bxV6bfOl0odZ0A=;
	b=1ohB1UH6ZOnE0Zt2MWS1lYKfirmzlBsQy2vppx1cwxG7xqSi7AYe9MkK26zInWYXhAFqcR
	HYS297UlFbheEiAA==
Date: Thu, 15 Oct 2026 09:33:20 +0200 (CEST)
From: Richard Biener <rguenther@suse.de>
To: Kees Cook <kees@kernel.org>
cc: Richard Biener <richard.guenther@gmail.com>, Jan Hubicka <hubicka@ucw.cz>, 
    Martin Jambor <mjambor@suse.cz>, gcc-patches@gcc.gnu.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipa-icf: Compare access path type sizes without TBAA
 [PR105438]
In-Reply-To: <20261015052441.7d2b3c-kees@kernel.org>
Message-ID: <39r25275-0488-rq01-55nq-28rs192rp368@fhfr.qr>
References: <20261010050537.i.784-kees@kernel.org> <CAFiYyc2gYAjiKDi+TeC9_qEX+LHa7fSxj42JjRtM6Dbi6Yfidw@mail.gmail.com> <20261015052441.7d2b3c-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[gmail.com,ucw.cz,suse.cz,gcc.gnu.org,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[murzim.nue2.suse.org:helo,suse.de:email]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, 14 Oct 2026, Kees Cook wrote:

> On Sun, Oct 11, 2026 at 04:50:41PM +0200, Richard Biener wrote:
> > >     In function 'small_to_big', inlined from 'f' at t.c:22:3:
> > >     warning: array subscript 'struct big[0]' is partly outside array bounds of 'struct small[1]' [-Warray-bounds=]
> >
> > I think these diagnostics are dubious with -fno-strict-aliasing which
> > essentially says you can access every object via any other objects type.
> 
> The source has no such access, though: each function reads and writes
> members through its own types, and every byte touched is inside the
> object. The "struct big" access to a "struct small" exists only in the
> body ICF picked, so the warning is about code GCC wrote rather than
> code the programmer wrote.
> 
> > So instead of this I'd rather work towards inlining the original
> > body rather than the ICF prevailing one.
> 
> That does seem like it could be better, but it's not clear to me how
> large a project that would be to accomplish.

I think for the case of ICF and non-LTO it should be possible to
"hack" this in;  it should be just to make sure the inline edges
point to the original body and hopefully the ICF "merge" is somehow
encoded clearly.  When the inline edge is set up correctly it should
possibly even work with LTO.

> This patch seems to DTRT, though. It doesn't appear to regress merging
> in a meaningful way for the Linux at least.

I don't dispute this, but it feels like a hack.  Either ICF should
work as if -fstrict-aliasing were given, but consistently so, and
for a good reason, or you could as well do -fno-ipa-icf when
building the kernel as you are doing so many we-don't-quite-want-C
things already.

> > And force-disable these kind of diagnostics with -fno-strict-aliasing?
> 
> I'd really rather not. Linux builds everything with -fno-strict-aliasing,
> so that would remove these checks from the kernel entirely. GCC's
> -Warray-bounds is still off by default for the kernel because of false
> positives like this one (which is why I'm trying to solve it), and I've
> been working toward enabling it, since it finds real bugs. (I have a
> stack of a dozen real issues that this found while doing a recent pass.)
> 
> For example (since I don't yet have links to the above stack), here
> are some random examples from a few years ago: a response struct passed
> where a bigger error struct was expected, whose "error" field was past
> the end of the object[1]:
> 
>   drivers/thunderbolt/xdomain.c:226:22: error: array subscript 'const struct tb_xdp_error_response[0]' is partly outside array bounds of 'struct tb_xdp_properties_changed_response[1]'
> 
> and a u64 remainder stored into an int on the stack[2]:
> 
>   include/linux/math64.h:56:20: error: array subscript 'u64 {aka long long unsigned int}[0]' is partly outside array bounds of 'int[1]'
> 
> But if you did disable diagnostics, which did you have in mind? If it's
> only warnings about an access whose type is bigger than the object while
> the bytes it touches are in bounds, that's narrower, but the first
> example above would still need to be caught, so I'd much rather just
> get ICF behaving nicely. :)
> 
> -Kees
> 
> [1] https://git.kernel.org/linus/19813551701d0
> [2] https://git.kernel.org/linus/9f3d543a9f737
> 
> 

-- 
Richard Biener <rguenther@suse.de>
SUSE Software Solutions Germany GmbH,
Frankenstrasse 146, 90461 Nuernberg, Germany;
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri; (HRB 36809, AG Nuernberg)
