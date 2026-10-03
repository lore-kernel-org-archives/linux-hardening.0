Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD11F938;
	Sat,  3 Oct 2026 02:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790993642; cv=none; b=cu5h+gKeFCtafHZ8ge/lDYryy7rPn0zqtLK1DqPkwBRt/GBSNR+GHDZ1aB4riQJuMK/HJ+YetAZoSyCkG/7Ofi2Nuq9Bpy4pS+zxnkO2TsfdEKHKXDC70oInVbKqFIRCN5u1nJcUdkiOZksibYS+ujF08D77PwYOI+29W8Vq+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790993642; c=relaxed/simple;
	bh=tmNE3NDLkmKZqRzBouz9+z5oRaOj5XiiIqr8ydu/WSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E89cvC/dxw4djo4lUygUs/EzcEcUTIJmFpuPSuvXFlkR9jyNSC8o0iW2jjRTNwvp4j4R2BEM0CKVvuBfrubDDeqx7rj8E9KHs1xTMYuqi0xR61jjtEQRf+LbdI1rjo2cBLx/HmgeGMk3jwkMaSMuHmK6fZNEY0CjiN0evt82h5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaIsnNbn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaIsnNbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AFC1F000FF;
	Sat,  3 Oct 2026 02:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790993641;
	bh=kYwaNKgHnOtxV2setx6ufp1hRmhG92cYphvxy9lvb08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KaIsnNbnLgQxH9tw1HTBH1XC9QmvIbfaAdJz52mwD3mYD3AaJ55e2DrBimnauWlZS
	 62cg06TkR0uVjJGLNkOqaf5hfRLnHEEggZyn5gcEsJW9abxsUvHqNJwJyHxk8zo14M
	 wq2lv1hirpJhWAGMbaBJ+RLheWhC/SUwE3bqR6PeiA37w1sQnyXroJWJ64u65UVppF
	 HjuGwFA/ZFdx45MTEb+UFBTjp+AlJuF5pHIVrD2fFNNrIkCqzDUSycde8jrp5cwqFk
	 xLDaj4ZKd+mflLfokWogc0nmhMueOEoXp1ap6n77EescC4sW4Xg1OBla/s+5MO+9wZ
	 deoh38JvA8w5Q==
Date: Fri, 2 Oct 2026 19:14:01 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 01/11] seq_buf: Do not print an empty line from an
 overflowed seq_buf_do_printk()
Message-ID: <20261003021320.fd7e91-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
 <20260930235247.157921-1-kees@kernel.org>
 <ar9d9ChvEvBDX9j0@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar9d9ChvEvBDX9j0@ashevche-desk.local>

On Fri, Oct 02, 2026 at 10:32:04AM +0300, Andy Shevchenko wrote:
> I believe a single blank line is enough.
>
> I would re-split to have it wrapped on logical boundary:
>
> static void seq_buf_printk_capture(struct console *con,
> 				   const char *s, unsigned int count)

Fixed both for v4, along with two more doubled blank lines in 05/11.
Thanks!

-Kees

-- 
Kees Cook
