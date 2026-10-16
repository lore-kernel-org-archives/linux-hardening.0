Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8E45D93C
	for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170264; cv=none; b=j2BE3oSKI2RlRKMFCXsJQsKdXQuQjPGc7S/M1dHHXO5uy+LQMaronYvtCnFLsB9SarJ3jZX6ni1e6K6Ba/M1ssCxJ/pxgqwMuvuN1qJo+CWkA+8MwYNEVLEV41YcXb0jm1Gs3Hp98EkrLNBGWn0xt0dFwyZ2vLB7rJDH2Ywi6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170264; c=relaxed/simple;
	bh=kR6ZMycAYu+JXQaokJoeRAca8CcTzwMI8IDFajQGxDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fq60LGzcunp++pE6E99UH8ApuucOR1Xyjf22QpUD6cY1yJEXLl/r2u2uwqmeDeoZ7XodSGljRviVQ3g7CgpPNCCf2VoK+m4cSXx7MQSC0lqvVgNCRvmqy3TzIJLZFIkXfD5NIMQ5wqmq3nj2s8qfvDo7OgosEPvkmG5y1BaiEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV4e6ld4; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV4e6ld4"
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e4a61a2ff9so159185ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170262; x=1792775062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CW8x8+uhyj3ukfLv0uTbEFXfFQ+XLujbiKlxRUfHWg8=;
        b=mV4e6ld4/yrAt3ehhgfkCFy1ksPQxonluegORSe49dq589QpxwaQAYi71a5OeQIxdW
         ev70g99CjZEiXUJTJLwPeORDb9l7FYXnLcBW2qFsRgqU+vUtIUaKUUepWdYMB0wSaUTs
         e1ajZD7fkntRYxpEwFAr1dzFyu/g3nwCjSHEfPVGwFai5NHj/j+2zBCzt/cZA8TwNsPO
         /gD4dYqQZZgGVxx95OvF0zdURo0Of7t9w1ge9GzlRnwUfqh2Ro4rBZeacMICwqRmaBr+
         Qp0XB6rA0SoMMsjyForQZhkU9LdEXIOTlD9cvcGOeyfvv2CDQQTCnQy3zXiklusE3uaF
         5u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170262; x=1792775062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CW8x8+uhyj3ukfLv0uTbEFXfFQ+XLujbiKlxRUfHWg8=;
        b=XvJqvJqZT6/Wmzm1pVoVmRKd++FV2UkS37UUwsxnZK/RrI0Sd4Qoz8KUyaVA+HTD6k
         V0uMQ3O8xcHZ8nKdv5S5TBYmeMRl8SZACtPCNnjGuVX3qKfYYeXoGMJqAmOmBDMYfJfW
         mVGRxzV49LETGCjXuvYIB1ftHjJaM953ANVAmKQdKeIQopES8QjS5QU20l9iLXZBnmx6
         0CfPxlVhur7u/qrZBTx97tJIxs0NxMmdosySuZgAMQlkDWIG78vPw8dWe0JZBKIBqin+
         QINTRuINvG3uwz2Eit174NNgF5jTqFZamK7IiKojduCNHhYVrwiLw+mt8b3A82TYd+77
         l7Aw==
X-Forwarded-Encrypted: i=1; AKwUvBz7uatiNYO/1ZlGzfqzh3VSoLQJGbfF8kgyjRr7dxv+Ntmt16VV0ZRA3wp7kSzGeX9pQGc0KvixdGZdX0ndL2g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJO4QFxFJ5gRjS4OP27Y8GQKjDyERioSvSmL78bda6ztBd0csB4
	I3/WaWYc3GwJW2sCoFn7yF5NsCrKOjY8fQnISRF0f3qyiRd7P3E3s0/1
X-Gm-Gg: AYBFou3SjpshRpAxTO/ZtTrMue9e+rd9n3VlnlNLIz0UwossCKd/uPKP4uJopYuTUXA
	sYtIZE+zNfHv8D3GQl1ZaNy0OLZWf7lE0kC1g5/cAJcDi0/fpWcqI9qkj5IZspTNQotP9enbMMx
	9bca77m16wIDEJG2CSiCp7h8SMwyhrRWaQvzDZtAeaOw79eQw7nxKWqCXGkNRPyfPuKTjfmBUCU
	5aKap0RV0dlOAqZ7yzI1aOrHGxOIV20HJtmF9quz9pM+zEv8qMrHeWkBAmnPHi1I+I3ru6wBZRw
	ptQ4oD0Xr61HXhBheaGCDncdffhivz2VFstICdPU5ST9ilnS25qDAzXRx1P9qxkf0b4qEkQAxSU
	Ur3dJkmho5YkC8ZxCVHuAP4Z9kvPUx8o6bLkH8QLBVD4H3RK03YJ7paJHQnbdPWxiIkD+EUlK61
	Qb2GgnHw01+TI6JFnS2DVb62glR8NtZj6pF8Z3+p8Wh2zxRXpoenL9qTP39uGQ9gy1XHCMKD7pU
	HsNJTyP5o7HSiM=
X-Received: by 2002:a17:90b:5450:b0:3ac:7c52:fb04 with SMTP id 98e67ed59e1d1-3acef0f47efmr352213a91.44.1792170262004;
        Fri, 16 Oct 2026 10:04:22 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([223.104.67.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm9928587a91.0.2026.10.16.10.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:04:21 -0700 (PDT)
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
Subject: [PATCH 0/5] Input: replace strlcat() with strscpy() in USB input drivers
Date: Sat, 17 Oct 2026 01:04:06 +0800
Message-ID: <20261016170411.51025-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several USB input drivers build the physical path by appending a
constant "/input0" suffix with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API [1],
replace it with strnlen() followed by strscpy() into the remainder
of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
strlcat with better alternatives") did for the usbhid drivers.

The series is split by input subdirectory:

  1/5: joystick drivers (pxrc, xpad)
  2/5: misc drivers (ati_remote2, cm109, ims-pcu, keyspan_remote,
       powermate, yealink)
  3/5: mouse drivers (appletouch, bcm5974, synaptics_usb)
  4/5: tablet drivers (acecad, aiptek, hanwang, kbtab,
       pegasus_notetaker)
  5/5: touchscreen drivers (sur40, usbtouchscreen)

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---

Shihuang Liu (5):
  Input: joystick - replace strlcat() with strscpy()
  Input: misc - replace strlcat() with strscpy()
  Input: mouse - replace strlcat() with strscpy()
  Input: tablet - replace strlcat() with strscpy()
  Input: touchscreen - replace strlcat() with strscpy()

 drivers/input/joystick/pxrc.c              | 4 +++-
 drivers/input/joystick/xpad.c              | 4 +++-
 drivers/input/misc/ati_remote2.c           | 4 +++-
 drivers/input/misc/cm109.c                 | 4 +++-
 drivers/input/misc/ims-pcu.c               | 8 ++++++--
 drivers/input/misc/keyspan_remote.c        | 4 +++-
 drivers/input/misc/powermate.c             | 4 +++-
 drivers/input/misc/yealink.c               | 4 +++-
 drivers/input/mouse/appletouch.c           | 4 +++-
 drivers/input/mouse/bcm5974.c              | 4 +++-
 drivers/input/mouse/synaptics_usb.c        | 4 +++-
 drivers/input/tablet/acecad.c              | 4 +++-
 drivers/input/tablet/aiptek.c              | 7 +++++--
 drivers/input/tablet/hanwang.c             | 4 +++-
 drivers/input/tablet/kbtab.c               | 4 +++-
 drivers/input/tablet/pegasus_notetaker.c   | 4 +++-
 drivers/input/touchscreen/sur40.c          | 4 +++-
 drivers/input/touchscreen/usbtouchscreen.c | 4 +++-
 18 files changed, 59 insertions(+), 20 deletions(-)

-- 
2.43.0
