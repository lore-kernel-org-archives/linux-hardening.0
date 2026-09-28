Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86396361DD5
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570723; cv=none; b=pBtsTdEB6xZi8x5C6KSXWKb2lNPxnMjHN7RPoTgpAI5SVC6MsH8KiwOtaKdpdWVqHOBwl0FVajE4Hl34hcrNVcL5o4JjilsJ6TubIBK1HjRfUZtsRI7WleKP+YIbqYvsQOrRmtQ6hWwtu3qHDfHVrmxZx3qEOOGZAyn6DtHjN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570723; c=relaxed/simple;
	bh=ggKlK180/E0rXqdeGU3OKFiV+qqILBEfQhs7E+YVhms=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J7hqHhRIuu7lJ0mbGeA4vq8qu4+AzkFLSPjf+S37WJkDFYZPki3S9dzUCaEH6N6mjsmtZdKTASxJS7ZqUh8ZohGHY1xbxagDmz2HgTkl0UEdlWwkoA8O1H2nlGAQZiFXHvCrdvJfq5rr+DdwG5Py+qTpO87yTXvTKcUSzGh/neA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YgXulh2i; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgXulh2i"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a47617a0b3so339653a91.2
        for <linux-hardening@vger.kernel.org>; Sun, 27 Sep 2026 21:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790570722; x=1791175522; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yzsbKzJOVwGlHF1oMtECAZyIGl7HsuDCUdGO92bcnNw=;
        b=YgXulh2iYgERMMxjTrR0yHksYC+fHlOQxj1sD/yYXnHnGXJGZ4au1UWlmNaTNiBHhv
         x/Itf7f3hryp6G6PFoLFXYx68/8sziwTTcKoH9sryWyM+engHFOvH6sYFfOzMTXwBq50
         6wyRFzst205Avd+rIGvcF/rEP8IgK0HM3eKSbAvj8rGKYerR3K2tBWHifoLuUpOjFqPS
         i1wkqw52TARqlVBapYELIDCwcSRU/8YWIY9O7oYGqGlwvZLIvvBAuUiM7V/pw9+gw7OY
         KShXGINFIo8hNNKqeUkHrd6EeTOPOd6Z5PE2Rp1tIpbDmLPQYELhQmIAclBcb9WNreqw
         Ttmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570722; x=1791175522;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzsbKzJOVwGlHF1oMtECAZyIGl7HsuDCUdGO92bcnNw=;
        b=I7Nae1nEBn2B+D0yJs7lqyFIJAmkJOM9xSepneC9xqeI+D64ne7mkk0RbzZOSXCj2R
         VyoCc77JQlsVu9TSYvrkUuSNh7O649x2wwa/oX/bs4yi+byCe+Ejzik7wgTIK6anVk1G
         yfRlVqBy770ycZZkYmFFSYvrS9YAEbIDuOEw00wfO/1+4ugu8dllNOWAQ2afGLbRGNVG
         b5+fKHp+N3qfL6QJTm+O5aHSqPBztBFg7RQXJlD00CoS3jczKmVyiMgSMgQ07sUlGgDy
         p/yuezzQQtPfBK/Zt+EZadAgq1MxrvpkfC2rzUwrT0KKCjJse+baRtExqi2JyAvcE/LZ
         u2Kg==
X-Forwarded-Encrypted: i=1; AKwUvBw2CPZNZMxVyizoHEd6r4WGMjkwNjsUzpmisMQQ972WGhrNATbOOkLMXcMg7jpZQYmGbheQZ6XAvRoRZ+bxgcg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnvDg/jacozTWar216BGyRqcqm+OqOD9IR9XABGa5GtRfyEVEz
	OajM+W1MftqMvb4cj5myUdFFD40Da+KGJsb4KauIxJTE7GSdukfaosLgMv1synoq5VFcT8t3ai/
	o
X-Received: from pjblx7.prod.google.com ([2002:a17:90b:4b07:b0:3a0:f05d:2b81])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e0f:b0:3a2:b246:be70
 with SMTP id 98e67ed59e1d1-3a2b247915dmr922147a91.22.1790570721493; Sun, 27
 Sep 2026 21:45:21 -0700 (PDT)
Date: Mon, 28 Sep 2026 04:45:13 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928044513.1330392-1-morbo@google.com>
Subject: [PATCH] firmware: cs_dsp: Annotate struct cs_dsp_coeff_ctl with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: Simon Trimmer <simont@opensource.cirrus.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Bill Wendling <morbo@google.com>, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

Annotate the 'cache' pointer member of 'struct cs_dsp_coeff_ctl' with
the '__counted_by_ptr' attribute. This allows the compiler and KASAN
to perform run-time bounds checking on accesses to the 'cache' buffer,
preventing potential out-of-bounds reads or writes.

The 'cache' pointer points to a buffer of size 'len' bytes, allocated
to hold the cached value of a DSP coefficient control. The 'cache' and
'len' are initialized in 'cs_dsp_create_control()'.

Every subsequent access to 'ctl->cache' is strictly validated to
ensure that it lies within the bounds of 'ctl->len'.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/firmware/cirrus/cs_dsp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 4e3baa557068..6aa1e1b2b4a5 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -96,7 +96,7 @@ struct cs_dsp_alg_region {
 struct cs_dsp_coeff_ctl {
 	struct list_head list;
 	struct cs_dsp *dsp;
-	void *cache;
+	void *cache __counted_by_ptr(len);
 	const char *fw_name;
 	/* Subname is needed to match with firmware */
 	const char *subname;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

