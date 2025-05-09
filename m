Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B222627E9;
	Fri,  9 May 2025 04:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746766587; cv=none; b=CPbXq230hz6fiLQFYB43hanv0J7ZO0krQpZyCKPWPdDyo93ybN1o/F4hbBBs60q3D9zIRrE8w2xEvXdNIveXSweSDb8G0T/w9xv8PwOUKPi6X3cy7LsHyWSlnN5UBmbjQpzp/W51l7m44K69j2AkKQvXxTs2YmrGzWKRjZNZNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746766587; c=relaxed/simple;
	bh=rvd35D0ZGFtaVPzqe01gVL+IaoWmCIYL67yAdE691eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y74FKx5aXrqrtjs+fe2FRBg1KTFgzMH5XLqejHG/FOLirSniOlCbjygk62Wv08GN06o3UVL0wgIFflKzgO8pmQ2K/dIe5w06jCEttp0CRiakkQkSkK7IOE1JlJ1Pd4BHMJet7jstL1SwrRsGdq8QD89+nJu/stEJA/5+GTpGE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E8AE67373; Fri,  9 May 2025 06:56:20 +0200 (CEST)
Date: Fri, 9 May 2025 06:56:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <20250509045620.GA29328@lst.de>
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

Thank,

applied to nvme-6.15.

