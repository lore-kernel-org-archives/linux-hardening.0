Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D91CA6F;
	Sat, 14 Dec 2024 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137791; cv=none; b=K4L5nwxXgcvBIVrRyMQOA0LEFjrwVVRCEbB9fVgndl4C9qQr1RpPZusJWqri3Aff5PXRXXN5RHeD9xGo0GkxjLJw1EzprYm9EAG9dh+F5eqMY9nLjT7CwlnN482IKF8cJlv49nsUE268BIRPpHfsgYNNaKZXM6ll+tnvL8RAj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137791; c=relaxed/simple;
	bh=92luzIVjfjAyEdhfZE/R/uAdo5CyLJyLxN1vjHYrNF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmiZaoikC9UY+BO64udCb0X/c4qD3MtlMyBrf8jOZgSRKXr+SVM7bqqFEDi3UC03Qw20iB2JA0SD45a1idrKMctDrdAX1yun9ebPFf4MKWVvNeWROqiaSyyyNQK+07Ro47uSs8ghw8qWqwe3dHv8fnuUmcQPe4CXvfU7ycg5PKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQnB2rQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQnB2rQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84150C4CED0;
	Sat, 14 Dec 2024 00:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734137790;
	bh=92luzIVjfjAyEdhfZE/R/uAdo5CyLJyLxN1vjHYrNF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQnB2rQSnBwr2OmGhth7bCvy/Qxff+5yElRN9uO42y1XtNa98wQaHkBoomZ/AOxjI
	 tB4loxYtYE/sBHbesLtSi4TIZb/ZnlBhvONJPmdQ2YJHrL2qISGpMNRgFPgfHRcc0o
	 95QP/j6STxtGA56lYmL0sFGRGVASWLjrUty5HS9yuZndJyK1d07HiQ3ZwfXei4uhpr
	 12Dv84cNBxod3c/lar+CzwS9hJOvnRHBGjNU6b3QqB2mJGKs9XyPk3eAg94JA30NQk
	 tNwxWGQehXMc525QZMNIP/lZS7x2bOyFKQAnU83L5j8b3gfS5k4qRyYsLy+NWJEmRY
	 w+9iCwnjngxHQ==
Date: Fri, 13 Dec 2024 16:56:27 -0800
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com,
	adhemerval.zanella@linaro.org, ojeda@kernel.org,
	adobriyan@gmail.com, jeffxu@chromium.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	jorgelo@chromium.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/1] binfmt_elf: seal address zero
Message-ID: <202412131650.9537DD1B@keescook>
References: <20240806214931.2198172-1-jeffxu@google.com>
 <172365478431.4159848.371478248517217096.b4-ty@kernel.org>
 <cfd3e288-c913-482d-a6ce-789fa6b0f2b3@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfd3e288-c913-482d-a6ce-789fa6b0f2b3@lucifer.local>

Sorry for the delay in my reply -- I've been trying to catch up on stuff
after 2 weeks off.

On Tue, Dec 03, 2024 at 02:13:45PM +0000, Lorenzo Stoakes wrote:
> On Wed, Aug 14, 2024 at 09:59:47AM -0700, Kees Cook wrote:
> > On Tue, 06 Aug 2024 21:49:26 +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > In load_elf_binary as part of the execve(),  when the current
> > > task’s personality has MMAP_PAGE_ZERO set, the kernel allocates
> > > one page at address 0. According to the comment:
> > >
> > > /* Why this, you ask???  Well SVr4 maps page 0 as read-only,
> > >     and some applications "depend" upon this behavior.
> > >     Since we do not have the power to recompile these, we
> > >      emulate the SVr4 behavior. Sigh. */
> > >
> > > [...]
> >
> > I added the cover letter details to the commit log and changed pr_warn()
> > to pr_warn_ratelimited(), but otherwise, looked good.
> >
> > Applied to for-next/execve, thanks!
> >
> > [1/1] binfmt_elf: mseal address zero
> >       https://git.kernel.org/kees/c/44f65d900698
> >
> > Take care,
> >
> > --
> > Kees Cook
> >
> >
> 
> Hi Kees,
> 
> Reproducing diffstat here:
> 
>  fs/binfmt_elf.c    |  5 +++++
>  include/linux/mm.h | 10 ++++++++++
>  mm/mseal.c         |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> It seems that in commit 44f65d9006982 ("binfmt_elf: mseal address zero")
> you took a patch that makes changes to mm code without any review/ack from
> any mm maintainer.
> 
> While I realise this was a small change, in future can you make sure to
> ensure you have that?

Oh, yes! I can do that. As you say, it was a very small change and
almost entirely "standard" boilerplate. But sure, I will be poke people
more directly if anything touches mm in the future.

-Kees

-- 
Kees Cook
