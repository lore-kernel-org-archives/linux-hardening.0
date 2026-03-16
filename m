Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1B1DFFB;
	Mon, 16 Mar 2026 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677863; cv=pass; b=ETL2sLOCM6+YeGJ2coqQTpLo5/BcBSrTv9JdeXeAEvc6yrpsWcFA8x8OC0a3US5MLdGGncz4fdyJtVFqbLPknvf3DNSmvo6iqnNxzXxssAMSYc6fiJZMZn//l16PQ8weydSba4qSkbGJlab8DmBZCjpw2rKPvGYdmolJGZSOk84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677863; c=relaxed/simple;
	bh=EV6I8Jp8DJZObjggmqMVOEdG3a93MP4Ik2SppLKiN3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HjdtPvVWcRnCi+bpA7qp8LgoXMkS6vp7z1G2R0Ff8HAPgpiDceMvl4laDiiMoJnKQNknCvIsJcCb+TVZJ6QSEHxRVX7vOMNYbd8O5+TBJDzLLZBGVL98xft6yIcNBcP0breNFPxCm/iM/dUUV6vHGeQomihK8p6yhHUQ747GShQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=bmI9ctRL; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="bmI9ctRL"
ARC-Seal: i=1; a=rsa-sha256; t=1773677853; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=gwMu2vUKQwpzpkvQ3aSDBYdp/YZCP4CtKDrgPlx2FahsPQa9alEyL3DFCu88oS1vhaDc5sK421i/kUTetx5ZiaPz/NL0stvXPIs8l3OnD37TVLuASQExVK7xCT6oUVpkHmei1rdO6Xix+XD1I4B2HgcHCaRFmBMh1n/br7nEZX4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773677853; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9LquFkDvJ6U2XSUzS0MFKH27OLwzBJYpe4jPChCwFhk=; 
	b=RNiMg+gO4gNhbOBvsZsf4vPTusseaZIk11pjQd4rAc7s7IoIxdZQFdEY71F6lV20VTWBTN0+6FBQrTsEmAsmgkKmdOyik4CX0V8dw1vi8NmE8PpNg/G6nIpg3z02sSgqi7oVRCSw+iW6XiOz1+bJeYWcnPo5Fva+DyO9/XSt1JE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773677853;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=9LquFkDvJ6U2XSUzS0MFKH27OLwzBJYpe4jPChCwFhk=;
	b=bmI9ctRLhdADFAfbNkoZJ/kO5suyE/+OkDNJdqKS4DtNruw9hwZgiq7OdzANf7Mt
	H35Nj1KhYF/olhJukRM5oTKPcb9bdKTdUP1/AdM5Vruus0y85yX3sQMX/Ia8Z2Sb0/K
	vx8JB/MEsn89P3ve7KSCUpAmtWxFrJ1qrYOjpJeo=
Received: by mx.zoho.eu with SMTPS id 1773677850331247.88446027781822;
	Mon, 16 Mar 2026 17:17:30 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: kees@kernel.org,
	akpm@linux-foundation.org
Cc: andy@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] lib/string: replace BUG_ON with WARN_ON_ONCE in strlcat
Date: Mon, 16 Mar 2026 16:17:28 +0000
Message-Id: <20260316161728.84485-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

BUG_ON() in a library function is too harsh -- it panics the kernel
when a caller passes a dest string whose length already meets or
exceeds count. This is a caller bug, not a reason to bring down the
entire system.

Replace with WARN_ON_ONCE() and a safe early return. The return value
of count signals truncation to the caller, consistent with strlcat
semantics (return >= count means the output was truncated).

This follows the guidance in include/asm-generic/bug.h which
explicitly discourages BUG_ON: "Don't use BUG() or BUG_ON() unless
there's really no way out."

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/string.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index b632c71df1a5..ae3eb192534d 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -255,8 +255,9 @@ size_t strlcat(char *dest, const char *src, size_t count)
 	size_t len = strlen(src);
 	size_t res = dsize + len;
 
-	/* This would be a bug */
-	BUG_ON(dsize >= count);
+	/* This would be a caller bug */
+	if (WARN_ON_ONCE(dsize >= count))
+		return count;
 
 	dest += dsize;
 	count -= dsize;
-- 
2.34.1

