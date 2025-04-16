Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DF1E5B7D;
	Wed, 16 Apr 2025 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744782242; cv=none; b=roVB4xqJ+qBdZ8WP/Y3h7exPvtP9d0MXcOpemVwM7Zo0IfJ2a7ty+iLNrVWf9sHSJljioxDJ6mlcJiE5x1UAiDazvi0/eyQnz28BwYAlp4rSuEYbNsq0H+UJH/XU7rExLMD8HPK3qhWMlWLTMh0KspIXLVHum9edY5hMz0OsaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744782242; c=relaxed/simple;
	bh=m+KgC2jJH/6Jo/NQ+qRB4Um+A/HbSoN2qQkFubW8hFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWKRdriETpSBGXkwQYjqy3gVXMPuyT61FcCRfHZKV37WbNFznq9YySzPEmczYE/B2Rt90eu6hvoZo13a9NZw/WRl8pbPrwBbpfhCw5R6wcCeduHUjH4H/vhSjvH+Jb5nA52buWGdClObR4RY9nSclxX7d7RUYEDDRB2MaZumexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9BE4168BFE; Wed, 16 Apr 2025 07:43:52 +0200 (CEST)
Date: Wed, 16 Apr 2025 07:43:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20250416054352.GA25107@lst.de>
References: <Z-axRObjXYjIHGQC@kspp> <a1c6fd4e-69b4-4698-bc5d-ef02cf7312e4@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c6fd4e-69b4-4698-bc5d-ef02cf7312e4@embeddedor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 15, 2025 at 06:20:03PM -0600, Gustavo A. R. Silva wrote:
> Hi all,
>
> Friendly ping: who can take this patch, please? :)

This will go into the 6.16 nvme branch as soon as it opens.

