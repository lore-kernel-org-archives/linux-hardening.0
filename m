Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056C3C3455;
	Fri, 20 Mar 2026 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018376; cv=none; b=AwCnNFqiaQGw00CXu5mWIMarGUGMzNGfBQE+TtAqyiQwx/z5RjHAN4r0ozPhUvc143rDXgsb4avfP3hoSViRD0Rpkomh7yUPIJLKWf5fjl9PT63DBgGqxeldEeR+Z5/ftJyt8CnrfJKTOVCl6ybVaD5CEHRk5mtk4fszuvwDTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018376; c=relaxed/simple;
	bh=7Yfr9ZLW+HBZAx47T0vzj7K4sheH1yW1VF7eS9bGzvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdwvvephyWKtJM9IQZmZXltOXjZ6eKX1q6UpJ0njzBPpXPudyb21LsDNg1h23Ld0TCFGQB4p2yHkh8CvDp3FvEZ2EmyFKO/K1gfrmLuESEhCW945ZhO9rtSANvJ0CQm2jCtQodZ5UcYHdetF/OFet5XUFX7Z+7IvdcxkYPuySx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP+HlV6W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP+HlV6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6415C4CEF7;
	Fri, 20 Mar 2026 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774018375;
	bh=7Yfr9ZLW+HBZAx47T0vzj7K4sheH1yW1VF7eS9bGzvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BP+HlV6W7x9CTXULFtST2hBBgnseSIDwSWRSYPAc28gDh0yOb6x849d0MDx6Lsklt
	 gbD3tTzUaIc8ay4BsgZrXdn5Xu4gmxkyDpvL7p3fRt5RUX+QJt/f2XzHzbIzf6oSLi
	 WidGREqiUdF1FPhcuKL7gMwWjjohBe1sIM4+C1PQnRo1WRgEsgIhCjfse/Qxi+zAYb
	 FyIidejjyjqm+iyit6h9tYt8AbOrZ3qTgx9NWe74iMcgPftd99w34sKB1MN5gdCOWZ
	 TN76sBRwraVtpVBRnVSvB52YPYUc/2yLjQ9g9d47tboWNnju7lZb6D6xbI9XaJUjzT
	 p8ek69XAuswhg==
Date: Fri, 20 Mar 2026 09:52:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: rafael@kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Will Deacon <will@kernel.org>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] acpi/apei: Add NVIDIA GHES vendor CPER record
 handler
Message-ID: <20260320145254.GB699200@bhelgaas>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
 <20260319111315.87624-3-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319111315.87624-3-kaihengf@nvidia.com>

On Thu, Mar 19, 2026 at 07:13:09PM +0800, Kai-Heng Feng wrote:
> Add support for decoding NVIDIA-specific CPER sections delivered via
> the APEI GHES vendor record notifier chain. NVIDIA hardware generates
> vendor-specific CPER sections containing error signatures and diagnostic
> register dumps. This implementation registers a notifier_block with the
> GHES vendor record notifier and decodes these sections, printing error
> details via dev_info().
> 
> The driver binds to ACPI device NVDA2012, present on NVIDIA server
> platforms. The NVIDIA CPER section contains a fixed header with error
> metadata (signature, error type, severity, socket) followed by
> variable-length register address-value pairs for hardware diagnostics.
> 
> This work is based on libcper [0].
> 
> Example output:
> nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
> nvidia-ghes NVDA2012:00: signature: CMET-INFO
> nvidia-ghes NVDA2012:00: error_type: 0
> nvidia-ghes NVDA2012:00: error_instance: 0
> nvidia-ghes NVDA2012:00: severity: 3
> nvidia-ghes NVDA2012:00: socket: 0
> nvidia-ghes NVDA2012:00: number_regs: 32
> nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
> nvidia-ghes NVDA2012:00: register[0]: address=0x8000000100000000 value=0x0000000100000000

Is there a convenient way to connect NVDA2012:00 with the actual device?  I
assume this is typically a PCIe device?  How would we relate this with PCIe
errors?

Consider a cover letter.  Some of these comments apply to the series.

Wrap commit logs to fit in 75 columns.  When indented by "git log", all of
these overflow 80 columns by just a few characters.

Possibly reorder so the acpi/apei patches are together.  I don't think the
NVIDIA record handler depends on the PCI patch.

Typical subject line style in drivers/acpi/apei appears to be:

  ACPI: APEI: GHES: Add ...

> +config ACPI_APEI_NVIDIA_GHES
> +	tristate "NVIDIA GHES vendor record handler"
> +	depends on ACPI_APEI_GHES

Maybe s/ACPI_APEI_NVIDIA_GHES/ACPI_APEI_GHES_NVIDIA/ since there will
likely be more, and they'll sort nicely if the vendor is at the end.

> +	help
> +	  Support for decoding NVIDIA-specific CPER sections delivered via
> +	  the APEI GHES vendor record notifier chain. Registers a handler
> +	  for the NVIDIA section GUID and logs error signatures, severity,
> +	  socket, and diagnostic register address-value pairs.
> +
> +	  Enable on NVIDIA server platforms (e.g. DGX, HGX) that expose
> +	  ACPI device NVDA2012 in their firmware tables.

Wrap to fit in 80 columns like the rest of this file.

> +++ b/drivers/acpi/apei/nvidia-ghes.c

Maybe rename to "ghes-nvidia.c" so future decoders for other vendors are
grouped?
