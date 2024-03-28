Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1181752
	for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660616; cv=none; b=NnZce22c5tE/wJ1p7gdrPHITGsVdqZiXv81I0Y2yxOqwZR3icKVX3p6Elhw0bfn0EFn+0/hP4rsh3YL6F0AB90vQGO82DCJRzDYAmP8UAM9CVOxtm7WHRFCMv3DAOdGLvfE/5SpyVdVW2GEFq1jl4q/92xihhMSAMYTwweM6vNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660616; c=relaxed/simple;
	bh=0VFh+DzMRQfIVgNlRT9ESQZjjQsBuArYH0hQL1mAk+4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ruoKEF7/4vE/imMLj/POLGgUyX7I6P/khshnYofXvPUVC+lGHwIo1fIyux6334CeetGmqX1hEDbtcQfePFRZIChUZdz1ujl6zLbZQ3FsjcIccsrUtGX5av6Dm/Kj32/X+j3iJAS81RQafF6EU49NSc4vD5mTDgtCFxyaJIq1vD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwoKR0iP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwoKR0iP"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so2099642276.3
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711660613; x=1712265413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3wUCiSEEQ5+XeQyXhRHLnb6mP5do/bu/MSL5lZRDfe4=;
        b=vwoKR0iP88Hs5iLGW31XIPmDcCBG4EiIZdLGEziBQxGHYFTmtRrxAB6OnAMCnRFiY3
         Bg4Wb0+EHaKSSFK685rTUC+XM3HrF8w9LBQbUCD4wV/OuNEurxHQHuZZz0zPDAIgQU7i
         hBD8K1xZOYMnzbZX96PFbHrTzSHeOvJTpk8edssrHCll+VBM24JA9H4ncxMgBVBqAKF9
         kMNkb6AiVyEbQWVVGskzfWKsC88vDvEpT4hojFJ3y97NBx8KCd6vBV33OSxZsfOuaas0
         870UbctzEhVHalFw0ZNn/wRCkMmxRve3aez4sTK4+tMWLsOrd4wIXvZdq/Ag3xWYrQk8
         J/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711660613; x=1712265413;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wUCiSEEQ5+XeQyXhRHLnb6mP5do/bu/MSL5lZRDfe4=;
        b=fBUVMKm59ekYg/RZ0bTxb4bTjlfi82Xtuwb/e+dbEUQOAVMQArF2wlzAT1Pxc9lvAo
         DIrAKJVgckDucdgh3bXlaQXm1/p9zJP1BrgL73s/YEggPt84UWSMOa0yCh5ihdc1w+cJ
         YZ4ajkAAmmKoI2vsR3jzAaWh5Fax8OY9qAs8bdOVR5M++SImzaZLQVC7/HRzntUQKMCS
         e5CkRcBvr94FfGjjdXXDH+TJDuW3ax4wfNAuSofwHNi+yN0SHa8pbuA1O35E/8cynQ/7
         4pyV9l0law/FX5ZPTDOsCsXtrsOweHulMwKqcQzIsYK6Mq1Os4kaKkas+9XKsuUeoA32
         pscA==
X-Gm-Message-State: AOJu0Yxc3kROzqy4KRnuojyhE4PrS+N/MV/RfWiRb/rW+rKz6aCaZv56
	ie5jKqhQU3G73icwPfrKt+ycNzUrtnLMHZcoKrq5wVrnrGli/RwqhsG8aEg4bzT5XIX+HiLsuSw
	t8iTe/M3PstfHyeZl+eiMMg==
X-Google-Smtp-Source: AGHT+IHWVCzMVtKrCw+i/PgALiAhU6zu7AOqpmDI80m0d7V9U062paVMiqBTNANBcEsgy0fO2PJsSHanRiBsp+zw8w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:72e:b0:dbd:73bd:e55a with
 SMTP id l14-20020a056902072e00b00dbd73bde55amr50248ybt.4.1711660612864; Thu,
 28 Mar 2024 14:16:52 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:16:52 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEPeBWYC/x2NQQqDQAxFryJZN6CjiO1VSikaM5pFxyGRooh3N
 7h7b/H+P8BYhQ1exQHKfzFZkkv1KIDmPk2MMrpDKENT1qFDWzVR3jEaKovXDrLy77tkQ0IK8Tl 0fUtVrMFHsnKU7T54f87zAthmjXxwAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711660611; l=2620;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=0VFh+DzMRQfIVgNlRT9ESQZjjQsBuArYH0hQL1mAk+4=; b=HFewU5nleyNYPIyFIUV1iK/w5aBXTqbW1KWUH47mJcq1k49eGfL+HqOzDVNTt0ToRWdUqAWoS
 hOrCspVs2CXC8b6UktjDgyOp0Zr6suyWPPwacdh7cLHBNmuoVB5OHgT
X-Mailer: b4 0.12.3
Message-ID: <20240328-strncpy-fs-reiserfs-item_ops-c-v1-1-2dab6d22a996@google.com>
Subject: [PATCH] reiserfs: replace deprecated strncpy with scnprintf
From: Justin Stitt <justinstitt@google.com>
To: reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Our goal here is to get @namebuf populated with @name's contents but
surrounded with quotes. There is some careful handling done to ensure we
properly truncate @name so that we have room for a literal quote as well
as a NUL-term. All this careful handling can be done with scnprintf
using the dynamic string width specifier %.*s which allows us to pass in
the max size for a source string. Doing this, we can put literal quotes
in our format specifier and ensure @name is truncated to fit inbetween
these quotes (-3 is from 2 quotes + 1 NUL-byte).

All in all, we get to remove a deprecated use of strncpy and clean up
this code nicely!

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
I realize this file has been marked as "obsolete" as told by checkpatch:
|	WARNING: fs/reiserfs/item_ops.c is marked as 'obsolete' in the MAINTAINERS hierarchy.  No unnecessary modifications please.

... but I really want to remove ALL instances of strncpy so we can rip
it out of the kernel as per: https://github.com/KSPP/linux/issues/90.
---
 fs/reiserfs/item_ops.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/reiserfs/item_ops.c b/fs/reiserfs/item_ops.c
index 3a5a752d96c7..5011c10287c6 100644
--- a/fs/reiserfs/item_ops.c
+++ b/fs/reiserfs/item_ops.c
@@ -389,16 +389,9 @@ static void direntry_print_item(struct item_head *ih, char *item)
 		name = item + deh_location(deh);
 		if (name[namelen - 1] == 0)
 			namelen = strlen(name);
-		namebuf[0] = '"';
-		if (namelen > sizeof(namebuf) - 3) {
-			strncpy(namebuf + 1, name, sizeof(namebuf) - 3);
-			namebuf[sizeof(namebuf) - 2] = '"';
-			namebuf[sizeof(namebuf) - 1] = 0;
-		} else {
-			memcpy(namebuf + 1, name, namelen);
-			namebuf[namelen + 1] = '"';
-			namebuf[namelen + 2] = 0;
-		}
+
+		scnprintf(namebuf, sizeof(namebuf), "\"%.*s\"",
+			  (int)sizeof(namebuf)-3, name);
 
 		printk("%d:  %-15s%-15d%-15d%-15lld%-15lld(%s)\n",
 		       i, namebuf,

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240328-strncpy-fs-reiserfs-item_ops-c-c2f9b8a6c1f3

Best regards,
--
Justin Stitt <justinstitt@google.com>

