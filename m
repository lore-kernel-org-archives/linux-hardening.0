Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4EE1292C7
	for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553524; cv=none; b=gUMYV/xIUWgyk6rOpQn+G9T4mQ8yQUTfPrlya7R6zdSYi/k0JIh/1fk3X0njgc254vrA67uNseMUHWj+0fDZyOYyWqy6QU5R8eZrio0DSa6dXKKGsrUkdyg5A/Ftjj2ggBGNDLsdXbaR6+iDl9zWtL0iu63JpRvs+49D99eT9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553524; c=relaxed/simple;
	bh=/rPb7XyLIQzOH6lWvHaGCiHeCQoC67DC2adMcM3z+3I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iWGK9HfkAOjP9u/aIty4YCppUNQHLyYLpPpIUoweM5iYYPxg1QPxFE2j6225/pX9Jkv+TpyhQE9+ZnpaMKZ1jZe/IV5MAzL90LokjKwvglE+W+uZkvoYwUYRLiRICU0qNSsN0s0rKvX2UzMIzKJD0Q5Vf6Xgj4F5hhCOzPv6NMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCtQyMUh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCtQyMUh"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60886665c25so18289917b3.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 14:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708553522; x=1709158322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/GG/FYJYyfJG9mT+LJy6IprkJBq09NioglCbunYjLM=;
        b=JCtQyMUhtYltWXjICTa/xzuMQ3VS5sLhIOamUc8JE4gxQmUXdgHKK5bJCetv3AL1u9
         3Hcw7PkQyYOqECI0+F3h2t6pQ9pIh6pSy0ehaw1k1aCTHXHTKOAdZdAuQ+T/35CjaQRM
         U3ICgZce1+eAm8guZxdWD2RubWmOBpJNAnHpEErmLdxgiVBlmtveHKJo4zwKO+Sl0Lin
         l6TmU6rgWrvZNMdl1rwyOBf7+RXu71KbyhEqMieazELR9xNUU+RZ7Au62fpCYS8hXK0b
         olwjuiE3XkI44Urx7bPlDsdBdr+ElfKMyX9Nd6rM2krHXP5DocxnBdGHVYUjQ21lyXvZ
         9H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553522; x=1709158322;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/GG/FYJYyfJG9mT+LJy6IprkJBq09NioglCbunYjLM=;
        b=r5M6OX4NuL5XQFIbxjLH1YfI7H1kG68AD9HezTeq/0XgYUXhBqBm8LvmYkfBlWHAIZ
         K2DFoG6HZ1IF53ORyjII+X9pBg0tPxq2N9rMkRsA+wvAkIOUppTzza7PrrYsvsDbbpZE
         l6PcDpgkQdUhHZm0q8hjt7rEEbSJshNVaJf7astYv55HcopMKWU4q3oUdjXDSsQAwYai
         LZnzTW+CTmREVWJ/LgnU8KwIkRKl8Bn5T8cUvF8+6mO74VUvpPp5CrljCiO/zKyhR1g5
         +140x6c3ClE7KGTkvRUlZfWK+bFjhsPGKNooDMZNNUzf5V8iFrRFGrdyJbpD/NqZkOe5
         1BIA==
X-Forwarded-Encrypted: i=1; AJvYcCUZd0mfQoJKSBHTqmztPjGjidulWEFLFXNfdomY7E9hhNiahIg7qlgCt4lZcRO/6GkkxTgBTHIcAaOgNI5rq5BxsCW96FT5gdKcwLUblPER
X-Gm-Message-State: AOJu0YxgMcZmZYbETu4gpJRjzVQQcRhtj4/Vgy/KI5mjAiyJqhsKBYIK
	8pBVz6I/YnV+kbn0Cphu44p1zDWr/r00LqCXRxI4zukzsj3PZl9XX/kRhv63JlDYP2xja+zwBID
	DD/LKFoMSVFTvMW9AopHjjw==
X-Google-Smtp-Source: AGHT+IEci/5Vf3xvtYbFkcaYw0HOJ1oknd+M3m+3oDNqcWJzcmzdj34YJpIssgfG0DDd2PMTBXI9vzt+k94gCxre9A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:a:b0:608:2104:5c64 with SMTP
 id bc10-20020a05690c000a00b0060821045c64mr3008801ywb.3.1708553522032; Wed, 21
 Feb 2024 14:12:02 -0800 (PST)
Date: Wed, 21 Feb 2024 22:11:59 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC511mUC/32NQQ7CIBBFr9LMWgxgQe3Ke5guKExhokIDTaNpe
 nexB3D5XvLfX6FgJizQNStkXKhQihXkoQEbTPTIyFUGyWXLpRSsxClTnEdmA9rHZGYbmLnoFp0
 +4+A41OWUcaT3Xr33lQOVOeXPfrKIn/3fWwQT7GSs4lIN6qrFzafkn3i06QX9tm1fFrIsr7cAA AA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708553521; l=2107;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=/rPb7XyLIQzOH6lWvHaGCiHeCQoC67DC2adMcM3z+3I=; b=xNryGjmPlmtJ/xKQh+oTgMUOQUpAJvyNQ5uOeHdanxDPo9fePKNVuKttSZFrsacspISd2N6dZ
 lypaFNdtnD2ALtrrQ5nK7WfoTqd7TPTxD6EQdpfv5X0jpUx7KOZBeHM
X-Mailer: b4 0.12.3
Message-ID: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>
Subject: [PATCH v2] checkpatch: add check for snprintf to scnprintf
From: Justin Stitt <justinstitt@google.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Finn Thain <fthain@linux-m68k.org>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

I am going to quote Lee Jones who has been doing some snprintf ->
scnprintf refactorings:

"There is a general misunderstanding amongst engineers that
{v}snprintf() returns the length of the data *actually* encoded into the
destination array.  However, as per the C99 standard {v}snprintf()
really returns the length of the data that *would have been* written if
there were enough space for it.  This misunderstanding has led to
buffer-overruns in the past.  It's generally considered safer to use the
{v}scnprintf() variants in their place (or even sprintf() in simple
cases).  So let's do that."

To help prevent new instances of snprintf() from popping up, let's add a
check to checkpatch.pl.

Suggested-by: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Had a vim moment and deleted a character before sending the patch.
- Replaced the character :)
- Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com
---
From a discussion here [1].

[1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org/
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..64025a6e6155 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7012,6 +7012,12 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# snprintf uses that should likely be {v}scnprintf
+		if ($line =~ /\bsnprintf\s*\(\s*/) {
+				WARN("SNPRINTF",
+				     "Prefer scnprintf over snprintf\n" . $herecurr);
+		}
+
 # ethtool_sprintf uses that should likely be ethtool_puts
 		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
 			if (WARN("PREFER_ETHTOOL_PUTS",

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240221-snprintf-checkpatch-a864ed67ebd0

Best regards,
--
Justin Stitt <justinstitt@google.com>

