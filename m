Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4213A265
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774102; cv=none; b=HWSGGvftn+46IsfG9kMrKtJozXbPXZAos9DiAaHgZ8nVN9JwKnpk0ci5Ds0GlmdVpbQSToEGr6RLHt6Ob4z63WZ2PCZCWBgAgD+vp6Z3cx4K1+Hu8OmakorTX0gSeSdJWARDxKvBqgf7jSgiBpHFKgZvi7XAZs267J/j9gWgA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774102; c=relaxed/simple;
	bh=tnrFrSyrtfd5q9IR099beA6KX8ykePjXKprgoNsqNFU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pFUecKySFD4MNVPpPW595INc9gFwj58fC6yhqAz5Md9Su92lfvZEPAtt1ww3Ou7ZyHp5FPWf+mTevyjBCdp/Y7s7HKZE9K7w0t0GIh82VCwOv4jJ0l5rUdRxa8n82zsGaTTz+1etPWwAMf5IUJSltRk6ufp01wf6lhVmnpdA5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pu64i8kU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tQapGghV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pu64i8kU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tQapGghV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pu64i8kU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tQapGghV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pu64i8kU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tQapGghV"
Received: from murzim.nue2.suse.org (unknown [10.168.4.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A06CA1F836;
	Thu, 21 Aug 2025 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755774097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09eW29bqX7oU+z4yOLmLM37wMoYZmdB2WE04HEealMk=;
	b=Pu64i8kU+xYOQM8+WUxdH00zldh7RpeQ+koLF6eCfToRmQIfdDoWnAV8IDwtqodd3em7Hj
	kO6hdFd9b3GB5XybK3CERt1IwBuPzEnEVezAJDzRBdnEXValAEa8P2Fqwjz7ln53fmERqr
	aDNionoRbAYkVb+5OymqcvzQ7+AH6ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755774097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09eW29bqX7oU+z4yOLmLM37wMoYZmdB2WE04HEealMk=;
	b=tQapGghV1IM0ESt//c85lsJWhCO2z67dINLjP0b6Gzf8QqzQxHxLma8MPSsw1e8JCcNUcI
	zWH92pxZyemDPsAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755774097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09eW29bqX7oU+z4yOLmLM37wMoYZmdB2WE04HEealMk=;
	b=Pu64i8kU+xYOQM8+WUxdH00zldh7RpeQ+koLF6eCfToRmQIfdDoWnAV8IDwtqodd3em7Hj
	kO6hdFd9b3GB5XybK3CERt1IwBuPzEnEVezAJDzRBdnEXValAEa8P2Fqwjz7ln53fmERqr
	aDNionoRbAYkVb+5OymqcvzQ7+AH6ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755774097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09eW29bqX7oU+z4yOLmLM37wMoYZmdB2WE04HEealMk=;
	b=tQapGghV1IM0ESt//c85lsJWhCO2z67dINLjP0b6Gzf8QqzQxHxLma8MPSsw1e8JCcNUcI
	zWH92pxZyemDPsAA==
Date: Thu, 21 Aug 2025 13:01:37 +0200 (CEST)
From: Richard Biener <rguenther@suse.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>, 
    Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>, 
    gcc-patches@gcc.gnu.org, Joseph Myers <josmyers@redhat.com>, 
    Jan Hubicka <hubicka@ucw.cz>, Richard Earnshaw <richard.earnshaw@arm.com>, 
    Richard Sandiford <richard.sandiford@arm.com>, 
    Marcus Shawcroft <marcus.shawcroft@arm.com>, 
    Kyrylo Tkachov <kyrylo.tkachov@arm.com>, Kito Cheng <kito.cheng@gmail.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Andrew Waterman <andrew@sifive.com>, 
    Jim Wilson <jim.wilson.gcc@gmail.com>, Dan Li <ashimida.1990@gmail.com>, 
    linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
In-Reply-To: <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
Message-ID: <q93o5262-po30-8n51-o17s-qrn0q96o51qp@fhfr.qr>
References: <20250821064202.work.893-kees@kernel.org> <20250821072708.3109244-3-kees@kernel.org> <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com> <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	R_RATELIMIT(0.00)[from(RL8y3m6pz8udumc8k65cwet)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,oracle.com,gcc.gnu.org,redhat.com,ucw.cz,arm.com,gmail.com,dabbelt.com,sifive.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fhfr.qr:mid,murzim.nue2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On Thu, 21 Aug 2025, Peter Zijlstra wrote:

> On Thu, Aug 21, 2025 at 01:16:56AM -0700, Andrew Pinski wrote:
> 
> > > +/* Compute KCFI type ID for a function declaration or function type
> > > (internal) */
> > > +static uint32_t
> > > +compute_kcfi_type_id (tree fntype_or_fndecl)
> > > +{
> > > +  if (!fntype_or_fndecl)
> > > +    return 0;
> > > +
> > > +  const char *canonical_name = mangle_function_type (fntype_or_fndecl);
> > > +  uint32_t base_type_id = kcfi_hash_string (canonical_name);
> > >
> > 
> > Now I am curious why this needs to be a mangled function name? Since the
> > function in C the symbol is just its name.
> > Is there documentation that says the hash needs to be based on all of the
> > function arguments types?
> 
> The whole point of kCFI is to limit the targets of indirect calls to
> functions of the same signature. The actual function name is immaterial.

What's the attack vector and how does kCFI achieve mitigating it?

Richard.
