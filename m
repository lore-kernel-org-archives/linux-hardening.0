Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85D14C5B0;
	Tue, 22 Apr 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344353; cv=none; b=Tt/YrFzD/6zoeHJx0XodhWlb5fuN6GF0cYMv1bknIwcT2HWM2mOKFQidU30FZiFtmQxiBX2/FPG1V++jifDYXxfqaLQ1gcuSA9DwDDbTTMHxdoY0paM4bcJYD9P+/tzkDi+8Ql9bCwSIqgG1EDtPLWaq5oX2iUxf708VAY72R/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344353; c=relaxed/simple;
	bh=IuS/9wOtEr5F/liI8jwdEQCfKDpWFZ83xDfbu0vahqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imQQAxPKwanb1jFH2oQyMXvChotxW0RMekusqw2WC0qim3Q+8NY6b3vE7zGq582Tf828Fjf0WywpLEy7sQstXhNEJv+vMg8mWOZVfP2jXghKIkTqocZE4UTV+B0KQKd9Sp0XVJQTpVOC0EsnOqH1/OJJ4i+xRyWNUnadNKhdyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV9jgxZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV9jgxZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6054BC4CEE9;
	Tue, 22 Apr 2025 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745344352;
	bh=IuS/9wOtEr5F/liI8jwdEQCfKDpWFZ83xDfbu0vahqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kV9jgxZR31l8eqUE+d4YFZRiGEtRt0Y0lNxEtycZAkRS7ddlKEMurEyC4SPYWXuba
	 D5cMd9Wlm8HEcyrpvuiMrPP64WVOp41A1gdTNIioujQqZkLk7b77Ze3yfdLulwk+rh
	 PihytcSjcF06hR8ygSR3Oeym8Cu6q7ZD79lzYUja77oxU7vGKgBs9AIwimTkeJgG2a
	 C2qmvy/c6fN2ocrt2U9pviAy01VQGCDad6pvulNwB96m2dLRQDvGstVZrZUrQBOYgb
	 CPiFVCfgBiVojJMb536bcSpAXfrg3DYQwjxZM+nPAvDsoFMzsELUlHRCT5YfE9rVJV
	 o66POSnBRCH/w==
Date: Tue, 22 Apr 2025 10:52:28 -0700
From: Kees Cook <kees@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Borislav Petkov <bp@suse.de>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH] configs/debug: Refresh debug config dependencies
Message-ID: <202504221044.98A9CEFD2@keescook>
References: <20250422165446.work.015-kees@kernel.org>
 <a115518c-c21d-4e0f-8abf-a1732031a760@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a115518c-c21d-4e0f-8abf-a1732031a760@kernel.org>

On Tue, Apr 22, 2025 at 07:15:44PM +0200, Matthieu Baerts wrote:
> Hi Kees,
> 
> Thank you for sharing this patch!
> 
> On 22/04/2025 18:54, Kees Cook wrote:
> > Many of the CONFIG_DEBUG* options need CONFIG_DEBUG_KERNEL=y to be set,
> 
> Good point! I guess it has not been seen before because it is usually
> enabled in the different _defconfig files. So probably no need to
> backport this I guess, right?
> 
> 
> > so enable it explicitly. Similarly for CONFIG_NET* options, enable
> > CONFIG_NET=y.
> 
> I'm not sure about that one: if I'm not mistaken, the net debugging
> options have been added for CIs using network features, to find bugs in
> this area. In other words, I don't think it is needed to add a
> dependence to CONFIG_NET. If it is enabled, then some extra debugging
> options should be enabled to get more debug. If not, no need to force
> having CONFIG_NET, no?
> 
> (On the other hand, CONFIG_NET is very likely needed for a CI, and it is
> typically enabled in the different _defconfig and kvm_guest.config. I
> guess adding this dependence will very likely not annoy anybody, so up
> to you :) )

Thanks for making me double-check this... it seems what was missing was
defconfig. :P

I noticed all of these from trying to run kunit like this:

$ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kunitconfig kernel/configs/debug.config \
	fortify

But it seems I need something closer to:

$ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kunitconfig arch/x86/configs/x86_64_defconfig \
	--kunitconfig kernel/configs/debug.config \
	fortify

> > Finally, remove CONFIG_DEBUG_VM_VMACACHE, since it was
> > removed in commit 7964cf8caa4d ("mm: remove vmacache").
> 
> Good catch!

Thanks! I'll nail this down a bit more and send a v2.

-- 
Kees Cook
