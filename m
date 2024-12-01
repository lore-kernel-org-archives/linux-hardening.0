Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC9AD23;
	Sun,  1 Dec 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733069958; cv=none; b=h+x8u6cZecV2hvlAzJK7LIP1gUV6ANrS/20luzjRqSp6NpSM29OW8vG8Lb+zgoffAMk5IzN/OuYS9OyiTvcHc400HVBV7lbyEYASQ/vyLo61cmP81axNspw87OMzx1ulwZagg6A94c9glAlZuChHMCyTNRQK5ZRejaIPaN7hKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733069958; c=relaxed/simple;
	bh=Tu5+8pnuqOdhEgt2L4vrY6Ar1qOMfH2L1Hwt/wQ/FO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASL0O7SSZZbXdhvtZT2FpJzJIftN8/8Ap4gfR3juHSjaCU5tImP7BeESSdYn972ngqqMYK6WigoUSF44mU2MWqemHMD+5XhwOkRuD7Dy+k9Tsu3Uesn4g0IUD2IXR8wJuR/LLTnokQ22GLij+0ip5y7vaM0r9FKywsiHooMDyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672E1C4CECF;
	Sun,  1 Dec 2024 16:19:16 +0000 (UTC)
Date: Sun, 1 Dec 2024 11:19:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Petr Mladek <pmladek@suse.com>, kees@kernel.org, andy@kernel.org,
 akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
 senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printf: Remove unused 'bprintf'
Message-ID: <20241201111914.6393fcee@rorschach.local.home>
In-Reply-To: <Z0xPUWMps0BzAQKe@gallifrey>
References: <20241002173147.210107-1-linux@treblig.org>
	<Zv5SLrKeQIpWnhsS@pathway.suse.cz>
	<20241003111346.0654f1ac@gandalf.local.home>
	<Z0vOVRcZQir0cjjo@gallifrey>
	<20241130223936.136b2f1c@rorschach.local.home>
	<Z0xPUWMps0BzAQKe@gallifrey>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Dec 2024 11:58:09 +0000
"Dr. David Alan Gilbert" <linux@treblig.org> wrote:

> > I can add it and Linus
> > may even take it after -rc1. Or I'll have it in iinux-next for the next
> > merge window.  
> 
> Please do; no rush.

It's not a big change, and Linus likes removal of code. I'll send it to
him now and let him decide to take it or not. It passed all my tests.

-- Steve
