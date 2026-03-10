Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841A2BE644;
	Tue, 10 Mar 2026 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152454; cv=none; b=cQy6RiBBIqteOQk3ry/T2awbYJVgloOMekMCSY9zRvOT1xPTwTGrTZUS/+RH5PkgKNAIkH+D6posd9JGsyYpOqeu3Bb2Nbbb1fmp36j3Ux91G+t7ZC3NazSzvdDBD1GQNqhOV5OmenJO9rQyd6rUKcUmMgmMC9MUHPQWUpO20dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152454; c=relaxed/simple;
	bh=0p6npGPxdTaDQP/V0FnyiepBYzkq4OziP2XRoMVUSB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvfF1OJ8qA/8ct9Qrjy7/qMt5ZYr6+es4/7/ov46IUoM/mRyfHfiICrhWiXp+a9GbKDO/BG0E25/Z6AmwhGJOlykSE1d2mNJlPWzugI7qQmQSCS/VaLDiDy4ZbAXg9jU1aFy9KVzJQC6o8dc9pYWDNY7EtZewVAeDT/dT/MIrhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 675B068C7B; Tue, 10 Mar 2026 15:20:49 +0100 (CET)
Date: Tue, 10 Mar 2026 15:20:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme: Annotate struct nvme_dhchap_key with __counted_by
Message-ID: <20260310142049.GA10134@lst.de>
References: <20260303213102.86585-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303213102.86585-1-thorsten.blum@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 03, 2026 at 10:31:01PM +0100, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'key' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

