Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359872D46CE;
	Fri,  2 Oct 2026 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927651; cv=none; b=PNWgWVZxqpUVU44vHYP3oXF7lSpyX6vkY2gNwStmDhzH0PDXyjhPdT21z6m1++zlLRs9N3VDvueC2cLZeKLrncXwNFNQeCGvFjpjopx6YG3W3o5/YCU1a7cnxuhythvsQDuiDmkMRQPiYoBQKCP/zTny8RcxZ8FCxVTkbnazzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927651; c=relaxed/simple;
	bh=cPF28YJgTJghD9WFIUCLa0BuXMwFBTS8ofA+ye8RAzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwVHmFx4lSFQYat2h3HlTXVyvVY52wiEUKTv7oVMHyghDzwXsniV4T2CMIDDqxaK2LKwX4+1R4vgqso9qmmmdMp70NfGzDMv0wo9qaRkKid1S7yh6aLfMYHSTLpwbQIFzdh5UU8Co9SfNiTSgSDysXl6eYeRNpE+DJ+C42dxVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V48V3ZpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V48V3ZpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84BE1F000FF;
	Fri,  2 Oct 2026 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790927649;
	bh=Lylx5gDUOY6P1xwCQDD9XcktxCTPN9JgKrsv7vw4XOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V48V3ZpY6Nbf9/Eq+1C6S8cLK5FswtynAkSnBtswQ4KXSPOvO99YIvwDpbkMLCPUC
	 3GRSfcaNCer7Tdwm0yl2tOpBVirzLHftHfGMTqDPB1UpDBMnidhyAPVqm70/qm0pmP
	 ssY5KA1LybHe6wBuAmLa9BL1BU6IXPD0z/E1D5orn1Qqx1CZwYLCi2cgfKAPJeVO4m
	 unyR75NCzxPEyaMtBt7KXuMWPnBH8/B72yLXVh5zgCuO95XMmlZATZT5JKQzEzJJzK
	 Z7s4sgoHahSzyyL8KLR4nGiPpybcsW63J1NqnmnaUh9vgdpJ5sHsGnthEBrGbphXX8
	 8tfdvKp/0PoeA==
Date: Fri, 2 Oct 2026 00:54:09 -0700
From: Kees Cook <kees@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Bill Wendling <morbo@google.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 09/11] powerpc/papr_scm: Return the string length from
 the sysfs show functions
Message-ID: <202610020052.9EAB79E@keescook>
References: <20260930235231.out.387-kees@kernel.org>
 <20260930235247.157921-9-kees@kernel.org>
 <9af9f47d-b99e-46d4-bb6c-06d28b037a34@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af9f47d-b99e-46d4-bb6c-06d28b037a34@linux.ibm.com>

On Thu, Oct 01, 2026 at 09:47:56AM +0530, Madhavan Srinivasan wrote:
> 
> On 10/1/26 5:22 AM, Kees Cook wrote:
> > perf_stats_show() and flags_show() build their output with a seq_buf
> > and return seq_buf_used(), which may include the trailing NUL byte
> > when the seq_buf has overflowed. Use seq_buf_strlen() instead.
> > 
> > Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
> > 16.1.0:
> > arch/powerpc/platforms/pseries/papr_scm.o
> > 
> > Assisted-by: LLM
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >   arch/powerpc/platforms/pseries/papr_scm.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> > index 75da96c08cdd..b03cfd8528f5 100644
> > --- a/arch/powerpc/platforms/pseries/papr_scm.c
> > +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> > @@ -1108,7 +1108,7 @@ static ssize_t perf_stats_show(struct device *dev,
> >   free_stats:
> >   	kfree(stats);
> > -	return rc ? rc : (ssize_t)seq_buf_used(&s);
> > +	return rc ?: (ssize_t)seq_buf_strlen(&s);
> >   }
> >   static DEVICE_ATTR_ADMIN_RO(perf_stats);
> > @@ -1150,7 +1150,7 @@ static ssize_t flags_show(struct device *dev,
> >   	if (seq_buf_used(&s))
> 
> this can also be seq_buf_strlen instead

It could be, yeah. I left it because it seemed be more about "did we
touch this at all?" But it's honestly all the same. I will respin with
it changed too.

> 
> >   		seq_buf_printf(&s, "\n");
> > -	return seq_buf_used(&s);
> > +	return seq_buf_strlen(&s);
> >   }
> >   DEVICE_ATTR_RO(flags);

-- 
Kees Cook
