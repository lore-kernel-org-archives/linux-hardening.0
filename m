Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74A17BB6;
	Fri,  2 May 2025 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746154022; cv=none; b=iCrkbVXAziWqXos/SYvvf1kfl0fobe3yR0m28/gpR5M+O1EOjLbjNB04z0FB989+o+4mDiI+qt2dYJURFYvTvbA1TLm36UGWnOhpNcMKe4S6lzs0uAMVUd1thM2jVHtK0EJRXmCfWHhBDDDtc0vUlC1xU12WAMq94yXjosypZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746154022; c=relaxed/simple;
	bh=kCsuUYT/SjUQVrPNwt+MDCVPrSpdg5Uljxu8zKa+2bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5lkxymeUaZO+CJ9uERzDsMTkxTorTyvdmnZXfxGaXQdpKwkIugTrsO3+7i7z7MhiZBZhUDp4QXbUnBjnHxf2F9fb/lyzpJNfmF3/kZiym3dbBiB8lzGk18V25uhuoGoBcpaQQDAbzX9Ye2vhDAz2StJfsrhEnkJI/pIaVaaL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA2+3X0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA2+3X0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270FCC4CEE3;
	Fri,  2 May 2025 02:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746154022;
	bh=kCsuUYT/SjUQVrPNwt+MDCVPrSpdg5Uljxu8zKa+2bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uA2+3X0YwVrQUFVA9HsqyCw5af9OMSANt0To2/hJS+SeOWEthCCcE5nlBXU8PPQQw
	 2G9h7L18fn1sGbCjOfnE86TLGT2X/AACZaIThdUgIPdnL85HHiLf1eQIkloGdR5Q5C
	 V5cKY+g/KJ7yKlGJKd9+nsWawOer6r/ApOZJthha6P1IToRMij8G+oTrZ1taauF2DG
	 QSSXC1uJZM0rSE4hb5oKG+9VUensoClaZkRBbzWYu2P2SiMk0orkiRFX5YAnbgWaBM
	 hKobl+lHiuMGVdDxmoNzzDD5Pl/lI9z1PPKDI1UsyGfSlsJcNSKp9nxCKrD+91KPZ6
	 pFuHK50PMq6fg==
Date: Thu, 1 May 2025 19:46:59 -0700
From: Kees Cook <kees@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] drm/ttm: Silence randstruct warning about casting
 struct file
Message-ID: <202505011944.E35A427@keescook>
References: <20250502002437.it.851-kees@kernel.org>
 <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com>
 <20250502023447.GV2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502023447.GV2023217@ZenIV>

On Fri, May 02, 2025 at 03:34:47AM +0100, Al Viro wrote:
> On Thu, May 01, 2025 at 07:13:12PM -0700, Matthew Brost wrote:
> > On Thu, May 01, 2025 at 05:24:38PM -0700, Kees Cook wrote:
> > > Casting through a "void *" isn't sufficient to convince the randstruct
> > > GCC plugin that the result is intentional. Instead operate through an
> > > explicit union to silence the warning:
> > > 
> > > drivers/gpu/drm/ttm/ttm_backup.c: In function 'ttm_file_to_backup':
> > > drivers/gpu/drm/ttm/ttm_backup.c:21:16: note: randstruct: casting between randomized structure pointer types (ssa): 'struct ttm_backup' and 'struct file'
> > >    21 |         return (void *)file;
> > >       |                ^~~~~~~~~~~~
> > > 
> > > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > I forgot the policy if suggest-by but will add:
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > Thomas was out today I suspect he will look at this tomorrow when he is
> > back too.
> 
> [fsdevel and the rest of VFS maintainers Cc'd]
> 
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Reason: struct file should *NOT* be embedded into other objects without
> the core VFS being very explicitly aware of those.  The only such case
> is outright local to fs/file_table.c, and breeding more of those is
> a really bad idea.
> 
> Don't do that.  Same goes for struct {dentry, super_block, mount}
> in case anyone gets similar ideas.

Well, in that case, the NAK should be against commit e7b5d23e5d47
("drm/ttm: Provide a shmem backup implementation"), but that looks to
have had 15 revisions already...

But I will just back away slowly now. I was just fixing a warning
introduced by it. :)

-- 
Kees Cook
