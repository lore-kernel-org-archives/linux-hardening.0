Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212C1FFC4B;
	Fri, 14 Mar 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963122; cv=none; b=HL+8N7zq56Rvaq/B8DepIs1iTjA9HUg70I6DukPTOaUoxG6nbs0f24x+fFUDzRAwLeOpFmG88yRRSaZWQLrWnZU3SFnS1AqpucJXgNBtMSt2s5KlG3Fhut2HwyUPyG0sHWkMPuFOmVi4CKVb7v1b1GcmQUK81e8anA7bp9ReYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963122; c=relaxed/simple;
	bh=nhJwcBN5xORLe4RPTOgWh/rOF7dwwkz4g6VbVKsi+EA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l4w7aGba4kFZ9Yve7NWQlKmSG0v/Vn1NiYBy1FL/FDWVv1UPNO+GPfk967FPqd/AlXQsW4sYDZjVFXirFJXSWQFGnAu/8VFqT5YZ3q0ENTqQplNcF220Pws4DAVPSy1xfJ65Hx4Wl3/m6IOFiTpLc5eM8lEHQ/eprIZRgEx1Noc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=cLqm2583; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="cLqm2583"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZDn6Y4WLzz9sPv;
	Fri, 14 Mar 2025 15:38:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741963109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HR2cA/3frnVcYkSzurVNHIrja283d0wVh4XQGvYIcWE=;
	b=cLqm2583YNQGn5NdZhcpil8v7duBCGwQlSHTnRXTXSqaiJxPv7IqwJfB+fYY4W1f4OCc6T
	o1nLVbpG9j2sKlu+2bEUJBmWTqIOuZE4Sr1dO3Oyhgt1gKXuWG6m3l2+GJYX2xM9GC+niQ
	lG7xEUPxGLSqdVee64SsD+Qqn7AzuPg1FaVfBuGC7LnSsG8JaEzbgOwnlvAc7/Y4YLcw64
	T6O8bn0pPAOMIfgp+9B/bp2uA7E447cSEwVZNeViHGsZLj/OcEn3/P4TCIvyxZ+LVHJakG
	S4eSrhbsn5qUiPV2x3rEA+XH29q3mO6MeFkzMMhcb9yUG7oiPdEjTFCdsJ8BDw==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Subject: [PATCH 0/4] ASoC: Intel: avs: move devm_kzalloc(..., size * n,
 ...) to devm_kcalloc
Date: Fri, 14 Mar 2025 10:38:20 -0400
Message-Id: <20250314-sound-avs-kcalloc-v1-0-985f2734c020@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFw/1GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0MT3eL80rwU3cSyYt3s5MScnPxkXUvD5NSUpGQTcwNzEyWgvoKi1LT
 MCrCZ0bG1tQCjWG0wYwAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=nhJwcBN5xORLe4RPTOgWh/rOF7dwwkz4g6VbVKsi+EA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGK3hqei8zV2R2TDRKOWRRcFhRcEpVejVOaGU5ZkJkCmNGcWRYYTRjRzluMDVzMzFi
 VklkcFN3TVlsd01zbUtLTFA5emxOTWVhczVRMlBuWHBRbG1EaXNUeUJBR0xrNEIKbU1qU2R3eC9
 KWHJ1cDl4aDErN1JtWFBnbGYrTVk0TEptNDNXYlpTODRMOWlYZHJmdDg5YjlqTDg5NjIzZkRkbg
 ppOWVxaGI4VU9XSWNzZ1cvY0ZVMEh0bXU5L25Nc29UYWhVV3lMQUM5WVUrQQo9TnJIdwotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

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
Ethan Carter Edwards (4):
      ASoC: Intel: avs: move devm_kzalloc(..., size * n, ...) to devm_kcalloc
      ASoC: Intel: ssm4567: move devm_kzalloc(..., size * n, ...) to devm_kcalloc
      ASoC: Intel: max98373: move devm_kzalloc(..., size * n, ...) to devm_kcalloc
      ASoC: Intel: max98927: move devm_kzalloc(..., size * n, ...) to devm_kcalloc

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

