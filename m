Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9D1CF87
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC8E8;
	Mon, 16 Oct 2023 05:42:37 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="7079914"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7079914"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929336265"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="929336265"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:42:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andy@kernel.org>)
	id 1qsMvU-00000005zXU-35Id;
	Mon, 16 Oct 2023 15:42:28 +0300
Date: Mon, 16 Oct 2023 15:42:28 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Kartik <kkartik@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, keescook@chromium.org,
	akpm@linux-foundation.org, arnd@arndb.de, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, pshete@nvidia.com, petlozup@nvidia.com,
	frank.li@vivo.com, robh@kernel.org, stefank@nvidia.com,
	pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v6 7/8] soc/tegra: fuse: Add ACPI support for Tegra194
 and Tegra234
Message-ID: <ZS0vtOwDVwSMErK4@smile.fi.intel.com>
References: <20231016101436.7146-1-kkartik@nvidia.com>
 <20231016101436.7146-8-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016101436.7146-8-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 03:44:35PM +0530, Kartik wrote:
> Add ACPI support for Tegra194 & Tegra243 SoC's. This requires
> following modifications to the probe when ACPI boot is used:
>  - Initialize soc data.
>  - Add nvmem lookups.
>  - Register soc device.
>  - use devm_clk_get_optional() instead of devm_clk_get() to get
>    fuse->clk, as fuse clocks are not required when using ACPI boot.
> 
> Also, drop '__init' keyword for tegra_soc_device_register() as this is also
> used by tegra_fuse_probe() and use dev_err_probe() wherever applicable.

...

> +static const struct acpi_device_id __maybe_unused tegra_fuse_acpi_match[] = {

Drop __maybe_unused along with ACPI_PTR(), they are more confusing than helpful.

> +	{ "NVDA200F" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, tegra_fuse_acpi_match);
> +
>  static struct platform_driver tegra_fuse_driver = {
>  	.driver = {
>  		.name = "tegra-fuse",
>  		.of_match_table = tegra_fuse_match,
> +		.acpi_match_table = ACPI_PTR(tegra_fuse_acpi_match),
>  		.pm = &tegra_fuse_pm,
>  		.suppress_bind_attrs = true,
>  	},

-- 
With Best Regards,
Andy Shevchenko


