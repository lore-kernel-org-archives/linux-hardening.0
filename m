Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997928C5A7;
	Wed,  7 May 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633645; cv=none; b=reVvD7W2kWMSqW8ekGStN1qWldv6sC85SdtHJzYTUTS6TLtVFvtnpuFyCAdTERjfmRkOyJMxTNuzCXTNPX24F/i6DUQdTZbULTFsUMxgfevq+9x+ZOU8OV9Q+zRUnB1u8s1GC+UKiovXCX6WXLSVsDDtWNIJkl2ET/j27n9vCow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633645; c=relaxed/simple;
	bh=murxxHC0F5RAJmpzPBp2DaXWwoLRB/TK3/yjau/uW6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4wBY+7xYcaKiG+48el9zoLHbsqA9obBz6JAlW1prn1zzXh9I7Cv8RDNLXLlfUDEsPDdxXmixiY21xbxb2OCxOHW9jKLtQdF5u1l0KOmoyiXL4dag3+JoK0ltIxMiHSGf/pQR/dF850WuwUKWuQV+jddQHVxQT+tbKyTQK1Qios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxsMPIvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxsMPIvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE4FC4CEE2;
	Wed,  7 May 2025 16:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746633645;
	bh=murxxHC0F5RAJmpzPBp2DaXWwoLRB/TK3/yjau/uW6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxsMPIvt9XtPhNQPKET9an+XAjBYSr4fQyjqvqgA51KIDoAvTcnWiGK0bKO3yWGan
	 uwN2fS3Tkxh4JIU/mH7k2rRMZQtLRpDu4qf3+rZjCLEdFNbNzRkvxzkgBWfpW9mufD
	 VRZclSlRzEqjCrugLqpcZwF3CZYfhn22KGPx16qR4+4YZTsodpxnFq/JH0+YAyavCa
	 0A6azIbv/aEAnw7lC0rOc7E2NhiZ8lUJyl3AMXtj2VvMvUmRQ+K/PK0T4PPyi7fwsD
	 vxU50Q9g9jp6SV4AxBBRkg/R/Edr7W9ZYh86R/rFLUzNMnJXYCqFVwAkq5oTEtDl7Y
	 K5ziO15epg6QQ==
Date: Wed, 7 May 2025 10:00:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <aBuDqr-9YCcVfAPi@kbusch-mbp.dhcp.thefacebook.com>
References: <20250507033536.work.088-kees@kernel.org>
 <20250507044754.GC28402@lst.de>
 <202505062255.130383D3B7@keescook>
 <20250507065913.GA31959@lst.de>
 <202505070849.1F48789B6@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505070849.1F48789B6@keescook>

On Wed, May 07, 2025 at 08:53:06AM -0700, Kees Cook wrote:
> 
> So, the solution for the "accidentally depending on a function to be
> inlined by the compiler" is to mark it as _required_ to be inlined,
> which given its singular use in BUILD_BUG_ON(), looks like the correct
> solution.

That sounds fine to me. Or maybe this should be a #define instead. It
looks like this nvme function evolved from a very different purpose when
it wasn't an integer constant expression, and the comment above it is
outdated.
