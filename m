Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD851E0DD6;
	Mon, 21 Oct 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503272; cv=none; b=EDvphpt7s/xuR4KALxNn1mbxD8yw+kk8JYuUjpgRyObuX12i94iv9ouNnml/b7l+ypsgVs7CGS6Y466UYjkoxfD81BASszKlBbqA3hofmnOXnQSjRRRgY3VI/gxByzctnjeEKWAB3dvj6bnReyAOzim9dgyZL2cW7ZHaIddM51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503272; c=relaxed/simple;
	bh=u01+hcfeQkP1Lf6fJfGlgCbowj/JPXJjgVD0/eECaEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix7ubiNs8zdICCQzMJ7I9KV1oVjKxBZ6sXDjKTaPlmLoSpZ68Uvz7HrUMqAjo1upFUJRqS9ziTQq4Ux7bFOGFJd6+r5+ZwyPAM88PtOQFqCqSf7xPdMkEDR34ZYjp2K3pwN0YmWT3u2dNWLSGLAjFLlIZBz2E7hXmMR1bd2ki3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LHcUhwvx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LHcUhwvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23BFC4CEC3;
	Mon, 21 Oct 2024 09:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729503271;
	bh=u01+hcfeQkP1Lf6fJfGlgCbowj/JPXJjgVD0/eECaEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHcUhwvxSpzlxIngQEywwHnB0/X2MkaYwhOSmKXQ8PS0IEOa+LJDFsUd2ahorWnsO
	 6ijKgGGQR3FThJJGEnvDod/6cCU5coYt6z4v23Uk0tz1KCWKiDBfuQUYQ9sMH08xtj
	 fjBS7TGpVDrX4LJr9wrVlJn98ViarEA4fqvaljbQ=
Date: Mon, 21 Oct 2024 11:34:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output
 truncation
Message-ID: <2024102113-shame-mooned-4f1b@gregkh>
References: <20241021091417.37796-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021091417.37796-1-brgl@bgdev.pl>

On Mon, Oct 21, 2024 at 11:14:17AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The output of ".%03u" with the unsigned int in range [0, 4294966295] may
> get truncated if the target buffer is not 12 bytes.
> 
> Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rounded to the correct SI range")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  lib/string_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
