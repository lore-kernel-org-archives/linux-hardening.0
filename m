Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F773B8BA1;
	Thu,  9 Apr 2026 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759186; cv=none; b=KG0m1035ssyCrF+khRB1rTC8NzhAXbOtZGO9y56wTMnf3Fy1qn89HLB/Gv4kZovnda04mlSNKxo1+D+XJaarmfYVERFccUbmhGpkCc/zr/eVS0Lkd5yuKzsyZ2odZWqHYGzNlTgKsG1DHijDKrookwf7LlOQtdjns4Mt0kr4Pg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759186; c=relaxed/simple;
	bh=A9bQ1ncAabtfS0R/KDC5j3Rw8ryqwWgMdQsEDLefxIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK8vYftiUA3kjMkk1wV9AWhlFOi1G4fYNtfBig21mqa6kMiTiidmEwzialoXtn+ViC+izwSXGeLHa0Jch9Cblz3IZQPBMc7W21ysZrfV6lPuP6W5jtEgPtQcqLX7duSP7JFhGSSK3i4dm4+iDMNp4SuW97rFEHnr3SIe0/8GmPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZQ2+rBx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZQ2+rBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFA5C4CEF7;
	Thu,  9 Apr 2026 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775759186;
	bh=A9bQ1ncAabtfS0R/KDC5j3Rw8ryqwWgMdQsEDLefxIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZQ2+rBxvWmuIce0HjdzyCT5dl8IF6I19g+TmFN0ObVDlIwajMODXNLhWJoZVVbWo
	 v4H5Qcj0hK6FekJowIPUhOPY3DxwycXhV6o/1JApGpJZ6LU3sCjML6D7p0Kk1LbgS8
	 Owia3/628zTQCzHFkzbW8dqrwj+bHeoVngT0jcJ47hY+50U8ejSZMw9CaLALPP7PLz
	 dYFVmY35XVtYB3Y+lxcLhV2d9xG+Bc7CX3oCRRGzIAYbwXnoh8faQ8ehrXTDAdtwm9
	 BJmEK5biDnMt6J0tAcswILZnIcM5Yzam/P+ul95i+Yw9YZAimdJ+Qrhk6teyQjH+V7
	 bk30wz/a8909Q==
Date: Thu, 9 Apr 2026 11:26:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>, Richard Weinberger <richard@nod.at>,
	kernel test robot <lkp@intel.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] gcov: Disable GCOV_PROFILE_ALL on 32-bit UML with
 Clang 20/21
Message-ID: <20260409182620.GA2550473@ax162>
References: <20260409052038.make.995-kees@kernel.org>
 <5cf1d83227fd5a6af784f0b11fcdebf9a0bc9f94.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf1d83227fd5a6af784f0b11fcdebf9a0bc9f94.camel@sipsolutions.net>

On Thu, Apr 09, 2026 at 04:47:32PM +0200, Johannes Berg wrote:
> Hi,
> 
> Maybe the subject should say "um:" instead of "gcov:" now?
> 
> (I'm assuming you want us to apply it to uml tree.)
> 
> > Prevent the bad combination by disabling UML's ARCH_HAS_GCOV_PROFILE_ALL
> > on 32-bit when using Clang 20.x or 21.x.
> 
> You say 20.x or 21.x,
> 
> > +	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
> > +	# on 32-bit, causing spurious compile-time errors in check_copy_size().
> > +	select ARCH_HAS_GCOV_PROFILE_ALL if !(!64BIT && CLANG_VERSION >= 200000 && CLANG_VERSION < 220100)
> 
> and I see that 22.0 doesn't even exist, and maybe that's a general
> pattern, but it still looks confusing? Wouldn't it be better simpler to
> say < 220000? At least to me that more obviously is "up to 21.x". After
> all, 20.0 also didn't exist, and you did >=200000, not >200000 or
> >=200100?

22.0.0 means a development cycle version of LLVM 22, whereas 22.1.0 is
the released version (mirroring how GCC versioning works). The bug was
not fixed in the 22 development cycle, it was fixed at the beginning of
the 23 development cycle then backported to 22.1.0 before the final
release, so I think the bounds is correct as it is. We assume all
versions of 20 and 21 and the development version of 22 have the bug.

Cheers,
Nathan
