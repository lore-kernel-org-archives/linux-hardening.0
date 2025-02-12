Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471251EDA22
	for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330525; cv=none; b=FJJcYuwVNRTEDbO+HluwbKzSVAKi+heIjiCXR/0aXpR/VuP9nuRmZ2rXyThPVIame+9jd+qdwtlvoeATgzHUkyEaI5gHhfLNvFdFQWr9yB9CkazuN406unNWBi1nXf+WVbBZ/gBhck472UlZsMAhn/aOSIjWjEmLZgMsw2b72x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330525; c=relaxed/simple;
	bh=PT30LLdMtYpa2VkGGccvOtXA9HUhUF4omPyr+dgwXow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/z7rYw7yGhJzEz2NqZRCUz0zs8k9ttKicNs/wYfhL6Y8o460zoYLRQrDnbJVbTembkhXb7b9zpZsxTEFwvtoPBx3I790CfmSdeu9rLgXeHEO2nhSdKthKdJJdvu+pG5LmPJtXzpMPW3YcGFvT+RhZ5Vybkzi964te9NESrJCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fKW9fDp2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fKW9fDp2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f5015bce7so7983835ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 19:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330523; x=1739935323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlSoQdNptgY7247+UT5J4unGLwbIYWVI4vHulpaAU8w=;
        b=fKW9fDp2tFP/xaBH4j02xTqPENg0CY4C1V9yvjlbf2JfdBiPP4Egi1G/IKpypaxKLn
         jaJiyhvJ/NiT7MUyqWdXIKuODWWjfvj4ZHx4nIrcspQDdNAqCjCfCbnQxyO+qFoHJ+3r
         Gc7JYbGnUCUbrW8xYgwHZJ66xs7dgjcMkNcTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330523; x=1739935323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlSoQdNptgY7247+UT5J4unGLwbIYWVI4vHulpaAU8w=;
        b=VOTGWJeFy5014Rv/My3fI+3QSOjSu/Cd++L1Ni4ppMcX4h4PaJR5QJbbU15EeYj4XQ
         tvrE9wqLHoHRr4dWjtGHW16M+7DNBb/P0YcMdb5os7mFfk7LC5tAnaOQf7bENODqraH6
         kdXgCgn56W9s1JuiWCqaf6giXdvaXPAHtvMccHtxznQvWCSq940ADflX8qDNb4wiLIOO
         AZBVm+Eyw17dgf2LPRSFHGJ32mL0RelLtfGikDJd/ycPAGgovHZaeW7ekNwUy+HIWjwJ
         Y00FbvU7n0QqwWoQo1m8qQhuV6q+pG5FYZQTO3zaksQPZXvvqzbQvbtI9+N41HEY7mMD
         1pLA==
X-Forwarded-Encrypted: i=1; AJvYcCXo7DQsN4M/u6XPjlj8LTj08lfeWlE0RUNpSiNQT4FO1Cgv89y/RkemMQdyOyg15fHYFMH+KQUsS9+5N8GMElU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgOBf+jwkyil8IEWVaKxNlIIWWC8bE4OdeFfp8TDJ+v6Fl0MU9
	7Fdae8ANHSLcjSZ8YUrahm+4ivThCJfZq6dmyVHgFAlrdnoGglZ6uugXZnOAfQ==
X-Gm-Gg: ASbGncszIj2eLnMLZD34stk9X1pCg0ZSiqbu+6wiSF3NcphFy0fBdHIPFErqhjHHJ+C
	OuaMidZGGoA2XAbHlsIAMcfk34QiDP+6NLBcEv+RZ7W2lkP42hoD6s5cGI5pvzlbYsVwe+dHEIp
	wvG/AWQLfjWnJ882wncdd/O3jLqtLqcV58X0vcTZXS1g638FLX1sa20HHWlXNg9BL2bCxvLy8jc
	w1Dvg6CIe8B6X/9GiYF9EN0XFlZ8WEJHfqkzcSMSoHD9PoFzRaNpj54L/zDFHHba3w0LkyC+9zX
	hdeWg6F4jNXfF+DlEgWxdt4fjiWV03eJUn9lbyfn5eTqHO7fwQ==
X-Google-Smtp-Source: AGHT+IHih9DPBHtIxeZtSPdWvKIHKG8FUBtw2uxCsB6lpgOAKvHZ+pA5HJl7oCK9T6pOYiqVU0U5tA==
X-Received: by 2002:a17:903:2bcb:b0:21f:356:758f with SMTP id d9443c01a7336-220bbaae950mr11340995ad.3.1739330523575;
        Tue, 11 Feb 2025 19:22:03 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21faa49249dsm32295415ad.158.2025.02.11.19.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:22:03 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v5 7/7] mseal, system mappings: update mseal.rst
Date: Wed, 12 Feb 2025 03:21:55 +0000
Message-ID: <20250212032155.1276806-8-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212032155.1276806-1-jeffxu@google.com>
References: <20250212032155.1276806-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Update memory sealing documentation to include details about system
mappings.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/mseal.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..1e4c996dfb75 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,11 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- System mappings:
+  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS),
+  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, vvar,
+  uprobes, sigpage, vectors, etc.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
-- 
2.48.1.502.g6dc24dfdaf-goog

