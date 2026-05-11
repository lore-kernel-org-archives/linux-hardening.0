Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DA3D668F;
	Mon, 11 May 2026 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521998; cv=none; b=PidYDFTzJgRuzER3tle7A6ROE3bM3FSByFVYDr2YfTvrTfhEzmzw4jsGmAFNOtvTsXzOFEm7QaR8KT/KxGdfZpmZcx+ofSfn0evPZjS0Sbq8CJduhJTTYgCSDKSQBzHQCgk0xUd3Mws4O+FQwsDd6/FRNI99uyg3MDW5Qtsfs/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521998; c=relaxed/simple;
	bh=3QodnBCUa9xlCndM4+Du9LVU9OPtBp5ZRACmS7Gc1Y4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r1VXU03zp34A6g0Kmx2H34wJpdW1Ysz3tnHIL/Lqxj2rbOeR364ZVAANBFkojg2rj6SmDg6xStGLb1cnncEcQ1q05qV2VCQhGyEZvXPS4fErCeOGJYPgmfwzvUQP4w/7c1EYsvoUcyG6WAHJ6pnVFgdWJjJ+udK7UdFIHbe8oSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APCOcG/b; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APCOcG/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521996; x=1810057996;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=3QodnBCUa9xlCndM4+Du9LVU9OPtBp5ZRACmS7Gc1Y4=;
  b=APCOcG/bCQHdfzmf43KZJpBONCOa+P1z8MBitYu82OD8QKW9ZHsh94ht
   xVFPgHKrvxzgnHwgqfVGB3KUiFZ/IEy7BfDV4Hdv9WIyE7m3U8YoyHnCT
   RED823a4MxwEhB4x5TGTEAjc/CDZz0wZuNBL0Q7o49j4kVcrJm2NmhFOs
   jvt4cl0oQHJbWmCm4z9sQB0K/ezcSQnvj8m0Dy1CwPZVw3P+eSCRa1ZR8
   YiWVx6Z/CnePTlybEQJQPJNwqN3tXztSfpBCQetADpg5HNV1gtfZgM4LD
   XjC/W7FOn4m1PdX0mPTNRSgObFpvkgnEpg4YDoK8dDiId6zsbb+ClwOTN
   Q==;
X-CSE-ConnectionGUID: Eq8+IYAbQs+uAlqrEm1E9Q==
X-CSE-MsgGUID: v/JRIg/zSIuVfJInLVP+kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83033371"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83033371"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:53:14 -0700
X-CSE-ConnectionGUID: 6kcEojnoT2GIOva9dVpv9A==
X-CSE-MsgGUID: AXOOovO2Tx6fh/JDSRVtww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="234857697"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.28])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:53:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Kenneth Chan <kenneth.t.chan@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260430221555.83351-1-rosenp@gmail.com>
References: <20260430221555.83351-1-rosenp@gmail.com>
Subject: Re: [PATCH] platform/x86: panasonic-laptop: simplify allocation of
 sinf
Message-Id: <177852198558.27853.167418180738728210.b4-ty@linux.intel.com>
Date: Mon, 11 May 2026 20:53:05 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 30 Apr 2026 15:15:55 -0700, Rosen Penev wrote:

> Change to a flexible array member to allocate once instead of twice.
> 
> Use __counted_by for extra runtime analysis. Move the counting
> variable assignment to right after allocation as done by
> kzalloc_flex for GCC 15 and above.
> 
> Remove + 1 to allocation. It's already done in the previous line.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: panasonic-laptop: simplify allocation of sinf
      commit: a3d0dbd18ce908292607bb6cf37c978ece8a33d4

--
 i.

