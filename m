Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3C1C71155
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C77624124
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiVBZscc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgKTSfH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730595AbgKTSfH (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:35:07 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B1E02408E;
        Fri, 20 Nov 2020 18:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897306;
        bh=Av3CctImS5px+vH5aOGnfmJT/5+na98GlyjEbLF9eUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SiVBZsccUC4NpRfbtlFuQWAATL1H4zKKttK6TJDLyoZ2uVPo2X6uKTUx1XRKQlP93
         uHYUqgPcpUxfYsRPpY5AWv+tQjsO4NlMncEEPFijghWTxd9rWv6EqC0UF/TShGbmsQ
         74m3R9JKdJbglFn0+W6xDXty1JSgikm3ASMagTfY=
Date:   Fri, 20 Nov 2020 12:35:11 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 078/141] drm/amd/pm: Fix fall-through warnings for Clang
Message-ID: <b73d98f74902b495689069177ffde953e1a061fb.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
of warnings by explicitly adding a break statement instead of letting
the code fall through to the next case, and a fallthrough pseudo-keyword
as a replacement for a /* fall through */ comment,

Notice that Clang doesn't recognize /* fall through */ comments as
implicit fall-through markings.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c                  | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index b5986d19dc08..afa1711c9620 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -6200,8 +6200,8 @@ static void si_request_link_speed_change_before_state_change(struct amdgpu_devic
 		case AMDGPU_PCIE_GEN2:
 			if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
 				break;
+			fallthrough;
 #endif
-			/* fall through */
 		default:
 			si_pi->force_pcie_gen = si_get_current_pcie_speed(adev);
 			break;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index c3d2e6dcf62a..7d7d698c7976 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -2272,6 +2272,7 @@ static int polaris10_update_smc_table(struct pp_hwmgr *hwmgr, uint32_t type)
 		break;
 	case SMU_BIF_TABLE:
 		polaris10_update_bif_smc_table(hwmgr);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

