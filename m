Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652978;
	b=C9MoelWUTBB8ij4wjxN0gMsuCJoU2ArzYBLlrIdGqlONL3rTyS0lut3kIJ3BfTiOfu4F
	 LPQ2+UrUrMg5KQ8H1qvS9rrIEqUxJNtOa5uFJjCx/M5/tzb+rl8U6dX8mohWGyk9sOCeJ
	 +Ixrg1GjkQ0cZOpAW0w+YxsJERcVi17dP1CEWddIOLP8gx9P52xWRCfKPDYVSNf98LLN2
	 pv2dZ4vBi5e87HTfuCePFZlHU06h3VvYWCvQoXCmYAlXcZcWxr1kTPKt9bAQN5vB8ojk7
	 99nxkyzD5fvvcZQ8SLmsfyWDUk6iuYl5G4X1QTlj0xL+Z6rnVl1qaeFxGbVcMhTMXeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y8vRmEfoyjBwhFBdczVPnT1IHPEuzg+vfDA5yLIzw3o=;
	b=r7vlHkTfQFj3gS0jdAcHmSTlU6hRLGNWcgtwICtHpKcWQT+JFNkgSb+epI0IVW/gAOhM
	 JXn9I/Wp7VeMjTO2IlGubfGy7ZG5XGdY55NFipdsZq2K8YtXxZPNTSgajTW+UxuMuo6EZ
	 D6IoNGL5Owt8Qw/Hmx4IY0kkH47XzDb995CtyEp5zl5F/LNdyoCLZzkLZgETHj8OKh4D6
	 p7y980g2NufVi7PgCFGb1EGGLLQgMrBFWlVW86bS61d0+84wKp8sqfBscqCaazwH8Jjd7
	 vMr0dI6iDpqWAwBgLeCw/iB2NzJ20qQycSG7EA4jb51eKDUOv8CrHQN/C4hItkzTVrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="NpeQI/zS";
	arc=none smtp.remote-ip=74.125.228.8
Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EAC606A31B
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 07:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07EAC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NpeQI/zS
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cd3da0e82daso291514a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652977; x=1793257777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8vRmEfoyjBwhFBdczVPnT1IHPEuzg+vfDA5yLIzw3o=;
        b=NpeQI/zSvEQxTUCHDlatv9wagKFyhbSq4iYaKIW5O5xnPR1b1UJnU2mVcSBRe/NycW
         USkvqDpY1Nr2gjg62c98xwoqTZxA2BgDDiHRX9I3lWk/7rtBKJThc4mLd9INLBQWvvVw
         yDF1CMrUm2PDdmhbK0usfcbOAaPfJ2/ICjM8Q0dPigwy5PRFAgnxiJyIbx/Zp/B+FPzm
         VF3d7gPwUZ2IJE1XmdAv9oRuFFHsJWDcKOIBPxO7gIwycmkIii8GcsErzdqCP8lbfItc
         pJcPIFIF3nKIL8hfzBqmSelulYlneGMOpOprXwsSOe7v32PJkPMxn4O/qsKAVx4SNkE6
         i35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652977; x=1793257777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8vRmEfoyjBwhFBdczVPnT1IHPEuzg+vfDA5yLIzw3o=;
        b=wun9LxDzYwpcYTpnq9EvEAdr/M7M0UrtQarfY+rWByh2SEcoJdrNvpQUnU8LLszKWl
         ZLgs6i5rd2QSRXbnB1qrKRV/wE4lQZte8sUebeWzpzQpGyLTfFaueEPs+Pwh60OzhbN+
         SE4KwWDM4GCUqa+X3vJG56qi4wmxe3DU1svtgnS5/CccZOJnCWQm4r3iUkWBynkKIw4k
         PG2DjliJexD1lbZBgkTS/pT0aRuhSpETZyQ+JBl+Ty9iNptdpq59fkMBJWFUxMvnH8zh
         7+UBCQOrVQOXwFdAmWpfTCjRqGkaOEbSBGqVX9V/VMfaH4TVpKaFKGmRNVNqkmyk2v+c
         a5RA==
X-Forwarded-Encrypted: i=1; AKwUvBz1ife5QwSiSsq7dFqkBUYLbnwUa+bdMsExhtpZHIszOunwSPyKrCetaPbf2Q/OwhKJLhN11UCWk3DmbePVzj0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqCxY5le41EBFVT31ewlM6HU+/M+5ihDKHdeCcTxrTzkeXKGzb
	/6Ko0vbDm9ThMUs+m8c9HwTA91Mr26VXjr8IQiRW5LvtV4ZwoFsF+fbF
X-Gm-Gg: AYBFou0qFLnT0iwSBm8FsX34gYAs5mlglKkUH/JD9X6OHJSGs8TexUD3zq2WZjYko2N
	Tem2VfTHBynPLTn+OnwQfKukfGvRBgdiOK/mTb4EU7mBX/fXWv6ZhsKLhR/GwjjKevnvXr7SWcS
	7W75AClXUK3WZitYQLsn0EMc0LzXoQ4ZIPQX1auWlSuATbkpPZHq9zJodqBC+BaDvVasgWJXaG/
	iUQC2zEfJZf/g4wNmtxJSHICkxh+CC9HJNrpalONxBD0NgtNgDq3h4FZKcxHcM2idhzLDW1ivyz
	Z9Gf7kWPXvs6I3J7sKZ7Bd1udWpp3hhqttswVq4nm5Yp0hrO7aWYGZ8nj6gUWgFROzsJpdzAtxa
	wB+0k8+RebE0IVx6CZrZ0SHRAJPHCts0pCXXix8TpwclCSApcbOxnk+9kXti3cZl6sYdHKUXr1c
	Nhco0gDeL0/ZjA/H+8oV7TXHIZb3FeDNLpEm7GURyE4V8eBcelp0ZBDkjcsufU3XhW2sjPaJrfc
	g5QpEbBgNY6dJO2eF3QHu+j/keTSbwIoxDR8G9QsLX/r9UGVIqsAgG4zZx5RrdgFb+GI92VrQ==
X-Received: by 2002:a05:6a00:1883:b0:8a0:73d7:aa7f with SMTP id d2e1a72fcca58-8a089e90a35mr3761029b3a.41.1792652977248;
        Thu, 22 Oct 2026 00:09:37 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:09:36 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 RESEND 0/6] USB: add usb_make_subpath() to replace strlcat() in input drivers
Date: Thu, 22 Oct 2026 15:09:23 +0800
Message-ID: <20261022070929.20820-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021123146.17202-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
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
This is a resend of v2 to include the USB maintainers and mailing list
that I missed in the original posting.

Original v2:
https://lore.kernel.org/r/20261021123146.17202-1-shlomojune6@gmail.com/

No changes to the patches since v2

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
