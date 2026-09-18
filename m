Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F3518122;
	Fri, 18 Sep 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755992; cv=none; b=kVi/2ZlM+u5v5AOhTQqAKfYjxobhRGRK7VdD7xqFvXnBbdQSs1DkMi+AlOwQnUlQ+4PqbN5LW8b9q1WH/wCz/wDx0BEV6lAWaOdj6aScwbTXwNiksiKuNNxGs5yuUJ/2+SqmUX1Mu4gnVi0mcyp1nqrdFM6mFOVGjTvoAeYBIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755992; c=relaxed/simple;
	bh=KvWVlDDQLHDlVqQRSdq4Wiwl9sg1P7RuwLBQ92OMGxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lHrxJXOJC5LrMmboidczedHzPCQWYr/a70cibL9CgsAaAjic4/hIgtn5W7imiI0DnokH1LoHJ86dAnsi9hRoMOvlN0Z4oEGHm+XETL239epLJ+Y+35acez3YsHLLq5ofSVcId7Ad0IlwfQv0B1BqB4tcuMtYMZj+Nprqef7zX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J27rrTs3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J27rrTs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789755991; x=1821291991;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=KvWVlDDQLHDlVqQRSdq4Wiwl9sg1P7RuwLBQ92OMGxc=;
  b=J27rrTs3yI9whcFvHgbBGKPBAS6V4h2IbPeeMo20OSjG/ti5Or8PPiAd
   SyKUERB5ztZKtsCPUu0Mle59lgStzCQjY1VidcKPU+stjCXd5Oto2lQ94
   AgguKFgqYlFb5eyUSKLttsIv+vKstJICfYMv23r3L9M2wYKUoGLOSarlv
   f+CKwFMnTHsCKsTW8d4EeJu8dy7eNB0ePDWGu7xaAXtYYlaW8KBp8kyTr
   kkqgPyWWYbbTsS+fxGG6QQeEzSnvt/j4Z7XdCcEATTKvdH8PMyaPpYgl0
   vDKcWnqv0vrOromZkp+x6ljC4QewOnevEb/n+NOgDG2IfLkqsmk8pderG
   A==;
X-CSE-ConnectionGUID: RK8FseiHSoKvQ/veLJ5r8g==
X-CSE-MsgGUID: 3fSn5twnRr+zMD28HreW+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="77847114"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="77847114"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 11:26:30 -0700
X-CSE-ConnectionGUID: L3IfZmW3QKG6LB+9Fs5QHw==
X-CSE-MsgGUID: Y/Z3mxV8Q1y3OzygLcX1XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="297975623"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 11:26:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Hans de Goede <hansg@kernel.org>, Kees Cook <kees@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Thorsten Blum <blum@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260907084319.351688-4-blum@kernel.org>
References: <20260907084319.351688-4-blum@kernel.org>
Subject: Re: [PATCH v2 0/2] Add and use supported/unsupported string helper
Message-Id: <178975598103.29716.3775645127941823683.b4-ty@b4>
Date: Fri, 18 Sep 2026 21:26:21 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 07 Sep 2026 10:43:19 +0200, Thorsten Blum wrote:

> Add a shared str_supported_unsupported() helper and use it to replace
> thinkpad_acpi's custom implementation.
> 
> Changes in v2:
> - Add and use str_supported_unsupported() as suggested by Ilpo
> - v1: https://lore.kernel.org/r/20260806131549.235170-2-thorsten.blum@linux.dev/
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/2] lib/string_choices: Add str_supported_unsupported() helper
      commit: 5383cf280ef4f00b15f1d9e2a2886d0d02c0118b
[2/2] platform/x86: thinkpad_acpi: Use str_supported_unsupported() helper
      commit: 53196ef3b1ef26dd4c354c501b6a4bd6fbe2bbf7

--
 i.

