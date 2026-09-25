Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F44FC8C5
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371567; cv=none; b=SeS/ro1sQCR3b0+m68ZSfd/5mAevqK14l+o0GpD3rq19t12KxdPiZiOcw26fqt2gEE+xy0lL0LNebyYGeMHYS8856xd15bstFtCYXz/74j1FNh2FKlL6Ew7kV0NoPLjog01ZwApcbjRGc44+b54LYvaGVcfydrp5wb/GdNGZPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371567; c=relaxed/simple;
	bh=lXnrrDdYRQyOlVitpkY8qFZuMpGdYCPpTCZxc/3kPwk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uIDgkFqPt2GUmSxCFbg91XFYAd+vjmC3yMlC7jOSZJw3345AzJZdlgtRTLAa8PSf8QsT5tqDBb/nRRyJkpPUb84N6LkbPAPZeb6gIR53EslmG7eAdvoaJRqLokEVa8ugiuUG0nWc4GYi+8g6slIcYd9dL9uF35gLXFB9baUo0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5jUiAyy; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5jUiAyy"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e087a17dfso1814685a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790371560; x=1790976360; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Jjlm+MZZkSIglDOm6l1bMaXqX1r3Y9qH35a6D/ysA4=;
        b=t5jUiAyytSaWWse+D6TY+OHr2VxLDp0g5DmnHLMu+aGjvfIW3oHgbjKToI9Tn7PfjV
         i5mSTLh3wTd5N8jdwnLjKKHTPG+131nOXzbc/FpZdYoicUTfOgMH75N9kqTG3dTU+vT4
         wx1aAtq6eoErw7yflK43iOZCsLDqRgIB0u0xYy8gprVZlCY5o4+Tvc9cvAWvwRQx6FCN
         iPEmepzxvACeJjy3AjMN8T4UFQv7wPv2Kf9S+9Z8FH9woANrP+uHMGoThYVGHt/Y+XBq
         Xdp0UV5utSqKB4yJ03ym2EkudjNtDNAOCwAyZXxxpOVcZxoILP4ENTpjFzaFWt3C9NZX
         Nydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790371560; x=1790976360;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Jjlm+MZZkSIglDOm6l1bMaXqX1r3Y9qH35a6D/ysA4=;
        b=y+J0WUm+xzK/WqPzGKKGt9wWH92/KFWNt1qECHucyoW6tHeuVXgeLmaQBnb9/C6v13
         jtpuYO5i9NQBeTsiHwSpdtF5sWMREJvMz3L8OM6hEcKpk349XxSkbriTx8YEJ9IYqxIS
         a3yvbndcN/P6pNNzpfXDXuE58ap/x415LjPKXJSK7E7HBbQWvxvPlUR4e89B3UdjqI4Y
         OlWFxuwAaxeZiieytwnDPJFNUiaXAOXUjD8e7O5BSW232N72YkpAgm/MNAdyGzgrR5Vh
         NUT7M6VCsJ/oOsAX0ANrva+cDM7yDoDB2oeflbc+5dPFfEA01OuHFCrr+CKjxzDbRWow
         6sWg==
X-Forwarded-Encrypted: i=1; AKwUvBzVeCVXDJRr7423lTevO+3BDp/ShV+Zv3a6WbVnOLhf7K5WuIuAr/LeMYFiIgSYnplgaF+tNoUoiNsaSyRHNWU=@vger.kernel.org
X-Gm-Message-State: AFuF++nd5nadCft0htlyQblO8detKCS30W5N8ea43qSxxEqYwEjykvex
	OE7EHszjf2JV68qk3xKdFuFiAsCTpJSPxsTaXUJzHoM6OTj/w60OvWLA7onfZ5YarHxzzqO1chZ
	j
X-Received: from pjbkw17.prod.google.com ([2002:a17:90b:2211:b0:3a0:cd29:5300])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c6:b0:39e:24ab:9f82
 with SMTP id 98e67ed59e1d1-3a098adeba7mr6300290a91.10.1790371560321; Fri, 25
 Sep 2026 14:26:00 -0700 (PDT)
Date: Fri, 25 Sep 2026 21:25:52 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925212552.125652-1-morbo@google.com>
Subject: [PATCH] firewire: core: add __counted_by_ptr attribute to struct fw_device
From: Bill Wendling <morbo@google.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux1394-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

The GCC and Clang attribute '__counted_by_ptr' associates a pointer
field with an integer field holding its element count. This enables
runtime bounds checking by KASAN and UBSAN to prevent out-of-bounds
accesses to the pointer.

In 'struct fw_device' (defined in 'include/linux/firewire.h'), the
field 'config_rom' is a pointer to the device's Configuration ROM data,
and its associated element count is stored in 'config_rom_length'.

Additionally, update the existing KUnit test in
'drivers/firewire/device-attribute-test.c' where 'config_rom_length'
was incorrectly initialized with the byte size
('sizeof(simple_avc_config_rom)') instead of the element count
('ARRAY_SIZE(simple_avc_config_rom)'). This ensures the
'__counted_by_ptr' bounds-checking annotation does not trigger any
false-positive panics or compile/runtime checks.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/firewire/device-attribute-test.c | 4 ++--
 include/linux/firewire.h                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firewire/device-attribute-test.c b/drivers/firewire/device-attribute-test.c
index 97478a96d1c9..2c482afca8f1 100644
--- a/drivers/firewire/device-attribute-test.c
+++ b/drivers/firewire/device-attribute-test.c
@@ -86,7 +86,7 @@ static void device_attr_simple_avc(struct kunit *test)
 			.type = &fw_device_type,
 		},
 		.config_rom = simple_avc_config_rom,
-		.config_rom_length = sizeof(simple_avc_config_rom),
+		.config_rom_length = ARRAY_SIZE(simple_avc_config_rom),
 	};
 	static const struct fw_unit unit0 = {
 		.device = {
@@ -168,7 +168,7 @@ static void device_attr_legacy_avc(struct kunit *test)
 			.type = &fw_device_type,
 		},
 		.config_rom = legacy_avc_config_rom,
-		.config_rom_length = sizeof(legacy_avc_config_rom),
+		.config_rom_length = ARRAY_SIZE(legacy_avc_config_rom),
 	};
 	static const struct fw_unit unit0 = {
 		.device = {
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index fd35a6570cd8..2040b17d86fa 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -224,7 +224,7 @@ struct fw_device {
 	struct mutex client_list_mutex;
 	struct list_head client_list;
 
-	const u32 *config_rom;
+	const u32 *config_rom __counted_by_ptr(config_rom_length);
 	size_t config_rom_length;
 	int config_rom_retries;
 	unsigned is_local:1;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

