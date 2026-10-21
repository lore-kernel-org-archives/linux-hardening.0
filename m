Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585915;
	b=XSODEftTR+Y+RanszX+/cLyeuzQ1XIE+aYMB6z1A4gCcsmtu3/7TugoMRdNvxTwAez68
	 egCsVS80zbiv07MYfIbwy/6s4U1QJM26OPLSWQqE3hDA+aZD2Wl8WgMgVNyQR7qsjU2UZ
	 RF/fCzLc6P4J1wTMBp7fNlG6x+Il60so7CY8PYTrZijfTqw6ZRgMBny9XeKkeXSUKxPkE
	 9UiW1hBMN9sfolPcKS48bL6P+pG2o3OGuKTZpmvEbN8fGHnpTBinoxDmdxXKCjQeRjm+H
	 R3wvQ/eeUgVbCArlBYRwzx4pw8/FU5+BWfv3onS987zCGmioOcG4XkSvq3b8k8wKyGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WCe2h/c6J0K15hd2wKQCLcyUixtVEx4iPn4ngkUBYj0=;
	b=vRrUotjhFV76f39E76URWMTp35ofLExQFXhs/YhtYTdElMqTJ5beClYkQVyG5Wc+ncZM
	 6P6OJUXH/zQNskOMVgH4l8gMEX0S4MwMGXMpNt6bqLirRfCw+bZW68CdFwm22BUrjSk1l
	 x7FmdkfUK6Z7aVYsSRsVhZNu3g4e0veWd6pge04vQZakAQcgy0J6U9iRwoaQBdRaq+NrZ
	 uxrxttuul6xRGAs+EYpHL1udZiNBcSsZG8Vg5TQ+gXkIuC6Rp2dhlrnOG+CJ7abr+YQQr
	 bruNDj7pkKx21wVFQd6N1NFQl9ABqAOAOsh/chzwrtnDpZ5ujxGt8r0dLgRRIzoKofQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DMfIYGgB;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83D606A32D
	for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 12:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E83D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DMfIYGgB
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso195905a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585914; x=1793190714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCe2h/c6J0K15hd2wKQCLcyUixtVEx4iPn4ngkUBYj0=;
        b=DMfIYGgB9fbpKyyVc6Mtp7dPhRk82hptsfy89WqLYIEnWeyqCgU+tsajJpsR3hXbYD
         csD7yG4DJM2J4ygwJiFVBrV2icf7o6MO/f1mCNcxeLhGSWYlWt3yA14hl1UK/pXcNV00
         7SdlNVyap1qx/D8oZwnrLodLrs7jVs8YOAsSw3SbutZg7BOTjrbCr3d4OflEPDGaF7WT
         yvzIG2HqRHkgkGw+tfoLck8zV6aCJBYw2BVb7LOKi8IsooIv52weIuDt7rEult1Jt39K
         IsUrD2pgNzyFSLIpjSbCCcexvn7rMZnxv+TBpNrdwjb1/VV6klzew0P9N4gNt2LT5dFg
         09Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585914; x=1793190714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCe2h/c6J0K15hd2wKQCLcyUixtVEx4iPn4ngkUBYj0=;
        b=Qg7j9CLUN8pFpGPnrbNyJDeDuVP2QcMKiH+Y8FmIYXm96Xu4ZrHj5mzAJ4oxgyUxVX
         kVKHrcp9RP7hUsRlZ1y3J0hCxjyMFmAhg94dg7wEEA/vUZVB6/r6Kd79f0H1Js5wqLAB
         IX3nJ7b5UUJ6LQygifz6GXlF/NshWslbs78Don63LTA946tZwuzshB7T0+Fk90HrU+Bt
         UJuOeAvf0gZxnX26xW82MoR603U99bcZEdpkNi7reAt02hq+kbP8N7UlSPsnwOm0vocQ
         0FJE9eOvgTWK8Af4iqkDRauenM0mgDfOPhe7mEqLRPk6iyXDGwSIt0wwKl0dpixzaJ7Y
         PUwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsnxPYTvow+gjno6qK8F7MhIMqfWvzSqkaJkY8Aj3Hwvdqzt1D3D1P/6DyDej2UOcsEpJ4stBstGEAP5BJxTA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKu/66WP3pCi4Q+5CAvlrc20/go13fwI80lcm/eQChDJZu67Hz
	HIOREIhqEJt9YrxFv8nPN1CgYDFEXPMU7Dl67VP2CXP+5UdCZngbEAcwcHJpvN+cYXmg2g==
X-Gm-Gg: AYBFou11xqHuFDnd9fiQW97+6OrZ9jxM/P4qAJuFGsUscpeTEDA4tH1XrcA1IKvGuB5
	HCYNZC12Xoy6zKLCGXcz+V0VJ/hcU3qIdlLHfBwPoj94tkQ7ZVQcN50Ud85imJYbB5ycm8VyWBp
	p+vigXMiZmFbUVk+7uIIYoWQN0MhaLT/UoiIdL4NSvEh16FK1+P5R0Co6yILR59KEAS0NJ1h/qQ
	7B+8PUMloR80i/pgZTTbtyvdtNbYXEIk8F0ax4HWaz4b7EkTYqAKJ3D5W/DXTTD4ddaICSOoHqe
	15SQTAixY3x+OVMbgUAYE3FP4i0TrnK/FWcobAGUenEuW+uNjV7cLsghbQEX75ZE5WmNIA69A+E
	08Quj/4wyVa797ccn2ylwE0bGWnk/sjTAcvl6cabxcjdRxwuEMd+L1SOxbmcJNuE9ARkdAdgxzM
	1mdYI6nrbFSakXplpCDtrUjmBJvrSf9vw7djj+Jvwd6LVZf8ilxgRwNqb3Dm/3agGnyP+rfjj2a
	xm8ghfTz6X3r5YdfNxjJWSTcfN4BLijnfAE2C3YFpjkryByGLGyqJct49uOuILQImBkBprHmk9K
	Qwyd7cZWntFjERx8FsQ=
X-Received: by 2002:a17:90b:4e87:b0:3a8:7242:e8d3 with SMTP id 98e67ed59e1d1-3ad86dcaf42mr1503660a91.7.1792585913894;
        Wed, 21 Oct 2026 05:31:53 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:31:53 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 0/6] USB: add usb_make_subpath() to replace strlcat() in input drivers
Date: Wed, 21 Oct 2026 20:31:40 +0800
Message-ID: <20261021123146.17202-1-shlomojune6@gmail.com>
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

Several USB input drivers build their physical device paths by calling
usb_make_path() and then appending "/input0" or "/input1" with strlcat().

In preparation for removing the deprecated strlcat() API [1], introduce
usb_make_subpath() and convert these callers to use it.

Patch 1 adds the helper in include/linux/usb.h. Patches 2-6 convert the
joystick, misc, mouse, tablet and touchscreen drivers, respectively.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>

---

Changes in v2:
  - Add usb_make_subpath() as the first patch in the series.
  - Use the helper instead of open-coding strnlen() and strscpy() in
    each input driver.
  - Link to v1: https://lore.kernel.org/all/20261016170411.51025-1-shlomojune6@gmail.com/

---

Shihuang Liu (6):
  USB: add usb_make_subpath() for formatted device subpaths
  Input: joystick - use usb_make_subpath()
  Input: misc - use usb_make_subpath()
  Input: mouse - use usb_make_subpath()
  Input: tablet - use usb_make_subpath()
  Input: touchscreen - use usb_make_subpath()

 drivers/input/joystick/pxrc.c              |  3 +--
 drivers/input/joystick/xpad.c              |  3 +--
 drivers/input/misc/ati_remote2.c           |  3 +--
 drivers/input/misc/cm109.c                 |  3 +--
 drivers/input/misc/ims-pcu.c               |  6 ++---
 drivers/input/misc/keyspan_remote.c        |  3 +--
 drivers/input/misc/powermate.c             |  3 +--
 drivers/input/misc/yealink.c               |  3 +--
 drivers/input/mouse/appletouch.c           |  3 +--
 drivers/input/mouse/bcm5974.c              |  3 +--
 drivers/input/mouse/synaptics_usb.c        |  3 +--
 drivers/input/tablet/acecad.c              |  3 +--
 drivers/input/tablet/aiptek.c              |  6 ++---
 drivers/input/tablet/hanwang.c             |  3 +--
 drivers/input/tablet/kbtab.c               |  3 +--
 drivers/input/tablet/pegasus_notetaker.c   |  3 +--
 drivers/input/touchscreen/sur40.c          |  3 +--
 drivers/input/touchscreen/usbtouchscreen.c |  3 +--
 include/linux/usb.h                        | 29 ++++++++++++++++++++++
 19 files changed, 49 insertions(+), 40 deletions(-)

-- 
2.43.0
