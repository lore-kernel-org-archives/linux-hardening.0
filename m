Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D72D63F2;
	Tue, 26 Aug 2025 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227367; cv=none; b=dyrBRoESDaUwWEby0Wtg0pp2lxiduiAaPl/tcZ0EMZ5jYfVGqrcgnaxdAvcnVo+yY+vpURAiY7RSAEG0XOyjnliWPvrcRFFrXwoUYRFCuw1FLX7h1/ExOJuiysxcJE0EukutyfX2xPFr05fsL6KxCRzJanKMjBAcC/sudNT6eDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227367; c=relaxed/simple;
	bh=VOKcXvOVDMlVdIq/9YenDUzJQ2ngSu2wlVMbNmIoeR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOJPZVWwXXjom1l2PinLohP8mrkGcyG2rwQoD6FJlgfKALgJYajugax/klz2K7YaxUbPNReVJ04iXdHQH6JV9YzN59bHIaxuZgMKIwJq2dKXrfSa54XLJKs28bDx3Q2glcKkbh0PaU9kuYoGokxXYmJOG7Pr6A5EJncieUF4kNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4lD90DT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4lD90DT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00421C4CEF1;
	Tue, 26 Aug 2025 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756227367;
	bh=VOKcXvOVDMlVdIq/9YenDUzJQ2ngSu2wlVMbNmIoeR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4lD90DTmr0M65OhH9CjX56WieA/RvNicew8YlXel+J6eox/mEwaMNWxA1dsupz84
	 HBXNLYChP72S7GLSmod+6z+2ULll4VrxMikr4AeaWIH7SJ6Lbk0jJmIREydk3C+12j
	 emZUJpRLN+uUgJD7hCa/GYe9+gi1MeNKDZWoGMO4Cr6QeHJ/CFaDIOuV4KpSvMAZ3/
	 uGNnomU6smQeQNgMkwl9eSypvQmdPL1AloPTuppbsC5YRpKOh4ZDA5e3BxCTKMPOdh
	 LVihbOwl51wRKZ7z2d/ZRRTNPbcNgbckaw6el8wKdEpPJLofXRgWQMFkbszkTha+gS
	 CbvMapmh1J+VA==
Date: Tue, 26 Aug 2025 09:56:06 -0700
From: Kees Cook <kees@kernel.org>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Yury Norov <yury.norov@gmail.com>, kernel test robot <lkp@intel.com>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arc: Fix __fls() const-foldability via __builtin_clzl()
Message-ID: <202508260955.2DE50A3FB@keescook>
References: <20250826034354.work.684-kees@kernel.org>
 <87ldn644d0.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldn644d0.fsf@prevas.dk>

On Tue, Aug 26, 2025 at 03:08:59PM +0200, Rasmus Villemoes wrote:
> If __builtin_arc_fls() simply doesn't qualify for attr_const for
> $reason, I think it would be good to have that documented in the commit
> msg. If it does, I think a gcc ticket and link to that would be in order.

I already sent the patch to fix it. :)

https://gcc.gnu.org/pipermail/gcc-patches/2025-August/693273.html

-- 
Kees Cook
