Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9755420297B;
	Fri, 14 Mar 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963131; cv=none; b=VbTrPuMkdzVDfEsl5fDGUPVwnvdlABKDUANbpPUjnE4a1YnEdImYKHVKM/dNE0f+0kKdZuQFdo4thKga48GBlpT9UzhXs5qmtnHk4o9pfyQSPRJsEYlVnsi2I5znEmfIW4Gw2h8iUOUnJpKGg1k5/RnsWI0Icj9dzDMLgPtEo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963131; c=relaxed/simple;
	bh=hK5nAdOzOVBPKtAa3bvrdTBZMx8kFgBmbzpTeUx6xVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozKiRRqFx3obC0A2hNU6kzmk71/4pmXb1844w9iVPa7bMF4N2lZkyISvs5uZWit805AFXp5kAUem5rZfukabIw0J0qS84yMnMV/YtXrbjXjgwjb1pkn/srkl8OUw6AFbuKpgGu2AU7EE/kzzSvvubuXar86td2EroSxpT0iYnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=LG1Q1cjw; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="LG1Q1cjw"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZDn6s4B9hz9smm;
	Fri, 14 Mar 2025 15:38:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741963125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zANwSsYgSk7QVAGua7pwVhPM3i4jh6ZRBE5JBsf5/m4=;
	b=LG1Q1cjw0b1pbIz0GnUxaRUq++5olw2by/tWrWcIqXrtb8RVrfEudBr/jcEITeBpPCwLX0
	HM0kYBtz3Njfj+NEVChkx0do6l7uX+0rif1uWENV7vxU+31H5gURNACWH4j6nvp0hbv0kS
	ldFQjxQUbeEwr3tExfCCzM8Wg5Q6o/ruHQxK596EQc960nCEUIcnKLBChAERoTYMzEDLUi
	UjCgsj4cCcSUu24H3f1ixIyXP5UtR5TfufJi3t01qWsNmeWhnrh8yHDieHRXlXVyIO7wrc
	wwyplXubNO3PtZ8JtStnCtey5SNp1CDMbSdKv5ksC+VlNatuUaRb1QY788n3bw==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 14 Mar 2025 10:38:24 -0400
Subject: [PATCH 4/4] ASoC: Intel: max98927: move devm_kzalloc(..., size *
 n, ...) to devm_kcalloc
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sound-avs-kcalloc-v1-4-985f2734c020@ethancedwards.com>
References: <20250314-sound-avs-kcalloc-v1-0-985f2734c020@ethancedwards.com>
In-Reply-To: <20250314-sound-avs-kcalloc-v1-0-985f2734c020@ethancedwards.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=hK5nAdOzOVBPKtAa3bvrdTBZMx8kFgBmbzpTeUx6xVs=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGK3hUM0RRZVhOcWhXNk9ndjc3dzllUDZmb3M1OW5lClBKZHZzc3ExTFczZlYyNlRm
 VzNVVWNyQ0lNYkZJQ3VteVBJL1J6bnRvZVlNaFoxL1hacGc1ckF5Z1F4aDRPSVUKZ0lsc0syVms
 yUCtkUDMxWDY0cmpIUFdWVzdaMHE5MHAyeDE1VHpXL01IajlrNVNYUEh0aTdqTDhNNjVMMnh6OQ
 pMYWZiK3huVDdRa0d3Y2ZYMzkvYmRzaG9qclNONSs1d3FlaFVaZ0QvMjA3WAo9WWpyZAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZDn6s4B9hz9smm

Open coded arithmetic in allocator arguments is discouraged. Helper
functions like kcalloc or, in this case, devm_kcalloc are preferred.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 sound/soc/intel/avs/boards/max98927.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/boards/max98927.c b/sound/soc/intel/avs/boards/max98927.c
index e8e5d1c717cd398aeca506bf7d20b5819d8dd1a2..e4ce553bf1d6432b4c11ce44857d969ca6b54c83 100644
--- a/sound/soc/intel/avs/boards/max98927.c
+++ b/sound/soc/intel/avs/boards/max98927.c
@@ -108,7 +108,7 @@ static int avs_create_dai_link(struct device *dev, const char *platform_name, in
 	dl->name = devm_kasprintf(dev, GFP_KERNEL,
 				  AVS_STRING_FMT("SSP", "-Codec", ssp_port, tdm_slot));
 	dl->cpus = devm_kzalloc(dev, sizeof(*dl->cpus), GFP_KERNEL);
-	dl->codecs = devm_kzalloc(dev, sizeof(*dl->codecs) * 2, GFP_KERNEL);
+	dl->codecs = devm_kcalloc(dev, 2, sizeof(*dl->codecs), GFP_KERNEL);
 	if (!dl->name || !dl->cpus || !dl->codecs)
 		return -ENOMEM;
 

-- 
2.48.1

