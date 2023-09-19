Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B521CD3437
	for <linux-hardening@archiver.kernel.org>; Tue, 19 Sep 2023 04:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjISEpj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 19 Sep 2023 00:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISEpi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 19 Sep 2023 00:45:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2925FD
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 21:45:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c240e637aso39772827b3.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 21:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695098732; x=1695703532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IH7UIUO8ZPh8JCHOo7ZA6yz3Au2q4EsS6YyTIw9aKQM=;
        b=qLaTQh8H2sjpmLNdDklu83pZOfLGUCpAjLNzsvFUIp/hjqc4PL6vQ7Kl1XfmJPeOcw
         d4VH/2ttIO7RXiDOr22iCKAbwrUOpmVhWqyQbDwZrlZzCFrns9FyAqmLbKR+dYySXPuy
         dj3UAt7cfDSwy8F94twloiRUnFPH4xG4MH/8xTlztKgkUvlHSWmv0AELscwrOVQe2fB1
         pnOnPcN4BtCY6zgn/avNxf/AiPa2zVgFMCJZSnBAcPB8/NskuB648xgVhc3GgG+8pEP0
         XsGS9fBqC7Wqh0LxVI87QRQHA7osW3vn9Cx/Fo3C7P/G1zzEPg2uFa3qzqkl3n8jEnyH
         hJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695098732; x=1695703532;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IH7UIUO8ZPh8JCHOo7ZA6yz3Au2q4EsS6YyTIw9aKQM=;
        b=BihagSPnswd1eWoGbpxT+hEabprpxBUza1jtC50m3w49nudHvbATJF6CE51xCzxouv
         k80x9uGaTjxaKYnIe9ny3SL2alSVjIwlIOuQE1XX7MZ9U3YTiRZ+Lp7SCxVdV20gfjXi
         4ukoKoPr4L1oxHf8Ab75S5yZJVo3OqHwnAplP0IsJ/vmBiURDiI4CmUI7ktARK3dyY4c
         WluQ+TUMcrzEsa6bzfBl+RAicB1q2w3W2ay28mfXke6LfqTCdin1ep9RXnI/BvOjHo2S
         juo9xvNiNiJBol5epmOLfIgGlOSjceI5i/05MkLmvOPFMMuD7joXpVkVw50ypfNoR9lC
         Hntg==
X-Gm-Message-State: AOJu0YwYPqBPsy4mbbmiYcHuHg9S61rJv3q1kHiQdMVfVIC6HR8l3eb/
        lGeaTCTIkSclbxDZEKNDvCVfkyAhTeor2y+IiA==
X-Google-Smtp-Source: AGHT+IHgcK/N83YQ2mNdvYNGNQ3V9bMbqdSZuQLWzK+X7XDxRHWEcfL/+F8t4NeNL6PFrFoRAaYVuWOSmy3X6XLJNw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:4cf:b0:d7b:92d7:5629 with
 SMTP id v15-20020a05690204cf00b00d7b92d75629mr255983ybs.8.1695098732152; Mon,
 18 Sep 2023 21:45:32 -0700 (PDT)
Date:   Tue, 19 Sep 2023 04:45:31 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGonCWUC/62OQQ6CMBBFr0K6dgwtmFBX3sMQY4ahNNKWdGoDI
 dzd6hnc/fcX7/9dMEVLLK7VLiJlyzb4AupUCZye3hDYobBQtWpqLVvgFD0uGwzRZooMZnmX7MB
 qeQFDDpjmMREnBhfw9cDgE60JEHRXY0eIxaJE8S+RRrv+tu994clyCnH7Xcny2/5jNUuQgM2o1 TDqVlF9MyGYmc4YnOiP4/gA0XNhdwMBAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695098731; l=1817;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=dI5rbVcmWedpnF/X5f5wXCMNbP0y4Fo65/6bHnEkkxs=; b=BLWueVk++F3LH/WYjvrqTYV8xX1dOK4/fe3O/DQC75Af+g3syikmsn7FwpllYX2rkC8Q/Wvv2
 9roNWKMlLldDU48PuASAjnlrScRPVNPmFQ8IAPjpB3Kw1zSg3O0+Uh9
X-Mailer: b4 0.12.3
Message-ID: <20230919-strncpy-drivers-gpu-drm-i915-gem-selftests-mock_context-c-v2-1-0b5778423bd7@google.com>
Subject: [PATCH v2] drm/i915: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding. `ctx` is zero allocated and as such strncpy's
NUL-padding behavior was strictly a performance hit which is now
resolved.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- drop the `... - 1` (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-gpu-drm-i915-gem-selftests-mock_context-c-v1-1-c3f92df942e0@google.com
---
 drivers/gpu/drm/i915/gem/selftests/mock_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_context.c b/drivers/gpu/drm/i915/gem/selftests/mock_context.c
index 8ac6726ec16b..e199d7dbb876 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_context.c
@@ -36,7 +36,7 @@ mock_context(struct drm_i915_private *i915,
 	if (name) {
 		struct i915_ppgtt *ppgtt;
 
-		strncpy(ctx->name, name, sizeof(ctx->name) - 1);
+		strscpy(ctx->name, name, sizeof(ctx->name));
 
 		ppgtt = mock_ppgtt(i915, name);
 		if (!ppgtt)

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-gpu-drm-i915-gem-selftests-mock_context-c-980c8ecc9142

Best regards,
--
Justin Stitt <justinstitt@google.com>

