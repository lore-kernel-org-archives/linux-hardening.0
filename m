Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0B77F2F;
	Fri, 13 Sep 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246548; cv=none; b=q5t1kkkcouYewK6z1wNiPtlZ+PMWvA/g2fOgLxX7cZneLk2LVnnJ3hCzP/AWuxGtD4kuIei0roRtzVl9IiC8xmjn4TgmOtdHMfeQrm5hbszxYbTzqVyURmNYXfiVN5ILcaKKE2MRoN83DSBpU/j0aOKkFWsQ3V50b6gMuR36U5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246548; c=relaxed/simple;
	bh=90xDXxfN2f5n65CXhpW5fm5Xi7ORcO34PxZRrctl0U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLCl1PzF/2lDb9M1DYr/QDPdZQUkWvqAQDmjoInwASLqeyb7rky5PjsBkhvTo8csjH1V7NZU88aJnWvEu+gDwPka/biK9uIJFiC22kXNlyb3TeHWcC2/9T9uok0rEg1Bq0xEmaTmxQZgpNv6Wi2cUWmY+iheJj9PA9rO9pc10pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwWmd4DY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwWmd4DY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B25C4CEC0;
	Fri, 13 Sep 2024 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726246548;
	bh=90xDXxfN2f5n65CXhpW5fm5Xi7ORcO34PxZRrctl0U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwWmd4DYyIcDyGsK51HvMOkUX37gDvRdYiMwkn0CrlAKtC+2pHXMvpBAiPQJIYYsU
	 9WYpRwQVwIa0jGYcu3vLNl3EWY8Z355KvSPP17XfwlY6ungg3yy6QLojYIJFu2H/qt
	 1cXASzTLXjmnqh74gQ7tjO16vfoCEtGIQY8HCEosap74+zn3sErFlb5XwFQgiHF8yV
	 jXnCfbR/JNyO2sLGne5ajs/icOSkNCEwU9eBQ8HM5L3uCsfY27VTlPgLvInuppVCwv
	 nDOmdVSRp35qRkVuyd0lDSHCYvvhlzAY1u6daGOn6qhkn73KcSKiyy8ZzkQqXgfDk+
	 WpZQmKwFJdz+g==
Date: Fri, 13 Sep 2024 09:55:46 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, kees@kernel.org,
	gustavoars@kernel.org, andriy.shevchenko@linux.intel.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs
 with __counted_by()
Message-ID: <ZuRukktSDoKqoV1P@bombadil.infradead.org>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913164630.GA4091534@thelio-3990X>

On Fri, Sep 13, 2024 at 09:46:30AM -0700, Nathan Chancellor wrote:
> Hi Thorsten,
> 
> On Mon, Sep 09, 2024 at 06:27:26PM +0200, Thorsten Blum wrote:
> > Add the __counted_by compiler attribute to the flexible array member
> > attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE.
> > 
> > Increment num before adding a new param_attribute to the attrs array and
> > adjust the array index accordingly. Increment num immediately after the
> > first reallocation such that the reallocation for the NULL terminator
> > only needs to add 1 (instead of 2) to mk->mp->num.
> > 
> > Use struct_size() instead of manually calculating the size for the
> > reallocation.
> > 
> > Use krealloc_array() for the additional NULL terminator.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> > ---
> > Changes in v2:
> > - Use krealloc_array() as suggested by Andy Shevchenko
> > - Link to v1: https://lore.kernel.org/linux-kernel/20240823123300.37574-1-thorsten.blum@toblux.com/
> > ---
> >  kernel/params.c | 29 +++++++++++++----------------
> >  1 file changed, 13 insertions(+), 16 deletions(-)
> > 
> > diff --git a/kernel/params.c b/kernel/params.c
> > index 2e447f8ae183..5f6643676697 100644
> > --- a/kernel/params.c
> > +++ b/kernel/params.c
> > @@ -551,7 +551,7 @@ struct module_param_attrs
> >  {
> >  	unsigned int num;
> >  	struct attribute_group grp;
> > -	struct param_attribute attrs[];
> > +	struct param_attribute attrs[] __counted_by(num);
> >  };
> >  
> >  #ifdef CONFIG_SYSFS
> > @@ -651,35 +651,32 @@ static __modinit int add_sysfs_param(struct module_kobject *mk,
> >  	}
> >  
> >  	/* Enlarge allocations. */
> > -	new_mp = krealloc(mk->mp,
> > -			  sizeof(*mk->mp) +
> > -			  sizeof(mk->mp->attrs[0]) * (mk->mp->num + 1),
> > +	new_mp = krealloc(mk->mp, struct_size(mk->mp, attrs, mk->mp->num + 1),
> >  			  GFP_KERNEL);
> >  	if (!new_mp)
> >  		return -ENOMEM;
> >  	mk->mp = new_mp;
> > +	mk->mp->num++;
> >  
> >  	/* Extra pointer for NULL terminator */
> > -	new_attrs = krealloc(mk->mp->grp.attrs,
> > -			     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 2),
> > -			     GFP_KERNEL);
> > +	new_attrs = krealloc_array(mk->mp->grp.attrs, mk->mp->num + 1,
> > +				   sizeof(mk->mp->grp.attrs[0]), GFP_KERNEL);
> >  	if (!new_attrs)
> >  		return -ENOMEM;
> >  	mk->mp->grp.attrs = new_attrs;
> >  
> >  	/* Tack new one on the end. */
> > -	memset(&mk->mp->attrs[mk->mp->num], 0, sizeof(mk->mp->attrs[0]));
> > -	sysfs_attr_init(&mk->mp->attrs[mk->mp->num].mattr.attr);
> > -	mk->mp->attrs[mk->mp->num].param = kp;
> > -	mk->mp->attrs[mk->mp->num].mattr.show = param_attr_show;
> > +	memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));
> > +	sysfs_attr_init(&mk->mp->attrs[mk->mp->num - 1].mattr.attr);
> > +	mk->mp->attrs[mk->mp->num - 1].param = kp;
> > +	mk->mp->attrs[mk->mp->num - 1].mattr.show = param_attr_show;
> >  	/* Do not allow runtime DAC changes to make param writable. */
> >  	if ((kp->perm & (S_IWUSR | S_IWGRP | S_IWOTH)) != 0)
> > -		mk->mp->attrs[mk->mp->num].mattr.store = param_attr_store;
> > +		mk->mp->attrs[mk->mp->num - 1].mattr.store = param_attr_store;
> >  	else
> > -		mk->mp->attrs[mk->mp->num].mattr.store = NULL;
> > -	mk->mp->attrs[mk->mp->num].mattr.attr.name = (char *)name;
> > -	mk->mp->attrs[mk->mp->num].mattr.attr.mode = kp->perm;
> > -	mk->mp->num++;
> > +		mk->mp->attrs[mk->mp->num - 1].mattr.store = NULL;
> > +	mk->mp->attrs[mk->mp->num - 1].mattr.attr.name = (char *)name;
> > +	mk->mp->attrs[mk->mp->num - 1].mattr.attr.mode = kp->perm;
> >  
> >  	/* Fix up all the pointers, since krealloc can move us */
> >  	for (i = 0; i < mk->mp->num; i++)
> > -- 
> > 2.46.0
> > 
> 
> I just bisected this change to a fortify failure that I see with a
> couple different ARM configurations when built with a version of clang
> that supports __counted_by(). I can reproduce this with:
> 
>   $ curl -LSso .config https://gist.github.com/nathanchance/6df4bd2ab4c4418020b3ed5417ef4f80/raw/758abf666dfe8c76e0f16735f336849ea47ef791/.config
> 
>   $ make -skj"$(nproc)" ARCH=arm LLVM=1 olddefconfig zImage
> 
>   $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/arm-rootfs.cpio.zst | zstd -d >rootfs.cpio
> 
>   $ qemu-system-arm \
>       -display none \
>       -nodefaults \
>       -no-reboot \
>       -machine virt \
>       -append 'console=ttyAMA0 earlycon' \
>       -kernel arch/arm/boot/zImage \
>       -initrd rootfs.cpio \
>       -m 512m \
>       -serial mon:stdio
>   [    0.000000] Booting Linux on physical CPU 0x0
>   [    0.000000] Linux version 6.11.0-rc4+ (nathan@thelio-3990X) (ClangBuiltLinux clang version 19.1.0-rc4 (https://github.com/llvm/llvm-project.git 0c641568515a797473394694f05937e1f1913d87), ClangBuiltLinux LLD 19.1.0 (https://github.com/llvm/llvm-project.git 0c641568515a797473394694f05937e1f1913d87)) #1 SMP Fri Sep 13 09:36:38 MST 2024
>   ...

Thanks, I've dropped this patch from modules-next for now.

  Luis
