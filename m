Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12C487AE;
	Thu, 22 Aug 2024 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348512; cv=none; b=ZxR95+q2kWgbmtdoO6Q4i7gFcajdPNMFl2j1FuKJAP0yq5eb9U5JQ+kZ5Ukr60+8rGcdFJD/yWZn9pyGgPJIQrc4/BWDNvHEkf/YdHaD39X939vMblDbMh5xMTCm33sQufnj/yEb7E0V4a2tkjrSd+gSCJid2+IiKrJ5Ry96z8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348512; c=relaxed/simple;
	bh=EIA1hEYwm1C2TI9GOWGiHROnOXNDw/yWFqOCejDP7oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQFT0RRuc3XPuqrZjNVm8CNcF2iCjQ5oxjFc8ZA/aYpWDMt34UjIJmSGtTWCt3I8E+gbqfB3QVhbJgcgtarzBZxeF6spBzb81uFFIwCTUhRw+1Vn8JmLga5MvRkln5AjABGj5ayMp1vNt1UbsdZq17Ea/6l2ogn9XhfTKXGfI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr6enR+3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr6enR+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DECC32782;
	Thu, 22 Aug 2024 17:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724348511;
	bh=EIA1hEYwm1C2TI9GOWGiHROnOXNDw/yWFqOCejDP7oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gr6enR+36v6pPq8NzbStvk6GTD120FWyjr6SQHOSZ7oQZpGhHbE+1VFa7NmXzNFnV
	 qi9pD51GM1eorajAlFle0jVSHC7W6LbGVrGiREVBiuNEiHH3B3qNcmrRVlqKJFaMQV
	 p+i9fSRcqakGYyoDrlBKXgaSoNXToyXX3zswYTJ20xS6GPs5aBC6JREBgC7bYxuKty
	 samd23N8OLvgX9JLDVN5PkLwpLwejSwKlmXBzsTjJMNECaEERrZ62oEo0ixmayO4bF
	 15Btlg/GzTisTXtSygtdIZjkZssPtoTcuZ/ZMqLpfh/QuoIHPe63hDWTmkKR9w5q7e
	 RFUJdoo4HNANg==
Date: Thu, 22 Aug 2024 10:41:50 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xen/pci: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <202408221040.2961A81@keescook>
References: <ZsU58MvoYEEqBHZl@elsanto>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsU58MvoYEEqBHZl@elsanto>

On Tue, Aug 20, 2024 at 06:50:56PM -0600, Gustavo A. R. Silva wrote:
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with this, fix the following warning:
> 
> drivers/xen/pci.c:48:55: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/xen/pci.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
> index 72d4e3f193af..a2facd8f7e51 100644
> --- a/drivers/xen/pci.c
> +++ b/drivers/xen/pci.c
> @@ -44,15 +44,11 @@ static int xen_add_device(struct device *dev)
>  	}
>  #endif
>  	if (pci_seg_supported) {
> -		struct {
> -			struct physdev_pci_device_add add;
> -			uint32_t pxm;
> -		} add_ext = {
> -			.add.seg = pci_domain_nr(pci_dev->bus),
> -			.add.bus = pci_dev->bus->number,
> -			.add.devfn = pci_dev->devfn
> -		};
> -		struct physdev_pci_device_add *add = &add_ext.add;
> +		DEFINE_RAW_FLEX(struct physdev_pci_device_add, add, optarr, 1);
> +
> +		add->seg = pci_domain_nr(pci_dev->bus);
> +		add->bus = pci_dev->bus->number;
> +		add->devfn = pci_dev->devfn;
>  
>  #ifdef CONFIG_ACPI
>  		acpi_handle handle;

Looks correct to me!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
