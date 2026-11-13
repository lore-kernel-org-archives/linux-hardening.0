Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559890;
	b=JXp5v/sm6AVksnKX3O5sTaPqbKdSzl3V+kuG4zaUiImjlZo48DuuIhV1ysz9CklV61sl
	 NKZmnxfP1pyALewrRdWiR+3BI2jSQNVm1N3Igs0ROzxC7cAdwGzB9cQplPJbPg2zelqcx
	 273XJbWriO7Fxc7yf13y2HNzs6X/pkKAbLrXAS60IPJdEyBc/IZBzZZuT/sp6PG75kxyO
	 H4GQGmfnHaoSoyb5sEQwPE15vm//HT6xzakXKIu5Kg8uXeLJ22qGdKKPQC0+EkbHjxeoc
	 ig0YcBDqXRpI2YdcTHqSOxaoyqCB63D4rpWnHl86Q3VxF7r4qscBk2QZuZFJnfLpZjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:In-Reply-To:References:From:Subject:To:Cc:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=Md769LsMtNFDtvpBg7Ba+68YL18ytLzyTSc3mrMJ/dI=;
	b=MmydgXqt+bRXJNOPueSBRVyjDTWGFW95wn6pAH9EdVpR1AawQzMrWP/BI1G3fBqxefmb
	 ckKfWdizPJaimkB1hY0PGj0yvNb94FiLaOQBudwu6Cv2UrAQJmzlExIvoEH+4xO59P/UH
	 uKOpeKOd0e7xQputFlxOPpWwaQ9hd5ONVoefq6fmuFSeV+I1nLPEYL99c+oxcQyc3L/J2
	 OFmFyvQbb32Kn/OjUCyVXwO/rV48cwaSuukMf+OMvVVg8gI1SyxHKiZxkF0ro10HVo4fd
	 Gu+CoYirv5FL1hyeKZwrSqW06fC3M/4fTmkxtS9gJrnBUmMYcEABIE7m6ndK3KAIktQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=dKyQHG7e;
	arc=none smtp.remote-ip=74.125.227.128
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98042606C1AD
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98042606C1AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=dKyQHG7e
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2ed216ed287so5576735ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559889; x=1795164689; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Md769LsMtNFDtvpBg7Ba+68YL18ytLzyTSc3mrMJ/dI=;
        b=dKyQHG7e36AfbdbP3xWgJ1T5mk3j1Zz7afAQdAkLhfmZUq6skcehaz3NG/QsgoHZpD
         G3hgalq5PQ9o0enPeskHgm3mVr1BKg4vjLcFE+/274UmQqoqzmgznMEAzLxTMwGIHRYh
         FvXiP6mXLB9oKFlqpSVIBLLE/Xhui0UbSyNXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559889; x=1795164689;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Md769LsMtNFDtvpBg7Ba+68YL18ytLzyTSc3mrMJ/dI=;
        b=ohhrRCq72Fo6GH7m1yNjz1EHRa+PTjZdKGT7jsaU6/pszTBdMMksZkxRWtXszvtvVQ
         8Nfgr4ZuTUJcxnEtA95cYPqxlD5qE5FZU5+07vCvYUI+qphGJ5QLfBI6EXSOoy278D0c
         PWMFGB8PtWr44ba0yitn8y2BPCUGgR3UPr5WkW2hNZwHZdjgJfYGrsW5zw9v5O1V5wP1
         CMKkN/busfLEpa6gag1Sado8VjLv62iuIBtmODUDthc8q8m66442x8m9PnYNpskSzk3u
         t2Faa0oUJnH7kuRA0YkQm2QAI/JTJcwWKTqMUcT+9+GVbNmJEk8VPrlwlvYTCpZKwVxd
         cxcw==
X-Forwarded-Encrypted: i=1; AL+hErE3SGqkxr6jNjpp6jDMisGeEZdJ9pNVgP8HwkwkrWhnoka3ka6ZjWJrffc2km2T7D3LSza+stcRPa5qIicYxak=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lhHNF0LTkUfA9scMdjc+8DGZZVUITt4/vD5IJZcVDwMPSEed2
	6UxD3tgzdjkyIP1AHH+yvz09CT9xjJ9b99LpU4fs65Asf3WFQmmx8Q7wcbbwoJnFKDM=
X-Gm-Gg: AYBFou1yMyIMIlPGWHN2gRv4Z21t9b9MZMKIq0buSi74DTuxA9QSEH29xAFHk3sk3u3
	o6GQ4j+cS1QsIlRmuo20r0u+8HAektjnKSwdA0fvHbKb3r6VOx0aC6UkbCCNlk0yWNODCo1u5po
	jfzgvaRoNUp1NsX+KiGJbZj1PLjj8q8Z1TfUz8wVh1YeEtEN8bt29HP8Bmu7sNVkYfaiB7FX3fI
	PIB24O+z4rCMWxGYIhomXnU75uvKyhfS6UKZQmCLZmEWCKe9l61DpPP0fjJ13xzLwAnC9efHspQ
	/zaI4/Ae9fxcwnp3rXPwR5wl1wXDPF754Uii8WXmQ+oKHjhq+5N6tnpBmo5Qx2e5XWqRdHwJASk
	M0zGtD6qjjNpoEuNs/SnWEc6m634QrP3GrRHDJd3X782FUUqhaX7UagLvX5sK/XK8xI6A85+9Nd
	jYulxxMYT5Ufc1kUE+F7w3jnYbmLUJ2zKGQec9K0u8MvOTs7vJ2CPTetHP2phfelFhqKcbgvzq0
	ynfHXdMR3B38aZVndH+x3Z0hmwoupIskQjDU3SJIMsZeJhaLgoSzNdLqAeJ9915U170o8tOn7WT
	g4bSgaxNemmS5eC4y1RbGGKmzvN824JubwvqfggzPlPpbjIZu+ll2+z/7o5nDdQpAfexd9RqLiP
	ot5GlMEYFYUnYNu8byun4yzqGgt9rnYGJpT+IdrgHHNd8mdboe/jToqigMkFv8jx3x7SwhwN0/t
	JUvzM1WPfoAEyGP7AAi1yB1gRRLOQeb5EykVcu42gCrmCucvzWucWnf/MG/Bw=
X-Received: by 2002:a17:902:c945:b0:2e8:8637:5e3 with SMTP id d9443c01a7336-2ee0daf1004mr19821485ad.34.1794559888836;
        Fri, 13 Nov 2026 00:51:28 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee1c4d802csm2287965ad.37.2026.11.13.00.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:51:27 -0800 (PST)
Date: Fri, 13 Nov 2026 00:51:25 -0800
Message-ID: <25b5bf9a7ef115709f1149044824576e6f71e71c.1794506262.git.chris@chrisdown.name>
In-Reply-To: <cover.1794506262.git.chris@chrisdown.name>
References: <cover.1794506262.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v3 1/6] mm/slab: Enable SLAB_FREELIST_HARDENED by default
To: Vlastimil Babka <vbabka@kernel.org>,
    Harry Yoo <harry@kernel.org>,
    Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>,
    Christoph Lameter <cl@gentwo.org>,
    David Rientjes <rientjes@google.com>,
    Roman Gushchin <roman.gushchin@linux.dev>,
    Kees Cook <kees@kernel.org>,
    Marco Elver <elver@google.com>,
    GONG Ruiqi <gongruiqi@huaweicloud.com>,
    Jonathan Corbet <corbet@lwn.net>,
    linux-mm@kvack.org,
    linux-hardening@vger.kernel.org,
    linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    kernel-team@meta.com
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
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

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
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index afff1b25b543..f330c2c29fd2 100644
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
2.56.1

