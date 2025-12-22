Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF7225785
	for <linux-hardening@vger.kernel.org>; Mon, 22 Dec 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766446121; cv=none; b=fqOD+dxnni8CC/dgBuLgv3yv4tewW5BmxKOijLizL7BkdQuJ7WQ1OB7N3NMWMN6uzW/MLNTGhL6jk8Wx2KibKVSVbHpAN8oue4C4UTB/BtGQjGliVXBlLj/R7Pan6syw52/mwwSYH3yQX64uFgTfvgBwtp+V5lZpUqy+MxaQnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766446121; c=relaxed/simple;
	bh=R3fe91pMWYmRZPN32QqlJWbZt+q2EYCEmx6Y8mW/T00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc0r7SZH7ZAd8w9F2IBF3HgWzYVmUp8PvF/FMjYAl82JC0/98rzZ0aycvqWAk9p5zKX8erfHEW2szSDZE4L/iUNjE14RguFMQrEiml6zpzCYzPPhZ0njhHAY+6ubcgJU4uthrLJ/Tppk+I2w9BvaAyOtUXUIe1VE84zjzK/WlMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFtXiYEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFtXiYEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40145C4CEF1;
	Mon, 22 Dec 2025 23:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766446121;
	bh=R3fe91pMWYmRZPN32QqlJWbZt+q2EYCEmx6Y8mW/T00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFtXiYEe09n4obtayrA1VVdpvDSsbqosxKdYWzQ+CL7Rrz20MI5u+rugv3JjL9xil
	 luNgVWDao/fwI9lZD3BKtrlsACFVgMmljsOvKXf7HXAc9clzrSr0iJ+mQrGpHwWB7c
	 5X6QKLQNMvj0LnW4Lb+pigQ9g6yAHOwA5JVi9AHCIOhV4q7ka/ScBTR+6rERsPkXPE
	 mv4wTfypX+mNGqolcc76B+ZJ3/2U4V+xT704MQjWi/DRBCXt3oS2H6Gy1nUVPKfrYm
	 YI50dcKptOMHDF3YT6zJNEXhLCPnPfXzDBEYCFecb1K0A1EL6GHrdzmedv4BluHfnb
	 5gYGWR9UrPO8A==
Date: Mon, 22 Dec 2025 15:28:40 -0800
From: Kees Cook <kees@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: UBSAN: array-index-out-of-bounds
Message-ID: <202512221526.451D1BE1B@keescook>
References: <90e419ad-4036-4669-a4cc-8ce5d29e464b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90e419ad-4036-4669-a4cc-8ce5d29e464b@infradead.org>

On Fri, Dec 19, 2025 at 08:20:13PM -0800, Randy Dunlap wrote:
> 
> from kernel bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=220823
> 
> 
> Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/drivers/mtd/devices/mtd_intel_dg.c:750:15
> 
> 
> (from drivers/mtd/devices/mtd_intel_dg.c:)
> 
> 	nvm = kzalloc(struct_size(nvm, regions, nregions), GFP_KERNEL);

Yes, this needs to be immediately followed with:

	nvm->nregions = nregions;

> ...
> 
> 	for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
> 		if (!invm->regions[i].name)
> 			continue;
> 
> 		char *name = kasprintf(GFP_KERNEL, "%s.%s",
> 				       dev_name(&aux_dev->dev), invm->regions[i].name);
> 		if (!name)
> 			continue;
> 750:		nvm->regions[n].name = name;
> 		nvm->regions[n].id = i;
> 		n++;
> 	}
> 	nvm->nregions = n;
> 
> 
> regions is a flexible array in struct intel_dg_nvm *nvm; [see below]
> regions is counted_by nvm->nregions.

Now, will nregions change again after this point? There is a question of
whether nvm->nregions represents the _allocation_ size or the _valid_
size. It seems like a max is allocated but then only populated up to a
certain point?

> Question: does UBSAN use the value of the counted_by variable for array bounds
> checking?

Yes.

> If so, that means nvm->nregions must be updated before the array entry
> is used. Is that correct?

Yes.

-- 
Kees Cook
