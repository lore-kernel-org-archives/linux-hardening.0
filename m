Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFD197A76
	for <linux-hardening@vger.kernel.org>; Thu, 25 Jul 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902736; cv=none; b=STRGN9daKgqkGIIci5XQDKSDyJa5aancj9zCeCejMUXQR+WCMSlscji0Q7XPKjTLMfvz/d2K1ywUXBU2Za/z7HpfGn4VCpMi5AImTHy0McWmKOpp8Ymx86T7a1g2qn4/yXvB5d+a57HKyh3EWzmyg44OKiqw624ZOjlBt2qO8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902736; c=relaxed/simple;
	bh=3oHoNFJg0+LPlMiJvDYcBMN0cUB4MV59eRu2m2PT2wg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtSS8tCynazIK1VLvwt0kqi2CVeTJpNCaOoA7Eq9+pqszf0SEJPKWckjNIjeKdW8u0Op/pqjDnPtwT/NsUnfkr/KMk5RTw7rjNOvXNPc4ZWzbJItEyT3w6ziUIO+qoCMhoaForJaP4ebp31iDGrkB12oo1qSfTQUIYz0j3ehHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVk9CQt6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVk9CQt6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721902734; x=1753438734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3oHoNFJg0+LPlMiJvDYcBMN0cUB4MV59eRu2m2PT2wg=;
  b=HVk9CQt6fU1j3pGGnFheNGBb6/XXXrGj/q50gkc5pZy/4yteTt0EYXBX
   eLLgsswOM++sML/syYMhoB9834bt5iZCQ49w1KPhxbhw8tNJsAHcNKmwV
   CuS1mLaXc4WLw6EjPoqZLPARU5L2QblI04/jclUHNdEVpr0/yOyFvJyCj
   yVkXrQq8SmozaWQFdc+aYTQAQ/BjdWufQlXhjmOyBvTt2VDEAF3+q32Xb
   x709q62CB7ZSkKjLmn81Mc38F4v/OzJAOJS1KRMcnI5n6xj4/FiksFb1d
   PyKU03lzX54z7LEimvytjZkud3HFdop60yKF1T7eKawcw21yB1mfGBQy5
   g==;
X-CSE-ConnectionGUID: /tjgVui/SFi4RMVlCxw9MA==
X-CSE-MsgGUID: qHJkhUCzToGumPGwbOxdXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="31047518"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="31047518"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 03:18:54 -0700
X-CSE-ConnectionGUID: JxkXS0eGQgGx4vWRX3XBMw==
X-CSE-MsgGUID: d/wMKXODRnK9DahNZgrpQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="76089766"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.82.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 03:18:53 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-hardening@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] lib/string_choices: Add str_up_down() helper
Date: Thu, 25 Jul 2024 12:18:40 +0200
Message-Id: <20240725101841.574-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add str_up_down() helper to return "up" or "down" string literal.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_choices.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index d9ebe20229f8..bcde3c9cff81 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -42,6 +42,11 @@ static inline const char *str_yes_no(bool v)
 	return v ? "yes" : "no";
 }
 
+static inline const char *str_up_down(bool v)
+{
+	return v ? "up" : "down";
+}
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

