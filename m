Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0004D7D3A;
	Wed, 16 Sep 2026 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580319; cv=none; b=dubHV6PVFmQsL9j1JHFhGtDllxQCCEErVqc6jWIdFbkK+RdnnPHwj81WhknsQ1oSSi3ZiniDomesxkp2ZSWhZVCMYM2h2h6z/A1OLMNkLFvyPLHlscIRHImuP/uye2fj7f+u7gn97owNl6lYEzUvsmmMkYD1Pe3G9PjTy7vePPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580319; c=relaxed/simple;
	bh=AAUbiaQK0eUPKtiPYPI3YaJLXcEjwrbtYeg+YPYx2fQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=syApu1uSAvNHVuexMF85nHOV4PKPCDgj0zIeOlhVSGEnAMPcjKAIKcTQ9JAatcleqrbGOwdXLFAfPcqc+sNhtmUkPvoLxLfZSUHgUVv+b6puG/qAz2A6H9U12LMcLTfzWHjS5buNKUlSQ413IL+tWf9X6YkvAj81hMFFrcG2HqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: akpm@linux-foundation.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org
X-PTX-Original-Recipient: andy@kernel.org
X-PTX-Original-Recipient: kees@kernel.org
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 157A8200740;
	Wed, 16 Sep 2026 19:38:15 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6taJ-001Go9-00;
	Wed, 16 Sep 2026 19:38:15 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH 0/5] lib/string_helpers: fixes and test cases for
 string_unescape()
Date: Wed, 16 Sep 2026 19:38:05 +0200
Message-Id: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP3TqmoC/yXMQQ5AMBBA0as0s9akJJVwFRFpx2AsSjqIRNxds
 XyL/y8QikwCtbog0sHCS0jIMwU4uTCS5j4ZClOUpsqtli1yGLs9kKBbSaOxpXOIlUEPqVojDXx
 +x6b9LbufCbd3A/f9ABtMuS1zAAAA
X-Change-ID: 20260915-string_unescape-c056aacc90cb
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=AAUbiaQK0eUPKtiPYPI3YaJLXcEjwrbtYeg+YPYx2fQ=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadYWhKGWJQHhR0SFVnd8vAh7tamHh3fz8XtaU3ob57
 olem7Q8O0pZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABPht2L4Z/pUTpflKuc63+vM
 oVxHY4s+3xJrFjh9/kfF56eLtZ/53GX4HxPoytrFldvf8Mx87Y7H2RnO0ZZmfk4XOg/27WDjMVj
 IBwA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

This series fixes two bugs in string_unescape() regarding the
destination buffer length. Both fixes are accompanied with kunit tests
which would fail without the fixes.

To make this possible, preparatory patches 1 and 2 improve and clean up
testing helpers and 3 introduces test_unescape_one() which allows for
targeted testing of the string_unescape() function.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Jonas Rebmann (5):
      lib/tests: string_helpers: check null terminator too
      lib/tests: string_helpers: drop unused parameters
      lib/tests: string_helpers: introduce test_string_unescape_one
      lib/string_helpers: use full destination buffer in string_unescape()
      lib/string_helpers: fix counting of remaining bytes in string_unescape()

 lib/string_helpers.c             |  5 +++--
 lib/tests/string_helpers_kunit.c | 46 +++++++++++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 14 deletions(-)
---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4
change-id: 20260915-string_unescape-c056aacc90cb

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>

