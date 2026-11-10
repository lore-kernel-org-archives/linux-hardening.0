Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328950;
	b=Fmkko0JdHsm+lQ6z4oBTZ2wPIFBm+NpOrkp70BHjx2mS1uZISsLfKT65jUbpBFryKm9o
	 rS79smmbgdMreZTxkKsovG+emd8DJci6wqFa7vdQtk9x7+qCNStBwl67MihIX1TEpBSpu
	 /8BO5vY8wqKMFgqUN6e/jMbXqdebej0ZS37kDConYGKPfPrHPVJIQNBTMsSCm2eVmj9HZ
	 Fz8JDz7R6hsPNm+p8Yxh6sEw49PVcLAsqbiQMDwK3b6O8FLxLsftWZnbk1XcDbTTFM3Fa
	 xKeEfDL4QwlSCnGl9x6ypFh9O3HCbb9+W31A2U6KDGsIXvkwR3PNTP03J9bjvCUgZ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328950;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g+yV/Nsu3Nxl8iuwR4TnHM+4q0ruKeEgQTk1qd+O/hc=;
	b=xH8H3Bj3Q4+Lnj9ul8/eVUyayZ9bySgOur7VEP0dZ50t7uJduRq63i3PtMLsT7QOfMjn
	 RzEWGJJEqTpkyH3e5FAdt7ps/9SAsb3dVHwjondMd2fh1Wn/nlTeLhEPoEDLIPkLuMGR1
	 ftrJU3nJ9vz+U3o/TqwOnIOnuSiYllMhAIeMSXJp+VNu4xYC37TK9wmBVcFQTcdh237bs
	 kjci2lrJcX3hPOaprXXIKIL9x28LuUjDDh9u917gb0uD6whMHDTIO/RRBSHr2Y0rYm9R7
	 8cvvhZUJcpuA5Dq4RU6+zCcc8SBt1YzRR+hkJuIs63ZunWPGGNhh7MCyftlPh0qTAPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EkOFcAP4;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA14606A202;
	Tue, 10 Nov 2026 16:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AA14606A202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EkOFcAP4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794328950; x=1825864950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5un4gBHXmeuSCtHiKM1fVsAEh4pAvuk+weiG8I2an3s=;
  b=EkOFcAP4tdVs5Lv/oq1FyXk8NGKAhNPfYfXpInJGYRKM2gsd4R69vXtH
   1MAdBjwVH3y/d0/QMc8SQfR7H+1ZY1c7yAMyvsMs7SXYCAPy3ceejKQRq
   oSe6DB1o10WBE3kATDZ17AF5igrblLKk2hKoj7v09svC52St6F26dM0Do
   EAGMbA7FlQsIOgGb1VKQqMOxO140Zpoj6byri/Wci3QDve34CIOUWB2TV
   fn7gH89/4Vayh6ZU43wiuudo4rsHM2E+61nrIQrhrYJByLiQgLFzOGfcb
   K9yTxYfHENNho4vnDahKXeRalwg6C7RIgt9qnP0MrRAOu6oUjLlXVifeQ
   g==;
X-CSE-ConnectionGUID: yTGON3yySZipJYjGDf64zA==
X-CSE-MsgGUID: c4Ud6OOISaOknfUFo3OK3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2970503"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2970503"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:42:28 -0800
X-CSE-ConnectionGUID: YxN4Qx6MSpSCOjVo5dqt8A==
X-CSE-MsgGUID: mURPXlC7T+6dipbPfLo0FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8021088"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 10 Nov 2026 08:42:26 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4392499; Tue, 10 Nov 2026 17:42:24 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	jorge.lopez2@hp.com,
	hansg@kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v1 1/1] string: Export strnchrnul()
Date: Tue, 10 Nov 2026 17:41:50 +0100
Message-ID: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export strnchrnul() for users that may be compiled as modules.

Reported-by: Armin Wolf <W_Armin@gmx.de>
Closes: https://lore.kernel.org/r/1969fb5a-38ef-4b4b-9d2f-cb9a4348b968@gmx.de
Fixes: 0bee0cece2a6 ("lib/string: add strnchrnul()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Assumed to go via PDx86 where the first (wow!) module user wants to use it.

 lib/string.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/string.c b/lib/string.c
index a3778d5aab4a..cc8982a93afc 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -352,6 +352,7 @@ char *strnchrnul(const char *s, size_t count, int c)
 		s++;
 	return (char *)s;
 }
+EXPORT_SYMBOL(strnchrnul);
 
 #ifndef __HAVE_ARCH_STRRCHR
 /**
-- 
2.50.1

