Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C830347BDB;
	Wed, 18 Feb 2026 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443603; cv=none; b=rH4PaqozSDYGyklq09rrqVp8V6ldpdbzM8g0d7pdMwdIsRUO1yoOzUgsWK6lrj8OSxNt4pdwHfSQGYVN/wbP8r8sfAN0eEAzwyKaF1hFm/cAX3+NkBQXoFu0f9IpR+gW9yr9rG0oq9yBTD5SK9Ox//IFBwXkJSvha3s8BpYvCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443603; c=relaxed/simple;
	bh=ngcpdzAeKcD2NFlcOBp1MznCl8Ce6Xj894MkPjmT+oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDqNJ76NSusqiBUd/bq7rwp5tUwMzByO9Dez8tzm/hOgTjQId4HqbSkn5gGx4qotRI2CThyaoX7iBtRwsRle/J7OnvE4RlXKKZGLlnp5WcDaFK4zKSRh4fZGHWWwrN9OEtnZ5HpiSxLMikYXD+yiZdSlX9hHmg5kJkED2ZqwWRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Iw52QtIA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Iw52QtIA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pnW/mT7OsLd58tIVixerw1VWfasr3zPGAO7/y7FKJNo=; b=Iw52QtIA6kdsD+hl0c0J+OvYR6
	VZrdza6VrR1uxngqpayoMzRs8ltfkvrK/dd/Kcnq1gH6EOVAXd03ZpGPyMzI8hchNTsYN5R0mgKq/
	1mgPCo9LcukbfSGnzhmn8FhOoIGTBlNYkQCmTg0rO6d2kJbw/kVcKXwLknjyuK2S5zc9d4bAUM7CL
	FCOT9XjzuFYQ0EOPxspZrgddUetp0tlsolaKsuot/yEVFt6r1J3nalIvjf2RilppEK9/ITmiJLQJ+
	YCmVXUJlrqmnjy+RoMzYyiAPbr/9EvpOcKvioJ/u4YfwpJ1UBQPoSGUo5oUq9sp/aElYlsRBKualp
	ZwN4IDVQ==;
Received: from [177.45.213.208] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vsnOr-002Bdd-S5; Wed, 18 Feb 2026 20:39:54 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	tony.luck@intel.com,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 2/2] pstore/ramoops: Fix ECC parameter help text
Date: Wed, 18 Feb 2026 16:37:32 -0300
Message-ID: <20260218193940.912143-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218193940.912143-1-gpiccoli@igalia.com>
References: <20260218193940.912143-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to set ECC on ramoops, the parameter "ecc" should be
used. The variable that carries this information is "ramoops_ecc".
Due to some confusion in the parameter setting functions, modinfo
ends-up showing both "ecc" and "ramoops_ecc" as valid parameters,
but only "ecc" is the valid one, hence this fix to the parameter
help text.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/pstore/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 39936d6da0dd..295a837731a0 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -71,7 +71,7 @@ MODULE_PARM_DESC(max_reason,
 
 static int ramoops_ecc;
 module_param_named(ecc, ramoops_ecc, int, 0400);
-MODULE_PARM_DESC(ramoops_ecc,
+MODULE_PARM_DESC(ecc,
 		"if non-zero, the option enables ECC support and specifies "
 		"ECC buffer size in bytes (1 is a special value, means 16 "
 		"bytes ECC)");
-- 
2.50.1

