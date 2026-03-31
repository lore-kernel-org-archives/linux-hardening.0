Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8E1990C7;
	Tue, 31 Mar 2026 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938968; cv=none; b=SScIuf/8fnLOCAdgr5ezMkSDVMgLs2hcbwXq4E7MQwpFSTFRuhvFr0BJ5e9TUQN6/4XAfgQvsU+CV8sLK2LCcMrRO8ByHdpetHxWrP0ObO/KbIc8rf5n0dciTXJO5EQUQhnY7c+ZA7W88lw8ywlhDVt+V9I1Ifs081pvUrcBnnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938968; c=relaxed/simple;
	bh=uJzr9f8qA5a7GefgHQx5s8UkBqOGErZGg5C7Ofc6tJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKddGOpUZHNbpGZiv56c1hROe+0KiPDr5S1BboZKD8+mhuZoBNiOGsRInmCQLntPtQRNJjSGuCsBCCv50q4IjQXiXSfxcZe153xvValoR3G3HjGWuXhLF0vk4TfCjPvrBDPTH/JiQKI593x3p+GJGoT0dFZBC1fAsBu5tptJbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMybA4o3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMybA4o3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589D2C19424;
	Tue, 31 Mar 2026 06:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774938968;
	bh=uJzr9f8qA5a7GefgHQx5s8UkBqOGErZGg5C7Ofc6tJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMybA4o38qUuw0/RSgAhY1tpaN3Ak3KyFg/fECvIj+kDP+fOHsyJpmkWHZiMEUbL/
	 bT4xk56JsSzxknh4doaBBKzlonxJiLfK1Ae7YeKdD5VBM9lVaJk0/ZblgIQul1ITrb
	 UgtGAIsnzAgPYzY1CIplz9BDAlo5DnHM2Gg7232eOdTPkjV56Ec6c/+g1UlKj+9Ef5
	 Gm4/6ZbA7di8TIQnQoIxv/8CIieqaE+WzBQlfvB5UJipUnIt5IWK242Yqs5VZ3Hn/x
	 lJAGQDpLHesLTQ3WstQN59LdpgiwRACfsIGv6yzWqxo+sgvLM7cwT908ZDDeLuv96v
	 I+i1p5KUAMaXQ==
Date: Mon, 30 Mar 2026 23:36:07 -0700
From: Kees Cook <kees@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <202603302335.0AEEF9154@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
 <20260330132003.3379-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330132003.3379-3-david.laight.linux@gmail.com>

On Mon, Mar 30, 2026 at 02:20:02PM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> If the string is constant there is no need to call __real_strlen()
> even when maxlen is a variable - just return the smaller value.
> 
> If the size of the string variable is unknown fortify_panic() can't be
> called, change the condition so that the compiler can optimise it away.
> 
> Change __compiletime_strlen(p) to return a 'non-constant' value
> for non-constant strings (the same as __builtin_strlen()).
> Simplify since it is only necessary to check that the size is constant
> and that the last character is '\0'.
> Explain why it is different from __builtin_strlen().
> Update the kunit tests to match.

See also
commit d07c0acb4f41 ("fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL")

-Kees

-- 
Kees Cook
