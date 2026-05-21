Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE18383329;
	Thu, 21 May 2026 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359595; cv=none; b=ayKHgucZjzHQ3NIngPcL83glZgeFRbhtlsg1P/9Jrd2iyYoPtV/QpDyv9LZkRE2sjOr/b3rPUSRvOG0+94kBF6jb8j9xjjTCuqTcyPHFw0DN5CFD/Nyvbn04wyaFXJg7FuiZ/8PZSJMZmL7hhyn8cNb+oq5y4GOEj1eL8Ln5r38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359595; c=relaxed/simple;
	bh=4MaM1ztAmX1Krx7c0Ys9D3dOLXAsYTR9aeqOgCBvbSc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=czV7memyojV1+KWvVLYCEkeXqsXEgCo/u+YH3jeu3+jjJenMl24dky2Pf478UJixGNChYfrdXAqjLQWbPa3y0xruSQNAbn4e5QR8Ppoq8y7M/3qFep3DlIjw+VLTSJULmibivMWC+rlz50t7Eg5bGltZWoywsAZ4Acl5o6zSvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHkvToox; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHkvToox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779359593; x=1810895593;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4MaM1ztAmX1Krx7c0Ys9D3dOLXAsYTR9aeqOgCBvbSc=;
  b=JHkvTooxD0ZyrUahdijg0qagq6bqJx1yztm7F+Ng2Q+o9OY3w9pof4N1
   3yXXii+RlMssuXu4FhR3BypF5ipMmktORx6drqCFJ3rBwcJD5GeEWi1tE
   zXM6HEA9qmBxQX6O6zU2eVSjf3ksskGr3jns9CrUc0PTpWbLfQSL6vAhl
   ydo0X0enYMeh5NWvNQRqr5GNuvIg7exxNRcEb5D5mzUXkAJujBwXohd3H
   8nK0dv3vxLPq1N3A2d/FEIB3d9JwKJdFElqJungmAQOf64YshI9cFpAFj
   ZCals32pR5U7QOUXOXxevzfGYVutuphO3MDCTbiQk1chTvrIcVPz/EcuZ
   A==;
X-CSE-ConnectionGUID: 3779UNkQQxKtnnFn5H47BA==
X-CSE-MsgGUID: dg5R+1qmSJuXLbDdkl93vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="97702640"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="97702640"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:33:12 -0700
X-CSE-ConnectionGUID: HbTAJfcKSgeDszRUwAeyRg==
X-CSE-MsgGUID: 7f1CkquOSzKR04L5Lx1BoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="240520044"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.98])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:33:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 May 2026 13:33:05 +0300 (EEST)
To: Rosen Penev <rosenp@gmail.com>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] platform/x86/intel/tpmi/plr: allocate die_info with
 plr
In-Reply-To: <20260521014608.1356671-1-rosenp@gmail.com>
Message-ID: <d8ae7a61-c7ef-6b23-7d9d-e5dd35c86dcf@linux.intel.com>
References: <20260521014608.1356671-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 May 2026, Rosen Penev wrote:

> Simplifies allocations slightly.
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: Rebase.
>  drivers/platform/x86/intel/plr_tpmi.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
> index 8faecc311038..66220fadf670 100644
> --- a/drivers/platform/x86/intel/plr_tpmi.c
> +++ b/drivers/platform/x86/intel/plr_tpmi.c
> @@ -58,11 +58,11 @@ struct tpmi_plr_die {
>  
>  struct tpmi_plr {
>  	struct dentry *dbgfs_dir;
> -	struct tpmi_plr_die *die_info;
>  	int num_dies;
>  	struct auxiliary_device *auxdev;
>  	struct notifier_block nb;
>  	struct mutex lock;	/* Protect access to dbgfs_dir */
> +	struct tpmi_plr_die die_info[] __counted_by(num_dies);
>  };
>  
>  static const char * const plr_coarse_reasons[] = {
> @@ -305,7 +305,7 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
>  	if (!num_resources)
>  		return -EINVAL;
>  
> -	plr = devm_kzalloc(&auxdev->dev, sizeof(*plr), GFP_KERNEL);
> +	plr = devm_kzalloc(&auxdev->dev, struct_size(plr, die_info, num_resources), GFP_KERNEL);

Hi,

I'd prefer to have devm_kzalloc_flex() be added before continuing with 
changes like this. Last time I mentioned it, you washed your hands about 
adding it and moved the responsability to linux-hardening folks. (In case 
you didn't know, devm_kzalloc_flex() could be added even by you!)

Alternatively, I might accept a good explanation why that cannot be done 
or is not a good idea to have consistent interface for non-devm vs devm?

>  	if (!plr)
>  		return -ENOMEM;
>  
> @@ -315,13 +315,6 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
>  
>  	intel_plr_register_notifier(&plr->nb);
>  
> -	plr->die_info = devm_kcalloc(&auxdev->dev, num_resources, sizeof(*plr->die_info),
> -				     GFP_KERNEL);
> -	if (!plr->die_info) {
> -		err = -ENOMEM;
> -		goto err_notify;
> -	}
> -
>  	plr->num_dies = num_resources;
>  	plr->dbgfs_dir = debugfs_create_dir("plr", dentry);
>  	plr->auxdev = auxdev;
> @@ -361,7 +354,6 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
>  
>  err:
>  	debugfs_remove_recursive(plr->dbgfs_dir);
> -err_notify:
>  	intel_plr_unregister_notifier(&plr->nb);
>  
>  	return err;
> 

-- 
 i.

