Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCB3D994;
	Wed,  2 Oct 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880439; cv=none; b=ilS4Kjubcj1mVWmO/B+qsaDKncdvwXsaG1+serEMtyHQ/b9tfqJ2RWoJVufUppDhz1LmRo2JQInUiGRqw2BvNEYGraEt0nAwgcls3+9mod3KvB0wjkc9JrViffBbGL3Oxlvc6clDV4DWyEJ0Z+pPtIXvqKCEcnxzOVHiAFimqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880439; c=relaxed/simple;
	bh=H/ZGFmonr7OdzlsK71vUaWahQwMo8iTYkBup05km8R0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSCl5xxxrthW8JjeQdlr/96RPhjlPeZa/8GJDsHmq2MCRHKgLK/CmlbNrcUgoHp1Y0kFN75GmHDUrEjxokaXcvDNBjYkYNGDQrg1du7RIHgCQG7O3TYh4yuSTtyorFN9WpVwWqDDUsjp5c6ooF8xdF58goZiuYH/sJssW0vb8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7845BC4CEC5;
	Wed,  2 Oct 2024 14:47:16 +0000 (UTC)
Date: Wed, 2 Oct 2024 10:48:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Andy Shevchenko <andy@kernel.org>, kees@kernel.org,
 akpm@linux-foundation.org, pmladek@suse.com, linux@rasmusvillemoes.dk,
 senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printf: Remove unused 'bprintf'
Message-ID: <20241002104807.42b4b64e@gandalf.local.home>
In-Reply-To: <Zv1ZN8XZmSZTD-78@gallifrey>
References: <20241002012125.405368-1-linux@treblig.org>
	<Zv1Uk_3W2hu1M8-9@smile.fi.intel.com>
	<Zv1ZN8XZmSZTD-78@gallifrey>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 14:31:19 +0000
"Dr. David Alan Gilbert" <linux@treblig.org> wrote:

> > I am not familiar with tricks in BPF or ftrace code where this actually might
> > be implicitly called via a macro, but brief grep gives nothing that might point
> > to that.  
> 
> I've got an all-yes build (well, most after I took out broken stuff) booting
> with it, and it has CONFIG_BINARY_PRINTF=y and CONFIG_FTRACE=y .
> 
> trace_seq.c uses seq_buf_bprintf which uses bstr_printf rather than the plain
> bprintf() that I've deleted.
> Not sure where to dig in BPF, but I've had a fairly good grep around.

I believe it is safe to delete. It looks like bprintf() was added for
completeness, where as everything is just using the vbin_printf() directly.
bprintf() is nothing more than a wrapper around it in case someone wanted
to use binary prints directly. But I'm not sure there's a good use case for
it, as all users would likely need to add some code around it for
processing (like trace.c does).

Send a v2 and I could take it for v6.13.

-- Steve
