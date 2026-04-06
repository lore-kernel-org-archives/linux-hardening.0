Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD7396B78;
	Mon,  6 Apr 2026 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504072; cv=none; b=IYdTR6WBvib8FTR514HW4YCENpHWOa/A0Rs0DxM5HMlg+Iq+vTGIqnASLmCkaKHVrcTOijmgYfl56lIlbywz9lfvWp8t6ZxFoQEyyS3+kvloBBsk/UUvh0a4XMmD79k4yMO8uZ0rX2O0+cjPcfXmeQOHFQWi1TiGnyJOl9m8hfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504072; c=relaxed/simple;
	bh=gT6OkgT24x3CJ9UHtRxBs1ZHEb9GpW8wpRsy0aFINrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2R2m2BejUsz1wOLFYYHR0M8kMwnuIbkbIfLBpMAF1X9KeD8kxJfisDtPvJOrEz6zVXY5R6YYVGyzjHITY4XcfDcDw7kmCEoyZrhhScklJmxuV40hgvTzH18b1UKAy1RPF6LAFXqMkpVNAUz7W6ZAeFhZNtUdG2lahVOaZOISoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEnp8a3c; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEnp8a3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775504070; x=1807040070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gT6OkgT24x3CJ9UHtRxBs1ZHEb9GpW8wpRsy0aFINrI=;
  b=aEnp8a3cBCNvIkz+G1WBaEBKow5j7Ul+CtxNUrdcDObbcU4w+p1f5CGv
   5x0UZdK19HmU+DK2gBD3Y5uf0uL6qIeCLVTEhPsnAHWkFxUe/cZrY+0+X
   qqX8OvWBC/p3PkLSAIel9Nr2ikpkY/PxXilVdEH5DEb3hW6loyeZUNma/
   9OCt7pWb4+x4+Ue9SUUUGG0X9yzlDPh1/blt87lJBtVbtDC2+ErEKKm9n
   Ttq/dTnQt+CyF6zlvHk86DpiI54/MU8W3M9u7x4MTA6iX13ILsJns4Inz
   AS6KLnn6wm+YUm7WprF2dvw1THqMOH5W1v7Q/5K4rouuTbpoJ67qyCA0i
   g==;
X-CSE-ConnectionGUID: ZXJ283XeTyqB1AczEOv5Iw==
X-CSE-MsgGUID: p4Kkt6bORJyQVdMOKApUpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76421548"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76421548"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 12:34:27 -0700
X-CSE-ConnectionGUID: VGJcu2YKTh+q4DaBo/mAQw==
X-CSE-MsgGUID: +7vU1ZH6SwacVGXi5LocsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="227898399"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 06 Apr 2026 12:34:27 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 55A9395; Mon, 06 Apr 2026 21:34:26 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 0/2] lib/tests: string_helpers: Slight improvements
Date: Mon,  6 Apr 2026 21:32:46 +0200
Message-ID: <20260406193425.1534197-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two ad-hoc patches to improve the test module. It was induced
by another patch that poorly tried to add (existing) test cases and make
me revisit the string_helpers_kunit.c.

Andy Shevchenko (2):
  lib/tests: string_helpers: Decouple unescape and escape cases
  lib/tests: string_helpers: Don't use "proxy" headers

 lib/tests/string_helpers_kunit.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.50.1

