Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F5327BFB
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814566; cv=none; b=s1Jmz3aLGKD5T8mDuloQECyhUxqRezUN5Lx2JRtr0OeVP3y4G2MRawCPtMGq5XqQw2MUe39YnC0cLDZTsdiqJvlDTPHVdqKRSl5fIK2fSi4MG4cppjEh7EWRBj3dYP5bntZKIPNNYe8/yyQO1Co3yB7PRk/xXq8FgEXQT6zYJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814566; c=relaxed/simple;
	bh=qpB51Aeg+CkniZ1rtbjt4DnLU9jxLSTGoxFvPKabjig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlE4Km1qalcUxFziQLZejGdx0j+csoBtnb8uVn+RESH0aXKjwge+M0SZ/bYsLynL7GSmJcKc42Bb2BPupujraQ7sK7a+KhnqRxOH4hk82wRvIyyDhT9k/IABwh6KTdNYUG+rx+5Jt9O4bFUqQ+Bf2T7FnLDWLuu7n6Ap92l595g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWD80hUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWD80hUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF67C1F000E9;
	Thu, 18 Jun 2026 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781814564;
	bh=nc12dwRCZ7Zzj+YXWKd6gVuv1OCMYhWk73jXpe3WNEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cWD80hUfFe4/RLEM2IRvauitR0ExJo4Qu8NAsZSr3rAb1zR0MwaTYf4yLezOGDQQn
	 7PdFG3sDsGIVaWJKCTfNDcjGCPlCESu786lc7qXW/LMchbHWZvsuSmJCfcM1jXHV8C
	 EkM+8j0SdtNhfE8nAOdeC0uASdNXMuisJZAZFzVrbOaAilG2wAtDa2kQu8eEh+8Spn
	 D1UpbuNTihyk8hYvABKq8v61yUZdHQ8/Y/dyKAf+d7bwUeV9GYJPEOcawd2MImEE5L
	 5FdFrcxwYpFm6GQOlYfiP4WRr/dbMtJq72Wn23lqVFqGHWGB7Hjj+qyy1XxSVO/TAt
	 xKoizcKEI1sNA==
Date: Thu, 18 Jun 2026 13:29:24 -0700
From: Kees Cook <kees@kernel.org>
To: Joseph Myers <josmyers@redhat.com>
Cc: Richard Biener <rguenther@suse.de>, Martin Uecker <uecker@tugraz.at>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] c: handle .ACCESS_WITH_SIZE in build_unary_op for
 !/+/- [PR125604]
Message-ID: <202606181328.ABB25F969C@keescook>
References: <20260618195646.it.067-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618195646.it.067-kees@kernel.org>

On Thu, Jun 18, 2026 at 12:56:51PM -0700, Kees Cook wrote:
> Unwrap the .ACCESS_WITH_SIZE call at the top of build_unary_op via
> get_ref_from_access_with_size.  These unary operators consume the
> pointer rvalue rather than the pointed-to data, so the bounds-checking
> wrapper is not load-bearing here.  The assertion is retained: after
> the unwrap it documents the post-condition the rest of the function
> relies on.

BTW, I don't have commit access, so if this patch looks good, I still
need someone to commit for me. :)

-- 
Kees Cook
