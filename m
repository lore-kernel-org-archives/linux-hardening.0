Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84762604BC
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929439; cv=none; b=Pc5hcUnhlRposipM2KgxJwHRda0tRlu+yaAx002I88PIIwJPrjHWYLZtmgV46XblPHpNjse+jxBpnzEcK56gFqUuJeRc57BmRKzrN7Mjiu3t0QlDM7KUhAEkrNBa1c22/oh27CNYmxLSVtC4nk7tU85wNc0CeNzEll8/e8ZOrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929439; c=relaxed/simple;
	bh=QU5soyfiVYsFMnAv6ukaj6zRpJ7lCWP8Ml9Rf9UfVtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RyYo3482KYrLMtyfHYCpOhURs98WVnEBf/ffu0kLQkljmdzyyvBkI2m8mq/xbBquWsm4M7C4Ls+XLGxB4zN5kGaUvEoJU12ogu2NveOsJJEYM88Lx9iY3nqAUrPtKh/P3XIWJYYC85GVBCSpaVOaeUhlS/j2KQuf+jFBsFkZgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTkJtvyE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTkJtvyE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707929438; x=1739465438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QU5soyfiVYsFMnAv6ukaj6zRpJ7lCWP8Ml9Rf9UfVtU=;
  b=RTkJtvyEQPh4nif0ctawVO4jQeKiOWVO/rActltEp1hO7wOb9iPQnyh9
   cZwe7u2m0uSSnjmjI3jG9IPLDuNA+E1nDaBO4YGK8RVQ4KT4OGIwqun1w
   oUsy2acDb5hjtNzl6z0lk9vp992/k+C6RPRUlOlZHH2stnKOt3FQg/5A0
   zN8ASZ+UIc80/EvUpLdGBYyHkbcjpaxT5nEqsF4EaG3V/3NDY4GBzEtt8
   0pP/UqYJujfe96WUfywsP3FI7MrEH0j3xrZOEli0cBjIjwB58j8sZfMVZ
   7tcZ2v0aMxyTg1960V+M+yzQpagPQ9cEBTfjMd2W/mFYYEzsoGE4T6hlg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5800354"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="5800354"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:50:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7984161"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.138.241])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:50:26 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-hardening@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH] lib/string_choices: Add str_plural() helper
Date: Wed, 14 Feb 2024 17:50:15 +0100
Message-Id: <20240214165015.1656-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add str_plural() helper to replace existing open implementations
used by many drivers and help improve future user facing messages.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/string_choices.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 3c1091941eb8..f3cd270d11fd 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -42,4 +42,9 @@ static inline const char *str_yes_no(bool v)
 	return v ? "yes" : "no";
 }
 
+static inline const char *str_plural(size_t num)
+{
+	return num == 1 ? "" : "s";
+}
+
 #endif
-- 
2.43.0

