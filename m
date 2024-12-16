Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CF14830A
	for <linux-hardening@vger.kernel.org>; Mon, 16 Dec 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361732; cv=none; b=tOst9kM6LbjIN6++PWYqzcDmpNzE/p9d3DDgLnuNKxZKoKwP0+mv+9+krXh+E+eY3LRozasXaEaH9SH+OuBz2CGorI8tFC2tY5rv4DX67dO+WZcJm/ZckB5eQ5zr6Na8rsZA6ON7Yr2AsPkk9TBsQQHrbzCcECwO1t+S+mH5hzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361732; c=relaxed/simple;
	bh=39buhah7O8V0gWPnXNd4SBatRNxagXAmOIIkESP2Gfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VXpoQoKcLAki1V7mw4b9K2uHMq0ZM6SB3e5GZ3e4/W3iddhyNM5teY4In1V8iE9NBVBcf41S6waMxvacJBEO6KieFmpKIs3D3AVOgLB5zPeWTX8eYo+/oM3wRGxldyFTjBJ+P/beFGwp1Id04wbA5Vhjo12O1gn9cuX9ddf4P00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhoS9Xhr; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhoS9Xhr"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385e3cbf308so1722702f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 16 Dec 2024 07:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734361726; x=1734966526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMvxaK3H7ehB4Fo2EK2FAi003TZH7u0HRSOsLrU2A98=;
        b=EhoS9XhrstvNLPSStfrRJ8kuJMbaERQxhDL49IAS+tHqoorfiJIg6T5REZXU7PNeMn
         9slfp9v3bzfH6MZgde9uGnhPtgJ2/mvELFfruBIW1lvrbdzike7VuVq39FxaUyYU95Zg
         mGXsBLDqxx8vF8+y5NUO+IcQ09pDLvVMTDUTZLp0tHWVP/dOp9zgcFdxCldBrGUACgWV
         DcyTHIx0JcyOHunNWgtQ7Wqtq8ho4wLuLm9jrCMN+kvX5FEyb51ESWDHV8cIQGiR9IyS
         3tlehs9slHgJbYX2dZALrKhiS1P6BAOiMbOG+rRVj3BMfVwAT1zV4ROfAbehv3l8EO8P
         7REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734361726; x=1734966526;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gMvxaK3H7ehB4Fo2EK2FAi003TZH7u0HRSOsLrU2A98=;
        b=kQV3J2tWM0Yqc6W5UxcOIrGpYNaNJkCFaSVRpURFIAbm2RDjynlyhq9WNnFC80rvHR
         37F6I5QybxWaGFjvKdAGmZK2AMBZBoHnWaJKqDmUW1OpfbfiCb1iLIUOEgZHsah9KO4c
         N2hMzfP4UU9o7mBpio121jYazTf40XIJG/gy8A5oG3m35Z3ryUnOAS2e+wZXktmo/syd
         1gLAA5ZhY0EXZvg3Rt4nlDugXcx6OnAA/PcEtt2kLCwUwwZbaioP/o2pi5cZl6DyJgCr
         aI0p/Pnj8aRLfsYMVCGGsXV3j2AL07IpenTs7d/CAQZnMfPVEMLCXbxrip8kz3faMtMD
         ibLA==
X-Forwarded-Encrypted: i=1; AJvYcCWhmczogJEVpL+Fl8j94G2TcNbGWRGjY8p/RavMKllITzo5nbwBm51Z889MqQJxqiRwZUExBDPQuMvrFH8Rn44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLm+Y56cBX6c6Ii6IpcxoU7pV10Yb8eNqI/iT3XvwsoL5f0saN
	veMWnpvsEyaljic/euw2bYo2g8FXlRE+74CrIsoEGXmiwv4SjGnuOx6tDCaFSXzAJLwQq09ch3Y
	7Rg==
X-Google-Smtp-Source: AGHT+IE4qP/mYU9srjzQKxvWrJ37nbep1gNjepjF1UFUXvmyPsUPI8qeo3BBgvebbGQdSMAsV1kFE8Dvso8=
X-Received: from edbbt12.prod.google.com ([2002:a05:6402:a4c:b0:5d0:f9e2:d3c4])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64a7:0:b0:385:f280:d55
 with SMTP id ffacd0b85a97d-3888e0f2d7amr10190347f8f.37.1734361726616; Mon, 16
 Dec 2024 07:08:46 -0800 (PST)
Date: Mon, 16 Dec 2024 15:07:23 +0000
In-Reply-To: <2024121418-blazer-valiant-c51a@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121418-blazer-valiant-c51a@gregkh>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216150722.4079213-2-gnoack@google.com>
Subject: [PATCH] tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jann Horn <jannh@google.com>, "=?UTF-8?q?Hanno=20B=C3=B6ck?=" <hanno@hboeck.de>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With this, processes without CAP_SYS_ADMIN are able to use TIOCLINUX with
subcode TIOCL_SETSEL, in the selection modes TIOCL_SETPOINTER,
TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT.

TIOCL_SETSEL was previously changed to require CAP_SYS_ADMIN, as this IOCTL
let callers change the selection buffer and could be used to simulate
keypresses.  These three TIOCL_SETSEL selection modes, however, are safe to
use, as they do not modify the selection buffer.

This fixes a mouse support regression that affected Emacs (invisible mouse
cursor).

Link: https://lore.kernel.org/r/ee3ec63269b43b34e1c90dd8c9743bf8@finder.org
Fixes: 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste sub=
commands")
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 drivers/tty/vt/selection.c | 14 ++++++++++++++
 drivers/tty/vt/vt.c        |  3 +--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 564341f1a74f..0bd6544e30a6 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -192,6 +192,20 @@ int set_selection_user(const struct tiocl_selection __=
user *sel,
 	if (copy_from_user(&v, sel, sizeof(*sel)))
 		return -EFAULT;
=20
+	/*
+	 * TIOCL_SELCLEAR, TIOCL_SELPOINTER and TIOCL_SELMOUSEREPORT are OK to
+	 * use without CAP_SYS_ADMIN as they do not modify the selection.
+	 */
+	switch (v.sel_mode) {
+	case TIOCL_SELCLEAR:
+	case TIOCL_SELPOINTER:
+	case TIOCL_SELMOUSEREPORT:
+		break;
+	default:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+	}
+
 	return set_selection_kernel(&v, tty);
 }
=20
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 96842ce817af..ed65b3b80fbd 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3345,8 +3345,7 @@ int tioclinux(struct tty_struct *tty, unsigned long a=
rg)
=20
 	switch (type) {
 	case TIOCL_SETSEL:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
+		/* CAP_SYS_ADMIN check happens in set_selection_user(). */
 		return set_selection_user(param, tty);
 	case TIOCL_PASTESEL:
 		if (!capable(CAP_SYS_ADMIN))
--=20
2.47.1.613.gc27f4b7a9f-goog

