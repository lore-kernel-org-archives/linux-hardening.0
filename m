Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF85FC433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Feb 2021 23:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A305064DF0
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Feb 2021 23:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhBJX1F (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:27:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234140AbhBJX0o (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Feb 2021 18:26:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B226264EBB;
        Wed, 10 Feb 2021 23:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612999563;
        bh=z8PK7lQxdEjakhT1mHS5xkJS/hPiBnY76N9BArEFwI4=;
        h=Date:From:To:Cc:Subject:From;
        b=VHlMdkT+qJ2LMjznNTTzv1KOzBwgPGAT53rOQwZEt75wjMHB+z6g9eUm7YrFyNFXl
         3+C7C+HhmgUJt/9n+dyLxhXE2xHxs8nWrkcXwnPQmM+LChfhsQgOiMmR6k6xqEVw9k
         M3IAjSHXGqTqGw+Gc7mLOwZZmnzCJoA6s8j76wAa3xQsF+3oLi1xCzzF6ljjdJp8J9
         7omyZpecO7i8WzMbd0oIQTGH5YNFbkc2n+XtzKN3SGgPYleAz0hTvKVAb3onmc2Pwu
         g/RWjBSasGV/n7GjhUWUpf3AoY0PXmkDBFjD8DTDDtcGWqQZNQW7CtbsYD/V4aWS75
         GFh0igzGmUaSA==
Date:   Wed, 10 Feb 2021 17:26:00 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/amd/pm: Replace one-element array with
 flexible-array in struct _ATOM_Vega10_GFXCLK_Dependency_Table
Message-ID: <20210210232600.GA66488@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Use flexible-array member in struct _ATOM_Vega10_GFXCLK_Dependency_Table,
instead of one-element array.

Also, this helps with the ongoing efforts to enable -Warray-bounds and
fix the following warning:

drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c: In function ‘vega10_get_pp_table_entry_callback_func’:
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:3113:30: warning: array subscript 4 is above array bounds of ‘ATOM_Vega10_GFXCLK_Dependency_Record[1]’ {aka ‘struct _ATOM_Vega10_GFXCLK_Dependency_Record[1]’} [-Warray-bounds]
 3113 |     gfxclk_dep_table->entries[4].ulClk;
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~^~~

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/6023ff3d.WY3sSCkGRQPdPlVo%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
index c934e9612c1b..9c479bd9a786 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
@@ -161,9 +161,9 @@ typedef struct _ATOM_Vega10_MCLK_Dependency_Record {
 } ATOM_Vega10_MCLK_Dependency_Record;
 
 typedef struct _ATOM_Vega10_GFXCLK_Dependency_Table {
-    UCHAR ucRevId;
-    UCHAR ucNumEntries;                                         /* Number of entries. */
-    ATOM_Vega10_GFXCLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+	UCHAR ucRevId;
+	UCHAR ucNumEntries;					/* Number of entries. */
+	ATOM_Vega10_GFXCLK_Dependency_Record entries[];		/* Dynamically allocate entries. */
 } ATOM_Vega10_GFXCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_MCLK_Dependency_Table {
-- 
2.27.0

