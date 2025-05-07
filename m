Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68351C84BF;
	Wed,  7 May 2025 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746597334; cv=none; b=H3hea5WZBG9iM3i1HXaFmGQw2raeV/qZftrrw0Rv4psbfdWOfHZicg6OGXyHNt4i9vpPngcM6OKt6JQApKBNYc7ddG3i17CvJkLwkMJlU+MrU70E5thsKqxjEmjPTKvpPDdLx3KXSsQErkNdrsjP5bDZ3rYB/aqTIGJ3RrIsGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746597334; c=relaxed/simple;
	bh=c4CC6V9Grz+vwsqhkE8/eAXGhDDEiWIUvw+08z+578c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX9Dw6oHvuPQqHsRxSPT2s+fueTlXHE6WeJgH2S6ZtVJHN+8EwWRdppShVmFsF3POETS4kjUevC3PBhrlxt2X25A7U7mtapHcRn910EkV0veVfdqfgr8qkWcAWUELgiXOa9bJLuY8FyDpNEaPJ8iTfBfecEh7VrAgK7iYuEIENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqUjdo1q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqUjdo1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20619C4CEE7;
	Wed,  7 May 2025 05:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746597334;
	bh=c4CC6V9Grz+vwsqhkE8/eAXGhDDEiWIUvw+08z+578c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqUjdo1qTUWhDSCMMnoR+//QvT+AD9SDt9KvXS6o2cPixrOg7E62Ie2xy9AthxQNa
	 y/2FDZCiR+59WlQj6Lt6iaWr+nNEDf0gY3d96TQifcTjqzs904K9JnwnJpAQlLgCCS
	 Kwy3E/Ixl12ODLEfdD+bDwNL0oeZ97DSdSbcYe+xhsZmXOYwmfK33X0pniCDb1Kfaq
	 FxZBgtpSloN7tTdNXQ0HW/6B27y14LifK6slMj88nxIbjU3knK65SfO/dpVmG3Pp9b
	 o/npecIhv7y47oZYKd5PkI3yF4G6ZZfv6N2wuxKEhxQTGxU875DlOWfEHC806lae9d
	 ftUBSyY1KJ/iQ==
Date: Tue, 6 May 2025 22:55:31 -0700
From: Kees Cook <kees@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <202505062255.130383D3B7@keescook>
References: <20250507033536.work.088-kees@kernel.org>
 <20250507044754.GC28402@lst.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507044754.GC28402@lst.de>

On Wed, May 07, 2025 at 06:47:54AM +0200, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 08:35:40PM -0700, Kees Cook wrote:
> > The only reason nvme_pci_npages_prp() could be used as a compile-time
> > known result in BUILD_BUG_ON() is because the compiler was always choosing
> > to inline the function. Under special circumstances (sanitizer coverage
> > functions disabled for __init functions on ARCH=um), the compiler decided
> > to stop inlining it:
> 
> Can we place just fix um to still force inlining inline functions instead
> of needing these workarounds?

Oh, I don't have the history here. Is there something about UM and
forcing off inlining?

-- 
Kees Cook
