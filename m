Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A2372EF5;
	Tue, 19 May 2026 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219463; cv=none; b=jtBPg/lhFoMxcQH17qTvJRXULjMpoEMW3pxnMp/EWpZRTfccMS8FqEa9JvQOT8f1r/i2dXsISlbV2cwHmiT1k4XGuPOaGgVK7FBGsuKQvgoHKStE3jAAlm6s2qZuzZVTdq6fZ1+M/7kMHpBda4N719u2h3PnepO+dy2D2qU5V9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219463; c=relaxed/simple;
	bh=eHKCIJJYtVa39YBZL6i9JCxFHC9wwf9mDfxqFDc+MdI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L3y7r+n7bliP4m4zEr0rL0fyYMchiufL7SRB2e5n8cUOZJNMIMcLIY9BcCs5aTBxbxlBquDP8kY2FHUWc72rZtlorCQ++rw1qeg15JY5VhUQvSRFgUdseo+G7E/sIjfydnPHQMXC4Sy1ar6OznhHGCaBR0MrNhSSU0U62QF63J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rv8K6ZF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rv8K6ZF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA541F000E9;
	Tue, 19 May 2026 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779219461;
	bh=+iKhhPD1oKgqkGJEDxWoMdpoEdZrQons7aqeVyygrDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rv8K6ZF3f1TNTK7IMHS+kX+4FN/QfzcU0MNTyeKHrgOvH8PKZfVXlPG7PJqtLydRo
	 5Fd/u6cI6jg32CHXVooVOWknOT3ESSdUx0TkgQQMA1GSaBJLNbe/M3mvLZcTdMSm7H
	 i0ehCPQIpmulRD44v5Do04fssYS20pFNmAMpBTzY=
Date: Tue, 19 May 2026 12:37:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] string: use min in sized_strscpy
Message-Id: <20260519123740.458d905f958f39d41cb130fd@linux-foundation.org>
In-Reply-To: <20260514165601.527883-3-thorsten.blum@linux.dev>
References: <20260514165601.527883-3-thorsten.blum@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 18:56:03 +0200 Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Use min() and drop the limit variable to simplify sized_strscpy().

Why is this code so messy.   Never seen so many typecasts per inch.

> @@ -125,11 +126,8 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>  	 * If src is unaligned, don't cross a page boundary,
>  	 * since we don't know if the next page is mapped.
>  	 */
> -	if ((long)src & (sizeof(long) - 1)) {
> -		size_t limit = PAGE_SIZE - ((long)src & (PAGE_SIZE - 1));
> -		if (limit < max)
> -			max = limit;
> -	}
> +	if ((long)src & (sizeof(long) - 1))

That looks like IS_ALIGNED()?

> +		max = min(PAGE_SIZE - ((long)src & (PAGE_SIZE - 1)), max);

That looks like a dog's breakfast.

And a bit like ALIGN_DOWN.  Not quite, but I'm sure we have helpers for
whatever this is doing.

>  #else
>  	/* If src or dest is unaligned, don't do word-at-a-time. */
>  	if (((long) dest | (long) src) & (sizeof(long) - 1))

gargh.


Oh well, not your fault.  I'll grab the patch, thanks.
