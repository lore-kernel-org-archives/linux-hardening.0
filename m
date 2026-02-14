Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F291D5CFB;
	Sat, 14 Feb 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771077772; cv=none; b=q/D2HplY6pf9t5voj8y0B4nx//mnmRm2G3BpRWsnizA6oFlCN/JFLzgxqfYI7xrgmbOV2v9ppAvZntLQQ/jSpKCerL+ql/jVpGTBh/ZDwDzPH755hhTvePhuV/2rCeJ594CBBUjDSmkzA1Pljo+67Vy6UQuemzs/dnxZcEC2NaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771077772; c=relaxed/simple;
	bh=94hUQShU6CBty0VDifyTMpeH6CGrYXl8r8boBvv/6g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9RqSRF0AuBx8q6LWcfn4C3Ko5iIySZlZvQl4iUrw9GF8lu2teXPd5XQnhngINX08IkvoutEnLbSuv+j86Zg//q/RQbgOV32nYhWpu7AmrfkXGB5r4Y0g3ItAurVyWmbT+WbR3kY0iiYuSvCzuOD3GB0fVwl9f6YDYsWUF3nVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i/YCsgwJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i/YCsgwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBAFC16AAE;
	Sat, 14 Feb 2026 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771077771;
	bh=94hUQShU6CBty0VDifyTMpeH6CGrYXl8r8boBvv/6g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/YCsgwJ4u5vMVjZyWl2dtil9x57VzSrvWZgcPlP5MHB6+tLFavjk+gjBd7VxOkyU
	 ZfqUdPhuyGFmgDSLyNkXzJrsTS+mhiOJ33kSQ2LthblwaW9SNN8LC9cdxctAyQssX2
	 gR4vuRap0YIHKQ/QXMU2ix7ADPmOKweAPw+NmuCo=
Date: Sat, 14 Feb 2026 15:02:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Samyak <samyak.bambole07@gmail.com>
Cc: akpm@linux-foundation.org, kees@kernel.org, andy@kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [RFC PATCH] lib/string: fix coding style issues
Message-ID: <2026021409-clothes-subarctic-3dd2@gregkh>
References: <20260214135107.595089-1-samyak.bambole07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214135107.595089-1-samyak.bambole07@gmail.com>

On Sat, Feb 14, 2026 at 07:21:07PM +0530, Samyak wrote:
> - Add spaces around binary operators
> - remove spaces after casts
> - Add blank line after variable declarations
> - Fix constant on left side of a conditional expression (0 < count ->
>   count > 0)
> - Remove un-needed braces around single statements
> 
> Signed-off-by: Samyak Bambole <samyak.bambole07@gmail.com>
> ---
> This is my first linux kernel patch. I have compiled and tested the
> changes on QEMU. I would appreciate any feedback. Thanks.
> 
>  lib/string.c | 27 ++++++++++++++++-----------

If you want to get involved in kernel work, please do coding style
changes in drivers/staging/ which is there to learn on how to do this.
Only after doing this a lot, and getting experience, should you venture
out of drivers/staging/

Also, many subsystems do not want coding style fixes for obvious reasons
(i.e. they change over time and keeping the whole codebase up to date
like this would be constant churn.)

Hint, this patch would need to be broken up anyway, you should only do
"one logical thing" per patch.  And "fix all coding style issues" is not
one thing :)

thanks,

greg k-h
