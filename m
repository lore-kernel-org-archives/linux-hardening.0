Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4620C308;
	Wed,  6 Nov 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926665; cv=none; b=iAVe4rhVp6JpjLJ5YwofFYQMO1KN38GdI+yO48pfj0+SQg9F91Zcv5QipT0QPHVujuRjtVAdO3KftOR7ijr2I9360psBaAN1aYWoHfSTz+cB51xNM/MksXC/cV1PJLyLKg6ZbEmZubr04BY4/Up0AQ4F+6P66zPo+Zy/wOEt738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926665; c=relaxed/simple;
	bh=c8/i+aAT+f3p8CkKo793zsU+HTDsGoC2h0xF+cxEIO0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cLQ6H8nEza8G65KQeYNrZOb5lx1pFxVYf3L/zH5iLjQN5VifiMg8eUrkvNbuhjMeSHUFNrlY0RcxLsx1/C3wMF/8FnPIQywtzoE4NmMgjQjIdPhDoq2VbE9N/CMBSfjEYCTvh65llukmucvrZv7EGRkjE6aaLql3ihSavvIgqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PtS6ctDQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PtS6ctDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98F1C4CEC6;
	Wed,  6 Nov 2024 20:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730926665;
	bh=c8/i+aAT+f3p8CkKo793zsU+HTDsGoC2h0xF+cxEIO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PtS6ctDQsZnG4StsyFNciEmgwDWUQEGL6X+KzbnYpJEICltYPgLgYDhB9WysqswDg
	 ewHo0OmrXSQU526PYc//iXx/pqiIa2rzDYDYiCjNdmhaTkZtb9nIVvXdgbaIrRq47n
	 +1MgE2LEPl4eyH62LQDZNaFpnTmfZt4ft4zYiwhU=
Date: Wed, 6 Nov 2024 12:57:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: exec: Mark Kees as maintainer
Message-Id: <20241106125744.8645accf12a4ada579fbb0cc@linux-foundation.org>
In-Reply-To: <20241031220853.work.354-kees@kernel.org>
References: <20241031220853.work.354-kees@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 15:08:55 -0700 Kees Cook <kees@kernel.org> wrote:

> It's more accurate to mark myself as a maintainer: I've been keeping the
> tree up to date in linux-next, etc.
> 
> ...
>
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8488,8 +8488,8 @@ F:	rust/kernel/net/phy.rs
>  F:	rust/kernel/net/phy/reg.rs
>  
>  EXEC & BINFMT API, ELF

I suggest you add coredump here, and to the F: list.

> +M:	Kees Cook <kees@kernel.org>
>  R:	Eric Biederman <ebiederm@xmission.com>
> -R:	Kees Cook <kees@kernel.org>
>  L:	linux-mm@kvack.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve

