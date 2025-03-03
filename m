Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD572153CD
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021993; cv=none; b=u/YdEUeRWMOPc+YDhKjgzJMm/4vAtAE8SnR3onaNxU6OPt76udp4skXWdFFgGgdeOS1Im+pL4zOnY8HiKQ7IIQY74+Zi7/9A4u++iM5jbDcJ35I7Z3zLM8iXEiJ+3c2zIBrbhqCj+im/zjF9hE31jKj3f2jObyk+Penkks55MNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021993; c=relaxed/simple;
	bh=wjV3Q9OQE+KWxTknAB+Hn0XOQ/7ghCZqsPx0BsXVc9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmEtuKYes3kVdSR+Nh1+JFWAjeOWRoRf7fq2JK91gH1jeg2ezd4vA3B0D9OKeriMF+w8xwTAjLtTIJZFL/laX8Szlk7GPANgEbGyHDjRlFE/C9H27nspbHUtA3skXxGDnBMWab+SHLxafufrexmapvRM9IBjzjfjjjVhLx4kEek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZY2xu10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZY2xu10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87698C4CED6;
	Mon,  3 Mar 2025 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741021992;
	bh=wjV3Q9OQE+KWxTknAB+Hn0XOQ/7ghCZqsPx0BsXVc9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZY2xu10it+1g2cSt4Xbu7Z7M+JuXQBYG+FCVbRKiuQh+Vbv7Buh4W1JOaXQd/Lrh
	 AH95zR5NKLpy2YQ49Sk4A6OQ18hKuwoO/Oa6EaRvQ0S89haEE6s3Z0DLlcJ4KfcSPd
	 QSjQYMsrBerTUA3M5/M3LxdytjsbotilqV+dqZjZnt9CKc9WA07gQQMzYxf9gRmsPL
	 NWHN+8LJ4CVbcymNCW7+ZD7XoqAtSAK8drqVdFtrcEwWXn8N10+WmtFCEoH+sq7bbZ
	 Ax8hy47cHEGWND6zj7AMQ5Pv7OS7Kw9pXOvPvErNpT5fy3ZC2FEwkQL3yUWFo89HSM
	 P4+PYxUlKUO9w==
Date: Mon, 3 Mar 2025 09:13:09 -0800
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/10] lib/string_choices: Add new helpers
Message-ID: <202503030912.11512B29@keescook>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
 <202502281143.149423E53@keescook>
 <87o6yjyqeb.wl-kuninori.morimoto.gx@renesas.com>
 <CAHp75VdX-ZMf-mYrnA=DYszK8KvjVfi0kz30WfHRN_oYOJR_Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdX-ZMf-mYrnA=DYszK8KvjVfi0kz30WfHRN_oYOJR_Hw@mail.gmail.com>

On Mon, Mar 03, 2025 at 08:20:20AM +0200, Andy Shevchenko wrote:
> On Mon, Mar 3, 2025 at 1:16 AM Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> >
> >
> > Hi Kees
> >
> > Thank you for your feedback
> >
> > > > I would like to use string_choices helper to cleanup the code, but it missing
> > > > some of well used string pair in kernel. This patch-set adds it.
> > >
> > > Do you have some Coccinelle scripts or other patches that show the use
> > > of these helpers? We tend to avoid adding new helpers to the kernel
> > > unless there are active uses of them.
> >
> > I have a lot of patches which uses new helper functions.
> > Because it has dependency (add new helper 1st, use it in 2nd), and
> > different maintainers (helper patch maintainers vs each driver/framwork
> > maintainers), I have posted new helper patch-set 1st (= this patch-set).
> > After that, I will post 2nd patch-set which uses new helper, like
> > new helper patch for v6.15, each driver/framework patch for v6.16, etc.
> >
> > Because there are a lot of patches which uses new helpers, is it OK to
> > indicates some of them (as sample patch) ?
> 
> I am not Kees, but my point of view on this is that you may take one
> subsystem which, for example, I can review (listed as a Designated
> Reviewer or Maintainer in the MAINTAINERS) and add sample patches from
> it. It will speed up the process as my tag would suffice. Also you can
> add into the cover letter the statistics (how many drivers are
> affected (per subsystem/folder) by each of the new helpers in the
> upcoming series.

Yeah, I'd say just post the series you have and in the cover letter
refer to this series as a prerequisite.

-- 
Kees Cook
