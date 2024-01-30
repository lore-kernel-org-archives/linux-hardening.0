Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E27EEE4
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jan 2024 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658407; cv=none; b=eikKz5xpM3g+OqwzAoiSHOIrScpMyRnilToovA30/Rx519w/GxPYCD6Y4uh6kSiowSxW1TsutsoEoCoRd2vBveYZBe2+f5nXYfX4mI4FgvYUeyv2LnVOn/ij5q2bKmWiwd2bHkQW+jwFJMRJD5+KRm/eEzAaq2V7+v77tKyYgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658407; c=relaxed/simple;
	bh=68pp+GjivYN0ZDvqRA2BWkCDKfiI7nbctLbvssX4onk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I6htjO2R7b4YP1eswSOgAcFVbZgin3EfZ0gmKH0lWN3RTifYVls9iXOSyKiMmGucX3Eu4/RUOSBHNWukZTrtlvhANphgkWlLqmQ3bD9o28UzycRDBGXEv8xAQ/yVodx1u9RDJ527BPXUw79ZBY0Ea/tY3BJ2NCOiVpt5pJxiYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l7bWW7QN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l7bWW7QN"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d835c7956bso2630332a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jan 2024 15:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706658405; x=1707263205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6dNi4ZZhxefZTJrzdX9j8FgM2+qSITZYhekp3JVyww=;
        b=l7bWW7QNaZbKSnHMxb3SRJoePptS7kIqcyEHNMxebA5W1D9u5oAeiLPlS4Z84H9pql
         50GunHeximOInWZGJMu1KhQqLcUeAOfe2eTKoWGz0Iv0jz3DVm+PcX80wY8WjgIAUyjg
         FljoI0ZOLUHDEFksmOsVnIY11MBJcvqy/6dG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706658405; x=1707263205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6dNi4ZZhxefZTJrzdX9j8FgM2+qSITZYhekp3JVyww=;
        b=aDaa2VaFBAbGGpVYwj0a28kDva9g5UkyV8tqms4gIwXj+mkKr34IzE/Dx94N32CAYD
         B3B+dDPihQG+j2zfS9/jO0BDmYRTQbW8cpX7cr6oK3mEBt+g6Q4KZx+8S+7hNn2xUT+y
         Ue6nUM/WMGyb5+TElOGVjidNqIaB6drrdWKE3R4CLYuSLnhWCcgcF5SCRq4oh53Y+2fd
         pIF1sQ4nhwo8Dz5G4ggBf3VtVZvyM9u0zj84wr6ZgkOMIYPDlUSMlULclAgtfcsFpcHF
         rBq576ItTBrranUcb78VeJvO4NGues3hI0xeabP5kSbb9GxS4BlJ9N4/7Vm0Haw+wYkZ
         jSUA==
X-Gm-Message-State: AOJu0Yx6gLXMy7sKGDJNxVZQIfQtYBOZJNI22iZ29/vM7Oyv8ljVOXJB
	q/wXsMNsWYH6dd5js8DunnRi9iseOosPkK4VEe7iaDGxR0jBzHjCJT6+Q05A4/8ADcq/V6tiMio
	=
X-Google-Smtp-Source: AGHT+IECiUBdAXx6uX737GtDcfxzmXiOoGekoM1cWUztcgAOZtRqc9zKwX9nVtW1sl89aj/+V2VkgA==
X-Received: by 2002:a05:6a20:d90f:b0:19c:a7c0:acd8 with SMTP id jd15-20020a056a20d90f00b0019ca7c0acd8mr5712030pzb.0.1706658405559;
        Tue, 30 Jan 2024 15:46:45 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kb3-20020a170903338300b001d8d582e742sm4826598plb.270.2024.01.30.15.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:46:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add UBSAN section
Date: Tue, 30 Jan 2024 15:46:38 -0800
Message-Id: <20240130234634.work.003-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=keescook@chromium.org;
 h=from:subject:message-id; bh=68pp+GjivYN0ZDvqRA2BWkCDKfiI7nbctLbvssX4onk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluYpe0pYVP/k1qBXWc001Sr4f6y7zpV8AJRx5V
 3h1clm6XbiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbmKXgAKCRCJcvTf3G3A
 JsQWD/9dvh+IvK+6XtlrUxrtP5yabcyFzOeGlLGsWlbRR9Tevf42eZXseJEuecZkwp4PmAG64NP
 0lUu/GuIrruyk/7ErOO0ywJ4k5zJ+iw+XjY3sthA3VwvXhqFVFAtG/XZaOcVmA8mrZxn0aj9Wi4
 ad8qTa1dkm4oAixjtDAKNCTFggpkWrpewVQ0az6wp42bPetMxjN/oF00jSUI1fE6VBtm9yuO/5J
 wItOaMAHtE3EImiad7JWvw4OXhQbr08V+UAyvm/pu2wcCLfclxXf7U5yRhbD/9rsueyJuz2AyWQ
 qGfZ+VXI1XBIdhv9Th246VD6hnwe9+OalKWWm3TIV2Gw9pB4pJYEKoo0BIk7xZiLoRhTEPOhG+b
 rR2Xp1tnu59m3q5MiRukyvJ7r4rHfvLxzMQ9w5FOH2ue1meSzoWRutxk3kpe3p/xIGaAUEjxEOM
 o+mbyoHmRLCREEL7higvMaJmMwVzytm+O7VJlVFrGX909SmB7jneBzHf2NF15uMenN8ubmsqfEn
 DLApXDgpO4zeRnM6JbSFt6gHgox3jZPehn2O/ODUh5fyFqYEYNEEI5NryPaamWmAT3cNDfueD6Y
 zBnBjXImOW1Bv9C5TUslQr6J82ZzDHAsrarkXDQkEPVDtlZWOFd6zgGKVVat6LdsdfKJ/oadCRq
 eOAGKJV QIUdrUgw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The kernel hardening efforts have continued to depend more and more
heavily on UBSAN, so make an actual MAINTAINERS entry for it.

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Hi! I figured since I've been carrying UBSAN changes more and more lately,
I would just make an actual entry in MAINTAINERS. Are you all interested
in being listed as reviewers? Or would you want to be M: instead?
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..19b8802b2f12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22471,6 +22471,22 @@ F:	Documentation/block/ublk.rst
 F:	drivers/block/ublk_drv.c
 F:	include/uapi/linux/ublk_cmd.h
 
+UBSAN
+M:	Kees Cook <keescook@chromium.org>
+R:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
+R:	Marco Elver <elver@google.com>
+R:	Andrey Konovalov <andreyknvl@gmail.com>
+L:	linux-hardening@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
+F:	Documentation/dev-tools/ubsan.rst
+F:	include/linux/ubsan.h
+F:	lib/Kconfig.ubsan
+F:	lib/test_ubsan.c
+F:	lib/ubsan.c
+F:	scripts/Makefile.ubsan
+K:	\bARCH_HAS_UBSAN\b
+
 UCLINUX (M68KNOMMU AND COLDFIRE)
 M:	Greg Ungerer <gerg@linux-m68k.org>
 L:	linux-m68k@lists.linux-m68k.org
-- 
2.34.1

