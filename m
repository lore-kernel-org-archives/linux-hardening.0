Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348633D3A5
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 22:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79514C433C7;
	Tue,  3 Oct 2023 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696372212;
	bh=rn0rOWjIDB6/7GQlidfe1eVKXGJ9GKrMWvhbYPzPdB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fSuMCjd+ZcFrlc5XBSO+QtpHqHKHN2WZ9KYYXlX6T26/P5latDGOvcHwk+JpHUlch
	 AtkdRS8Pvc+Scw+sxVwXj/iO73M+lzfmRAihujmQMFlhIZyEzKnCBKJNbe5gdwzbfi
	 1ipZIC7jpBVseebSecq3X4VRHO8B79i6Il9DtJgf6hnrNTJZL7VTTyIM7zONmObPoJ
	 w2Vsf508a4WgG7lTlVNBDbfdJPa8js799mvyx6MQEcvPcvF3v6cnfHRqkOy+jEOzKW
	 gVVV1lOFTN7IgCYsgtypv0Fv8j5/TCs2cuhTvslB4FPSZiVOdxMwCitbfwkioeigRs
	 8Wx082pkQyNFw==
Date: Tue, 3 Oct 2023 17:30:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] PCI/P2PDMA: Fix potential undefined behavior
 bug in struct pci_p2pdma_pagemap
Message-ID: <20231003223010.GA692794@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRsUL/hATNruwtla@work>

On Mon, Oct 02, 2023 at 09:04:15PM +0200, Gustavo A. R. Silva wrote:
> `struct dev_pagemap` is a flexible structure, which means that it
> contains a flexible-array member at the bottom. This could potentially
> lead to an overwrite of the objects following `pgmap` in `struct
> pci_p2pdma_pagemap`, when `nr_range > 1`. This is currently not the
> case (notice that `nr_range` is hardcoded to `1`), however as commit
> b7b3c01b1915 ("mm/memremap_pages: support multiple ranges per invocation")
> mentions in the subject line, this code can `support multiple
> ranges per invocation`. So, we'd better prevent any problems that may
> arise in the future.
> 
> Fix this by placing the declaration of object `pgmap` at the end of
> `struct pci_p2pdma_pagemap`.
> 
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to pci/p2pdma for v6.7.  Since it's not a current problem, I
assume there's no reason to apply it for v6.6 (or tag it for stable);
let me know if otherwise.

> ---
> Changes in v2:
>  - Remove `Fixes:` tags. (Logan Gunthorpe)
>  - Update changelog text. Make it clear that `nr_range` is hardcoded to `1`
>    (Logan Gunthorpe)
>  - Update subject.
>  - Add Logan's RB.
> 
> v1:
>  Link: https://lore.kernel.org/linux-hardening/ZRnf6wVOu0IJQ2Ok@work/
> 
>  drivers/pci/p2pdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index fa7370f9561a..ab34d3d36a64 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -28,9 +28,9 @@ struct pci_p2pdma {
>  };
>  
>  struct pci_p2pdma_pagemap {
> -	struct dev_pagemap pgmap;
>  	struct pci_dev *provider;
>  	u64 bus_offset;
> +	struct dev_pagemap pgmap;
>  };
>  
>  static struct pci_p2pdma_pagemap *to_p2p_pgmap(struct dev_pagemap *pgmap)
> -- 
> 2.34.1
> 
