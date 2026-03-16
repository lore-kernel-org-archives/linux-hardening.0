Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5133CF660;
	Mon, 16 Mar 2026 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680528; cv=none; b=i+VblW2GAIiJkNkwBF1nB0DLKVYgwV6byQMX4IkUfu5IWm54q6UgqC++lzWocB5+6iInO/2ibTBInnbVRItfDvUNLggtgD9V/0Ha7gGSREvHBQCDHErJ93EjZFpMCVtuXulh7qUIOgz9RAjsolhASsT+cy1zcIjWgN/sOvgeyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680528; c=relaxed/simple;
	bh=e6mmkk3VjvQ6Kl9fH5x9ptP0O2SVcyrconnDJ8iPr3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4W63TJK4z9i0AC59AEZ5DPR+YrW/dNWBOubx1edOM+vYAtQrtTUB85kK49dQFg+Bk1SKdXVsHGoZ+2zuZSSoUPHW13I7YqFFMxhgLCHEE6nIVBtz1V0KlB77BaV5z5vt3KS12ZlI/jMCj3HtDb0Isr2KA5bCJ/J/CYbL5lj3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ju958/4/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ju958/4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773680527; x=1805216527;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e6mmkk3VjvQ6Kl9fH5x9ptP0O2SVcyrconnDJ8iPr3s=;
  b=Ju958/4/Pdn3rQE2GDP3r1aN+0R4r8qTSDAaWOGuxUpSLKZf+OhdDGHa
   bikHG+JqDZJpl87g6uzlXMgABL7Xa6H0iOKDYHgy9zbcNrI449POeBdBD
   aIi8N/1YUPz4eMWETrjYNPAGmmXX3R+Fnx3iKv8NezckpQF16yifWs/K7
   eiGQDpdQY9n0y1CJoJDAFtg3TsefYBMF/SbKvm9nwjwoGXZKstEU4bnHQ
   7O0yyFcJ2KtwTO2d80yZOK9UTgw0bFy4fW0yJvum7J/Zrm4vz6p8mkvjC
   LePhbowAJqbx+rR48wqPEi7gYZqvWHzTL5G+mztSjGcvAfqqwXqhLcN3s
   g==;
X-CSE-ConnectionGUID: mPa7PncWR1qZyFHbSrjhtQ==
X-CSE-MsgGUID: bhis/FjXRV6R04/8UmEbDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="97310986"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="97310986"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:02:07 -0700
X-CSE-ConnectionGUID: EDrfobONQWGcqOa8Ty2lpg==
X-CSE-MsgGUID: Aad8T/JCQnCVxvqKGGEFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221019928"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 16 Mar 2026 10:02:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 397A095; Mon, 16 Mar 2026 18:02:04 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Josh Law <objecting@objecting.org>,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with better alternative
Date: Mon, 16 Mar 2026 18:01:58 +0100
Message-ID: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strlcpy() and strlcat() are confusing APIs and the former one already gone
from the kernel. In preparation to kill strlcat() replace it with the better
alternative.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/processor_idle.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 45b5d17443cf..498d88f5d5c9 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1010,9 +1010,7 @@ static bool combine_lpi_states(struct acpi_lpi_state *local,
 	result->arch_flags = parent->arch_flags;
 	result->index = parent->index;
 
-	strscpy(result->desc, local->desc, ACPI_CX_DESC_LEN);
-	strlcat(result->desc, "+", ACPI_CX_DESC_LEN);
-	strlcat(result->desc, parent->desc, ACPI_CX_DESC_LEN);
+	snprintf(result->desc, ACPI_CX_DESC_LEN, "%s+%s", local->desc, parent->desc);
 	return true;
 }
 
-- 
2.50.1

