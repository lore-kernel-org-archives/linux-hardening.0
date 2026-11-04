Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773506;
	b=wm/1yBbcxb7NM3lRDolEovCV51e/6GcNMNSf+D5BlQDX3ZrZsYysaL1wMEJ5bFtffYOf
	 MSbT9cOqlJ9U63XRzUyq3/jIR7EZstdpI9YTy+lf7HtF07YRoSFTRTURXrCAGvPaA+DyT
	 isj4IqUolpYnspp43TUvLwnTLR/+L2t5qSzZ9fuXS4EuuJO1Z64Mdns/xc5oI+v+Z5UqI
	 cSFd/Jdfyz5mF63tCYicdEP9VqchfYJjUN3jzd8XTUe3ylfcvFXhiJJclbePxvb9zjgg1
	 KuxdJhR0yHJjcqh4I9bIVhEa4mWodAhMtKvqxgK/CjJgXJKMObdxXuVTIzHj956ELdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6aqflyyGibB6JpqtJHNzZdrDhDz9SBMlPar0zuxq8rw=;
	b=nUvyvo0UYUp9SfU/C1ZQbgQHGCUTVvDhvXcdIVwYm0S7URBTDeL7b8hK4L7fGB/jTOW1
	 3dhVsi7GfE5oTO/8+Y+JlwMBgoSpfiSjgKqU9GPR/9sJ7YGrdxDVsWY046JmOaNRhq2Ri
	 0bEsZC13k0HnAJ/JX8gxDM8PMPzwBcPIrJhwvkxXM/Mfd/0hINIRQFzdef5H8m8iPDXIM
	 YDFzft8YuFwovXiDSOaSBvSHa96EoF5z4nvpSzK6E98A+IqcMH8u6SvhfC4objbe+gJrT
	 v6oEK3kH2irLSQXLrxC2SZX1+UbrJRC6CXbBlvwd1IcSAss7w4Zr6RCimG0dp4D5SfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+2n7Ak7;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB987606A328
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 06:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB987606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+2n7Ak7
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14fc585291cso367807c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 22:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773505; x=1794378305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6aqflyyGibB6JpqtJHNzZdrDhDz9SBMlPar0zuxq8rw=;
        b=S+2n7Ak7tV2EJGZD2ZPpD4lN8xiJfS5kAxeubkDJcpbqw0AFxfAIHpdR5fzsjv0cs+
         i7CUhFQj9ik/a1NcJEP7H7+kR850mD41LPurwO/jH89nmuJG7G70LvXom89npCcGEVSh
         OmqyEQlukw+KPed/wEqrj81aVM4OJ395XPiAEPbGdHJ+lkBD0hRXCJRYqH768oXOG0GC
         RTAuwLizS6+M6y7QISup/pRQqhcoY94bFwFqK/Bi88ygcaaBhs6W7YTmGK+O7TXVkX5s
         59g8jINCi9yykjdI/DwtgU3LbHPEyEuwGY9w4ZDOVb3VyLTr04NmyIGZ/ykzQBSKBV+r
         MYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773505; x=1794378305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6aqflyyGibB6JpqtJHNzZdrDhDz9SBMlPar0zuxq8rw=;
        b=vvSfYIRe6r94zjy019VJOdoVmTRt/cKyCBGJI2EFvEJZDYX1DXvYBYOv/CV0U6uv1c
         gzqV5Xsb0bDh2XYpGMbwjaIFFCpqJI/8cIq1PzbWVVDA3ezBNxLAU9ZYprRCNAk22MVQ
         HXeRtiWkzx43qzf+bL1CNIFBRmElT5qhKvYjTK9zIlp92k+3tmtck7h48NBWy3oW75xY
         QeRUOB8hVFwWg+O+Kbmte+1QRXYnclOrE4mxTHvyk3aswPuaqBdn1NA14x/ykUybs2z1
         9CLe3bCtuCcNRhKc9g1kUF7DDOgEk9Gji0W2K9mt4bgu/e5CkRO/rjQpmCPE/GRQCP/R
         R+0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxwTj6gALKIkrRUUEIk6fdu2gMyhVoOFdr+Be9kJJ5jmMmiJuQ1Q86nn/Ncz6qzS0caTQ5bB4a8U7NqyBM5RZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Gc5sLpWYqMQ93szKH1g/m6u+AywOtonUh1HrRN3jMw1+ugC4j
	0jt6joVuCblfhEom3QULwu4LBQnY5UTim8FkwUGlUF579fSt0DK7PiQn
X-Gm-Gg: AYBFou0P85jWYi6BBKbqgTFpZrNrEfdoQyVogqSnoUcu++HUygJj9OLFFXORyMVRlRF
	s6il/H878qRF3ldmXmcRUWllE1HOYw4AxLUc8YlEd80BPvbgLTll2w596WwrEhNDpF8YZUaCy3C
	Lhgcn/t1BDCIdgfOX/91dCiq63NHQLjGvjKRmIQgbHncIT3v8U+x5NbSFcMAJmzoTy0uKVeYlux
	Dq7qYaKTkey9PC6p28AFJM/1W3gLVVFNCdcdwPy6U+TdiT7+wZnPIp/d9VCmXj7pa8VJDJKb4hc
	OprZ9CQ8bf6cfYVKKLrkQcR59P/mto/CIU6pSjw7Y1pRG/2msqYcvR8JuUMeQ4yb+eErWEMOJXc
	QgYW4Tlp+jERys1UhjUAr582Km1iKQBnr14R2DaJ8XNpzZrdxliVRXcF9lLgCxX6ZD22FyjR+io
	lQF2XQ8UNGR9ADszUcxJ6d9KO3y7Gg7t0B9EtYmYbLXAoTYetCI5ezkHfRQPFLcm8nhbxfdOLjU
	fVKn0QcD95KyHyqudkKjW+rDDg3F01hsRXQ2ouUmyuGGi8MepzLEGyaDQ/8eZAbpxdGF+N6kU28
	FsnGazCWvL2BNMBT3c3Mw1fz0hL+9Srj7oxVpGBV6FwqQ8pdwFlOHanQUm1uV6ohlErYmaeI85X
	+6XJs
X-Received: by 2002:a05:7022:5e09:b0:1a4:3169:cb with SMTP id a92af1059eb24-1ac5cfe5610mr20134833c88.17.1793773504605;
        Tue, 03 Nov 2026 22:25:04 -0800 (PST)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:37bc:b892:b6fa:fd6e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm5615163eec.27.2026.11.03.22.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:25:03 -0800 (PST)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	justinstitt@google.com,
	morbo@google.com,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Date: Tue,  3 Nov 2026 22:23:18 -0800
Message-ID: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for removing the deprecated strlcat() API[1], use
strscpy() to initialize the mouse device name.

The destination is zero-initialized, and the constant string fits
within the buffer. Since the return value is unused, this preserves
the existing behavior.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
 drivers/input/mouse/vsxxxaa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
index 042a17fe81db..b3a0d7ff5738 100644
--- a/drivers/input/mouse/vsxxxaa.c
+++ b/drivers/input/mouse/vsxxxaa.c
@@ -463,8 +463,8 @@ static int vsxxxaa_connect(struct serio *serio, struct serio_driver *drv)
 
 	mouse->dev = input_dev;
 	mouse->serio = serio;
-	strlcat(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
-		 sizeof(mouse->name));
+	strscpy(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
+		sizeof(mouse->name));
 	snprintf(mouse->phys, sizeof(mouse->phys), "%s/input0", serio->phys);
 
 	input_dev->name = mouse->name;
-- 
2.43.0

