Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774617108B;
	Tue, 11 Jun 2024 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086870; cv=none; b=kFdsgTOgD6LR3toEytuv//umwi4Zo6eVhI39pqtYXdEi8tHiFTvknL0J46a8Yt7o9wZ1LhHB6TkvQBoaRWK5qSn4E6rU7OCLK59DeEY2GYENXM+ps1Ljgi1H3H97Pi6fy9CFaYCYI4sqMr8WZsJPTCH76lhJt8QETGgUv0hLedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086870; c=relaxed/simple;
	bh=FdvcjugTQA5eN+YNmowO2Lsa9ldk4+jwb0PaqWtLnDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWIymFHrYObKxx/0I+2gKd8mG8sinlk+BVj/45H3J9WdyeQpfD1vdpOUXN4bIVMYX6lFJ4rgV6DCmGagi9w1qAitJ7jgs0vlG3I2FHoan9UmgwOEc8wXRfnhGjkJ1f5cGm/IirD3faVWJOzJCiuTTTRnhA8XQxVKKw8xyy232mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hHgFOx36; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHgFOx36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23157C4AF1C;
	Tue, 11 Jun 2024 06:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718086869;
	bh=FdvcjugTQA5eN+YNmowO2Lsa9ldk4+jwb0PaqWtLnDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHgFOx36G/kLrMsYBTD7TQ/ywAxmxhutm3HV5b0+lVSJafHpbrPySk5hTWlZGyuY/
	 Ff7RODDMdRHmZpaI/WcB3yBKFgDjuVv8NrCoXvWxWyzFEYdDF4j4crAyXg3itbz4QS
	 /c2ufIcz0HgIwm/46toJAPdOwWoUrJKu6Ew4lda8=
Date: Tue, 11 Jun 2024 08:21:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/uaccess: Fix missed zeroing of ia32 u64 get_user()
 range checking
Message-ID: <2024061151-flinch-storage-fe08@gregkh>
References: <20240610210213.work.143-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610210213.work.143-kees@kernel.org>

On Mon, Jun 10, 2024 at 02:02:27PM -0700, Kees Cook wrote:
> When reworking the range checking for get_user(), the get_user_8() case
> on 32-bit wasn't zeroing the high register. (The jump to bad_get_user_8
> was accidentally dropped.) Restore the correct error handling
> destination (and rename the jump to using the expected ".L" prefix).
> 
> While here, switch to using a named argument ("size") for the call
> template ("%c4" to "%c[size]") as already used in the other call
> templates in this file.
> 
> Found after moving the usercopy selftests to KUnit:
> 
>       # usercopy_test_invalid: EXPECTATION FAILED at
>       lib/usercopy_kunit.c:278
>       Expected val_u64 == 0, but
>           val_u64 == -60129542144 (0xfffffff200000000)
> 
> Reported-by: David Gow <davidgow@google.com>
> Closes: https://lore.kernel.org/all/CABVgOSn=tb=Lj9SxHuT4_9MTjjKVxsq-ikdXC4kGHO4CfKVmGQ@mail.gmail.com
> Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and put_user()")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  arch/x86/include/asm/uaccess.h | 4 ++--
>  arch/x86/lib/getuser.S         | 6 +++++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 

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
