Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2BD1E3761
	for <linux-hardening@vger.kernel.org>; Tue, 15 Apr 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707873; cv=none; b=HO1h9bmWggamj1LCQ2+Ri1Ew+UnnvFg261CLSY+w+Y+y76i4Kc/ZhPnWdksmeoBczVhMiTkLJH5tsWWMyrf7u4a1C/lGQ+Iw36uwuvjwHDsNwCde4GXqRLvbSx4rxZTpFzi85TjiZGGdhrKwhS4xFAxJrtK8zyM+Gka5N3sSGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707873; c=relaxed/simple;
	bh=5Yr9DFS4YYzbSoj+iCIvNtBnsVN/9nYfDboO9pt0WxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxKXh8RmAXpmlCGSwxL3VCcuJnra+dV4y0DW+BGWTHMRBy1fcCRzT0xja9d5EdsAhoESdJA8NTupKBVvJboTJZpOJ5lHXs5CgFEYjLXAUYaPjGYfa69mzgo3tlBaozGq0NeM6LuoUQj3XjGGWvBHqoSmVVcTLO77ggZQHdbwIUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=moqq9Ync; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="moqq9Ync"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744707868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aVSUpFvZNChKWZuSnWMz4EXoGJLNgPtOq6YYndgZ030=;
	b=moqq9Ync1CxOT1OwH3YujG+LHq8YnRTQ6N/4JKBw+h3/yPz8yAM+JhkjPjENQ85hWIipGV
	KvFjpEHfLC7eFiGbw9AJt3HdJDCiqe/BU3PRGDWDWW8QLPoBOqA4fHPzCYF1SDcrwnvs//
	oKUS5eXu0Hh9b4GSz7aXa3TijBzxyDo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ASoC: cs-amp-lib: Annotate struct cirrus_amp_efi_data with __counted_by()
Date: Tue, 15 Apr 2025 11:03:55 +0200
Message-ID: <20250415090354.92211-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/sound/cs-amp-lib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index f481148735e1..5459c221badf 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -23,7 +23,7 @@ struct cirrus_amp_cal_data {
 struct cirrus_amp_efi_data {
 	u32 size;
 	u32 count;
-	struct cirrus_amp_cal_data data[];
+	struct cirrus_amp_cal_data data[] __counted_by(count);
 } __packed;
 
 /**
-- 
2.49.0

