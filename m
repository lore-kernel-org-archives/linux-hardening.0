Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1D23395D;
	Sun, 18 Oct 2026 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304352; cv=none; b=IlFZTRAS9QZ6tHWQxIYnyQ94n5+Hw800k0E11UgsavKgifsh4AwBpW4/tZZLgNaXlakZm/4JRvspNjpr7KWbWSJd59WKdCyNW+UVOpBInersMOTXnhRSWPpbkYr90xHRS+EZmvWtePCtdRTDwoyWPWZR0BbG2a+lPpoEFa7DMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304352; c=relaxed/simple;
	bh=d4KTo66k29I7garBO1fwcPxQ769tQ8IZCywFFDWrkoo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OCztlO8vXJXz07txOtnWD8hXeAGvPNwKrEmjQv94+PNRAIBNFiNP32XQurlSlcgIir+tiOTXjDMMHNagqDtpCF8/+fpz+0mIV1mbS+Bw2CLaz8koxVH1QpMeTyr/4Ogs1l+mB1W4D0fUhsbkjfLPzXnTcjjuzo5O4bEXGfn2rVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cmqqQYpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cmqqQYpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635511F000C4;
	Sun, 18 Oct 2026 06:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792304350;
	bh=ycEJR+8zmQkx8497np5QP1rga/PZk7rr02Cf+WPUZ0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cmqqQYpBt72V/x4fVHAgO99kOJXG9duvHbXWqWVY9kVtNx1F8+lOwZCsYl/NLsHjZ
	 SQXdZKj76wC9bSdVxtp4g84XPTRd1NN7BiiNXnSPBZQ1UHExoKUcg+GdJvausNrfiF
	 GBkxGOH2Y/6D42LiFPDJmU5Nup1dq7kD3AZS2+uQ=
Date: Sat, 17 Oct 2026 23:19:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Collingbourne <peter@pcc.me.uk>
Cc: Qiliang Yuan <odys.yuan@gmail.com>, Kees Cook <kees@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kasan-dev@googlegroups.com
Subject: Re: [PATCH] string: instrument the word loads in sized_strscpy()
Message-Id: <20261017231909.c9fa8474da8fc1079f112891@linux-foundation.org>
In-Reply-To: <CAPQLkRhXZwozmfhNd_PEx1ihwdH1_5qthP6PANYJ_m-v9vfQTw@mail.gmail.com>
References: <20261018-bug-string-strscpy-kasan-first-byte-v1-1-375a2c46d88f@gmail.com>
	<CAPQLkRhXZwozmfhNd_PEx1ihwdH1_5qthP6PANYJ_m-v9vfQTw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 22:05:03 -0700 Peter Collingbourne <peter@pcc.me.uk> wrote:

> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/bug.h>
> >  #include <linux/ctype.h>
> >  #include <linux/errno.h>
> > +#include <linux/instrumented.h>
> >  #include <linux/limits.h>
> >  #include <linux/linkage.h>
> >  #include <linux/minmax.h>
> > @@ -132,6 +133,12 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
> >                 unsigned long c, data;
> >
> >  #ifdef CONFIG_DCACHE_WORD_ACCESS
> > +               /*
> > +                * Unlike read_word_at_a_time(), load_unaligned_zeropad() is
> > +                * not instrumented. Check the first byte, which must be
> > +                * readable, as read_word_at_a_time() does.
> > +                */
> > +               instrument_read(src + res, 1);
> >                 c = load_unaligned_zeropad(src+res);
> 
> It looks like at least some of the other callers of
> load_unaligned_zeropad() have the same problem. Would it be better to
> add the instrument_read() call to load_unaligned_zeropad()?

Well, with this setup (Kconfig-time and runtime), does our user
actually care about performance?  Can we simply use plain old C code in
these situations and not compromise the runtime checking?

I'm not sure why we have the assembly thing, really.  If the kernel is
spending significant amounts of time doing string copies then why the
heck?
