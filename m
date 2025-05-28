Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF620B806;
	Wed, 28 May 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473206; cv=none; b=AkVu7UVm5ueEBY0iA52rZV6yC/NShh487Td68xzecKnXTVPPNZivyHT+vGNo/Vayau330/ou/Mqz7shUrYLiFY1pN9dhZo6fSNVdwT/bW7oevVvS+JpzZqkKX3+Tqp62T1vYz0oS9YOLxGvK549KZb0sE9UWmIrttnuR8Yuh6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473206; c=relaxed/simple;
	bh=xugXewHqc3q1cop251f4ND/MS9iKw3qYkpWghA2m+i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CazvFX/ibk0Oj39rJ/uACIQ0lxBqzy8tLJgP1Os2oQ8dnxoImPM91gMK3XUTkgve2OlljNO92AHLPpvSmbByJ6dohZ9sh6V8pEru992zOKBFytRK0dJ9D0Yx7aJfOz8UQqwdUi4z9ETOlvAAqS/rbPREHgCWJJOkS+aqrqjBAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRzJuyXv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRzJuyXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2701C4CEE3;
	Wed, 28 May 2025 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748473206;
	bh=xugXewHqc3q1cop251f4ND/MS9iKw3qYkpWghA2m+i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRzJuyXvagDUNcrsTFHDUikt4P4Njr2MVvdguw+JE2AlCrSGxMo+//0IY6DE+j1Xk
	 pugrmgZeUFJx5i3+QpsnIOnacLsPLt08TY2f0CvCBSvmumy5TiWwgnTRKSH5876Nug
	 5dK6uTFGYlVQ7G1r+9eJfCBw6x9OHkt4dNqEAqBdj4rpXHidKCMK/7VYTjfCGo/JLH
	 d9RbQ+QoU0NAzjuz8gvAH47xzHFAkisipD1Wax/oEykrajdzgU4aVl5SVbas1QDOxX
	 zitEbrzUVMHRucafzPdStW0S4UQuEZ1ULpzmSnlQ0B9vk9nimKJiIeRCcSqAvrmvKQ
	 I19N1dHDDtHeQ==
Date: Wed, 28 May 2025 16:00:03 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: integer-overflow: depend on BROKEN to keep this
 out of CI
Message-ID: <202505281559.FD37A978F@keescook>
References: <20250528182616.work.296-kees@kernel.org>
 <20250528213223.GA3885532@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528213223.GA3885532@ax162>

On Wed, May 28, 2025 at 02:32:23PM -0700, Nathan Chancellor wrote:
> On Wed, May 28, 2025 at 11:26:22AM -0700, Kees Cook wrote:
> > Depending on !COMPILE_TEST isn't sufficient to keep this feature out of
> > CI because we can't stop it from being included in randconfig builds.
> > This feature is still highly experimental, and is developed in lock-step
> > with Clang's Overflow Behavior Types[1]. Depend on BROKEN to keep it
> > from being enabled by anyone not expecting it.
> > 
> > Link: https://discourse.llvm.org/t/rfc-v2-clang-introduce-overflowbehaviortypes-for-wrapping-and-non-wrapping-arithmetic/86507 [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Should this have a 'Cc: stable@vger.kernel.org' on it? There might not
> be much randconfig testing on stable but it is still very much possible
> for some random user to turn this on and report problems.

Ah yeah, I should probably do this via a proper Fixes: tag. I'll add
this.

> Regardless of that though, I think this is a good idea with how much of
> this feature is still being ironed out.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

> 
> Once this lands, I plan to mark all issues in the CBL issue tracker that
> came about from UBSAN_INTEGER_WRAP as 'have a workaround applied' since
> it will not be possible for regular users to hit them but you may
> consider notating them in case they need to be addressed before the
> feature can be reenabled.

Sounds good!

-Kees

-- 
Kees Cook
