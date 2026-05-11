Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2F438FE4;
	Mon, 11 May 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517099; cv=none; b=G1Sy5CfXY4DM2XANYAeSKUNfuCtwWY1vBckEkBDXePVKIKbDKNiECCWcrQYtTDE6/+Ec9hOkLf0Ubwn9pBbFMPCZU2myFZiy13RnGH9RBg0jc9UObfKBWqR+xT9FEFEpYxPKYI6Ww8Kulczycni0JNqXAaYz6b81T8k6OqtGvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517099; c=relaxed/simple;
	bh=dXKhRv22TYniykRdD7ytCvispTZ99l1PvGtabcu/Zq8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YZou0as9isG5yrFn2UHrdgrfxuzM5uYu6GFQWa8S5+EAnym4nlLuSeYVSn0IgJEzK99OS6VcBm701cqY7nv6s6Q9jfn8JvwzbZJXkjQzaGxlFrE2P6Z95YH1INXJuoF32DA5qUyveh60scaHQ+hxqXZytNeaScO/sypAoXpwAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epHcdC9w; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epHcdC9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778517098; x=1810053098;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dXKhRv22TYniykRdD7ytCvispTZ99l1PvGtabcu/Zq8=;
  b=epHcdC9wGs7iW0cTxICsvWEKB3LMRpbW6T5gS8A/C7XuMfiw6P/c1qlr
   XoLnwEVlq9XCX/LTp9Lj/XEif+ZyKZsKNaQO1qV8b35KluJzcqQkzneXO
   Xlmcy5A9k+fcEA6LcwJjtQ2jqHgPH3FdvoawtcOTeOeprvu2u55ZMNlsH
   uZjtpHYfXt0o0rD5J7GU/ZQkUgcCvxjKAzWbkTqJMFqyDFVOq0YrWshVB
   bqTKDXRMNDAq2TG/phJ2a5FchrsHOIYE3bA30HwcoIbDnZi2bq6I18d0G
   bzKWdqcCgDFqk2vUB0CWDk0Kn1KDbykVF502eiDg/VAFt50Jcd1a66Fzn
   Q==;
X-CSE-ConnectionGUID: l4Ksh/3zRRGTf8ZjmFs0KA==
X-CSE-MsgGUID: vCatAGqgS/OAU5arxcHJkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79434832"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79434832"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:31:38 -0700
X-CSE-ConnectionGUID: JvzXzTTeTuC7Jt5pawPNNQ==
X-CSE-MsgGUID: b/ySphJcR6iglBJZySmDeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="242465123"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:31:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 May 2026 19:31:31 +0300 (EEST)
To: Rosen Penev <rosenp@gmail.com>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:KERNEL HARDENING" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/intel/tpmi/plr: allocate die_info with
 plr
In-Reply-To: <20260430225309.117557-1-rosenp@gmail.com>
Message-ID: <db8119fd-6d40-5df0-68ef-5579290c5bb9@linux.intel.com>
References: <20260430225309.117557-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Apr 2026, Rosen Penev wrote:

> Simplifies allocations slightly.
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/platform/x86/intel/plr_tpmi.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
> index 05727169f49c..2fd27e80bc1f 100644
> --- a/drivers/platform/x86/intel/plr_tpmi.c
> +++ b/drivers/platform/x86/intel/plr_tpmi.c
> @@ -57,9 +57,9 @@ struct tpmi_plr_die {
>  
>  struct tpmi_plr {
>  	struct dentry *dbgfs_dir;
> -	struct tpmi_plr_die *die_info;
>  	int num_dies;
>  	struct auxiliary_device *auxdev;
> +	struct tpmi_plr_die die_info[] __counted_by(num_dies);
>  };
>  
>  static const char * const plr_coarse_reasons[] = {
> @@ -278,15 +278,10 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
>  	if (!num_resources)
>  		return -EINVAL;
>  
> -	plr = devm_kzalloc(&auxdev->dev, sizeof(*plr), GFP_KERNEL);
> +	plr = devm_kzalloc(&auxdev->dev, struct_size(plr, die_info, num_resources), GFP_KERNEL);

Is there some particular reason why we don't have devm_kzalloc_flex() 
other than that nobody has yet bothered to added one.

One of the most annoying thing with the various alloc APIs is that devm_* 
variants seem to never keep up with them. It would be nice if there would 
be some generic solution that when somebody decides a new alloc api func, 
the corresponding devm counterpart would be auto-generated for it.

-- 
 i.

