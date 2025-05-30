Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E61898F8
	for <linux-hardening@vger.kernel.org>; Fri, 30 May 2025 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591077; cv=none; b=K5jRDqA1ifXGoGn5HN/TdftZ9BeKpJd4c1AZqCuAWlBqmJBDY9amOIhkfl1STniLECw2FhPNYk11lKDQpviMAyqCjy2kQ6oJrkWtwZ2QH6NPfcLaqcLpjeyFVcQRKaMczWQ3Opd1nlpGIX8zrKgrXXQTpivfaJCILl0siYdlZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591077; c=relaxed/simple;
	bh=HSbtNWFqstfSDKUTqNvMrJXLZod1LF6FPl9mMEobWso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nsF2U2v5QRPb+5qgGbUOy/Lbg8zfz+S5kD/uEmBHWK3gGSh8v2UkdQFT37upf0TA88TkEZwsXFkTIDpqfUtQnjNSSAfZVtxmBe9W3bJEH02+Kk/CRTMWYkwnr2no9gwmGxNHkQ4ljNvvyQkkWQxOS6QP/1zUD03a8SVf84z47jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrjKoewb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrjKoewb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748591076; x=1780127076;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=HSbtNWFqstfSDKUTqNvMrJXLZod1LF6FPl9mMEobWso=;
  b=UrjKoewbckTqwHB+gtkD/OvLx3gJRMHT7P/0vpHhaXYRlZnOUgApDSt+
   TnS+lOXQMEc0qPQTSyPslPf8yVz+DYqz4KnyCTFsRD+RYVjG5Svs3wa6G
   ftGyYbmr4KRtivlrbjXFJqPu3EPDVVCNn3ULDR8qsCC6yDlbk6Auaziip
   8OqmLMu6verZ1wjc1FvROpoIiNZUGjj4ixw2umh4sXoGV2N59B23LVgbQ
   Sdwy4rT47Jz6N9/dGLSKIjlMFcPZnedmon7Xd3LDL76soVWqsd+7HkFA5
   NXcZKzrS+KsKmlm2maY8DbtBQOpnKyYlKzf+Y0CMbA3Jg2kuexaddjQmM
   w==;
X-CSE-ConnectionGUID: sBlSHJJLQ3+YC8Pj8z2eFA==
X-CSE-MsgGUID: atQuxsfUTRqeBXNPgcoDmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="54475090"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="54475090"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 00:44:35 -0700
X-CSE-ConnectionGUID: u4dOncj3RWGK6pDn1/EmiA==
X-CSE-MsgGUID: 4+3iPFIMSJCMISMH/8SOFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="144141101"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 00:44:33 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: i915 utils: range_overflows*()
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date: Fri, 30 May 2025 10:44:31 +0300
Message-ID: <cd0ea72c6cab6c478336cd1bb5b517a9fe7a150d@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Kees -

drivers/gpu/drm/i915/i915_utils.h has a handful of helper macros for
checking range overflows: range_overflows(), range_overflows_t(),
range_overflows_end(), and range_overflows_end_t().

Looks like the first one has also been copy-pasted to
include/drm/drm_buddy.h.

Feels like include/linux/overflow.h would be the right place for (some
version of) them.

Thoughts?


BR,
Jani.

-- 
Jani Nikula, Intel
