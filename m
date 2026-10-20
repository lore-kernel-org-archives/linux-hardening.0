Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509277;
	b=r1/pW4ZHEvrbg71CxQjAGK8LABLUtScVdEWFB9LI5YsMMGTFsMt6ckMiJNrqSHlT3FZH
	 zRWXN9+CjvCEq3WklCRoDspo0QBwmfRlyX339MhnvHkDS8yylErEbu5gw6Wy0kVSRJyEJ
	 H1W2ShfNXcvni0CkxS9BglG5b9yEIMGoPBCtbgr8jev1TdAG4eTwxcuDSjhUbzZYyAA+N
	 6HrLEewyId3e9TH4p5bLKjH6OQO8aPjIIOZRtS4aW4EKmU6rp5JrKJLztP2fKDikIO+1Z
	 flv/04jw4u6DN5vtSpS5JvxqaSAclFFkGd4xVXS2ksndSlZQQM4FsEiLhsZEuCOgkTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509277;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spamd-Result;
	bh=CqjCtBFUFd+1iHaj1nr2DkTfyqVxORiTyYK/8Gv0TZk=;
	b=faypXvlEn9E1lBdVmsq1NGIC/T8/LW7cRXrn7/K+xSGqjJ4KY14mLuk60PNORfWYbR2T
	 RCJRT6EPHENuHxuOT+4On3oPHFYNcAEvx5yzKyvV689Xa0lcYbTUALF0QvgLUG0EZzlyy
	 QkdYg+UR5CY42IfMdtjFJuMPy8ZRYC0Ealp0uSGTtsv7coXgMeyK5JRivKPK5RoVWLTU/
	 5Fd8KUlov9OEnLpN48vDkIIkVsUgFe5yrIN/+pGYzBhStiOaC5WmxKhKHwU9+WspBa/77
	 Ull+H2bIhwkQN8SAKJ7Mve4y9RGQV2CjouloXr9NB/o0WUaJb7HkyTUeA/38AQ7O73g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BhyVvHxe;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7zFuOTts;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Xl1DC7bo;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5VRyfUyg;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671F606A33B
	for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2026 15:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D671F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BhyVvHxe;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7zFuOTts;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Xl1DC7bo;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5VRyfUyg
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC2E321BD4;
	Tue, 20 Oct 2026 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792509275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqjCtBFUFd+1iHaj1nr2DkTfyqVxORiTyYK/8Gv0TZk=;
	b=BhyVvHxeWuX/9WDvsA9oO1UJopJKQ3RNZfOTT4RgeepDRlfRGe2nEA02kzwQyXaQQBzgiG
	PZcr6lV8NX408C1lBxlxpoKn9LVfUQAruRjRVBkeOc959kBI674FRYqPATNf8Q0AEvLh+6
	WVO/l5M1fDlsvsj2zNyYMDXNKwkJEDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792509275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqjCtBFUFd+1iHaj1nr2DkTfyqVxORiTyYK/8Gv0TZk=;
	b=7zFuOTtszKaFAJlGTkZjt/qpTNpl41uFt5jFxTT2pHVQRYbHJjrpisI9WeXHV8X31fhB/S
	A8ovEvnPWlkksCDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792509274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqjCtBFUFd+1iHaj1nr2DkTfyqVxORiTyYK/8Gv0TZk=;
	b=Xl1DC7bondVlvqcb1sWlYHDvk3A5Cb4AnXooVzzupQr6UMIl5+IvqDHsY2Bx62BK4nCe8C
	S1zvPaly0shInWleCBBQa5qP/otcDYDb1I6+5pOa7je2OJdQ2OJTEn8KGVftQqOrFOe+ac
	CAOsAvfHhEEr6Eb9nnXL2cZMQNw1MxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792509274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqjCtBFUFd+1iHaj1nr2DkTfyqVxORiTyYK/8Gv0TZk=;
	b=5VRyfUyg8whal1MMkSk0JunYlLH8WcX7BJke8FdtJcrgiTqydecCfUNRQH17NAr5Rhwwmz
	cRlgucdeg7EpR0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FDDF136CC;
	Tue, 20 Oct 2026 15:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mD7+FlqF12rAbgAAD6G6ig
	(envelope-from <mjambor@suse.cz>); Tue, 20 Oct 2026 15:14:34 +0000
From: Martin Jambor <mjambor@suse.cz>
To: Kees Cook <kees@kernel.org>
Cc: Jan Hubicka <hubicka@ucw.cz>, gcc-patches@gcc.gnu.org,
 linux-hardening@vger.kernel.org, Richard Biener <rguenther@suse.de>
Subject: Re: [PATCH] ipa-icf: Step to the next caller past a thunk in
 redirect_all_callers
In-Reply-To: <pr158sq2-203s-20n3-q44q-o599q271r309@fhfr.qr>
References: <20261015194513.i.609-kees@kernel.org>
 <pr158sq2-203s-20n3-q44q-o599q271r309@fhfr.qr>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org) Emacs/31.1
 (x86_64-suse-linux-gnu)
Date: Tue, 20 Oct 2026 17:14:25 +0200
Message-ID: <ri68q3sl7zi.fsf@virgil.suse.cz>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ipa-icf.cc:url,suse.de:email,imap1.dmz-prg2.suse.org:helo]

Hi,

On Mon, Oct 19 2026, Richard Biener wrote:
> On Thu, 15 Oct 2026, Kees Cook wrote:
>
>> redirect_all_callers walks the callers of N, but steps past a thunk
>> caller with next_callee, the next call the thunk makes.  A thunk makes
>> only that one call, so the walk ends there, and so the callers after
>> the thunk in the list would not be redirected.  This came with the thunk
>> check in commit 17d1bf760f8 ("re PR target/65263").
>
> Huh.  This looks obvious to me, thus OK unless Jan or Martin object
> soon.

This is fairly obviously OK.

Thanks for catching this!

Martin


>
> Thanks,
> Richard.
>
>> gcc/ChangeLog:
>> 
>> 	* ipa-icf.cc (redirect_all_callers): Step to the next caller, not
>> 	the next callee, past a thunk.
>> 
>> Signed-off-by: Kees Cook <kees@kernel.org>
>> ---
>> I found this while looking through ICF code and Richard's recently
>> proposed changes with inlining, so it's technically unrelated, but it
>> looked wrong.  But I haven't found a way to reach it: on targets with
>> symbol aliases a thunk calls a local alias of its function (.LTHUNKn),
>> whose other callers come from redirections and so are ahead of the thunk
>> in the list, and on targets without them, such as Darwin, thunks are
>> expanded to GIMPLE before ICF.  So I have not been able to build a test
>> case for this, and I suspect it may just be accidentally/effectively
>> dead code?  But the intent of the function didn't seem to match the
>> result of the "else"'s list-walk.
>> ---
>>  gcc/ipa-icf.cc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/gcc/ipa-icf.cc b/gcc/ipa-icf.cc
>> index 64cc722bd7aa..7b524bdf16b1 100644
>> --- a/gcc/ipa-icf.cc
>> +++ b/gcc/ipa-icf.cc
>> @@ -995,7 +995,7 @@ redirect_all_callers (cgraph_node *n, cgraph_node *to)
>>            nredirected++;
>>  	}
>>        else
>> -	e = e->next_callee;
>> +	e = e->next_caller;
>>      }
>>    for (unsigned i = 0; n->iterate_direct_aliases (i, ref);)
>>      {
>> 
>
> -- 
> Richard Biener <rguenther@suse.de>
> SUSE Software Solutions Germany GmbH,
> Frankenstrasse 146, 90461 Nuernberg, Germany;
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri; (HRB 36809, AG Nuernberg)
