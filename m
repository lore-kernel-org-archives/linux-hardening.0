Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D35235BFB;
	Tue, 22 Apr 2025 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308680; cv=none; b=ldnhvgxZ/eekpNzbsKKuPbBOR1G/ArXGoITBKnVljK1t/fJsStAnDMfpzcjKMZbiV2UCKAcdJy82KcORsri7IAADfZSWqhixS26VYOejm20B4P0FSf+wxPRRb5mXF8XBYE8E39D+HRx3tseDvqSCLzWvOTQYg6MRtN1okfp07RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308680; c=relaxed/simple;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex7ognpTomb4N+WTZ0cRe28sjkZjlY2bReBBuc9Ax15MY+4wK0ig1rh7Guoay4sudE6ioM4unH9PfDPM9qbB86k/iFWUZ1pqSA0N6s6A10ztVHHwK7gEYp5bM/wpEgzpzTbsvK7RGMZJM2owjRXLCMJe23ZQKV6IzZ5FJ8vwQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2585868C7B; Tue, 22 Apr 2025 09:57:52 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:57:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20250422075751.GA32494@lst.de>
References: <Z-axRObjXYjIHGQC@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-axRObjXYjIHGQC@kspp>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to nvme-6.16.

