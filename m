Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D611CB0
	for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QnTTsZIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C029FC433C8;
	Sat, 21 Oct 2023 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697916202;
	bh=yhDGV+afbKRRSHX9sgNtz5SsFfBE8tY3ozhHoe4H7gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnTTsZIQfovQp8cjxbyLj0z4ii9wo96GH4bh3XuUbQiaTrIw2ltzGJJNk0B9EbsgS
	 ZxN5xq8AsyFd+1tEf5wMDdKXGIrfXQgAGfCcWrWMVTe07wrQcAKlK/kop4uLKbqA6e
	 TA247/a3LeZ6zPrs7bGxQt14+ep72B5C784txzM4=
Date: Sat, 21 Oct 2023 21:23:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: keescook@chromium.org, Robert Richter <rric@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergey Temerkhanov <s.temerkhanov@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/thunderx: Fix some potential buffer overflow in
 thunderx_ocx_com_threaded_isr()
Message-ID: <2023102149-scrunch-carrousel-dcc3@gregkh>
References: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>

On Sat, Oct 21, 2023 at 07:13:51PM +0200, Christophe JAILLET wrote:
> strncat() usage in thunderx_ocx_com_threaded_isr() is wrong.
> The size given to strncat() is the maximum number of bytes that can be
> written, excluding the trailing NULL.
> 
> Here, the size of the 'msg' buffer is used (i.e. OCX_MESSAGE_SIZE), not
> the space that is remaining.
> The space for the ending NULL is also not taken into account.
> 
> in order to fix it:
>    - call decode_register() before the snprintf() calls
>    - use scnprintf() instead of snprintf() and compute, in the 'remaining'
>      variable, the space that is still available in the 'msg' buffer
>    - add a %s at the end of the format strings and append directly the
>      result of decode_register() stored in 'other'
>    - write directly at the right position in the 'msg' buffer when
>      appending some data in the for loop.
> 
> Doing so, all usages of strncat() are removed.
> 
> Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is cross-compile tested only.
> Review with care.
> 
> v2: remove some other erroneous usage of strncat()
> ---
>  drivers/edac/thunderx_edac.c | 44 ++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)

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

- You have marked a patch with a Fixes: tag for a commit that is in an
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
