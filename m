Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708C41B36E;
	Tue, 31 Mar 2026 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971895; cv=none; b=Jqo1zIgvfsW+WMoOYrnND8BQPxDApMSwYUWHqDal2L73ccD31Zhg2eS9El3yL05wqumH6/QcvAlLv0dMDLv8kv1kEkgNi9cbbJBX5CrtN2triZQD0NzCiBO8DfdcaRPeO9TdWlU2wn9o8SaI+8rA2fk4V7cgDr22v0tpBw+hbrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971895; c=relaxed/simple;
	bh=7OP6PZ5N/qSaa2KVWc+HzMDatsxeHVYY524qQB1CJL8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nIX8PWGG5R1jB9KjRcwsLbcMAvo6GxqsCe76oL5ZHJxEOihQDeWFQTARV4gz8lYMFH76W8y5mJadF5KXqghl88gTGi0xD0Tfs26ugLQf7wqRnAfsjOeoUUIBd/kpTk0OD9x9c/PMeKGvorVqMtjmwDUA7CgXo1A/9qMWiUn9ibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHph9Ec5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHph9Ec5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774971894; x=1806507894;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7OP6PZ5N/qSaa2KVWc+HzMDatsxeHVYY524qQB1CJL8=;
  b=NHph9Ec5hJvJAsUAUcduVPKQ/4tAjo25mBYl2MopVYnwR9GBIpoLE2Qc
   IGq5gFmQFxB6YuUVOFg8e4lvEWViPb/T7KXlddeqw8KShOIGjvKV+So8i
   4ifidswD5iEJPObeD8IcNfAiPXfR2yci9vg7SojGStBuPC8dz2azE3OvL
   ezOEc3NSmOgEh9WWeu8q/2UFrFSOjhDeHdHJ8haCYmICMJGuyceM/F7HP
   KTejPPOzL37UL22CU5sB73vsI+1SuIaGtClBX4xdnznMrKkWYvbXyYm7M
   cXJx5jbGL8tso9fg1RtTKt1LLvtw3LsqQg12xScWM1BNRoVV/c/lifqMJ
   w==;
X-CSE-ConnectionGUID: Xyw/uD+ETNyAFta7jaWXnA==
X-CSE-MsgGUID: J+v+PtzsSrq/QeRfL1um7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="93377785"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="93377785"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:44:53 -0700
X-CSE-ConnectionGUID: peHiC8o6SCujpcjFpQZ5lw==
X-CSE-MsgGUID: YidqDsHoTLejldodjGoafg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="231220119"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:44:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 31 Mar 2026 18:44:44 +0300 (EEST)
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc: platform-driver-x86@vger.kernel.org, Rosen Penev <rosenp@gmail.com>, 
    Kenneth Chan <kenneth.t.chan@gmail.com>, Hans de Goede <hansg@kernel.org>, 
    Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCHv2] platform/x86: panasonic-laptop: simplify allocation
 of sinf
In-Reply-To: <ee68ff4e-27b5-4373-86dc-3b7a5ad7f7b5@embeddedor.com>
Message-ID: <0e92b09e-3fe3-16bd-d6c2-bb7e0dcf2094@linux.intel.com>
References: <20260326024525.63258-1-rosenp@gmail.com> <177496937487.10314.4187390108669622962.b4-ty@linux.intel.com> <ee68ff4e-27b5-4373-86dc-3b7a5ad7f7b5@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1838150724-1774971884=:989"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1838150724-1774971884=:989
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 31 Mar 2026, Gustavo A. R. Silva wrote:

>=20
>=20
> On 3/31/26 09:02, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 25 Mar 2026 19:45:25 -0700, Rosen Penev wrote:
> >=20
> > > Change to a flexible array member to allocate once instead of twice.
> > >=20
> > > Allows using __counted_by for extra runtime analysis. Move the counti=
ng
> > > variable assignment to right after allocation as required by
> > > __counted_by.
>=20
> This is misinformation and should be phrased differently[1]

Okay. I'll drop the patch for now.

--
 i.

>=20
> -Gustavo
>=20
> [1]
> https://lore.kernel.org/linux-hardening/37378f49-437f-438b-ad6c-d60480feb=
306@embeddedor.com/
>=20
> > >=20
> > > Remove + 1 to allocation. It's already done in the previous line.
> > >=20
> > > [...]
> >=20
> >=20
> > Thank you for your contribution, it has been applied to my local
> > review-ilpo-next branch. Note it will show up in the public
> > platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> > local branch there, which might take a while.
> >=20
> > The list of commits applied:
> > [1/1] platform/x86: panasonic-laptop: simplify allocation of sinf
> >        commit: e75869527c720c4ed1458cfbe25e92186950e43a
> >=20
> > --
> >   i.
> >=20
> >=20
>=20
--8323328-1838150724-1774971884=:989--
