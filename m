Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BADBEEAA7B
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Sep 2023 22:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjINWRX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjINWRO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 18:17:14 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA382724
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 15:17:10 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1d64d665e38so982569fac.1
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694729829; x=1695334629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NmiSL1hPoXorfA2q6qNOq7ioFso4QUSjYQj36GecrTE=;
        b=xkngvD2Ibfn8w03jxth/IdNDuHUov2S9wEE3mKAgK6Q1mChzRVyw499SXq0AUo289Y
         +JKqJd5TxrL2PO0QKNR23nWlvl+MrmwriQSqIDEvCUnQd7Uo1p0lI6XDj9OYqGoIkXck
         J52jeUoyaC9rVgZDVdETfWrEwEszVZ7TSIDG2h37hl9k13Tq+YmW9EiDJUA51/nf10WK
         BZVMls7AVpXNkoY3o0KpqXGp6n2kd1H6koJZTJ4EMOE2GfZ8txQDffzrlTUlK6yqOwur
         qV+YJoBcWV7/tAxy6NAzSig4O+Rx095bL6zYNVPjmsp0kcIPm3buw0KK2lkdTG32viMt
         KB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694729829; x=1695334629;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmiSL1hPoXorfA2q6qNOq7ioFso4QUSjYQj36GecrTE=;
        b=DpeFktzoq1GvgWLFZY0hHo9mAbRfpAr89CGXAWCLKcbS7AeUeEzYJEVkwQrItVkoRe
         zm+U8MLFkq45bRzB9NIzTYIbPSe1SL1PExi7fWqEimSOLzFX1faXqpoPLd20KK02cQVn
         C4fgO+gaxIGKXtevNV8ANQUDYVJRzbLh2Mn1ND5h9bIYJ1ihdcaAHg6zCbX83ukwBgK0
         h/J2iX6CkrFDiJU1JpOOg33qnFFhRj6mCqVgCXsnK1LI3TlESuPo1Ns/xkNormgZfzib
         87tbIAooSDcasW1woplLd9mRFji+YxAhggfSI5dCQlIIm0EPLgrW9PoSldygtIjTsekb
         SVWA==
X-Gm-Message-State: AOJu0YyQA8eDzfusprBYygw8Fjp5c9p87Cnd3q0tT+iSFFrXxsffZqx3
        7JSNC+F1vKdYgZ+aLRQ3sayrAGQbWS/fraP8DQ==
X-Google-Smtp-Source: AGHT+IFwcROu4zar64CAvXwI9J0nMFhba4+cLsta+BCeiKNlxnKo7O4A0MBXBGcuyAHHg0RNV0zPR7a2HtcCyI3FeQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:5b17:b0:1d6:6175:e8b7 with
 SMTP id ds23-20020a0568705b1700b001d66175e8b7mr704oab.4.1694729829605; Thu,
 14 Sep 2023 15:17:09 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:17:08 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGOGA2UC/x2NQQqDMBAAvyI5dyFqodqvlB6SuEmXkjXsamgR/
 97Q28xl5jCKQqjm3h1GsJLSyk36S2fCy3FCoKW5Geww2rm/gm7CoXxhEaooCqnsjTPwuld0O3B 9Z0BOxAglg3eKEGCcfJzDbfLBRtPaRTDS5/99PM/zB65MP5KHAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694729828; l=2319;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=RxOj2KRPJoHaPbd44NSfvp7xlYOfBBUfmUGMt4NplWM=; b=DjqYwwhRW21CQ5QMz9Kq/kMZK/2XQMBC1ojIhEn54/lvBB1ZMdiXQOPyCP7EYWc+wzaWYIxZw
 urNwQ6OfNmeAjWVrv9S1uYW4YBYQvugcZXBlGnwgHVmMTJgXi8klaNc
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
Subject: [PATCH] drm/nouveau/pm: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c
index 8fe0444f761e..131db2645f84 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c
@@ -462,7 +462,7 @@ nvkm_perfmon_mthd_query_domain(struct nvkm_perfmon *perfmon,
 
 		args->v0.id         = di;
 		args->v0.signal_nr  = nvkm_perfdom_count_perfsig(dom);
-		strncpy(args->v0.name, dom->name, sizeof(args->v0.name) - 1);
+		strscpy(args->v0.name, dom->name, sizeof(args->v0.name));
 
 		/* Currently only global counters (PCOUNTER) are implemented
 		 * but this will be different for local counters (MP). */
@@ -513,8 +513,7 @@ nvkm_perfmon_mthd_query_signal(struct nvkm_perfmon *perfmon,
 			snprintf(args->v0.name, sizeof(args->v0.name),
 				 "/%s/%02x", dom->name, si);
 		} else {
-			strncpy(args->v0.name, sig->name,
-				sizeof(args->v0.name) - 1);
+			strscpy(args->v0.name, sig->name, sizeof(args->v0.name));
 		}
 
 		args->v0.signal = si;
@@ -572,7 +571,7 @@ nvkm_perfmon_mthd_query_source(struct nvkm_perfmon *perfmon,
 
 		args->v0.source = sig->source[si];
 		args->v0.mask   = src->mask;
-		strncpy(args->v0.name, src->name, sizeof(args->v0.name) - 1);
+		strscpy(args->v0.name, src->name, sizeof(args->v0.name));
 	}
 
 	if (++si < source_nr) {

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-38bf9c78bc0f

Best regards,
--
Justin Stitt <justinstitt@google.com>

