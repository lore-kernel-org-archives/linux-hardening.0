Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F771EEAA77
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Sep 2023 21:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjINVOP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjINVOO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 17:14:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9068626BE
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 14:14:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5925fb6087bso18361937b3.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726050; x=1695330850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Utwbn05dq1P3cRtHOia0ZZtBcmsSMx5ruKCs/P2Bvow=;
        b=gRTzGf5Wgw2/H/KNWTK1j/bD4V/KwuvMUyaza2R89tJgLBrYSUdgJMAxc7V9ImBd0Q
         yzFczZDEXLMiJbifoR6wn16NA1LpgqL1WSn2xcee/1ap5qFgYeahbgzukzZ4D2aF6+Y/
         9V2wR4g9vgj8JF29uEzAnenVLypQTi48j/Y2j96/Uvif6V2mIrqQh/P7ffNmzX81UiTS
         5uY/pah0U+yLnXd+fCdi533XFm1k3WIKZVoSqxxvy4IcEV7qhjWvDEBw+JmfbzsflEMr
         KT6dfc1SZApAvBJSxtihtVpHgCvluI1Vtk+scr8JvHrHc0CGXDJO8qvAFG6KDOmVS+HF
         V2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726050; x=1695330850;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Utwbn05dq1P3cRtHOia0ZZtBcmsSMx5ruKCs/P2Bvow=;
        b=AACZXUmtJoJ2/jwBXi5GOzY+OT/3U1jo8ANIhrtTAmc0CLGG68PmesM5En29LtZwAM
         bI3j0yuxanhK1kXjpuquSXwWaCu6NpswoxeQoT/6enw4EYJazVvubbUjB3ITeFw/ZTG5
         LGHTZaITgUSnvoEKBQ//dCdu1xf899Wg2Ydsjl1B+ZSHZs5gizRPyJf+ECHLVOjpRIKw
         14QcwfAMJV0tzqOTy/U0xOoTCEgVmEMzPeeLekyX0lragmFQFoRTv4RyOXXZ6cF+1SE9
         aZlBzZZXv7CS/RlIwQVvFsVFgry6pzY5vN9Tlc4Ty83Lz/B8YOgyp5iG8bqYvLD49nk9
         FpDA==
X-Gm-Message-State: AOJu0Yz1xdv9VJUgO1AZq3mQIQvQtWjR3fZQlNdpjMWMvejnRvG6NsWn
        H/DrYBuNODfrdm25beM/35FWzCutlUgxdBNNww==
X-Google-Smtp-Source: AGHT+IER36kioS8OEQ6mW1MX0UaEyRGxkscXFet8xuTfWHv4C/xW3RLVWiv7TxQnUUbCzU6IzHZhFSDlYovg3BK4jA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:385:0:b0:d81:bb31:d2fa with SMTP
 id 127-20020a250385000000b00d81bb31d2famr27447ybd.3.1694726049875; Thu, 14
 Sep 2023 14:14:09 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:14:07 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ93A2UC/x2NywrCMBAAf6Xk7EISFRp/RURku42L5sFuLJXSf
 zd4m7nMbEZJmNRchs0ILaxcchd3GAw+HzkS8NTdeOuPNrgTaJOM9QuT8EKiEOuncwIO7gyREii 950baFFLB1x1LbrQ2QAijxZEQe8Wb3q9CM6//9/W27z+CzKY7iwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694726048; l=1748;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rUGaAKYDAI4tRkXj4vLoGXXH5bgLIpzt3gFa14KFRqo=; b=UKJjqLcZ98/YSLUUQU9h/fX9EPUL6MGCgnZQv0LIXvqtcWCkalUmCEO2+q3xYXDVzZmuDBhh3
 5Vr6lYASBMSBjn/LjbYtIm2jODAgQdE0C1Pnma6HaMChyGag60U+ITo
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-gpu-drm-i915-gem-selftests-mock_context-c-v1-1-c3f92df942e0@google.com>
Subject: [PATCH] drm/i915: refactor deprecated strncpy
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

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily NUL-padding.

`ctx` is zero allocated and as such strncpy's NUL-padding behavior was
strictly a performance hit which should now be resolved. It should be
noted, however, that performance is not critical in these selftests,
especially by these margins.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/gpu/drm/i915/gem/selftests/mock_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_context.c b/drivers/gpu/drm/i915/gem/selftests/mock_context.c
index 8ac6726ec16b..025b9c773b93 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_context.c
@@ -36,7 +36,7 @@ mock_context(struct drm_i915_private *i915,
 	if (name) {
 		struct i915_ppgtt *ppgtt;
 
-		strncpy(ctx->name, name, sizeof(ctx->name) - 1);
+		strscpy(ctx->name, name, sizeof(ctx->name) - 1);
 
 		ppgtt = mock_ppgtt(i915, name);
 		if (!ppgtt)

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-gpu-drm-i915-gem-selftests-mock_context-c-980c8ecc9142

Best regards,
--
Justin Stitt <justinstitt@google.com>

