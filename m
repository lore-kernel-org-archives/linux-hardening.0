Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9065C4727F
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3D420789
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086129;
	bh=DnGfCBaWseLBM8TVFoELwrQRAC5MuHq6bqVMisC2Yvo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=yK3nsz8PO8J5Bn1IqXsPikwV8Sx28a4AyXfkCzsohoRI3ItC1t4ORGXr5W7b4lWX5
	 RniRvbrFZOPxsu3hq2kSNJ8e6434ds9S0N8ZQd8fKVN6VbYgaT6kZ7aPAgr98oenqH
	 m2cSQ3+jPsZECQf4j+F33Eogx56GNKDtjMkTGb6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgJGPz3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJGPz3 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 11:55:29 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F4320789;
        Wed,  7 Oct 2020 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086128;
        bh=DnGfCBaWseLBM8TVFoELwrQRAC5MuHq6bqVMisC2Yvo=;
        h=Date:From:To:Cc:Subject:From;
        b=mDVqpVfuFWeeaFRs/tBZmwj1GKg0uFJM+VvcUSBodBR9xt4w6UTErIkNxSF73hD2L
         jkR+jcqRKww35nmLeV8JBRPgoXP5GLKAYXEzm9XzC/CuQxGZN8pG0tqTw0srpYbIEl
         6QVElnqaRXGMkNHQQyo6DmmbPXe6sqOPgRilXY60=
Date:   Wed, 7 Oct 2020 11:01:28 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 00/14] drm/amd/pm: Replace one-element arrays with
 flexible-array members
Message-ID: <cover.1602020074.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

This series aims to replace one-element arrays with flexible-array
members.

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code according to the use of flexible-array members, instead
of one-element arrays, and use the struct_size() helper to calculate the
size for the dynamic memory allocation.

Also, save some heap space in the process. More on this on each individual
patch.

This series also addresses multiple of the following sorts of warnings:

drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu8_hwmgr.c:1515:37:
warning: array subscript 1 is above array bounds of ‘const struct
phm_clock_voltage_dependency_record[1]’ [-Warray-bounds]

which, in this case, they are false positives, but nervertheless should be
fixed in order to enable -Warray-bounds[3][4].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays
[3] https://git.kernel.org/linus/44720996e2d79e47d508b0abe99b931a726a3197
[4] https://github.com/KSPP/linux/issues/109

Gustavo A. R. Silva (14):
  drm/amd/pm: Replace one-element array with flexible-array member
  drm/amd/pm: Replace one-element array with flexible-array member in
    struct vi_dpm_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_clock_array
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_uvd_clock_voltage_dependency_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_acp_clock_voltage_dependency_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_phase_shedding_limits_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_vce_clock_voltage_dependency_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_cac_leakage_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_samu_clock_voltage_dependency_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_ppt_v1_clock_voltage_dependency_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_ppt_v1_mm_clock_voltage_dependency_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_ppt_v1_voltage_lookup_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    phm_ppt_v1_pcie_table
  drm/amd/pm: Replace one-element array with flexible-array in struct
    ATOM_Vega10_GFXCLK_Dependency_Table

 drivers/gpu/drm/amd/pm/inc/hwmgr.h            | 20 ++---
 .../drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h    |  8 +-
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 85 +++++++-----------
 .../amd/pm/powerplay/hwmgr/processpptables.c  | 85 +++++++-----------
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   |  5 +-
 .../amd/pm/powerplay/hwmgr/vega10_pptable.h   |  2 +-
 .../powerplay/hwmgr/vega10_processpptables.c  | 88 ++++++-------------
 8 files changed, 107 insertions(+), 188 deletions(-)

-- 
2.27.0

