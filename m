Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41679C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 16:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB4D6103E
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 16:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbhHYQVw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbhHYQVs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 12:21:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBEFC0698C1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 09:20:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso170635pjq.4
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9XhY8p7G+0bDyMlbnytdHLPofSqK0+HvIRX3QNft6U=;
        b=er5jXCwFvNHmPXCLmHbM9lgRrgRCxgG1opusLq2zieJBNo77QgyOCSKYRVXtfsQ7oi
         k+L/TFn+Cgt5x4X3lQu+kAkG0XCM8G1fU8xVhlBZMClibfRNT8rfyCbV1bWD/NWn/qGQ
         cnLRWzWVgnoe9Nrf2hU/7dyApLfH1yGuGU9X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9XhY8p7G+0bDyMlbnytdHLPofSqK0+HvIRX3QNft6U=;
        b=hzaYkBh9G6AoSfFLxPGOSV5e/xEGJns83S2oUHuEfuMqDMXU6NljHx0q02mF5AKIAR
         8hN5O61i1JIj9ZwPeTO5OkR9+vX21AoTeHOSWF+YE7ralrRcTIzu+A8+J+EUsitk4sOM
         5CI/SxsJVP5w0CkFkSBGDfbyoQTpXUYeLUCmmtA2ay3yKZD2kXGrCREX7VyhugEniB8q
         Orws1qJUsZdp2ESTw6Ifx8eOSgjSbsB+gctBqXNGUQ63gsiZC2wbFlv5RHyIdOdho0tI
         XMgNHFg764RxuOyliLPiLcdGnQrx3ZGan5Mip2mc7n4eQz4v5FfHVoTEYX4f68RPOTSz
         IxOw==
X-Gm-Message-State: AOAM531y+C5yQbmHDDvCQ9zEhAcztJ1r58f5/B5t23b+ld8yHQsMnVYm
        5L2cJOYvyXTuIbz+8REo+V7nhg==
X-Google-Smtp-Source: ABdhPJxLw35PQJptMjCd//eeBe1KjTkohZdpaMBavFZprJQ6S+Pbpoi+JNSD0gcZPFFZBT++CNzxRQ==
X-Received: by 2002:a17:90a:4093:: with SMTP id l19mr11481974pjg.118.1629908400185;
        Wed, 25 Aug 2021 09:20:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x19sm286030pfo.40.2021.08.25.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:19:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        Jiawei Gu <Jiawei.Gu@amd.com>, Evan Quan <evan.quan@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Sathishkumar S <sathishkumar.sundararaju@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Darren Powell <darren.powell@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Ryan Taylor <Ryan.Taylor@amd.com>,
        Graham Sider <Graham.Sider@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        David M Nieto <David.Nieto@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        John Clements <john.clements@amd.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] drm/amd/pm: And destination bounds checking to struct copy
Date:   Wed, 25 Aug 2021 09:19:57 -0700
Message-Id: <20210825161957.3904130-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7050; h=from:subject; bh=vF67s6QnU0fC5nISbg7n5vHeCrbf4UxTJE11PW86ehA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhJm2sqJLOuF3URRcTav9BLmXNiA7slPCKTLtLOLI5 ImHjN5GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSZtrAAKCRCJcvTf3G3AJivOD/ wNaiUJ5ux73lmKYESY4bT3EXBpHilQ9p5V+3lwyxKfURqdki00w311PXX4vMM1L+hfQHL6TKPoiuc5 nzlR+CMZIshnglKxUWjttBLiAFLdZM9FAsusFb6JVISf9gGGRmapAG43us+wPX0T1YzNx6LWpkMU07 yh2xJ6QmFtrhgBe7S3ktSizAI4T32hGhOJ+Woh+YZxZw6psrqr+l6zEKRd9q8kOG7w+TEw6P1rx7O0 wWG+1jg8pSPk5KUVzLC/3FsSkEgaTpDNtTLkmMQayLKgi0MCQnRjseQ0VncXswyYwOni9Mn1Hu/En3 BPZyozNulGMZDtNEtMOygZZHXjx3hl2jwjMMkabwWZ2/J4Lt3XsZzQVN4POqDNEKGhQ+EcljGBNucY UrSIgQMYd17/Q1K8fJHRX4g5NGzDEBGyJu9TmpMj9d19HjpKZZ8Axsj55vcvVX8JoAokiziT8gjIho 6Jlvg9JAobQYZtLfBNzK4Ca3beMXk5vt+k1c7deuag4aAxohkNzXwtCtIW3qYtmgXWU2F0m5HDVA3G 9xBrdCFp83WAMTYNmxIgS7h3Rkkcyx5YvfbgxevaCg1QN5HZZzPW30x33v9YXgsTrXIjX7S+sX2LUt 66ZuedhDRBHLBDh0lwK7gJh40hnlcGPO2QduiNB5L3AYFQ3fqCPG/7GsYGxw==
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
v2:
- rename and move helper to drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
- add reviews/acks
v1: https://lore.kernel.org/lkml/20210819201441.3545027-1-keescook@chromium.org/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       | 24 +++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  6 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  8 +++----
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  5 ++--
 5 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc3c6b3a00e5..c911387045e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1452,4 +1452,5 @@ static inline int amdgpu_in_reset(struct amdgpu_device *adev)
 {
 	return atomic_read(&adev->in_gpu_reset);
 }
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 715b4225f5ee..29031eb11d39 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1335,6 +1335,30 @@ enum smu_cmn2asic_mapping_type {
 #define WORKLOAD_MAP(profile, workload) \
 	[profile] = {1, (workload)}
 
+/**
+ * amdgpu_memcpy_trailing - Copy the end of one structure into the middle of another
+ *
+ * @dst: Pointer to destination struct
+ * @first_dst_member: The member name in @dst where the overwrite begins
+ * @last_dst_member: The member name in @dst where the overwrite ends after
+ * @src: Pointer to the source struct
+ * @first_src_member: The member name in @src where the copy begins
+ *
+ */
+#define amdgpu_memcpy_trailing(dst, first_dst_member, last_dst_member,	   \
+			       src, first_src_member)			   \
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
index 273df66cac14..bda8fc12c91f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -483,10 +483,8 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
 
 	if ((smc_dpm_table->table_header.format_revision == 4) &&
 	    (smc_dpm_table->table_header.content_revision == 6))
-		memcpy(&smc_pptable->MaxVoltageStepGfx,
-		       &smc_dpm_table->maxvoltagestepgfx,
-		       sizeof(*smc_dpm_table) - offsetof(struct atom_smc_dpm_info_v4_6, maxvoltagestepgfx));
-
+		amdgpu_memcpy_trailing(smc_pptable, MaxVoltageStepGfx, BoardReserved,
+				       smc_dpm_table, maxvoltagestepgfx);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f96681700c41..88a4a2aed48e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -431,16 +431,16 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 
 	switch (smc_dpm_table->table_header.content_revision) {
 	case 5: /* nv10 and nv14 */
-		memcpy(smc_pptable->I2cControllers, smc_dpm_table->I2cControllers,
-			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
+		amdgpu_memcpy_trailing(smc_pptable, I2cControllers, BoardReserved,
+				       smc_dpm_table, I2cControllers);
 		break;
 	case 7: /* nv12 */
 		ret = amdgpu_atombios_get_data_table(adev, index, NULL, NULL, NULL,
 					      (uint8_t **)&smc_dpm_table_v4_7);
 		if (ret)
 			return ret;
-		memcpy(smc_pptable->I2cControllers, smc_dpm_table_v4_7->I2cControllers,
-			sizeof(*smc_dpm_table_v4_7) - sizeof(smc_dpm_table_v4_7->table_header));
+		amdgpu_memcpy_trailing(smc_pptable, I2cControllers, BoardReserved,
+				       smc_dpm_table_v4_7, I2cControllers);
 		break;
 	default:
 		dev_err(smu->adev->dev, "smc_dpm_info with unsupported content revision %d!\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ec8c30daf31c..d46b892846f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -409,9 +409,8 @@ static int aldebaran_append_powerplay_table(struct smu_context *smu)
 
 	if ((smc_dpm_table->table_header.format_revision == 4) &&
 	    (smc_dpm_table->table_header.content_revision == 10))
-		memcpy(&smc_pptable->GfxMaxCurrent,
-		       &smc_dpm_table->GfxMaxCurrent,
-		       sizeof(*smc_dpm_table) - offsetof(struct atom_smc_dpm_info_v4_10, GfxMaxCurrent));
+		amdgpu_memcpy_trailing(smc_pptable, GfxMaxCurrent, reserved,
+				       smc_dpm_table, GfxMaxCurrent);
 	return 0;
 }
 
-- 
2.30.2

