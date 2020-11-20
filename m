Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39733C8300B
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DC32224C
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPJCGoQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgKTS2J (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730287AbgKTS2H (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:28:07 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C8B2224C;
        Fri, 20 Nov 2020 18:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896887;
        bh=ITxFoy4MVc42ndwX0jIIAa7SbZop74YrE0LYwrVuP7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPJCGoQjpThZZ/JXn1jpc3jG+TydIj7u88U/uy00mGaTTnBM+izlWhAKiNdNXj+lK
         VXgqzUdX4pc21MyJ7ZxDyaCxelstxLQeqvBlgeez1ag623llErpw4KmzGvBJTw8T27
         uzIF4bywLRRHqmLHXIKKuybf/tw4t2YF5JungJ+c=
Date:   Fri, 20 Nov 2020 12:28:12 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 028/141] drm/amd/display: Fix fall-through warnings for Clang
Message-ID: <9ac81a4aab74e0b3317172e66a985fe6d1ae4e1b.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements instead of just
letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  | 1 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index ad394aefa5d9..23a373ca94b5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -1198,6 +1198,7 @@ static enum bp_result bios_parser_get_embedded_panel_info(
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 29d64e7e304f..fd1e64fa8744 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -903,6 +903,7 @@ static enum bp_result bios_parser_get_soc_bb_info(
 			break;
 		case 4:
 			result = get_soc_bb_info_v4_4(bp, soc_bb_info);
+			break;
 		default:
 			break;
 		}
@@ -1019,6 +1020,7 @@ static enum bp_result bios_parser_get_embedded_panel_info(
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fec87a2e210c..b9254a87ee73 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1052,6 +1052,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 
 				return false;
 			}
+			break;
 		default:
 			break;
 		}
-- 
2.27.0

