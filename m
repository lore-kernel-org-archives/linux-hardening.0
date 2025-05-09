Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F425394B;
	Fri,  9 May 2025 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817877; cv=none; b=CJGGFhAlCdSu44kWbSZdu1jhpLUnUvt7L3eatMdmXnN6+tTvJnvwBjkAfV+fGdDW601NqjMYr2/86vJSDyzZL+bJN9EEo6bxfdhoDS1sZ2gqEnIkYkni5i+s98rMI9DSUttzASkpBRsTSw/r5UUK5DDy5J9FuG/4Vfzb5oXAceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817877; c=relaxed/simple;
	bh=hyY+JitAwMQV4zbqWlsTROXHyJTaWJ6CP8kAorcHNgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7PUTK1qC0mdlUil3lrngCk5/73OmAxDH+R/+iuo63horqoMUMJuPoPi7ZgeH04ucBfn9bTVhPmrJf9PX4tA9Nyz1QLeY5BIGtbOGypWMgWaYB83HNt6dwjkfhcpAgy1asrL55oe8obpn/mTRbBCnZ4u4l6KO5dyWTdW6R31Zeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwypWcSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwypWcSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEB8C4CEE4;
	Fri,  9 May 2025 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817877;
	bh=hyY+JitAwMQV4zbqWlsTROXHyJTaWJ6CP8kAorcHNgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XwypWcSwYYFt50MwMh8R6Axdzu33F8RQibMw1KcPIC0ru3cFF8DE2YeWBgkvtE3dc
	 7hXv2e/gpjskTnTt6U6weCQ2F2X8TjogmGdK+L2XWcXKnMce2yWP6ogI43uWrYlLze
	 v1nacdt4NF3j7nT6LD+X7MUhEz2O/sFnWA1MR/Q5LSO2Z5rn3TFaq/hLp6Bww+OXTd
	 nYVjHU+SZEHcASnIe2hlVcg6fWbmk6UljBSTujzIv27ZIKCz0zubq4siD+/N8BPuIL
	 Qbc/rxX9ROQb8jRJKKqoGiCOoyh3Etg4gJm/0AYVR7v8EXakdqxbh5kbjpeHc2AGUl
	 ibaGrJPCx66Cg==
Date: Fri, 9 May 2025 12:11:14 -0700
From: Kees Cook <kees@kernel.org>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore/zone: fix trivial comment typo
Message-ID: <202505091210.DB71C8B566@keescook>
References: <20241224154405.295840-1-eugen.hristev@linaro.org>
 <e03d3e18-9868-4896-a8fc-1443372c0c5b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e03d3e18-9868-4896-a8fc-1443372c0c5b@linaro.org>

On Fri, May 09, 2025 at 09:25:41AM +0300, Eugen Hristev wrote:
> 
> 
> On 12/24/24 17:44, Eugen Hristev wrote:
> > s/conpressed/compressed
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> > ---
> >  fs/pstore/zone.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
> > index 694db616663f..a4ee4e04d1cd 100644
> > --- a/fs/pstore/zone.c
> > +++ b/fs/pstore/zone.c
> > @@ -43,7 +43,7 @@ struct psz_buffer {
> >   *
> >   * @magic: magic num for kmsg dump header
> >   * @time: kmsg dump trigger time
> > - * @compressed: whether conpressed
> > + * @compressed: whether compressed
> >   * @counter: kmsg dump counter
> >   * @reason: the kmsg dump reason (e.g. oops, panic, etc)
> >   * @data: pointer to log data
> 
> Hi Kees,
> 
> While you are at it, there is also this trivial typo

Ah-ha; thanks! I've squashed this into your other commit. :)

-Kees

-- 
Kees Cook
