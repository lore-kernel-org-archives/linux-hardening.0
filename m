Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22AC432BE
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 03:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E1760E99
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 03:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbhH0DRk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 23:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244077AbhH0DRk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 23:17:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3028C0613C1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 20:16:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d17so3047401plr.12
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 20:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Bce03JETrzRTBCx67BKzzG67CqV+rVyAmVgfbY2R98=;
        b=TQzwMV1p5Prk0gGyavK+W/IvCmvya/Vc+wjN8gRjd7LuFrilVEKRfmOwf0YvRseQ+R
         cOfZRyFilbMnzNh3M1liQe6ihaIoNeJtN6SJCZW3gzkAnbdw7xxS1iADYhPIT/3Ajp2Z
         arHAPghOAlIep79ygmgdiSiywjkwtH8ze6U70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Bce03JETrzRTBCx67BKzzG67CqV+rVyAmVgfbY2R98=;
        b=uAgKww2ZobK6l3Qpzkn4CO5LoM/tFG2gNmijeFQdwmHgkh3n4lNaYdRFspx7lx3YQ8
         wezk49clJw79uwTpFhbcKpgEaaA+PuH/snpZWv2cLh2ZEaZpX4L3qvDyQHK0PeBLKyRF
         AeDBiyiSY4Lxbs1bZtBK9MFlcs/NYfbW7Z2fGFSm1ZnFH1gp0EMdM5sJF6ODAWisUE6A
         aLd/tUg3WnU9McQ2cLf1kkW8FvrVnqHog73jAIcXSgMBeoNHNWRmKGJcEp8zAxyXphqd
         +EqP9Cm+s3lbbm0bwTjocul9CANPugkpa4M3FGKRgSMUJXlwyGkgHAQSDWPfLYyxbxKD
         QGew==
X-Gm-Message-State: AOAM532FRFavm6MMJbO+M4teI/scFpLlHf7Sv37tc1y2YzdAQL7+v8D7
        2CCZ7oPWScoFXAAO7E3pnezo8A==
X-Google-Smtp-Source: ABdhPJwPyyT+f3x1j2UZaMSQO66Rv6bh+5vZ0anST2XY4etb3TPn4bp/ofgQxQcwcdfUHBO2y0GWYg==
X-Received: by 2002:a17:90b:f8d:: with SMTP id ft13mr20345178pjb.228.1630034211114;
        Thu, 26 Aug 2021 20:16:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b17sm5185691pgl.61.2021.08.26.20.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:16:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        Jiawei Gu <Jiawei.Gu@amd.com>, Evan Quan <evan.quan@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Lijo Lazar <lijo.lazar@amd.com>,
        Darren Powell <darren.powell@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Ryan Taylor <Ryan.Taylor@amd.com>,
        Graham Sider <Graham.Sider@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        David M Nieto <david.nieto@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        John Clements <john.clements@amd.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] drm/amd/pm: And destination bounds checking to struct copy
Date:   Thu, 26 Aug 2021 20:16:47 -0700
Message-Id: <20210827031647.2069945-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6646; h=from:subject; bh=l/HykKGKZ/lNbmKW9XocYhto47HK5IIlertRLOIBrms=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhKFkeNlK7S7S7FDCkJ+mjmsiZZTEmDY4kXit477yu i+FQlXWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYShZHgAKCRCJcvTf3G3AJjkpEA CL7oYV3Rjc9EGLFlAov18nHd/fM3DMWfr1zwSh8CUI1eM87GFa3hbplAoB8ehl5F/vdOxmnEXFGRLH YGwTVBjnGaCSD2zFmjC90IGj3SatilgtO3EVTAyXI283Ho/4ri+jKjeXvn333i5+PI8dSp8Kv4uQUg qf61OvZzuXvRf29J/QmJ+tmbu3PeRNxta7TIz4xZvwFDxaGOi9XDV5eUz2BguWlHMZ3+Rvy2vk32TY PQkpddBUrLD7/ELg5LbueKbOIReswsVuL6nRSTIiZrVb6s+l46qKR9ry1e27JgEHej5wsBDdNbvmCa MQrMW3lqV3iqmiYeZTEC0dTIrp/iwtZGCpBO8VOFdEwKAaGejDiYECN4aC95NO3l3Nm90LE+oh/EXd M2WimYS0+pLcXCOICK45DVugOiERDDTUqPAixAZogU5YGkSjyzFXgJuzWzueAgAakbIWJM6eeY0DBU xZGeaqZvoCBrAEQNLwCnzJf/fWV+Z44CiErdUftq9QbDv/OUlo80m3Oq1GY7wwcJtig5IMqxJS+wQ4 tjoiPdH0arG6Am260/XleuVtPSGHf9QcHB5K/fB7ulx+mz7z49vLQfA9uc0kAxQewTgsXk+12AC5lo 52CsCcxh9evy+PwHVD/ElWmt5AC3AR4DUSKr8gFxJ9i1nvH8zoBKbr5hMC2w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

The "Board Parameters" members of the structs:
	struct atom_smc_dpm_info_v4_5
	struct atom_smc_dpm_info_v4_6
	struct atom_smc_dpm_info_v4_7
	struct atom_smc_dpm_info_v4_10
are written to the corresponding members of the corresponding PPTable_t
variables, but they lack destination size bounds checking, which means
the compiler cannot verify at compile time that this is an intended and
safe memcpy().

Since the header files are effectively immutable[1] and a struct_group()
cannot be used, nor a common struct referenced by both sides of the
memcpy() arguments, add a new helper, amdgpu_memcpy_trailing(), to
perform the bounds checking at compile time. Replace the open-coded
memcpy()s with amdgpu_memcpy_trailing() which includes enough context
for the bounds checking.

"objdump -d" shows no object code changes.

[1] https://lore.kernel.org/lkml/e56aad3c-a06f-da07-f491-a894a570d78f@amd.com

Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Feifei Xu <Feifei.Xu@amd.com>
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: Jiawei Gu <Jiawei.Gu@amd.com>
Cc: Evan Quan <evan.quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3: rename amdgpu_memcpy_trailing() to smu_memcpy_trailing()
v2: https://lore.kernel.org/lkml/20210825161957.3904130-1-keescook@chromium.org
v1: https://lore.kernel.org/lkml/20210819201441.3545027-1-keescook@chromium.org
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       | 24 +++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  6 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  8 +++----
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  5 ++--
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 715b4225f5ee..8156729c370b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1335,6 +1335,30 @@ enum smu_cmn2asic_mapping_type {
 #define WORKLOAD_MAP(profile, workload) \
 	[profile] = {1, (workload)}
 
+/**
+ * smu_memcpy_trailing - Copy the end of one structure into the middle of another
+ *
+ * @dst: Pointer to destination struct
+ * @first_dst_member: The member name in @dst where the overwrite begins
+ * @last_dst_member: The member name in @dst where the overwrite ends after
+ * @src: Pointer to the source struct
+ * @first_src_member: The member name in @src where the copy begins
+ *
+ */
+#define smu_memcpy_trailing(dst, first_dst_member, last_dst_member,	   \
+			    src, first_src_member)			   \
+({									   \
+	size_t __src_offset = offsetof(typeof(*(src)), first_src_member);  \
+	size_t __src_size = sizeof(*(src)) - __src_offset;		   \
+	size_t __dst_offset = offsetof(typeof(*(dst)), first_dst_member);  \
+	size_t __dst_size = offsetofend(typeof(*(dst)), last_dst_member) - \
+			    __dst_offset;				   \
+	BUILD_BUG_ON(__src_size != __dst_size);				   \
+	__builtin_memcpy((u8 *)(dst) + __dst_offset,			   \
+			 (u8 *)(src) + __src_offset,			   \
+			 __dst_size);					   \
+})
+
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_get_power_limit(void *handle,
 			uint32_t *limit,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 273df66cac14..e343cc218990 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -483,10 +483,8 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
 
 	if ((smc_dpm_table->table_header.format_revision == 4) &&
 	    (smc_dpm_table->table_header.content_revision == 6))
-		memcpy(&smc_pptable->MaxVoltageStepGfx,
-		       &smc_dpm_table->maxvoltagestepgfx,
-		       sizeof(*smc_dpm_table) - offsetof(struct atom_smc_dpm_info_v4_6, maxvoltagestepgfx));
-
+		smu_memcpy_trailing(smc_pptable, MaxVoltageStepGfx, BoardReserved,
+				    smc_dpm_table, maxvoltagestepgfx);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f96681700c41..a5fc5d7cb6c7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -431,16 +431,16 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 
 	switch (smc_dpm_table->table_header.content_revision) {
 	case 5: /* nv10 and nv14 */
-		memcpy(smc_pptable->I2cControllers, smc_dpm_table->I2cControllers,
-			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
+		smu_memcpy_trailing(smc_pptable, I2cControllers, BoardReserved,
+				    smc_dpm_table, I2cControllers);
 		break;
 	case 7: /* nv12 */
 		ret = amdgpu_atombios_get_data_table(adev, index, NULL, NULL, NULL,
 					      (uint8_t **)&smc_dpm_table_v4_7);
 		if (ret)
 			return ret;
-		memcpy(smc_pptable->I2cControllers, smc_dpm_table_v4_7->I2cControllers,
-			sizeof(*smc_dpm_table_v4_7) - sizeof(smc_dpm_table_v4_7->table_header));
+		smu_memcpy_trailing(smc_pptable, I2cControllers, BoardReserved,
+				    smc_dpm_table_v4_7, I2cControllers);
 		break;
 	default:
 		dev_err(smu->adev->dev, "smc_dpm_info with unsupported content revision %d!\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ec8c30daf31c..ab652028e003 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -409,9 +409,8 @@ static int aldebaran_append_powerplay_table(struct smu_context *smu)
 
 	if ((smc_dpm_table->table_header.format_revision == 4) &&
 	    (smc_dpm_table->table_header.content_revision == 10))
-		memcpy(&smc_pptable->GfxMaxCurrent,
-		       &smc_dpm_table->GfxMaxCurrent,
-		       sizeof(*smc_dpm_table) - offsetof(struct atom_smc_dpm_info_v4_10, GfxMaxCurrent));
+		smu_memcpy_trailing(smc_pptable, GfxMaxCurrent, reserved,
+				    smc_dpm_table, GfxMaxCurrent);
 	return 0;
 }
 
-- 
2.30.2

