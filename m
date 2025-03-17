Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063D21D3DF;
	Mon, 17 Mar 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214134; cv=none; b=teuwQdYTUl3IRcvWGURK/cHCB+8et9Ed6zPF8oOB3y2Psc9LmenIRYLPjawsj/SDpbPwdeO1t4+oP1yYqoUVNBMHZ2i0VLw7aoHtlqlpScvEeBKqYaSpatxa2F2I5ZJcxvSm7P0XE9mmkYilBSl038qG1Pi0nSeL1GVqiEUhMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214134; c=relaxed/simple;
	bh=lg/PHbQVkUOwDCCl7zLfT9oeKWfFOGtZTeDyFrx3no4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gGyF4gU3Yyq1Qy5ND2Ce6fUOkPWfGquC/zvmOqsNxh3g495WMOiUYQXZlWp3UhGj9KO07jdzOdAt2Lps7vETMy82qVgA+VnIbIxamtpZx8GybrI0DL23ID+KxgYhZD/XMc/tC9lgxZ2PI2dLTSUrDPgLWDsS5LyrxCDlCEX4aRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=aY24WilC; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="aY24WilC"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZGYxr1z86z9tDq;
	Mon, 17 Mar 2025 13:22:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742214128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CUjO5Cau+laHGyPUlcU076wi/e6BFBvAjdFQlKJGQIg=;
	b=aY24WilCCYYN9cUhKa2vNDG0HPWFDq2KcVSTGDtem7V0U1eENHaVnqju5LqD12Ip+jPN/F
	LCHiLqV4y+c+csun5qYw1AQu4gxACgbjQBgiw1wLAHv8p5shCPipcF5RmwYRnkV7Qizn6S
	EmmCCkmJtOHek6b27rSnQd/4WTKY2j66SIINosXPQtXtT5P3gABw2p0H85NZHpLj4hiKMG
	6aTfyfNL7GNQ083DAruxYR6ip2Z4mTq844atkjIQWmXj2SETbbsQoCh97upGTXdWsGfw4W
	T52lF1rNH7FYPQmW48/fkAz1icnxb/NkUWNCKst7AQJVrwWT/caOyUADLpet6w==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Subject: [PATCH v2 0/4] ASoC: Intel: avs: Replace devm_kzalloc() with
 devm_kcalloc()
Date: Mon, 17 Mar 2025 08:21:55 -0400
Message-Id: <20250317-sound-avs-kcalloc-v2-0-20e2a132b18f@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOMT2GcC/32OQQ7CIBBFr9LMWgxQmlpX3sN0gcPUEmsxTEVNw
 93FHsDl+8l//6/AFD0xHKsVIiXPPswF9K4CHO18JeFdYdBSN7JWRnB4zk7YxOKGdpoCik4huQu
 aVrYGSu8RafDvzXnuC4+elxA/20RSv/SfLSkhRXdoBt3WBqWWJ1rKkTLxstHxHsMd+pzzF1XKd
 C+6AAAA
X-Change-ID: 20250314-sound-avs-kcalloc-91cedbc47074
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: gustavoars@kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=lg/PHbQVkUOwDCCl7zLfT9oeKWfFOGtZTeDyFrx3no4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOOFFmbG5sWGgxeDNIWE5Jc2JUWWRzTnB6NmQ4bUxmCkRqSHZhK0UyVFR1K2V1MFgz
 V3JVVWNyQ0lNYkZJQ3VteVBJL1J6bnRvZVlNaFoxL1hacGc1ckF5Z1F4aDRPSVUKZ0luNGJHZjR
 YMy8xNTVtRFZ4cWZ5NlFscnFxenIvbXNzRXF4NDNiY3BxejA0a0tHS2p2SjU0d00yLzZlMnZqZg
 p1N0oxNCtOSjdnVWI5bGNtYnAzMzcrT1AvUy9udmFwVnVkSXN6d0VBdlVwVDBBPT0KPVJibysKL
 S0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZGYxr1z86z9tDq

Open coded arithmetic in allocator arguments is discouraged. Helper
functions like kcalloc or, in this case, devm_kcalloc are preferred. Not
only for readability purposes but safety purposes.

The changes move `devm_kzalloc(dev, sizeof(var) * n, GFP_KERNEL)` to
the helper function `devm_kcalloc(dev, n, sizeof(var), GFP_KERNEL)`.

Here is a series of four patches within the Intel/avs drivers that make
these changes. They are all compile tested only but should have no
effect on runtime behaviour.
    
Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
Link: https://github.com/KSPP/linux/issues/162

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
Changes in v2:
- change subjects to include avs
- change commit message to Replace devm_kzalloc() with devm_kcalloc
- Change from Link: to [1]:
- Link to v1: https://lore.kernel.org/r/20250314-sound-avs-kcalloc-v1-0-985f2734c020@ethancedwards.com

---
Ethan Carter Edwards (4):
      ASoC: Intel: avs: Replace devm_kzalloc() with devm_kcalloc()
      ASoC: Intel: avs: ssm4567: Replace devm_kzalloc() with devm_kcalloc()
      ASoC: Intel: avs: max98373: Replace devm_kzalloc() with devm_kcalloc()
      ASoC: Intel: avs: max98927: Replace devm_kzalloc() with devm_kcalloc()

 sound/soc/intel/avs/boards/max98373.c | 2 +-
 sound/soc/intel/avs/boards/max98927.c | 2 +-
 sound/soc/intel/avs/boards/ssm4567.c  | 2 +-
 sound/soc/intel/avs/pcm.c             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: da920b7df701770e006928053672147075587fb2
change-id: 20250314-sound-avs-kcalloc-91cedbc47074

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

