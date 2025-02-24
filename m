Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6620D4FC
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437577; cv=none; b=LkXUSD8GsjWJH09iHaaIstZxKQRqsd+vhiF39GfUUi8T9ZgOyd8EqI3lL0yb4wbd/h6dZ4QUdC2LB7hQt0omE0/EC08Q3X0jxeYlCWKxKK/muQelWq0E6cfb0P/RDqUMX0x9xisD63p4oohcASAInOgHqFnqjw9q9Qbsq1e4XcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437577; c=relaxed/simple;
	bh=wCBUro8X74PEVZGjy8/v6ioiKNk+ksES9zc6oIeICgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9ORhqDeY/O8X4t4VFWksqlPbMgdOQOHsQFyBMM/f4FvT9EjpjDl1kAU6SauehYPofYBAx6FScTYZtJywMuabmECjKxLwHBcY9j3/GnwP3e/W/SWgjDE1YOLUWk5K8ixPURJWaDL14jTswsO+UylWqrNVTWOA5qAx9K71pQ+hVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gdfh3RDM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gdfh3RDM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2217875d103so11454425ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 14:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437574; x=1741042374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC+iCaenVWT1qC+wv1WYjnvGE2KwlNSxR7B2FLEJRHA=;
        b=Gdfh3RDMuL/f58E3rRMPSXDE481hOe7+hkV6sRSuAeK3oTMFbI5ngWeB0Co7L4y5mZ
         aimwR4seqrWPPgUf64FJDsh0aRci5+XZd6w4m1Htz3tCk2PTmH3OXypx/+QMcIaOEoJx
         Xk7S0m+RnbXMHNpt5NjlWW9lvB5bk7VbAa9jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437574; x=1741042374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC+iCaenVWT1qC+wv1WYjnvGE2KwlNSxR7B2FLEJRHA=;
        b=aOq+y9WeK38J98PfK6TP218VjHW371zjUCiHInqLBprkeCQoCuhlF9ws0bbBJj6vY3
         ASVVfUVtI3WhnuQ9v3l74uR9Vvb+IXOKX5Xuz3dAezNzcGG8yRf9OcVd2A2FiMnkgCl+
         /XAPFk8RmF1P/jpSMOKiLWlPwPyvRaHVZsGNyfAB+cX7CshBdyM4QC3sCNu5lUec0XFb
         vNzlKhAnJojR/gNCQs0lq/o9j/oX0jju4ChY7aCt4CAiKP9zFPn1c7WpEAotcRtrk/TJ
         Q4f0mHIaNTwJYasdUIk6PHLURrI9/0GjnZwTVK8LduYDXhpkRCJ2PeY9emB0zN0EKr5o
         pi+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWvjIJq0cPQdp6Umz+KtXpwa/ZgUV95dBvOl/wPkY6t4FRAiq1Wd2FAqhKxdV5wfPjTLxWGa5EYN+uqQpA78k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmn7BhfTtl73Dfe7hdpjRP5SYq6Iq5jR6A1LaaWucvkEFufkue
	6rNo6D21cGaRulnk9v38B66xGZIHRG2lZRcYYxJls7JLtYlp+mffIp6MEercTA==
X-Gm-Gg: ASbGnctgB2lEGLPfZbjMoH04bQCI3dBmllLQy2KLXpAAPzHuX/C2Jwrw9WQXksej6lD
	y34GEjQboLqK7rufw1m2bPdWOegonhF6oUIqe1+qyrdLpfhpOA7oYJ0FfjRr1sXUJk0I0GiNGOA
	mXjh5vBqLTajUUJenp/lqPY5yb8dK10o3gFk73IzGyb31mXSzOrnbc9ZQukfzxZs38JFvNaYwVI
	uMUqk+jT3TO2ALGP7JX5CWHG4Jj/z5xyYZULAFYoCRo2WP9hQKyTh9kcWO2GuaPcBmyQlSki1ex
	pSxzT8x3t/yzBP7SlnVLTJsyx+3DCYq3LwHM0ziKGQpDnPlNs3jN+ds8709b
X-Google-Smtp-Source: AGHT+IFWvMJ1DifgHpp00NgiU+l7P2X3hIfGn/N0QZgxCBlNaoLWIru7jUXTs0mtOdXL84lprXpfPg==
X-Received: by 2002:a05:6a20:3d89:b0:1ee:d621:3c3f with SMTP id adf61e73a8af0-1eef3b1fcddmr10299435637.0.1740437574612;
        Mon, 24 Feb 2025 14:52:54 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aedaa6475dasm110603a12.54.2025.02.24.14.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:54 -0800 (PST)
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
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v7 7/7] mseal, system mappings: update mseal.rst
Date: Mon, 24 Feb 2025 22:52:46 +0000
Message-ID: <20250224225246.3712295-8-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
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
Reviewed-by: Kees Cook <kees@kernel.org>
---
 Documentation/userspace-api/mseal.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..10147281bf2d 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,13 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- System mappings:
+  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS),
+  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, vvar,
+  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, rr are
+  known to relocate or unmap system mapping, therefore this config can't be
+  enabled universally.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
-- 
2.48.1.658.g4767266eb4-goog

