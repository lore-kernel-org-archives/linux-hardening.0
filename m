Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C24503ED
	for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402211; cv=pass; b=mzMgN7/W0bz05QuTYCHajjdZBi6NGQf7uEwGMRsReQib2hJHztLRmhzqrMKWQdx1H8Qw5CZxPerHrlF7W4mPY8dc1AStd8A6n54IEK/0O4yQjk84HOoA+PohnhADfF3Az73zmbjoKj/LRPwr+WL0WVpWwvLzc68pwD1uQglDuZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402211; c=relaxed/simple;
	bh=PUjiziNEMHv9KVvAHz5yTGk4BT4l174s5CjTaMAEZ04=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asVWf8wSXCqzjIk8A7URnhMqK8or2jWilUxje/cVisWmm2KmHoBXLef8oeo9F39aIIjRSDYgh8TZsaZYZNTkzvDYYjip2So8pVQCFZeWrMUsOmN+EqOLdyuFxYqYuPMazZX5EmGuMqb7yCtF9qO91xCD6CxyR3FRJq+i49rslBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com; spf=pass smtp.mailfrom=trukhin.com; dkim=fail (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b=fZad9d1O reason="key not found in DNS"; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trukhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b="fZad9d1O"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4af7283bf83so611599b6e.3
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 02:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402209; cv=none;
        d=google.com; s=arc-20260327;
        b=AGAm6WYkiVxr5GhRbmEPWAfHyd1Ji2WBxkaj7Nh/k87Kyd6YsNEVD4vzFxjdLUkLZJ
         Q10G457ZwyPpyugzVl+M0OEgVGZCcBlPtGUJ4buZGBtcZMAqF/ErvrsOi2TO4f7DHBPC
         fnr0/NxmbM9Klx2rzDe4rsv/wfh13Gv71w45CTLvyKOSiY6b3fh++g+3FqcztBnMxpHu
         +gCWdUtYedGJ9U9ydLfyok8ZINRCUiOobOnDrXKklM1yfRrmD+LeOjGTrbYN1Ly6UuW5
         yiDFTHn4fZ3GcUksUHgrlBXw5LvyXHaRiwI36o2iDgGFUgmX1AIA+nuw8nOpCT3MGJp4
         8VEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=hc3pxWFoIL1GHsifcw+K6D0g1vNndK05iALHsmZ6jX0=;
        fh=+A8NWO3DLDr3rYmgAUA2EEiSN/lrQR4yQe85zb1+U6g=;
        b=E33vVuvVRPCrCUm7YEZJq2EtBpN5CNG7B2CIve0rCYKn95qa10ACGeXBdd9qfZCoGc
         VIqXQGl7oRke2ihL4JkvlNHeB4EbkTrLhnMdPBf41NOglv63Bi+Q5qIhHD4m2L9Pn39K
         JAfO/wh10CLDKr6THOMT4mZ7ssJ1Ly6kdCEJ170p/27aBJWCD/i3qToMkjTxHkrCBbtv
         FWZrMSkjh9V0wPnw9kuDjBo6+PfjCrlsG6TDD7KGyG388UVtaA/EFG6kw4W2ebJtN78J
         ZYfCi1BBQ57a7vI7lOUuBHq/QI8EpP/RtU25S82taO3T59TlJ1yJC/Zl8aZUVUuHEVSG
         DEPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trukhin.com; s=google; t=1792402209; x=1793007009; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hc3pxWFoIL1GHsifcw+K6D0g1vNndK05iALHsmZ6jX0=;
        b=fZad9d1OY9NJSrhkU3A+62LbAvDI57kRzZfzmFfvLolWi+O8N5TrbxbEWbSGZYvO6f
         LwtCb8hxbe1a5ynW3WB3jhvNul1OCAKMmOFJfYSuhihJoZN0/MLCvgcQGJQM2ARM7V/E
         ZtxmU4VAobh4DZ7zAbYHKWGY1z6ZsEr7ktOmFasY9i7vG1hPL9wazljSmYCE3PrXDOFs
         IL1DD2AoUf1Y0IjaqcD6TXxokzNpx88Ghlll6/5vjOKu/Am6WOjT5yQawCnjikG/QQts
         MQ+71uuxNuM1ZLTPb0d55rYMn73w+MTyPVfNwRy+2Bufxh2uRKcIkOOMJ/ARI3tWygAf
         FA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792402209; x=1793007009;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hc3pxWFoIL1GHsifcw+K6D0g1vNndK05iALHsmZ6jX0=;
        b=XrI/aKDCzJfMHub+KocTWHy1tyZle9rsciREfguRtn4N1SJ5462CPsnqNHFovmcRRW
         cHP1hHZ+w3OyPvvnQJuHC2xPu4Wqn5HTGb8kUF983YFK+dUowQrcyveAak3lEIXd8vrj
         O/F4oUu5sgOIaCRSuTk8K6AoeNnr1kSUwcxGxoUx2DR0oZSXpa1F9Jq6TVej85pNmTZB
         5cSnyxLKcIWnVpACacMTrcJ3EpQlhMyIB0YHUZZHi+LRWgpanzMh75M9ZsHQqVf8EtvW
         Dd4z3A9ywquUk2zLhQipQrqVaqMsHl7xUUX9NmH8uV/YVLGFwIly1B7p4P/C1mTIvf3p
         jmcA==
X-Forwarded-Encrypted: i=1; AKwUvByRW56biAxvZN7GsD4KBCwfxUHnVhO+vlAaEoq7INBzTk7kvoa+8awrH4aXWYN5dRTYlui30K/hlWMnDL7pcOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJks5TQVBmdx+yuot9sXzdu3y6OHyssmsdAf8wOUV3+RuFGvG2p
	fED8nCkgIyz1gFsyLaBnvSnqstEGF30mkHsOqeN06s6vr0dLJnyvHSg5JUorNfqLRbh2sWmE85n
	vs116iPaFB/9STVrUQNeSYHk2NTkCy+oYNuS5mjGfpQ==
X-Gm-Gg: AYBFou2uBosMYWDXiGK25YClqBMLuoFn9AJo82rr3rkPavVKAGKOimFoSgj1PryPHfw
	IegSBO8CjcruoR3jSAPeR8Pb2PFbuqS8muyuBCfQ2DgTx4fL+SRSk0HNBCUX8Sx3SnFNn0U1qOQ
	nxyy1wFBXF9eZbn7luinG9uhwtc5CMmNXPqYE1po6EcbiX62D2dB+V03GcSgz6A8mVH663z8P4k
	ihlw8B6/oWnqnSBRYVfZGBgsYdf9Vg7bmlGDCSjtZM+PFsTIOkE4xLMzrgnFvVNHREVBNzBFzou
	k1HLVNkfwiycUpY2UmFGzRvMmkaxjpAEuXupkq6y2b1+ZblcTdJsstuX1iW4JK+VC9fhP1VorBL
	KUHpx5eQ9IeIeeOboSVFX02xmLpq0TjJWMvJHE7vRBXX52g+SEeGpqXmLoQ==
X-Received: by 2002:a05:6808:10c9:b0:4c3:d087:4446 with SMTP id
 5614622812f47-53cd0f1c6d5mr5243860b6e.42.1792402208617; Mon, 19 Oct 2026
 02:30:08 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 19 Oct 2026 02:30:08 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 19 Oct 2026 02:30:08 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Iurii Trukhin <yuri@trukhin.com>
In-Reply-To: <atXD1bP8NqDfnaoE@debian>
References: <CAOx7e9K707oLMN94TC=FBBZYKnwACsN-8mDVjsL+N+BBCmWTOA@mail.gmail.com>
 <atXD1bP8NqDfnaoE@debian>
Date: Mon, 19 Oct 2026 02:30:08 -0700
X-Gm-Features: AclHuK9CLzri4J91pqIi2kS9miZl1lVQnycxf40x9LXok0HRJz8gj47iCp1_r6Y
Message-ID: <CAOx7e9J=HPvJem1fcD6coi=wQeBLUzsGiuAyLWToq0y3aqeh0w@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add vmalloc() and vzalloc() to alloc with
 multiplies check
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Using typeof(*p) for the existing k/kv object helpers makes sense.
vmalloc_array() and vcalloc() take a count and a byte size, so their
fix needs to retain sizeof(...).

I suggest handling the k/kv change separately. While testing this patch,
I also found that the new vmalloc --fix path could copy masked strings
or comments from checkpatch's parsed statement. The prepared v2 uses
the original source instead; the regression tests cover those cases
and check the existing k/kv behavior.

Kees, would you prefer the typeof() change here or as a follow-up?

Thanks,
Iurii


On Mon, 19 Oct 2026 09:19:48 +0200, Alejandro Colomar
<alx+linux-hardening@kernel.org> wrote:
> Hi Iurii, Kees,
>
> > Date: 2026-10-14 20:20:06-0400
> > From: Iurii Trukhin <yuri@trukhin.com>
> >
> > vmalloc() and vzalloc() have 2-factor multiplication argument forms
> > vmalloc_array() and vcalloc() in <linux/vmalloc.h> that protect against
> > integer overflow during size calculation.
> >
> > Commit 070580b0b174 ("checkpatch: Suggest kmalloc_obj family for sizeof
> > allocations") updated ALLOC_WITH_MULTIPLY for the (kv|k)[mz]alloc()
> > family to suggest kmalloc_objs(type, count, gfp), while vmalloc_array()
> > and vcalloc() retain the (count, size) signature.
> >
> > Extend ALLOC_WITH_MULTIPLY to warn when vmalloc() or vzalloc() is called
> > with a 2-factor sizeof() multiplication and suggest vmalloc_array() or
> > vcalloc() respectively, including --fix support. Also include the 'v'
> > prefix in ALLOC_ARRAY_ARGS so swapped sizeof() first arguments to
> > vmalloc_array() and vcalloc() are flagged.
> >
> > Link: https://github.com/KSPP/linux/issues/342
> > Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
> > ---
> >  scripts/checkpatch.pl | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 8a7787d228a6..651a46f1fc40 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -7355,10 +7355,11 @@ sub process {
> >  		}
> >
> >
> > -# check for (kv|k)[mz]alloc with multiplies that could be
> > kmalloc_objs/kvmalloc_objs/kzalloc_objs/kvzalloc_objs
> > +# check for (kv|k|v)[mz]alloc with multiplies that could be
> > +# kmalloc_objs/kvmalloc_objs/kzalloc_objs/kvzalloc_objs/vmalloc_array/vcalloc
> >  		if ($perl_version_ok &&
> >  		    defined $stat &&
> > -		    $stat =~
> > /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/)
> > {
> > +		    $stat =~
> > /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*(?:,|\))/)
> > {
> >  			my $oldfunc = $3;
> >  			my $a1 = $4;
> >  			my $a2 = $10;
> > @@ -7366,6 +7367,8 @@ sub process {
> >  			$newfunc = "kvmalloc_objs" if ($oldfunc eq "kvmalloc");
> >  			$newfunc = "kvzalloc_objs" if ($oldfunc eq "kvzalloc");
> >  			$newfunc = "kzalloc_objs" if ($oldfunc eq "kzalloc");
> > +			$newfunc = "vmalloc_array" if ($oldfunc eq "vmalloc");
> > +			$newfunc = "vcalloc" if ($oldfunc eq "vzalloc");
> >  			my $r1 = $a1;
> >  			my $r2 = $a2;
> >  			if ($a1 =~ /^sizeof\s*\S/) {
> > @@ -7381,9 +7384,13 @@ sub process {
> >  					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
> >  				    $cnt == 1 &&
> >  				    $fix) {
> > -					my $sized = trim($r2);
> > -					$sized =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
> > -					$fixed[$fixlinenr] =~
> > s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1
> > . ' = ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
> > +					if ($oldfunc =~ /^v/) {
> > +						$fixed[$fixlinenr] =~
> > s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*(v[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1
> > . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
> > +					} else {
> > +						my $sized = trim($r2);
> > +						$sized =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
> > +						$fixed[$fixlinenr] =~
> > s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1
> > . ' = ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
> > +					}
>
> Could the suggested fix add a typeof() to the first parameter?  The only
> reason (AFAIK) Kees avoided adding typeof() in the first parameter was
> to minimize churn, but if someone is going to fix new code, it would be
> better if they do it good.  The good thing about using types explicitly
> is that it's safer.
>
> That is, it should suggest
> 	kmalloc_objs(typeof(*p), count, gfp)
> instead of
> 	kmalloc_objs(*p, count, gfp)
>
>
> What do you think?
>
>
> Have a lovely day!
> Alex
>
> >  				}
> >  			}
> >  		}
> > @@ -7397,7 +7404,7 @@ sub process {
> >  		}
> >
> >  # check for alloc argument mismatch
> > -		if ($line =~
> > /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/)
> > {
> > +		if ($line =~
> > /\b((?:devm_)?((?:k|kv|v)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/)
> > {
> >  			WARN("ALLOC_ARRAY_ARGS",
> >  			     "$1 uses number as first arg, sizeof is generally wrong\n" .
> > $herecurr);
> >  		}
> > --
> > 2.56.0
> >
>
> --
> <https://www.alejandro-colomar.es>
