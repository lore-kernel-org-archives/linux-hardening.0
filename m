Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A0399D00
	for <linux-hardening@vger.kernel.org>; Sat,  5 Sep 2026 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636595; cv=none; b=Ta+RE02pUEDpbHOZckf3uu9fuk2QI6F9dpYR6BSjSm1ohSSslFJ9wlhtAtbNP7hUBQkCqVDTP97Tvnqpg22vp9Bs0Jzes5snm9p1T7hWMUgl5NcmA/vCamuVuXrcj/32C/ZBnH59w2XH7ad7TCtzrO6J7C6UBfH3i4Yn9XM0Cb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636595; c=relaxed/simple;
	bh=lVWPvO4U0PzjUNH5kaTEpUlpvE87Z4wloLcJMNvypDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahS8j9clSp336Hc4wSIQVbnYh3dF3fNayhCduLN9uCecF++lyqrBNw4COBX2S7tgOBD3iJfNmbj7oSB50feK8KI2qfzhsloeGZz2RwajSbsomjIC1tWcSj/dCA/n0WK/ExrnjL2QKTrKdN6Io1Yh362o5r9qmzlfeyt0+YqDYUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqmU8tQ4; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqmU8tQ4"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-86c0e4dd49cso26759297b3.3
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636588; x=1789241388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DA+s/QyodZ5LzLfcrOq12dlBnw99myrSQbNtH+UZd9Y=;
        b=NqmU8tQ4PofGq4r5bXhBGRDJU4rBvD4X11KTb9znxIO5OyK6RHTWnkRbScmghawQeg
         pQh3ldPoshfa548E77BhrjCi03B97EdvdRsvzpbTRVx1iFCGHkQcgbQZWzg9Zu5Iw/dt
         DFo9u9xrR5RmtXqtMNYfCF8Z0FoQ0MA4sQw5lOq0+zTzOmi43tGt9zir2TeLqwXnDYsl
         C7Afs/k+TOXQm3qYOjNlbDc4uKtd2yfQrbuvl/8CURRUNE/uwR28MX0O6uhA6noD8sYQ
         I5qvaD+9rJix2E+ih+TL5tguBsNtta6cCwSFMpZIdn9Nh2pPTShAL4BI3Xe4AxMs3H1W
         yxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636588; x=1789241388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DA+s/QyodZ5LzLfcrOq12dlBnw99myrSQbNtH+UZd9Y=;
        b=PIKEjiscVFsHbSBeAw729WraLx673TN+0M5DA/xO0E4JtNzttfxtLEd+9mr5Bqq73M
         GUzXwF9hgqOarOWs5HRQTFFk7P1lSMkj1MwXNlD8RRzjHOYNpEJhb8kJ7kZhuHrsd5bf
         4hDtt4cBh1Huert6tmfCjXe5hPyQncECMA4lw7bZugjZHEInfEWCyMQ1jCxTDQ1A/33S
         a+Bde353OgcHhICjdNxSgk4l6Y1bBvs1uYLRlpRqhOLlqw09aC4M2UUc7NtUTNxAsHpN
         P+52XGkpAqNml+9inPzhnjaM1jxOX6M6s6ofbSZIDencoW5Z+Ocys3SzyqO6Bdvyu9yY
         NsVw==
X-Forwarded-Encrypted: i=1; AKwUvBxgvfaPFQ8Y4Rw0TbJkib7YFDSsA37HqOwPsQSagPn8xaTr0+qBSfaP6sS4RKA9WM/P5RlUczQwZ4bKq0UHMoY=@vger.kernel.org
X-Gm-Message-State: AFuF++n0xGxT6eopOiPg6MC3DE+ID5dOaLdVSfCxzhRR6mruYJMWIVIg
	2PtGTsROJQhNUg/lOFWPW5nhMvFJ7N+52zIpNi/sy+Lkqw4weac0TstQ
X-Gm-Gg: AYBFou0xHqEI+MseTGM0TSdvMzRBKgmn3sd+aipfhJDZzEWXXneVQCFEGAecPPG7g9p
	6OFcq4J+2adexfZw3RGhUifK2eTb70uUBygoSJyEjQhraXkdWsZWt4807VuhbXZ1v0Vq1UySVx8
	aROp6cjzjboP+ol8xJ/R6T70q46TlZlnC7i5/lU7KN9rSKPyKs6Ui6usmwXDy2yAuou7fwvMbxN
	/JmW/YdC3WH+GBJpYUxPG8vqe7Ny0eoCeBOsu3CDv3S+92HPJEVi61LQwtGOPbvd7+GV1Lk7HJz
	U+jyzj2Mn3EiqamZHM6TmeJ9dPdRovjODT2+lZ0pIXaduxGmEB6gkYfnmw99vzZcxeJD2yQadoQ
	qed9TsLHYz8/v4zdwUggFCTk+yODzptcm2ZzVj7lUZGUXKYl/WAUcTlF/goy/SednolG/Ad1hBr
	2rjyoD1UTcCdOman5HfmBPG3lv+HoQT/HgSbgD0KCxJhB1wUB3b+GFbdN07ZpK
X-Received: by 2002:a05:690e:b4c:b0:66f:9cdc:2b09 with SMTP id 956f58d0204a3-66fb5ab575emr4278563d50.47.1788636588384;
        Sat, 05 Sep 2026 12:29:48 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48ee9easm4992431d50.8.2026.09.05.12.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:29:46 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 05 Sep 2026 15:29:31 -0400
Subject: [PATCH v2 10/22] alpha: select
 ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-arch-kconfig-options-v2-v2-10-83e8245761a2@gmail.com>
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Kees Cook <kees@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=lVWPvO4U0PzjUNH5kaTEpUlpvE87Z4wloLcJMNvypDE=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm5E72ChM4a7tjV7n9C2Wll7PuLNjEbPTkS+LHy+In3
 4eFbN20t+MjC4MYF8NMMUWWuPWKLLPadiz1OS39C2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIziIXJ6DBqZxcWlqUW6aQVFDnn5JYklmfl5xXr5Bal5BekFemmZaSUZGflFxalAI/TyUkt
 MXR3djAwNTCwdLcycLBxNTZydnQyd3BwdnV2djCzNTQycLR1NXC3NGbg4BWCuKfdjZNg++Uq7IJ
 +0QtGSyhc3Jn8IOXPqKfsLiYT+L6pr31xpTM1nZJi+2JDPrXXGUavglK1Ja5e3bSgOvlj51OJwW
 NrHa/N5WXkA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Alpha has a clean split between user and kernel address spaces: user
space occupies 0x0000000000000000-0x000003ffffffffff (TASK_SIZE), while
kernel space uses KSEG and vmalloc regions near the top of the 64-bit
address space. These are strictly non-overlapping.

This enables optimizations in BPF and tracing that can skip address
range checks when user and kernel pointers are distinguishable by
address alone.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Matt Turner <mattst88@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 237ef0c214dd..8f97d6e22b28 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -9,6 +9,7 @@ config ALPHA
 	select ARCH_HAS_DMA_OPS if PCI
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_UBSAN
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO

-- 
2.54.0

