Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDA18563E;
	Fri, 24 May 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716552583; cv=none; b=T/zNLWz/OVt+1C0FuEMga/Tu+smKSGcysiBF0RYDvLHtN3cVOZnjYecmWFqYq7AiI0JV9itDWDy0ywt8uUKAU/fQMvbYmtfUiRK62ag0YTAloeoqYupBz2eOep5cf31LITmIddF6PRVChcSOC09rVXNxnLzb94bx8s7P+sGr9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716552583; c=relaxed/simple;
	bh=wJXQkk1V3FlJQgr1pPSLFK/VZCsoXjvfYpl1+qjKKjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GYzx/avEaNBV3IAKML9FZCUnfiH2B0Vo6dbwz6awPBlnEr+8is5roOMJPb1OJ22+LIHuSENANArF6nMd5NDxsQPJQtKKgKpETBh4oJnUhrtgbV5fgRh7KG0+UeXyredUahRsxS9YsPyv06nlFj8j0h1Y1uYl59t25aVtlH8LggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pW4oKXsd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FZDiGBBf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pW4oKXsd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FZDiGBBf"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716552580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KwrJkb5UWtVpW+6uKKTmNSXBikkf8k2POmcqYvLF5LE=;
	b=pW4oKXsdeuaZgoTWdrml6XjbqmgrqdpmmH2MubZjxWL63MLmcW1vw/G93JHPUpDoMCNkp2
	rDcIIO1iMWPq2WKwZYxDZqoHUoa6Tfdx5j6AYl5dJO5K3r6FY4SmlUipcidw1JKDDd6nHt
	lYwtB4HZArKPdYOLOT19nqFoTIILt4TMUgj0nNpoJ72DZGjd6GVuQTomHBkP4g08KbmK18
	3QolkNFpiXR1TwkRcemfFGMaza53vqLmkEImRuPOE3/zw5KOceuW/obPiKoEWvKpVEM915
	LvUH3E6mMMseBUEWN/vz0K06/ek8I1/oqHfwQyNzbwCp9kOefHkHTGxXs8f4dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716552580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KwrJkb5UWtVpW+6uKKTmNSXBikkf8k2POmcqYvLF5LE=;
	b=FZDiGBBfBuVXX2DRLl4ddYpgChHlXu3v5tNdnqJknphBtYWA+QP66aasNIxadcqqphj9sQ
	YbxFrVRYokfkWiDg==
To: Justin Stitt <justinstitt@google.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, Nick Desaulniers
 <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
 Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: [PATCH v2] ntp: remove accidental integer wrap-around
In-Reply-To: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com>
References: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com>
Date: Fri, 24 May 2024 14:09:39 +0200
Message-ID: <87ed9re7i4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 17 2024 at 20:22, Justin Stitt wrote:
> time_maxerror is unconditionally incremented and the result is checked
> against NTP_PHASE_LIMIT, but the increment itself can overflow,
> resulting in wrap-around to negative space.
>
> The user can supply some crazy values which is causing the overflow. Add
> an extra validation step checking that maxerror is reasonable.

The user can supply any value which can cause an overflow as the input
is unchecked. Add ...

Hmm?

> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index b58dffc58a8f..321f251c02aa 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2388,6 +2388,11 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc)
>  		}
>  	}
>  
> +	if (txc->modes & ADJ_MAXERROR) {
> +		if (txc->maxerror < 0 || txc->maxerror > NTP_PHASE_LIMIT)
> +			return -EINVAL;
> +	}

I dug into history to find a Fixes tag. That unearthed something
interesting.  Exactly this check used to be there until commit
eea83d896e31 ("ntp: NTP4 user space bits update") which landed in
2.6.30. The change log says:

    "If some values for adjtimex() are outside the acceptable range, they
     are now simply normalized instead of letting the syscall fail."

The problem with that commit is that it did not do any normalization at
all and just relied on the actual time_maxerror handling in
second_overflow(), which is both insufficient and also prone to that
overflow issue.

So instead of turning the clock back, we might be better off to actually
put the normalization in place at the assignment:

    time_maxerror = min(max(0, txc->maxerror), NTP_PHASE_LIMIT);

or something like that.

Miroslav: Any opinion on that?

Thanks,

        tglx
