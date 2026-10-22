Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697091;
	b=J5wiSSKNUTbevPH3DtdljiiIlEbxN6VxIpaEz2jXha7fbMTU4RP/QtlSgesbLL7lk5Y0
	 PD8m+mwQzPculaejGpuSRVwVuPqkVDbjT+Sn800ZkXhtIaF8SPtIkkdIWE27k7lzLIc2d
	 fCzVLxn24om4dzcKgjwbr7xuOx5EaLZwrEUfsrbJl1/hQnkJILZXmIMwa/r+QuQOKO5aj
	 O0M/lqGYRmwjmmA2DP39OR3N+yXJrLzkDSOOAqseesPENMscjvrVZL9yGSc7BmGcLVSAm
	 F+GSmLG6KTDgB6PMpa0xcWv/rNGHumwc5okqnhkP5KDhAG9GqGDYhiKm1xvlhy1IeiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697091;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rYWHiFbQm2dwxFsz4ZREOzfxKwGWqmDgU1C9LjFjhyk=;
	b=RQiTjFziGULhAbYZxVVJIPwJoVUWV4YPb+Y+8RDJ8O+Vp+tzJDI4QWS4RU5Bz8HXc7SH
	 aw2R6b3Ja5HB0n7EbWg7ypU5RXETDu3AEAtVNNTjUfzd1v3/IcG/DVj2jYvHA8TJ6zRKr
	 nuoaCLX3iZqHI84m2wf7UqEaxVrdh5VIJ/FUV+mBxT+iblLF/yoMqvBorfhugp1zKAGhY
	 l3tgTX5gZjXF52vGjpfQUpoapz1ThyWn0LbPFu0coYOzTJRIvjzb/fzgfB/jh0bCbatrR
	 chrnLYI+I77mLgknpZ/LbYLgwDtGjWescihpqAgxJ9e2o3db67mL5yVTspJTj8V5IBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Alb4+QzG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C293606A319
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Alb4+QzG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FEE1F01825;
	Thu, 22 Oct 2026 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792697090;
	bh=rYWHiFbQm2dwxFsz4ZREOzfxKwGWqmDgU1C9LjFjhyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Alb4+QzGmOybq6zgaMhrQhf4zE7DSXgf1WrNIQIK8f/OYx0GUOTPEBTy3h9fMJ1QT
	 XvWH3pwEgbsS8BBGjmmf/TqjBWmC8zcsDdkYTo3QT7MKatAMxPi+HHfjLep44VC1Gr
	 X8+ebnr087sDgmsr6Yt929X6/wSvoZJLKVfxec3ej0B40lTZ1Gv/BdNl51bAREvfNm
	 ehbMRz+tGxpRYBYJ2FIOEUgJTtqDhzBASYAEoji97k6Ty7G9iFqUb3WpoAOsFKgOr/
	 XjKeB0gGASsKvdKZZzwQz7taBmbJbD8zZYU/i7OST0ueuFQiKq/1qB7lK68xxYhTHH
	 3jFAxWYbQgRRg==
Date: Thu, 22 Oct 2026 12:24:50 -0700
From: Kees Cook <kees@kernel.org>
To: Martin Jambor <mjambor@suse.cz>
Cc: Jan Hubicka <hubicka@ucw.cz>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org, Richard Biener <rguenther@suse.de>
Subject: Re: [PATCH] ipa-icf: Step to the next caller past a thunk in
 redirect_all_callers
Message-ID: <202610221224.60CF7CE4B@keescook>
References: <20261015194513.i.609-kees@kernel.org>
 <pr158sq2-203s-20n3-q44q-o599q271r309@fhfr.qr>
 <ri68q3sl7zi.fsf@virgil.suse.cz>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ri68q3sl7zi.fsf@virgil.suse.cz>

On Tue, Oct 20, 2026 at 05:14:25PM +0200, Martin Jambor wrote:
> Hi,
> 
> On Mon, Oct 19 2026, Richard Biener wrote:
> > On Thu, 15 Oct 2026, Kees Cook wrote:
> >
> >> redirect_all_callers walks the callers of N, but steps past a thunk
> >> caller with next_callee, the next call the thunk makes.  A thunk makes
> >> only that one call, so the walk ends there, and so the callers after
> >> the thunk in the list would not be redirected.  This came with the thunk
> >> check in commit 17d1bf760f8 ("re PR target/65263").
> >
> > Huh.  This looks obvious to me, thus OK unless Jan or Martin object
> > soon.
> 
> This is fairly obviously OK.
> 
> Thanks for catching this!

I don't have commit access, so if someone can do that bit for me, I'd
appreciate it. :)

Thanks!

-- 
Kees Cook
