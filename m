Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3A24A066
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460267; cv=none; b=r0gNGx/En5Ily1GjH1hSJg5LkNdMMAA9OvZlZbdEOBJ9JwoTPWkwkhYM1naAQTQcRGcQS2sMMG2D+FrlE4mgXOhWuOsqsLc5CSGCsENJBp1wkGGUVqiwWkIz831NAYg4cOF3js+V4ny+0RbvC5UGBWpEbhWBCOUTGPrJwnoqjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460267; c=relaxed/simple;
	bh=ZmekuVWh9HwE0TpAn0cxQrAIBKXU655+phVVUhIIyEw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DoAdgwmAdDbUWwsK8oIDo8yKqQBbyz+m9Z+k17bwVGqebB0dYGZDQ01y7iveejwAXJC86B0U53MvI73WinqWrA8a+uudlhDSYIsCznILI6nh4sE98TkahjLo0dLuip8o5uhHknMRtKSd3nR1G191JI2UaftyCYCR3Hj6OUSPmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zXLDEpR4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zXLDEpR4"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b31c610fcso4585033f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 02:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763460263; x=1764065063; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4RjKjA/NnMP3ef/YL0bM59KAESzVxNux0nJstTB344=;
        b=zXLDEpR4gzKJiNATHLUqpGEuMc6a8nVFOdHK9GL2jYMSNSkavzb3LA2Yk0oXSTY4cA
         zvpyuUGTqgj5HInHKAH/pL47qxnYofRen+yLGl44RsN7orW7wxUrb4RjB6Wju94bitx+
         IcnrroTYel6AHfARTM5ZWeH9ctZGRM8eFkWTS62VAxi2/sJ0Y1+4F1l6P8DXMXUzizQC
         v41YPYkfchvNE2wlWVTyHiBtlC1MwK2ZuZCxw7kf056jBnrp4UoXJi1d9IPna66DZJDq
         dNcxqXS3T1akNt0g6e9hTO9R2lfm/zfnLAlOztj3u08Zk2GnEbHl30XsMM/dHlLpyzzC
         E/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460263; x=1764065063;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4RjKjA/NnMP3ef/YL0bM59KAESzVxNux0nJstTB344=;
        b=rKIipxsHP3jbpQezY0uQLNEIiDA3lMPbj1OVfsUtgGlCD+BDh88gnsuhuKHNY1l2n+
         9/2stowqO+OvxPf/pJJc57OdCXH/74WRkbhxbHCx1RuclFtUrNM8zyUPDTDhxjE/R+tF
         iLWLA4qyorhsyC3eWtBtyHyJ0tAYPu/M0JS3bKQ6JereEy/IIeY/vIL6w+NjCKFPgq4L
         scFCrYm0leHXR5HkRSfYw6WPwKmsWinubaBca2KrKpDsilpsgZDwH0kovpDt8vsl/57M
         r8zHDVbxp9QMxd/QGjE0t8UJjpsCGNWDV6ENsqltBHRJaiApbiFcTWi62ZILAIV7gFoW
         xQqw==
X-Gm-Message-State: AOJu0YyWXyXjTe7SCZe+2OzJO7VHDSMwzAsAxD+r6Kg9DBy19Z9dA54E
	TZL4ZsnhZS93lPFi7sP2ebEa6yp2OJhXHPss3iNepAnGScO+VDMZaLqbrniK3pt6smU=
X-Gm-Gg: ASbGncuRAoIBuKPgxDqJeNo5Jp2RM4Vo+p1hD69qewmhoU24eKbPyaEP7KQlziqENtS
	J3WLT+W5LfdqEDVHMGN29Ud+qQ6eCtX4ubRRx4drlqxQ1eHxMBIgMOcJXEg5R4WCdSLoxqBaUBw
	h2rcIKc+kjHOVfeRdS7zmtSRa1Mn3RRXP1JkIHVC3FZYOcVH8cu4ibzmbPGqppAsFYzMEW02rRH
	/nWSzJdB0HABWiZjc+cq3x9+jSj98xziqrisj+4SjkxpW7AOe6I9qFdHf2R+Xvf5cMopOJyDCxx
	uI2I/YR+tShpmq2mUZ6uv+2eTCpBVRQTpUWhGo0ONjwEL+BWr5mxOG/naZZ8pwdf6vFyYqdgJDK
	bz/WAMX+D/d2BPz9FL2j2GDBhMiC0iiazBsL/cd/MmMIcnkkxz99NaQVrICc/khfzNLH5OUQoE0
	orwMUqq4KKEsrWSA==
X-Google-Smtp-Source: AGHT+IEoZDl5oz0L8tfjeFzBYv1IVQvY/ZUzx3b7D4fKQZDuRWPXFQnCnrL1l8cm0K9l/w7rFiPKfA==
X-Received: by 2002:a05:6000:1849:b0:3e7:45c7:828e with SMTP id ffacd0b85a97d-42b59385bcemr15197234f8f.33.1763460262494;
        Tue, 18 Nov 2025 02:04:22 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c283:3472:316:988d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7aea7sm30999781f8f.1.2025.11.18.02.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:04:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] string: strends() follow-ups
Date: Tue, 18 Nov 2025 11:04:02 +0100
Message-Id: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJJEHGkC/x3MSwqAMAwA0atI1gaMKBavIi6qjRqQVhp/IN7d4
 vItZh5QjsIKbfZA5FNUgk+gPINxsX5mFJcMZVHWRGRQ98jeKU5hXcOFx4ZNVTg71KYhayB1W+R
 J7v/Z9e/7ASZZZkxjAAAA
X-Change-ID: 20251118-strends-follow-up-740dab5871a8
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=641;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ZmekuVWh9HwE0TpAn0cxQrAIBKXU655+phVVUhIIyEw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHEShdOut83YeZzjJcabLUDfmeIfWS4Nh1rZly
 /fc80BmtnCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaRxEoQAKCRAFnS7L/zaE
 wwaaEAChmpwM9nx7t8Lh37YAr4dyfzhcGdsLNtQI3pGO8cGUft/x+U+ArIdEu8b08LJtWbzd+KH
 pR1+cgLlGLeZZWZMMnZMls5Df7gEkHy1HbZuWC1Ak96Gn4KUhkcyyO0k3KGMHLNuKdbeUqVLGLg
 ++OqAlWScQdtiWp6ThWZh6wXtfp5O9YXv3wJQgrJaKH1IZcdr2vfEUN04b2WpgUn0loaTEnIV4n
 w9TnoiPP8CNnjLOFO6QcpkxFITRFt7ITmdFItWjOSLyPdSTm6wU01IagNXK1Uk/2R35Fhc5UY5p
 iuGRNg0CNiGIM/H7ZdXpFhBd4tVruIpQEEtdPCMoxFhFSXfavTKJanDENJX01yoMy9syn5Pi8KR
 msmppyESpVIcSOMd2UrwvCMFxSRy2ike4B9Se4GjB2LwrIULCQqd9YqNMMtKM97rQlRjYEy2xGb
 DKGvAg1ogCWazvaXxlOm8dsLoC+VHHkSEWE8rSzUhiBaGm45GdfCLM1PCshK6bIQ8z3EyE5j6Cb
 +vWoshQcn3SaimAQLPRvHD3dBjY9sBCajbtpVcyMt8tjRz7O7JQi4m+5R2yE6gU9mDJIFmxY5Ch
 YrB7LPsO9PSGBmewIc/1ao98kAAU8NIfa4Q96m9yvnyiJ7MmnAicaTz+ex3+Syvl3M/+gmOtCXf
 K4WWaE2i414L0wg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

A couple follow-up changes to the new strends() string helper. This
needs to go through the GPIO tree as this is where the strends()
currently is.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (2):
      string: fix kerneldoc formatting in strends()
      string: use __attribute__((nonnull())) in strends()

 include/linux/string.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
---
base-commit: b32b526a0d034be69d115fae3051dda915d846ee
change-id: 20251118-strends-follow-up-740dab5871a8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

