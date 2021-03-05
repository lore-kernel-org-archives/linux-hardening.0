Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B400C433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D2364EE1
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCEJ51 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCEJ5A (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 04:57:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24F6364DF4;
        Fri,  5 Mar 2021 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614938219;
        bh=9BmS0kveghpNaMuDKytgyUYioo9f1ZWWPnYnjLIlXiM=;
        h=Date:From:To:Cc:Subject:From;
        b=uD9p7kmeDCz9RzL6h67uN8QlU7c0YXR8MUbXic3xNHI+SKMeU/WGrWgwbDb0RNX/6
         FQ8S9XvNcqGTxy1GXmnC51vZs+cHcKG7iQInyX510KfHTrtTWR3oSM5Qu13ngY0KMm
         zaMUC7NrbGW9GoZ+kL6NLF3ysoZERtEkYS0sviPHEvUDzrpMDOn/96AIC+iX9UGwcg
         YKaT7J8WdnRlbBMtcjsI8ZH7AVb2PfaY0SLTsr2CM1aXIVCPx235Wu2UJVKJIrlQtr
         TnSl/OHqQdpnIEkiXKvvP6JqpNitXoEqTbAiAxaneNPASKUBhLlXlV4zjJh0Dt5i21
         EaQ8R14GC7gvw==
Date:   Fri, 5 Mar 2021 03:56:57 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] drm/nouveau: Fix fall-through warnings for Clang
Message-ID: <20210305095657.GA142006@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
of warnings by explicitly adding a couple of break statements instead
of letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c        | 1 +
 drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 2375711877cf..62903c3b368d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -443,6 +443,7 @@ nouveau_bo_pin(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
 			break;
 		case TTM_PL_TT:
 			error |= !(domain & NOUVEAU_GEM_DOMAIN_GART);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 61e6d7412505..eb844cdcaec2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -157,6 +157,7 @@ nouveau_conn_atomic_set_property(struct drm_connector *connector,
 			default:
 				break;
 			}
+			break;
 		case DRM_MODE_SCALE_FULLSCREEN:
 		case DRM_MODE_SCALE_CENTER:
 		case DRM_MODE_SCALE_ASPECT:
-- 
2.27.0

