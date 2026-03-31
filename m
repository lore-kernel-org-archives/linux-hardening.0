Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B784035DA;
	Tue, 31 Mar 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969383; cv=none; b=eqG6YglYna7IjkjSn2igd626SgubS5LiKwFhE+/WTRcFEQh4N/Xtdr8C/NjOpCG/oaA5zndUgbHK4O2WVYlgnHyjeBLIvqUlYK9ZF6vY5hCWOBtd8OVCbwzCYn0AjESy60dne2FcljGj8nIC8yyt+gO/ejevts7qcCQ+yW0wHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969383; c=relaxed/simple;
	bh=+MFs3y49/gC/7iiej/CAtcZdOGR9Cxk7lDTnyBC9cfE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UFa37mPBh3GuX74DRCOa80QXS3KXVj+jq4D5w+GyEps7HmL31mPvzJfPzT0XMR8SPsr7tTTGKsUH5xlBT6C1+4iTtT6yk3oxYq1PoPxSTya6WSFw70sA+XjO+yadAO4+8nfJSPajlS0bZT/fCXdwS/8rhahHeIf5e5l/DRxZgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2hCcFP3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2hCcFP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969382; x=1806505382;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=+MFs3y49/gC/7iiej/CAtcZdOGR9Cxk7lDTnyBC9cfE=;
  b=T2hCcFP3wb95NnSLaR84g9GycBffNxqpZugIfL63TPNiJH9IYuhCNy6f
   3uDiTfzIH/GIxDr5+7Us8rqC4rW6sCJBH/VDtiHqLlC25wybaCCu/kVur
   VH4Kqjr73907hz6WA//BCTbj+MQ8m/yIyz4Z+35XL+nP01B5XCtCfw+vS
   VORnbWULz0JJfaAnmZXnHRJTZ1bE2QFnwV3f0ffaWvYet4ZUTnHFWYmAt
   MFAGgZ6i1wT0XkiD3m3KQJT+uw6F8IEbM5k3wLPGZyjAI7iFo4xaAaAac
   UcUyrKHs5Y4CJFnD6vVQMGCk32Km2wiWVHN1n1/j/8nUXMc0LCK24tgBd
   g==;
X-CSE-ConnectionGUID: Y5MH6fgUT6u9GktojnhFpQ==
X-CSE-MsgGUID: HmSVwy9GT9eQhTq/oG4Wrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86682299"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86682299"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:03:02 -0700
X-CSE-ConnectionGUID: eKESiV2sQ0GCPNeCFhvjeQ==
X-CSE-MsgGUID: 2jTCSLy2QwWADLW9yhpI9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221527729"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Kenneth Chan <kenneth.t.chan@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260326024525.63258-1-rosenp@gmail.com>
References: <20260326024525.63258-1-rosenp@gmail.com>
Subject: Re: [PATCHv2] platform/x86: panasonic-laptop: simplify allocation
 of sinf
Message-Id: <177496937487.10314.4187390108669622962.b4-ty@linux.intel.com>
Date: Tue, 31 Mar 2026 18:02:54 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 25 Mar 2026 19:45:25 -0700, Rosen Penev wrote:

> Change to a flexible array member to allocate once instead of twice.
> 
> Allows using __counted_by for extra runtime analysis. Move the counting
> variable assignment to right after allocation as required by
> __counted_by.
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
      commit: e75869527c720c4ed1458cfbe25e92186950e43a

--
 i.

