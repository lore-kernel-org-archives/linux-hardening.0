Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66144BCA1;
	Tue,  1 Sep 2026 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788297072; cv=none; b=o1sVWqs87T1N7SuZZzKW5eznvfEqhLsxa3Hdsiqmqi/1WOqLo/90r7QjUMDkbVTdSGFHkOpcXVD/muHD8U/uq5r5CgQVW/Oel59RqW3NzqPtBvUULJuOGmzg/egi1IMyigAFOcFAL6fckOHGc0nyp7g0aKBAbQ0VMnRkdUEXnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788297072; c=relaxed/simple;
	bh=U5IEhO0qDVwiGJOxLAexGkrw9hPZ/qebp38QR60HJ+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+vZE20ugKBzorq3NgyQpZHTUwAcS9BrmLca7+0a+r1Qg9AufiIsRSfA3sn5+pS8v4WV8/I233+un6biyc+HlL+ml4/yp7vjk3X9kbQaHtvkGEXCEaLfC6/Ze8CwbEyYFDwNsinwh8Qnq1kxeRqH1FJJw5fcvLgutVxu5kQYnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBfEfBbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBfEfBbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA321F000E9;
	Tue,  1 Sep 2026 21:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788297071;
	bh=ykmxhHememF0txBG8E+wvvcWTDZvCd21RgcqcobuqV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DBfEfBbbHMnTWXpw6I8LehjUiNGCo/OsLUFtu8tCgVcOgnZZ+4+srfFgwzx7pMJRJ
	 7d5tjKI8wvg5bfonuVVaUFXTmvUAuSqIZAvXtWcrTvJQxA/8VZBV6PBLHFVw8baBjX
	 OXqC2lH6+bFt26aVcFrPo+E05wpUt5+3+gqkl+THXhHx5ysw4ZcxNeq1Coe0+8QTxm
	 T7yxw8LhxNv0P+n0m+XKT0aDHyfQ4y27CB4Y2J0Hat1rCympHoEoqWJIuKO1JWwAlu
	 K+XYlel2YNO59xcKNHZQJ1BmvxTrtvdQE/5m6qnRvafdH17gzHVRZc4nJ3oKAOa86Q
	 cW1UBhjLt9wbw==
Date: Tue, 1 Sep 2026 14:11:11 -0700
From: Kees Cook <kees@kernel.org>
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: nathan@kernel.org, nsc@kernel.org, linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v3] scripts/gcc-plugins: suppress recorded GCC switches
 for extmod builds
Message-ID: <202609011410.3F904D4@keescook>
References: <20260817185146.GC1249844@ax162>
 <20260820060116.786173-1-jaihindy@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820060116.786173-1-jaihindy@qti.qualcomm.com>

On Thu, Aug 20, 2026 at 11:31:16AM +0530, Jaihind Yadav wrote:
> With GCC plugins enabled, external module builds can record
> -fplugin=... paths in DWARF producer metadata via
> -grecord-gcc-switches, leaking host/build specific paths and
> triggering QA checks.
> 
> Handle this in scripts/Makefile.gcc-plugins for KBUILD_EXTMOD
> builds by adding -gno-record-gcc-switches to plugin cflags.
> 
> This keeps plugin behavior unchanged while avoiding absolute
> plugin path leakage in external module debug metadata.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/all/20260817185146.GC1249844@ax162/
> Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>

Acked-by: Kees Cook <kees@kernel.org>

I'm fine with this going via the kbuild tree. :)

-Kees

-- 
Kees Cook
