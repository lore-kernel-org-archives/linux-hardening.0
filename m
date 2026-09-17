Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D50842E43A;
	Thu, 17 Sep 2026 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685254; cv=none; b=eosT2ry/2MWrIQ8njZEBweA255Xhu1ELZhyY7+olmSVZOVl/BVq5RY4OY5fqeQmr1R0Z31oeiWQk7lhI92J2SgUQAqllQLBlbhel9Rh4p1s/RP7tN2vKuvFHnsApjuFhHEPSdkyVt4aM1Bj7yxTLArDCoKOyLcLxNvsMWb+urcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685254; c=relaxed/simple;
	bh=SMqYdfiPwRXRyTKswGzz5iO1soozNB7Bw2nAH6gFfqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPmZZiWDoXLWn5U2DmTCV+ZmI/mT3lr0NtVHT/jts/9uhmQqIENv1cicpyBwm7N9dK0AkS7HHSRRc0LyCeMGXpeY/bgYkoSYkp+JOymCbgAusEfRkVz6BfyzI+tOcH+yim84snEdScWwu+zVOzvZWNBxZvNJKM6hOXyCQKojoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5wRw5JL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5wRw5JL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557C61F000FF;
	Thu, 17 Sep 2026 22:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789685253;
	bh=8Li/olbUQ7G8GFrX4U0/Y+lzE3EV3zjQFNNG4WPCqrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n5wRw5JLBeFR1hel4a/n8LSxMtWLORFssE+amPgpyU65X393AnLKWj6EYDT4rctR8
	 JGMcR+6Q78oK2krKLDunCtuTySxFTMPziAS3azB5bp+p/5Q//cUsePeP3Sf4bmmlCk
	 uFpmrKLThNbtNNL47WaOBdXaMZbYIalYNznB1gl68ScxwakaHPcbtCsIMBf1BEpP21
	 sYHy0lm+VN/w/Vty/1druh+PytAH5gZIAgJkU589Go7b8e7tdu49qWfiNhuwvJA1nO
	 150e9b03Ry4vxiBF/RIKuJvt0q+dVDC+p3ThWUTOIs5kWAxYypQevEMHygaM4Rnglw
	 QItmzN/8aQo/g==
Date: Thu, 17 Sep 2026 15:47:33 -0700
From: Kees Cook <kees@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: Add const to pattrs allocation type
Message-ID: <202609171545.A37F12B74F@keescook>
References: <20260917211423.i.786-kees@kernel.org>
 <37f07dcb-9b4a-4767-8d0c-471148729c20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f07dcb-9b4a-4767-8d0c-471148729c20@kernel.org>

On Thu, Sep 17, 2026 at 10:32:15PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 9/17/26 10:14 PM, Kees Cook wrote:
> > From: Kees Cook <kees+treewide@kernel.org>
> > 
> > In preparation for making the devm_kmalloc family of allocators type
> > aware, we need to make sure that the returned type from the allocation
> > matches the type of the variable being assigned. (Before, the allocator
> > would always return "void *", which can be implicitly cast to any
> > pointer type.)
> > 
> > The assigned type is "const struct bin_attribute **", but the converted
> > allocation type would be "struct bin_attribute **", which is the same
> > type without the const qualifier. As there is no general way to safely
> > add const qualifiers, take the size from the assignment target instead.
> > No change in allocation size results.
> > 
> > Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> > drivers/nvmem/core.o
> > 
> > Assisted-by: LLM coccinelle
> > Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> > ---
> > Cc: Srinivas Kandagatla <srini@kernel.org>
> > ---
> >  drivers/nvmem/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 0556d140170a..19edc9ab0282 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -485,7 +485,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> >  	/* Allocate an array of attributes with a sentinel */
> >  	ncells = list_count_nodes(&nvmem->cells);
> >  	pattrs = devm_kcalloc(&nvmem->dev, ncells + 1,
> > -			      sizeof(struct bin_attribute *), GFP_KERNEL);
> > +			      sizeof(*pattrs), GFP_KERNEL);
> 
> Thanks for the patch, while you are at it, there are few more instances
> just below this.

There are, but there were no type mismatches with those. pattrs is const,
but attrs and attrs[i].attr.name aren't, so no change is needed there.
Do you want me to flip the attrs devm_kcalloc sizeof to *attrs to much
style, though?

-Kees

-- 
Kees Cook
