Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3089537C904;
	Tue, 31 Mar 2026 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937222; cv=none; b=YemNwCRwJmmngMcL1l11tYTlkE0fuiun4lQaJnHTm8CMlrsAUDKKDlP6tIsjz6cqHrdRMAUPwEjdiPhUmlPe5gZvP+gFaRqqmKzE2qrGwAAyuA7sE2HFn01tdTM3Yng+Ogrlt8awWiZPNOM1tRuAl8W1cYUsuad70fk56YjpJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937222; c=relaxed/simple;
	bh=xMN1SThAik50QFXcJCbiNASOKHtR1Sdl6sBqrTmMcGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7aQJEV/t/oAJW3T+AoCTRfxZULDpm0QgX/8c3oQbHRTvE2vdOF8/JuSyZCkIpRAW8RghyngMU+WK9wE4nfPa/mnVgJZ3ZuAwfN+BropNiVOJ7DNuLRUjU7MSyxdyMIF0Eg5CG8uCnW+jtXhVZOQLSMttZyaR4EL2FlX7Nkejw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhKDUPQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhKDUPQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F83C19423;
	Tue, 31 Mar 2026 06:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774937221;
	bh=xMN1SThAik50QFXcJCbiNASOKHtR1Sdl6sBqrTmMcGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhKDUPQ3EkcnegzvZuh+fqTfRTcwDKfqXH7V0qUx/FUAwA19rHqoaMyk03+a9TqR2
	 kW5yQsJMYtn04Ix+uL37U0oMyD4Jy/9/WCH/iDG0Zs5eb66Ki5pNIwPGwedCpW2CiK
	 wgVgrIkFyJKt3vHgAYqIykzlwTnFyDSIHN5Nr0lS86iefzx7XMhsU9UKVE/ksCnK4C
	 q5HjNxpYVkx7yuPavpa1baGCH7GLX9vYiigtvgoziK2Lx4JZ+jj4gq9bWIFfi/t0Xy
	 kTyQwc8+9g8nfS/HzcaPEpPnOqP5ZFCjBNsFne4deBQfRmOJDPE+WndV3qol3FZVI2
	 inm9z0JP4KN2Q==
Date: Mon, 30 Mar 2026 23:07:01 -0700
From: Kees Cook <kees@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 3/3] fortify: Simplify strlen() logic
Message-ID: <202603302305.19F4EF8@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
 <20260330132003.3379-4-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330132003.3379-4-david.laight.linux@gmail.com>

On Mon, Mar 30, 2026 at 02:20:03PM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> The __builtin_choose_expr() doesn't gain you anything, replace with
> a simple ?: operator.
> Then __is_constexpr() can then be replaced with __builtin_constant_p().
> This still works for static initialisers - the expression can contain
> a function call - provided it isn't actually called.

But __is_constexpr() != __builtin_constant_p(). I will go find the
horrible examples of why this, too, needed so much careful construction.

-- 
Kees Cook
