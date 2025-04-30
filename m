Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34CC2980DD;
	Wed, 30 Apr 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043587; cv=none; b=fI0cS1Ai59I1s6X+fJYRVf/2SeFVFvK/coSl1FFuXBSb0RmjTeaeQMB9HKIkquD7BqLxOhXcNjyNjLksbnZoLrAz/6WBPlJw5BG7DNJddEKwLIuj3nRLIGNTzlAhWAJ7DXmWAHJWXgNST+Vebwk82pNU36wewD4o/Ftzofcaovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043587; c=relaxed/simple;
	bh=iZIMCppN1Ev0tPCOUt0ZBGp5W6iVvPZP4no8Hky88Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecA+XfEGTNk8jfxIbqPI8ri4PXTnNIyENKEh63j+HTSRS8kZ2d9rlQt6J3+cgl75+a1lbTemBaHC6CHBH60QyvJZ7+Z9Jjf0RmFm9e/nL2wjSkOZqZP6ElVoGhiHnhRQJ8+Bl0EK0yLrehg7h6WzSmEJ4h6qoPQqgsHm3OVpE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5syfOcP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5syfOcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B60C4CEE7;
	Wed, 30 Apr 2025 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746043587;
	bh=iZIMCppN1Ev0tPCOUt0ZBGp5W6iVvPZP4no8Hky88Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5syfOcPY2POt/ZJvF9cL+XB3hlalp94tlny8tHbD6yPBLvSZLfW/NO0hq2BF5tYz
	 wvQp93q9uZqRIdmrrYxP0nB1alymdp7ohuOrEjMLabHaMzKV91R+HKwIzgRA3O6xMd
	 0cHMTQi7c94h0sRxsulxU8eOuByBUgVuhYNf9g6teJehRHQXTcI96c6dSnpStF55Cs
	 et00A5E77jU1qU7v0Vu4TPk4OxRFPUrgPfKC42KpKR2TPk3inimxP8JTOoKMhZRQzp
	 O5r0ddvRiyxIgopT+Qnk4oiYoVmp1dgNoWjgoP6Ayqqwv/BrrRQeebnmN0GkGhvpO/
	 7MYEyc4exNdUg==
Date: Wed, 30 Apr 2025 13:06:24 -0700
From: Kees Cook <kees@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] module/decompress: Adjust module_extend_max_pages()
 allocation type
Message-ID: <202504301305.2A0CD4E8@keescook>
References: <20250426062359.work.358-kees@kernel.org>
 <d7382c8a-cfb2-4389-b120-f01a17e248ab@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7382c8a-cfb2-4389-b120-f01a17e248ab@suse.com>

On Mon, Apr 28, 2025 at 12:30:03PM +0200, Petr Pavlu wrote:
> On 4/26/25 08:24, Kees Cook wrote:
> > In preparation for making the kmalloc family of allocators type aware,
> > we need to make sure that the returned type from the allocation matches
> > the type of the variable being assigned. (Before, the allocator would
> > always return "void *", which can be implicitly cast to any pointer type.)
> > 
> > The assigned type is "struct page **" but the returned type will be
> > "struct page ***". These have the same allocation size (pointer size), but
> > the types don't match. Adjust the allocation type to match the assignment.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Petr Pavlu <petr.pavlu@suse.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Daniel Gomez <da.gomez@samsung.com>
> > Cc: <linux-modules@vger.kernel.org>
> > ---
> >  kernel/module/decompress.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> > index 474e68f0f063..bbb2a55568cd 100644
> > --- a/kernel/module/decompress.c
> > +++ b/kernel/module/decompress.c
> > @@ -19,7 +19,7 @@ static int module_extend_max_pages(struct load_info *info, unsigned int extent)
> >  	struct page **new_pages;
> >  
> >  	new_pages = kvmalloc_array(info->max_pages + extent,
> > -				   sizeof(info->pages), GFP_KERNEL);
> > +				   sizeof(*new_pages), GFP_KERNEL);
> >  	if (!new_pages)
> >  		return -ENOMEM;
> >  
> 
> The function has a similar type mismatch a few lines below:
> 
> memcpy(new_pages, info->pages, info->max_pages * sizeof(info->pages));
> 
> The sizeof operator is used on 'struct page **', but it should be really
> on 'struct page *'.
> 
> Could you please fix this as well? For consistency with your patch,
> I suggest changing it to 'sizeof(*new_pages)'.

Actually, this whole function is basically just open-coded kvrealloc...
I will send a v2.

-- 
Kees Cook
