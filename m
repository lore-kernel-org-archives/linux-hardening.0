Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448E381B16
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774641466; cv=none; b=f7ON95lJD88YWUr4SILxC9iHIJJAcr2AlquPd2el+BB76fS8Q6o6Zamge1SH1+oPonXFR9JH0xTvrjDu9IxkPstBL2MtDYz3sQYN0oLq21VTo21DoG0p0g+u635TTJEww4Zhob09IBha59dXlegHxAWePALoFKFMoJnhGNSxvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774641466; c=relaxed/simple;
	bh=wz1OGCVcy0nrMSQ5p8MWSwMy2j3Y/e0VxNE08nTwkgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l/VOnWjpUKex/R0cmhMgANhU9mwLW8DXQsVPl0Z+X6Y5nnGmPBdbUBYJXZYOUeMgwsGhTjo/KdLytb1V8oS0GKvO0g/KL/hKNE36X4Nr+UYOyAHd65wtOr+im8vcNJz4tVaS0z9LIcprT2Kndex+2aXC4Yow4pO0uf32Jo2qtg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHOicVq2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHOicVq2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso28126135e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774641463; x=1775246263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFg98qZ3lCCSVt8lr34pw3VzQMgyzjSNpkoFfcv1k64=;
        b=JHOicVq216V8imKWWWXk31m3ubCPVrq5xQ766X8vWash9tf78CgO09vC5Xnwv7di4+
         6nAY2dEIAP2J5kQbmfzESTT6oyZEZKoBi2tvyHzCjpjrP7PlZPeM60RIm+puJMt/nmxE
         /N3G+Ogdjy8Zw2SgN6GQOO2hJYbeu42VCyPOh3cjNJxqvh9dVD28bCfSEKsC0lFatTj7
         82niPltrBBE3J/ihlgwPYseGtJJMt/iKdplmwGzkiLrxcb06mI/0wYDK1meTDL3GyD8b
         ybfwvaljHWqCfn5lTWqO5TufoCiGQM3HzOlDo6FmBLAzp3pANJwtZn+6vdUQrXpjbhHD
         KFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774641463; x=1775246263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFg98qZ3lCCSVt8lr34pw3VzQMgyzjSNpkoFfcv1k64=;
        b=U8neboiQrHB3mIZq3vFGxr0jfzFjVP06zWm7L2qb7Lk8WEKE3Vg4V8BofyNeXTkNXT
         XxLsZTn2QgWTzGnik5oOPWsW6LQE5bwj2J23UIZ8ecZzNsFMYS59jNGAYUJHHRn1BgtW
         WK7PXMUwW2T1QvIj0y1a4Uq18twKi/mooT0rfyb58/isV15v66UbBKO20ibjOqMBWtBl
         p3PbPNlTlUw5BhXHezgHI3n1coEV03HefQpvEOygTPZbXLQzufHqypq0BB5/wRLIQDsN
         IBhsZQZDu/wUAVkAnEOZCSu7XBxYmX5kuTILRBeM7l2Wu2Tdwy0cIrlOwqo1U0R7mrP0
         wJCw==
X-Forwarded-Encrypted: i=1; AJvYcCXYzx+pK86SVGcLj6KsAtXQfXEBPu+nS0UunX0MBVWCaFAwpVKMTfvwGdJ+7l+bJ0pq3/MqSb2qNh9hD574YbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzFZF0TGqHu3iSBjJ46E5Qr++u4OUJeoqcENW2YLrWbEeBRzf
	ZvqxWX53hbSakkN9+d9uFMTV2Eo6pkNt/5sfTR/dAeYG1ec3j1jbeVeT
X-Gm-Gg: ATEYQzzRcDP7jj5duKHWf3VW8QsAitbNnbDyUi9Gk71azOos/9+cFAKmdOa6iQ9Qqs4
	JwtJ/JPB6mwf1ak85ZNddeE44ICQAAuk5lQVKGsihwmcZtxpkRvR1bloUx5+VYXFmfb3DgLrpOm
	SWQkoKLMIPHAJQ5ul5OykfeiO9BMOy5vZ81XxipK/f8uK8XJHGjrOovoQFF8qPl5p1vRta1ki5X
	vxst8SuZz7NeWJxG7v0rHuT+7gDV3o4KJrhqajFuL/eouzQa94Y+Y512ZmjoZbkycMgGnCQll1+
	Uw9dwaFhVQr8Xy0kjfWBHJU6/46MwmYLBy6epSPgm/Z1P4wbXlWOpiGEMYyYjzyqeojosxV9wUH
	tuqQQrf7M5dk1sdwhCCA4DKAzgyQ1vT6HJDMqqbaPRaOc2d6LsCaq68kxPkHb8kGZBF6pZEacjw
	86+fm68XDNuoMDdNmo3o9EgqaQ+qd94VYwTNESyVYF4GQuwI251xpE1QGbrMARtYbKVkxvsf72O
	VvzR0McLx9u
X-Received: by 2002:a05:600c:1d15:b0:483:703e:4ad9 with SMTP id 5b1f17b1804b1-48727ee9b10mr63168225e9.19.1774641463293;
        Fri, 27 Mar 2026 12:57:43 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487306acb47sm3065875e9.15.2026.03.27.12.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:57:43 -0700 (PDT)
From: david.laight.linux@gmail.com
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] string: Optimise strlen()
Date: Fri, 27 Mar 2026 19:57:37 +0000
Message-Id: <20260327195737.89537-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Unrolling the loop once significantly improves performance on some CPU.
Userspace testing on a Zen-5 shows it runs at two bytes/clock rather than
one byte/clock with only a marginal additional overhead.

Using 'byte masking' is faster for longer strings - the break-even point
is around 56 bytes on the same Zen-5 (there is much larger overhead, then
it runs at 16 bytes in 3 clocks).
But the majority of kernel calls won't be near that length.
There will also be extra overhead for big-endian systems and those
without a fast ffs().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

For reference 'rep scasb' comes in at 150 + 3 per byte on Zen-5.

I've not tested any Intel CPU, I don't think they can run a
'1 clock loop' but the change might improve performance from
2 clocks/byte to 1 clock/byte.
I can test Intel up to i7-7xxx but don't have any older AMD CPU
or any other architecutes (apart from a pi-5).

Other architectures may well see an improvement.
If only because of a reduced number of taken branches.

I did notice that arm64 uses a very large asm block that is clearly
optimised for very long strings - I suspect the C version will be
faster in the kernel.

 lib/string.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index b632c71df1a5..31de9aa86409 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -415,11 +415,13 @@ EXPORT_SYMBOL(strnchr);
 #ifndef __HAVE_ARCH_STRLEN
 size_t strlen(const char *s)
 {
-	const char *sc;
+	size_t len;
 
-	for (sc = s; *sc != '\0'; ++sc)
-		/* nothing */;
-	return sc - s;
+	for (len = 0; likely(s[len]); len += 2) {
+		if (!s[len + 1])
+			return len + 1;
+	}
+	return len;
 }
 EXPORT_SYMBOL(strlen);
 #endif
-- 
2.39.5

