Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E219923815A;
	Mon,  7 Apr 2025 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023021; cv=none; b=ukkd1QRuUIbPRQeEpgMVsPrvqqffILwa+5qg/USwQTt2RrB1ft02qtVFm5oLzxQiFFFX3xpuAZOcxn+9y+FkUeEsBoVLYmcjs3X902SWL7Z6GnfX8AqFZ8KFk6euD9pZSI7q2K8mpqYv3Md1ZaYH0EFsW3VKHz8NNgsQXdTV2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023021; c=relaxed/simple;
	bh=ox9GRWY6nvbeZArMaOwT3nxrycWzZcSJyn51bD8Zrh4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qvdcu7TFNcHegFaNIoWDVFxv92SIIGwZnj5L0X2Xow3+NJ5y9DLzVkccCU8A8oOLBl4rOeO/emTROJPtALxFodDDEHXQiePGVRfPyWCfdyTwznWfrV06p6t56T3OGd2BDTvcBSnLc8Fouq7+s5E5s61z+aXTCyi0XV1mzOwPUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIFd1DHF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIFd1DHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744023020; x=1775559020;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ox9GRWY6nvbeZArMaOwT3nxrycWzZcSJyn51bD8Zrh4=;
  b=HIFd1DHF0LBBsGHBm1sQzGlewoHk1bqN+loJsrcj1LyXpB41qo4eaWFw
   xhYAT4kgz5toVkmZBdYTkKMfTuukcE5L4WyCqy93K2L1YtsV7R3vF4Sef
   gdbkKvCrN1Z3cNJT+YU+Jd0IVKWGqK/cJSFI7ZQY6+dhrXejCmftf2Y1W
   1oh6b5G5GWK7Xu1xDQgbgtyZU1GYoYyNWpCkV41/ZpN/AhLeyvciMjsj9
   aT5wK76cHgv7FY90ZwHtQT6dOf0FBxCvOIaVjdQu7fqCYmQ74i4t7KLjO
   MMJLdefEgz/+JxcTifIPGa778/oxtsDQm9niWDacO8Qcaq8RfP9acTBcB
   A==;
X-CSE-ConnectionGUID: 8UfJmuWbQKiFVg/n3/bIFg==
X-CSE-MsgGUID: dF2p5X5MSmGr9TUopMWR0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="44545325"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="44545325"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 03:50:19 -0700
X-CSE-ConnectionGUID: f1nTuujKQLm3g9jP4N2ZZg==
X-CSE-MsgGUID: REmFyb67QcqdX9ffKAQDcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="133130367"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 03:50:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mattia Dongili <malattia@linux.it>, Hans de Goede <hdegoede@redhat.com>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <Z-WlhL_tAP11M02G@kspp>
References: <Z-WlhL_tAP11M02G@kspp>
Subject: Re: [PATCH][next] platform/x86: Avoid
 -Wflex-array-member-not-at-end warning
Message-Id: <174402301172.2251.17175317523714748552.b4-ty@linux.intel.com>
Date: Mon, 07 Apr 2025 13:50:11 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 27 Mar 2025 13:22:44 -0600, Gustavo A. R. Silva wrote:

> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct acpi_resource_irq` is a flexible structure --a structure
> that contains a flexible-array member.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: Avoid -Wflex-array-member-not-at-end warning
      commit: a62372b6c9284ed42c68a0d8b3148f2dde61b4e4

--
 i.

