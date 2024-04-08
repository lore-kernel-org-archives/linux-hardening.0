Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE5433BD
	for <linux-hardening@vger.kernel.org>; Mon,  8 Apr 2024 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609623; cv=none; b=lrdkcgl+hJLlYWbFSCgcj5JSn/UFOzalpEdjajugbINiZNBYYoNIO+DclfBdc/YiuqL6ISs5S7NfiIofv82ucBonBQXaEUYEZgyjpJL46MWrO16n5wgLzq7yKRSvCFJYWsu1mZ7FqIqYvc9w3cv5SEjuWY43RThpatDoWr33P0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609623; c=relaxed/simple;
	bh=DOqZq8kuJzYUPOSgaA5tk+PTqcOohixHy8k/tyKf4YY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HDgUGAuaMxzoRCbhpcOMX10dVlkjwMBlW/3cN1u8q6icL82Tjzv3ZAq32iRB7ZgEvZMCdanS4IxXecVuRDU9W7yVwk9Ahqu8yyw2KueiNmYa0N4UBat3/3dWWdnkGLjsDb4ElL2QUKwbdUhl6rmFvjJCTX7Tj+VYIavKcyPvVX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xf61bhPo; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xf61bhPo"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so540613739f.1
        for <linux-hardening@vger.kernel.org>; Mon, 08 Apr 2024 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712609620; x=1713214420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NBGsS2/S3Mj7HXkZYf1Aj0lD7GM30KGEteH+N54+L68=;
        b=Xf61bhPo8YhJG2NkUoPFcLs9vVUIBIJUMZ2fwF0gY0zAltdKMmVxu8ZWusQ8c19pP+
         3K0otW3DRshFZxr05CT7drLL2tfpL0zzTSHvcPfy4FHjG4d8sQNxJNx3hGPvQzhQLUZm
         UzrwznSfaTCjDD9gF0TNgMXSU6Zad8vjhnqLjCJpZnrs+8uQvI9Zp5ck2/sHEYSJJkzF
         pRCh+lHtLG3Ujwxh4tFb/hrQmQVWAWbKfSH0EM+j0rzg24x6wveUrQpt/q3YsPP2Ahmq
         ZsTeSdJJnKF0bJ/aPFBBjKbTupV+FK6bcLR45uQUXTYNwf1BBIMJYeKezBRtOrMVmfrR
         CtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712609620; x=1713214420;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBGsS2/S3Mj7HXkZYf1Aj0lD7GM30KGEteH+N54+L68=;
        b=l2WJkzXaoD/UCoQ0kmb9jj+DlN7mEiulCiEwWNr7TfjDMAyngFlQJO90vnf3RzEQiz
         TJS2ga92GBZL3h//NEiAlWvFhOnrL0Xy20vrK4SP3GFJ5u348quQMIeP/3avVDeUyFLP
         aDPnNAUJr5cBy+BYYGuFUAp4b4Kkii90LrUgVbmd4G3EgIde2SZLFqh7xQpfmR6MOzIV
         OK9otv4DePL34YV4A2CsO8CPhKAkq73CsL8gloZ+lq9k33AjcztnbPdQ67RiETX2lnLw
         8BiGsMHyo633M4cMEreFlb1+dzFbUjdOf6nTrocYCKgheClE52d03vfBvd1MGXsLvBTR
         Bi+w==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZeleLYm3QWpuGWCTog216WuzgZvr5kXCyEW8fhsdZVqu1dDv09PCJsmHnVBuXrV4HI4eiQ+pTaP8LpnWHLKIdyaJI+8B3FnNN68zQSur
X-Gm-Message-State: AOJu0YznCzLv5AompGOuTwUeFbOJwshhAL9+pV63WoSTYi26MXVLR8os
	ZTejAAd5ZyZkLBG3gByiN0ccblQP+u3IFFoPqGC7I+PPBKHfYgx7MzSGBt9zJw6VbXiw3eGMG/D
	WrVzxRzKZUqJeM+6E6ABn3g==
X-Google-Smtp-Source: AGHT+IGRqybDplhDDdFYGn2qkod05B1D1siyL1k2PvY5mOUnlsBqs0hUzmP+PXLNZi79lfQ+W2tZotf8sNlVmwoj8Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:2656:b0:47f:bbce:999f with
 SMTP id n22-20020a056638265600b0047fbbce999fmr679656jat.0.1712609619830; Mon,
 08 Apr 2024 13:53:39 -0700 (PDT)
Date: Mon, 08 Apr 2024 20:53:33 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAExZFGYC/43NTQrCMBCG4auUrI3kv9aV9xAXaTK2QU1KUoJSe
 nfTbkQUcfl+MM9MKEF0kNC+mlCE7JILvoTYVMj02neAnS2NGGGCMEZx8kN0fjxj04O5DHo0PdY
 7JcCqGlpLULkcIpzdfVWPp9K9S2OIj/VJpsv628sUU8y1kYTJVjaKHroQuitsTbihBczsD4QVp Gk1FMFq4OQD4S+EU/kd4QXRQlKolRKcqDdknucnAVcEUUEBAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712609618; l=2547;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=DOqZq8kuJzYUPOSgaA5tk+PTqcOohixHy8k/tyKf4YY=; b=ZnsbFijeEdgYz9BOFIR2GqN3ptuzZxowhptyWoqNfINIUmFZ4hWGfE6dfmHlgeF4sNWgP2qQa
 +PFy/geJjS0DBnBPsefZ27ki+zSu9bTY64xmBx4okvBLiKmC5a7BhaN
X-Mailer: b4 0.12.3
Message-ID: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
Subject: [PATCH v4] checkpatch: add check for snprintf to scnprintf
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
Changes in v4:
- also check for vsnprintf variant (thanks Bill)
- Link to v3: https://lore.kernel.org/r/20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com

Changes in v3:
- fix indentation
- add reference link (https://github.com/KSPP/linux/issues/105) (thanks Joe)
- Link to v2: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com

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
index 9c4c4a61bc83..a0fd681ea837 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7012,6 +7012,12 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# {v}snprintf uses that should likely be {v}scnprintf
+		if ($line =~ /\b(v|)snprintf\s*\(\s*/) {
+			WARN("SNPRINTF",
+			     "Prefer {v}scnprintf over {v}snprintf - see: https://github.com/KSPP/linux/issues/105\n" . $herecurr);
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

