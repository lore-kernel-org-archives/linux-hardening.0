Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0336165D;
	Fri, 20 Mar 2026 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001622; cv=none; b=D9NpEsNFr9wfK1xhS9mz2QlZAkyMQoqKs+mF+8otrSBy16ScBOYfcbGxfwcQBOsONYRA8YWHnCXzVuINdhqCL/ihusPxNe/4M7aZGscw9KffI5oGnxbFCBI4o9wbokiDH+QcWBg/pJCM1KIfGZxyQmEe7IE9ZoxSGPft25RggVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001622; c=relaxed/simple;
	bh=iESlretG5HIAa3y+PLiVDqAohM7DlrdQBntZV1byCro=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCCe1VDfd8Qws4hH/C9xfndqq9KFIzWQmd2HjRewaGfMeKKjUPizKGMZuCz01VLjK7v8J0f0Oh9DThrYnfuYW/NKoBLaC4xW1KkpP0RnTVFnaeqX4cKzgQ7mi2T8i2yq1qBSekzzc19BSnGzB7pYkZIU1ZUnLX//D+rXGg83g6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fcdfX36RwzJ468L;
	Fri, 20 Mar 2026 18:12:36 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 4739A4056A;
	Fri, 20 Mar 2026 18:13:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 10:13:36 +0000
Date: Fri, 20 Mar 2026 10:13:35 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>
CC: <rafael@kernel.org>, Shiju Jose <shiju.jose@huawei.com>, Tony Luck
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hanjun Guo
	<guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Shuai
 Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Will
 Deacon" <will@kernel.org>, Huang Yiwei <quic_hyiwei@quicinc.com>, Dave Jiang
	<dave.jiang@intel.com>, Nathan Chancellor <nathan@kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] acpi/apei: Add NVIDIA GHES vendor CPER record
 handler
Message-ID: <20260320101335.00004026@huawei.com>
In-Reply-To: <20260319111315.87624-3-kaihengf@nvidia.com>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
	<20260319111315.87624-3-kaihengf@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 19 Mar 2026 19:13:09 +0800
Kai-Heng Feng <kaihengf@nvidia.com> wrote:

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
> 
> [0] https://github.com/openbmc/libcper/commit/683e055061ce
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
Only significant thing is around use of dev_err_probe().

I'm surprised that didn't give you error messages in the log even on success.

With that fixed (other stuff is all up to you).
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


>  apei-y := apei-base.o hest.o erst.o bert.o
> diff --git a/drivers/acpi/apei/nvidia-ghes.c b/drivers/acpi/apei/nvidia-ghes.c
> new file mode 100644
> index 000000000000..aa2e3a387b49
> --- /dev/null
> +++ b/drivers/acpi/apei/nvidia-ghes.c

> +static void nvidia_ghes_print_error(struct device *dev,
> +				    const struct cper_sec_nvidia *nvidia_err,
> +				    size_t error_data_length, bool fatal)
> +{
> +	const char *level = fatal ? KERN_ERR : KERN_INFO;
> +	size_t min_size;
> +	int i;
...


> +	 * Validate that all registers fit within error_data_length.
> +	 * Each register pair is two little-endian u64s.
> +	 */
> +	min_size = struct_size(nvidia_err, regs, nvidia_err->number_regs);
> +	if (error_data_length < min_size) {
> +		dev_err(dev, "Invalid number_regs %u (section size %zu, need %zu)\n",
> +			nvidia_err->number_regs, error_data_length, min_size);
> +		return;
> +	}
> +
> +	for (i = 0; i < nvidia_err->number_regs; i++)

Trivial but I'd take advantage of it now being acceptable (in general) to do
	for (int i = 0; i < ....)

> +		dev_printk(level, dev, "register[%d]: address=0x%016llx value=0x%016llx\n",
> +			   i, le64_to_cpu(nvidia_err->regs[i].addr),
> +			   le64_to_cpu(nvidia_err->regs[i].val));
> +}

> +static int nvidia_ghes_probe(struct platform_device *pdev)
> +{
> +	struct nvidia_ghes_private *priv;
> +
> +	priv = devm_kmalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	*priv = (struct nvidia_ghes_private) {
> +		.nb.notifier_call = nvidia_ghes_notify,
> +		.dev = &pdev->dev,
> +	};
> +
> +	return dev_err_probe(&pdev->dev,
> +			     devm_ghes_register_vendor_record_notifier(&pdev->dev, &priv->nb),
That's too not great for readability and dev_err_probe() should only be called on errors
I'm fairly sure it doesn't have special handling for 0 so will call dev_err() or dev_warn()
and print some stuff before saying 'no error'.

	int ret;
	...

	ret = devm_ghes_register_vendor_record_notifier(&pdev->dev, &priv->nb);
	if (ret)
		return dev_err_probe(&pdev->dev,
				      "Failed to register NVIDIA GHES vendor record notifier\n");

	return 0;



> +			     "Failed to register NVIDIA GHES vendor record notifier\n");
> +}
> +
> +static const struct acpi_device_id nvidia_ghes_acpi_match[] = {
> +	{ "NVDA2012" },

London Olympics :)

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, nvidia_ghes_acpi_match);
> +
> +static struct platform_driver nvidia_ghes_driver = {
> +	.driver = {
> +		.name		= "nvidia-ghes",
> +		.acpi_match_table = nvidia_ghes_acpi_match,
> +	},
> +	.probe	= nvidia_ghes_probe,

I'd just not attempt to align the = 
static struct platform_driver nvidia_ghes_driver = {
	.driver = {
		.name = "nvidia-ghes",
		.acpi_match_table = nvidia_ghes_acpi_match,
	},
	.probe = nvidia_ghes_probe,

There aren't enough of them to make it much of a readability improvement
and doing this often results in unnecessary churn as a driver evolves.
Also it's already broken!

> +};
> +module_platform_driver(nvidia_ghes_driver);
> +
> +MODULE_AUTHOR("Kai-Heng Feng <kaihengf@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA GHES vendor CPER record handler");
> +MODULE_LICENSE("GPL");

