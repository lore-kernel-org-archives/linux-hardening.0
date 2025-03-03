Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D71E835C
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978582; cv=none; b=AGwJKJkuDOGWFHp2MLb0NVqD0Af2y5OBMMvPn//m1UoMXg9ZeRf0s/DLgQ0Jym2i6Xt4iKyNCJmsWzZdyRmJG+bVs9Q7EvS5rOCp648UuFWncYIjvAr4+vzYN69jwtkwnvRfrxUYrIYg6I7PmK6c4A8SO20TwY+r9pWEDHKD+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978582; c=relaxed/simple;
	bh=WLzo15XZCOUhn48p1nU5oCESt5AY/XAN1+82zsPI/4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EssG16JPztam5bXTMgGvvcKo7OpXyp7f5Jag2M7F75+X9+Uc8RfR9PtTiiGOjwotbpjxUP9xup5f2yXdSJyjSaW1kV/2+5DV7pXVIp1TUQSJY92lGY9W7YpyzH5TnxC7Zc/mc+L0oZ9mMVjoOB3gWGn4q+SS47wmfFWcX7VCwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=liCFx+bP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="liCFx+bP"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de8e26f69fso914088a12.0
        for <linux-hardening@vger.kernel.org>; Sun, 02 Mar 2025 21:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978579; x=1741583379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYjwm8dHrLXGz6gb7qV5M3QfXuZDejaPJfbAmodOPNU=;
        b=liCFx+bPN8LLL5lhssS5CRtivEw4TPdaaCXsWoGTxBu43/B29kAaBateO593VCtUtQ
         d+idFLivxLJqGtcQFj2gjgwpF9L0KmZa5FNp9m1ySOLicnTz0i3GJNQ4kCE3sQeXa5jp
         1seC5xXl27XTCNdX9/z0V+/qHvEUCL/5M5ySI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978579; x=1741583379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYjwm8dHrLXGz6gb7qV5M3QfXuZDejaPJfbAmodOPNU=;
        b=nlBYKUYwj7oWIFW7xmjVSBfRoirlLdxqbXqpNI31SGuV7VKtSP6R0gJwNiOft1bvr3
         aDf/oHAUT/BvicJzg69wdaUiS+3GDl8eyMO5+gJmLsbl0g75/8YDnejwo7K9ViimF99J
         im/wD/HIyjRSlIwqGnxYUNn8mo7EPeZW/Hi9bAy3QvSyvmISUAcUSoqlm0T7/wsRBeU9
         fhd1utMM+pk8P1myDtgt4+BfMeyq397TsLV3jN54HtHRT0m+ivN9wXshjaEL0xe0RQzw
         DiGBjFdNvG5bKdF9aQVTioWDYd2BLxzygG9E+XDlyE7la9J6IutzPoYqh8lk4kVhL/6C
         gjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhaFDonhQzcJoZ3OQcjTnIAnMCWvpa1uPqtttIspwygoU5pxrnBKx+laXOWzSImmxGXwBwOSn0JOrI1Mm5AmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hkaK5aQMqUtpWTwAr0tspfRXA9Ngs63LQ5P9CW7k0H9UYp5t
	uLf4fA5XSeU0oKRKMaMAlV9+sXQftakaMQw1dr5kPcZtPpeQ0yZK5ntY3hYtdw==
X-Gm-Gg: ASbGncstb8riUV5pXaNqnp/4RJvYU9PaP5aZjbL2mm1EOkxLvToA99YDaKzUDORUl8R
	lbuFO/q3pRP6XGbVrwnp0h1HcpfrfZUHXllOZFnKGnMhtOZZpIsahrrrXDWpz0U46ZCkIzV+696
	LZKhVZey8JrXjwoKi+1Nv5Ni7nV9TTgvAMfNnmEqP6p+vSU4X2W8JR6G0hKRLzj+9Q0ZAzB7m0P
	4xqpGzr9C691TBKzkiCuwWXivDFQvxgfbYOjhdrpUM2w9nkk1C5l/v+Z2HHf9bmfNaEiPy4ujgp
	CCGuB/Oqk6QH318JxnN1BZwarE0u+v+twOMqye1po1P/0dBjvh36wdFyBSqlNvpLQOwSK9YvAlZ
	d
X-Google-Smtp-Source: AGHT+IHtOuKA+9OaPh5jrHwcaVGv4sg/p5d2FB/xdLoG2RY8640XMMB99IsWJcicRocUIUi11DwD4w==
X-Received: by 2002:a05:6402:518b:b0:5e4:d192:86c5 with SMTP id 4fb4d7f45d1cf-5e4d6b85dd2mr4581736a12.9.1740978578724;
        Sun, 02 Mar 2025 21:09:38 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:37 -0800 (PST)
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
	linux-kselftest@vger.kernel.org,
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
Subject: [PATCH v8 5/7] mseal sysmap: uprobe mapping
Date: Mon,  3 Mar 2025 05:09:19 +0000
Message-ID: <20250303050921.3033083-6-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support to mseal the uprobe mapping.

Unlike other system mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime. It could be sealed from creation.

Test was done with perf tool, and observe the uprobe mapping is sealed.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 kernel/events/uprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bf2a87a0a378..98632bc47216 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1683,7 +1683,8 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	}
 
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
+				VM_SEALED_SYSMAP,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
-- 
2.48.1.711.g2feabab25a-goog

