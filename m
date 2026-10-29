Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254050;
	b=wLfcZUxEZTyoeqksayIawAHNyGSco0zPAJQdfaTEpJYzM95ygOb3gy6op0uTDZzlEddi
	 y627F7rUkjHx5HYvxrCLfY2RFHkNzoPfUCwhUAvCwOer0wRrmkzZHfhqZUEjGgRKIFkOn
	 MTirnMMQHQgbPbXnu+thC3UWhhsZJhJjpfqp38dFtIZe/N5juWfAt+LbMSrykW+fMGJrL
	 R8Brb2Rso5z/JVzOWMqYajWY2+zATdtlfQwdiSij32JEFV4WaD6CRlsHRG7WrKDCXoZY7
	 HR0vaXPqngJQwyirCNohwGeAYyu7JbA5kkVq9JWn8sR/Xceck7ctPfOZD6lGgXwxKDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=hEvr/hVOQ19MxZAsJUGrC+tPSerEFjUvPXYsJLofEYw=;
	b=WQwftfw4B9It0cURChEkN1gay0SdeHKDpfM4mXGMMbyi+RhIuTApYcFNGo9zx3xVp3MU
	 cn3Ws8TOIw4rJA4fQ0/vpyHY0nPKNxAjatMfRSzGkoJ6nt5iKRMFgOd3h3qVVU3jZHfjv
	 H/yNAoKMXMVK9F3KSK52QBXTQVOM2BhfyqIRskT2e56bSFx5il/MyClwooAyoeyHxheLq
	 TlW/pGYmnjor2Zpde7errFED8DhEav5liJsa2uimHnSS/HhOYElkd/Tj1LUf7NN78FhlN
	 VwFd4cFOstSKYHclW9wiWWd2v2z2fJP6SfFjgwlkohgcSkyamKvM2TTeEGRhmeBZljA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=wKCE9Rr2;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC26606A31D
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 06:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC26606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=wKCE9Rr2
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e5fb79ce82so10999395ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793254049; x=1793858849; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hEvr/hVOQ19MxZAsJUGrC+tPSerEFjUvPXYsJLofEYw=;
        b=wKCE9Rr2pHlg9Iej+EfB+fHQaFD30y8Iu8WDDxhTeJdE6aGYQr15Q+KLHymc6gwlN6
         vnUYvr5t+AMhOlR3QljtofN6FTegQofX5SyEouR6+99oQOyuIqA9sl/VpQcNHMItuuP5
         mT9VUR9wnudDopJMD8QrpR63eOQSWHSbUp90w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254049; x=1793858849;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hEvr/hVOQ19MxZAsJUGrC+tPSerEFjUvPXYsJLofEYw=;
        b=nQ/vNlOIIbLEm6lquTlg2yit/nDwPif29HyCWHLsTqUrA/v5HbME8xA8gZiu41Xbrx
         Xjwo9f4N24Fex5JV6A9RyBJrynFAKtGQPHXRd+UgdU8fUoKHY6WDGHOI257RnzIWHqNe
         O+UpTwUcgw7W1IOa9cwWZbrmnD55xrVW3WvvwvkG+ykHo7XNR/sFW+5oJf8oWx1TAmVi
         iXxoBtQsrZ+tHCBJYwM30Q6W+VzFON780pNyYpUm/rNxRQArINfKnbplLGli6USc1yhx
         NOoSb/KyBHfgVc7W5BjntuD/mOZvvfUUdvUN/3PGE2bqVte6xTGeaCF5iYqAUAyXTXqo
         AxiA==
X-Forwarded-Encrypted: i=1; AKwUvBw1p/Q0gDHukOT29MUWvnRKSkUqQWg7ctQ35Vbd5PS32n4pHNTY2qgW7034q8Bb9BMsqLUBr1WzNsOpflgPBvA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxWyZStxyOVKLibVv4Zy/960XfFv+1Y3UUE4pEtTZm84msaadm
	lhEBwc+KHF7WYMplYLklgQVLa5anIPh+fhTJB6cu4WZmoVkFH3WJ1LK/qtuh2ti+Vl4=
X-Gm-Gg: AYBFou0su7QCpJxr/QqGvCaweDB57XvCTXZI08n2obLd7wtQIrfxQZGctBjK1aaRG1v
	YdyDDBaaj4FVe0Vaql2BljJo/WDw/71NHywvBNu4cqwQL9s8q2vfWKl55n//tT4kuzeUDSUlqq2
	LdoUqkF76mI7TBEJXYF96vPXIDK1UjDldk3s30fcBTYM/Vipi6iVyo7M/YxuHatPqJcuvTIdPao
	+Hy393uTWOtxhUfpnQ8To8hAGiuy59O3K9diHDDMW+00ELFqGBat/r6aiZnBalk8eWEgVwKqzyh
	a4IVLeouRjHJSi1jBBZO/GwjMg9FN/+2oU0pgTX6quNqlihl6m1h8eVXZeJedyU9i4fHfDJkUk/
	7+TzEMkMzinv3UfJst8SRsErKXPhMyTpNPY6p9rCsDlIOB55LxoewNFr2JRbYEaLD4g/QVXlXM0
	/rAT20BfqHgBd9WUn38Yp0e2pV+OeGgPaevgkaoq3u/6kSXdobZFqv9UTaxuNQimfvUhktJ5/uT
	skf24o7hmLHhG+B7rwq1lSfdEqtNUjYCMuXDstjZxkhN1kosT42EKyBFX29t2XMl1OOWQUi9SLr
	j+c70GnNDeg6zJlL0BK4DsyjtNWpxHZJ6YL0Frz9BO3kfUSCpCJfZjHUwUhN1dNlac9HVPa36/1
	Q9JqVnDT4BDe9LIuK83MKpLZ/y61dP9SZnGD/LNJbZCDkVRJEcj5Cv/pzGawmIaMgWXggnS0C
X-Received: by 2002:a17:902:e545:b0:2e8:2d05:9780 with SMTP id d9443c01a7336-2eb0005dca5mr43806985ad.8.1793254049153;
        Wed, 28 Oct 2026 23:07:29 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b79ce2sm28521545ad.21.2026.10.28.23.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:07:28 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:07:22 +0800
From: Chris Down <chris@chrisdown.name>
To: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 1/6] mm/slab: Enable SLAB_FREELIST_HARDENED by default
Message-ID: <2ba9dc862607d70050bbc86fce0091de2e23c023.1793253633.git.chris@chrisdown.name>
References: <cover.1793253633.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793253633.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

SLAB_FREELIST_HARDENED obfuscates the free pointers stored in free
objects, and catches naive double frees and frees to the wrong cache.
Most distros already enable it, and with sheaves its cost is small,
since the per-cpu fast paths don't touch freelists. Measurements also
show this quite clearly [1][2].

So let's just enable it by default. SLAB_BUCKETS defaults to
SLAB_FREELIST_HARDENED, so it's now enabled by default too.

Link: https://lore.kernel.org/all/auITixAJMfLtfa7i@chrisdown.name/ [1]
Link: https://lore.kernel.org/all/179312451613.474906.1475329637924619088@kernel.org/ [2]
Suggested-by: Vlastimil Babka <vbabka@kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 604c58199acb..17d017e8fbef 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -208,6 +208,7 @@ config SLAB_FREELIST_RANDOM
 config SLAB_FREELIST_HARDENED
 	bool "Harden slab freelist metadata"
 	depends on !SLUB_TINY
+	default y
 	help
 	  Many kernel heap attacks try to target slab cache metadata and
 	  other infrastructure. This options makes minor performance
-- 
2.54.0

