Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A94477995;
	Mon, 11 May 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522009; cv=none; b=VtsczA/rf0yG+iZCjQfxuvTdEOyTl7+fAM3tikyBoRjP2iQfmhTgayMJHDhQRzHqKogJGrVLDewE3ziRD6Hg/VhrBDh0HedmP3OtSL1zh7DLYYnctEyMBdSwSqcOD4eG4ZN5jQHqZRaAJypcvWlLMumMM9LeTtOXC7M/0sLOaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522009; c=relaxed/simple;
	bh=jepv+2EMfu2s+0dZ96NgwTHAogXlos+dU+67lWPEcIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hfrynw1GhPLmOL1t22cLnnR+HEFWJP1lYrerZg/1xypcNyFwAEuQ3vqW1odhgJmfGDKuv4mpNFz1qn2HWKSBtrsgcuEZTt2altZDJBDpy6iY8pbKxbfhD3JvUa/LQtT8jlUiKxpZ0S5P8kEyYivfdvUKB75oUEW5y1WUk+9MQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAKwZ+xt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAKwZ+xt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778522004; x=1810058004;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=jepv+2EMfu2s+0dZ96NgwTHAogXlos+dU+67lWPEcIc=;
  b=OAKwZ+xtb4k2EsYVP1XMGH7Ub8+1N3pe34vD7gKeMikIYZF1kAdhDBiQ
   UJB0XB+0+Ptv4F6blDv98Mcg6C5yjcJ4tpwHK4xf2mC25GBXA2fAhXWQ7
   RxXWkEMCrvevfTZ0kLU0n+mWjELuWqahE9+TeFy8FiI90ThBMiyDotZqE
   a9Yg7pzEkW5rN0T0qMr9Kn1VaBHxWgIFylH1/yPVKtRTaDccsZrpijBDL
   WkJb/nMUxnXbSi/pb3v4PFzrt8niaMFWqWXdCedrDCOjp08rKRANHnzgK
   tmhUgZxIkcs8D0xp1AgepQXQOpRwRS8EXOW6KnFpGuvr2pr4iPMzHEzwW
   A==;
X-CSE-ConnectionGUID: zqXtsNGjQu27MsPkYMYTBQ==
X-CSE-MsgGUID: eRV/sJrQSdCCrB6RAuw4ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83033382"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83033382"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:53:22 -0700
X-CSE-ConnectionGUID: pebBENjKT56F8VmsydZUbQ==
X-CSE-MsgGUID: 3xAqKX/CSz6ouC7eL7aOJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="234857713"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.28])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:53:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: "David E. Box" <david.e.box@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260430224307.109311-1-rosenp@gmail.com>
References: <20260430224307.109311-1-rosenp@gmail.com>
Subject: Re: [PATCH] platform/x86/intel/vsec: allocate res with
 intel_vsec_dev
Message-Id: <177852199364.27853.2102392778321482482.b4-ty@linux.intel.com>
Date: Mon, 11 May 2026 20:53:13 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 30 Apr 2026 15:43:07 -0700, Rosen Penev wrote:

> Use a flexible array member to combine allocations. Avoids having to
> free separately.
> 
> Add __counted_by for extra runtime analysis.
> 
> Move counting variable assignment to after allocations as is already
> done by kzalloc_flex for GCC 15 and above.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/vsec: allocate res with intel_vsec_dev
      commit: 8ef6b01cee44803691c0a0c95b36f8ec710e2afb

--
 i.

