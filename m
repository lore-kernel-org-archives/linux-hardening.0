Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3761DB356;
	Wed, 27 Aug 2025 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260784; cv=none; b=XNjq1OO1rNJGk4IGM2ehi4tXoNjKIxMcUPVWH2RyrE827Sq036hY2iI/2lwMgTNaZpWi8zPZPeuTRotred8sB3N/XqrpZbZvN+YzL953Zwpwxq4FzlojLNnEwOPUkFD73E3ZsP7w4cTSpEcznLtJItWJFBCypKTbmGob1C2zL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260784; c=relaxed/simple;
	bh=AFuDBk0eLL+Qy41VIQegDgTCTFROIcEB8P2huuPNwog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHOCbJF2OI5JaxR2GCZu0Nhk+KiTfmwBm3Ilftq4C0sjZ7gSTJ21AIJkNB0529CRWY4d/nN8F6lGpPxBo87oTjDxRGZT7NB1oS4VEs58krWQWzGiaL5KNOIk3ucmnk5onGjuLwCUo7Ef6HMJHieTES/zlG8JNOzPnKq7PLSY5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhUhZmhs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhUhZmhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9320C4CEF1;
	Wed, 27 Aug 2025 02:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756260783;
	bh=AFuDBk0eLL+Qy41VIQegDgTCTFROIcEB8P2huuPNwog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhUhZmhsbxOZ+lfXDAK8KkzQXW9IAzyP6K5mHeKz5Ahg+M56c5+phLxl7YpvWu6kk
	 W/x7Ykg31qwj2v77cv3SYjNFJPUV3LnAgdVzdiZecXiCvsmRsfix3QugEjBz5kY4D+
	 oVukQAZ237CFBzY3cPPJ9iXZRWPZ0WMbUBV07KepRFBYt6IAKa262QyhFYOyf2OUf7
	 HN9zGhRgCrq4lA8rhL0WhrMfjmhACnZKHVb4EjcJV4GWAR2DRDwgHa/a5XbOOYChsJ
	 iBtEN0syQrH7joaI7mR5TTQoTlXqWgo9tvTRAdMmA2GtNj0XeLUGsMbk/+sX24dIbG
	 oy58+u+trER+g==
Date: Tue, 26 Aug 2025 19:13:03 -0700
From: Kees Cook <kees@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>, kernel test robot <lkp@intel.com>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arc: Fix __fls() const-foldability via __builtin_clzl()
Message-ID: <202508261911.ECB628656@keescook>
References: <20250826034354.work.684-kees@kernel.org>
 <87ldn644d0.fsf@prevas.dk>
 <202508260955.2DE50A3FB@keescook>
 <aK5eNDa5H-PNGHpj@yury>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK5eNDa5H-PNGHpj@yury>

On Tue, Aug 26, 2025 at 09:24:04PM -0400, Yury Norov wrote:
> On Tue, Aug 26, 2025 at 09:56:06AM -0700, Kees Cook wrote:
> > On Tue, Aug 26, 2025 at 03:08:59PM +0200, Rasmus Villemoes wrote:
> > > If __builtin_arc_fls() simply doesn't qualify for attr_const for
> > > $reason, I think it would be good to have that documented in the commit
> > > msg. If it does, I think a gcc ticket and link to that would be in order.
> > 
> > I already sent the patch to fix it. :)
> > 
> > https://gcc.gnu.org/pipermail/gcc-patches/2025-August/693273.html
> 
> I'm OK taking the patch if it fixes real problem for you, but it looks
> more like a GCC problem, right? Is Clang also affected?

Without it, KUnit testing of ffs/fls fails on arc. Clang is not
affected. Even with the GCC fix landed, all older GCCs with still fail,
and since it provides a improved code generation for arc, it seems worth
it (compile-time-calculable values will be emitted instead of always
running the arc instructions).

> If, say, Clang is not affected, and you expect that newer GCC versions
> will not be affected too, let's protect the new code with a proper
> ifdefery, so that it will be easier to drop the workaround later?

I think the codegen benefit is worth it as I have it.

-- 
Kees Cook
