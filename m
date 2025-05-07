Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906CF1F956;
	Wed,  7 May 2025 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593281; cv=none; b=s0PlMDokKxJhBpV2DYJJvci2IqOPINQZlnQPDgzYznbvTHjQR2BLi+iEhGwh7PFDWKlTgjkU7YEv4NN1q5C73nrHPU2hG+u/vpp5FT2qb+Yj9tK3wGp3AyUQr5ucQpOFnvOQuSuCaft4D64PUpUEMTwE4keEWNBzQ6aFAKsECpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593281; c=relaxed/simple;
	bh=An8FJYbH7fHFCmKYgxAkvcFLQI3QFlSqGo8/j4F+HEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEsZt+PwyCYPK+/n2zdd1ekX28wLF1rIzzTpoRIiKesqStHPqE8BIbwwRRBe51Eur2e3ANmJf2I/EPv5Zox9BiRWn3wsvYd9mzZ0S6QiCrfsUbuKqs7Y2QtkHOTApI+xOu7sBW3nSYwYg3ljDL0eyHvIpg/rcoteb/VYPBU7fOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFA5C68B05; Wed,  7 May 2025 06:47:54 +0200 (CEST)
Date: Wed, 7 May 2025 06:47:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <20250507044754.GC28402@lst.de>
References: <20250507033536.work.088-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507033536.work.088-kees@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 06, 2025 at 08:35:40PM -0700, Kees Cook wrote:
> The only reason nvme_pci_npages_prp() could be used as a compile-time
> known result in BUILD_BUG_ON() is because the compiler was always choosing
> to inline the function. Under special circumstances (sanitizer coverage
> functions disabled for __init functions on ARCH=um), the compiler decided
> to stop inlining it:

Can we place just fix um to still force inlining inline functions instead
of needing these workarounds?

