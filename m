Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1CA424D57
	for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409967; cv=none; b=qcblgchlV0Z3hxCEhKaRG4VYjPie6ZJnGwHlCeVyX9PKEPhYhMWXG9IQ5ztM8EjblzoRaJMMA1VVq0REFGOXI7B0iuYSMZOTFFX4G1AgfbB7/iZHGujlklj54Pj80kPZmjdan3DQHLVk4vZkxyJ2UGs7Y3k6cpsQYMBJf3kDWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409967; c=relaxed/simple;
	bh=awkNo/kj7yLvqZkoG+xfMVqvhGEQtvjXH6Uqmeinpo0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mg7nig2StJ+u/CHWsvj8ejW7QXwI/dieUH6y5kM4OWnNT1NVKdscykRelxxC/i3EEXoN7O1I0cPINnU9sL1TnXhiYNByWORJNe8jdtUUtnq+GyLNKKGvyUbgTsMgxWk57xOJoQKRmtlOTMj+7yWWxRufxXOznIDWKVm4kzTKdlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dt1kXcK/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kxg+qW4N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dt1kXcK/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kxg+qW4N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dt1kXcK/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kxg+qW4N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dt1kXcK/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kxg+qW4N"
Received: from murzim.nue2.suse.org (unknown [10.168.4.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99D0E21D11;
	Mon, 19 Oct 2026 11:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792409964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9p6r1N4CKIu4f5chNy8FH0LgCUaNNngbviF60xrsy7o=;
	b=Dt1kXcK/wNyO8qcX8G8yh1lJLqMSiB0QwKA9P+sYS7TD/F++uKIylTGGLxw5QUcXeZJlji
	VFfCT35khyJ1ujW128BAvQbw3WMLGyadTXdRK/IuhPn+frzhKYMwsx0z/7KKt2XG7Db87d
	o4WwgL/29MhBmAjUsIsC34qXD2AnlYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792409964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9p6r1N4CKIu4f5chNy8FH0LgCUaNNngbviF60xrsy7o=;
	b=Kxg+qW4NUs8J9jrjSkdYPZVE2eobt7EcFyrzEVdpo5xvQjqxMoODEDi6p33EmUbDAACDWj
	ROvujDTcZ2Ml4nAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792409964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9p6r1N4CKIu4f5chNy8FH0LgCUaNNngbviF60xrsy7o=;
	b=Dt1kXcK/wNyO8qcX8G8yh1lJLqMSiB0QwKA9P+sYS7TD/F++uKIylTGGLxw5QUcXeZJlji
	VFfCT35khyJ1ujW128BAvQbw3WMLGyadTXdRK/IuhPn+frzhKYMwsx0z/7KKt2XG7Db87d
	o4WwgL/29MhBmAjUsIsC34qXD2AnlYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792409964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9p6r1N4CKIu4f5chNy8FH0LgCUaNNngbviF60xrsy7o=;
	b=Kxg+qW4NUs8J9jrjSkdYPZVE2eobt7EcFyrzEVdpo5xvQjqxMoODEDi6p33EmUbDAACDWj
	ROvujDTcZ2Ml4nAA==
Date: Mon, 19 Oct 2026 13:39:24 +0200 (CEST)
From: Richard Biener <rguenther@suse.de>
To: Kees Cook <kees@kernel.org>
cc: Jan Hubicka <hubicka@ucw.cz>, 
    =?ISO-8859-15?Q?Martin_Li=A8ka?= <mliska@suse.cz>, gcc-patches@gcc.gnu.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipa-icf: Step to the next caller past a thunk in
 redirect_all_callers
In-Reply-To: <20261015194513.i.609-kees@kernel.org>
Message-ID: <pr158sq2-203s-20n3-q44q-o599q271r309@fhfr.qr>
References: <20261015194513.i.609-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Thu, 15 Oct 2026, Kees Cook wrote:

> redirect_all_callers walks the callers of N, but steps past a thunk
> caller with next_callee, the next call the thunk makes.  A thunk makes
> only that one call, so the walk ends there, and so the callers after
> the thunk in the list would not be redirected.  This came with the thunk
> check in commit 17d1bf760f8 ("re PR target/65263").

Huh.  This looks obvious to me, thus OK unless Jan or Martin object
soon.

Thanks,
Richard.

> gcc/ChangeLog:
> 
> 	* ipa-icf.cc (redirect_all_callers): Step to the next caller, not
> 	the next callee, past a thunk.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> I found this while looking through ICF code and Richard's recently
> proposed changes with inlining, so it's technically unrelated, but it
> looked wrong.  But I haven't found a way to reach it: on targets with
> symbol aliases a thunk calls a local alias of its function (.LTHUNKn),
> whose other callers come from redirections and so are ahead of the thunk
> in the list, and on targets without them, such as Darwin, thunks are
> expanded to GIMPLE before ICF.  So I have not been able to build a test
> case for this, and I suspect it may just be accidentally/effectively
> dead code?  But the intent of the function didn't seem to match the
> result of the "else"'s list-walk.
> ---
>  gcc/ipa-icf.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gcc/ipa-icf.cc b/gcc/ipa-icf.cc
> index 64cc722bd7aa..7b524bdf16b1 100644
> --- a/gcc/ipa-icf.cc
> +++ b/gcc/ipa-icf.cc
> @@ -995,7 +995,7 @@ redirect_all_callers (cgraph_node *n, cgraph_node *to)
>            nredirected++;
>  	}
>        else
> -	e = e->next_callee;
> +	e = e->next_caller;
>      }
>    for (unsigned i = 0; n->iterate_direct_aliases (i, ref);)
>      {
> 

-- 
Richard Biener <rguenther@suse.de>
SUSE Software Solutions Germany GmbH,
Frankenstrasse 146, 90461 Nuernberg, Germany;
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri; (HRB 36809, AG Nuernberg)
