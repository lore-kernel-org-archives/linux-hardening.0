Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3289A42C1F
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:32:32 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8925F10F8
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:32:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c43166b7e5so21899065ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403946; x=1696008746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTtgeSpUdLuurLr/un8bnu1axQ+1dpOqA/3ccL3TFAo=;
        b=RiZkqDxwPqiamDEPM6ALZ/ULcNxNIdY6CQequLRSq3ojpcEsCci+2dR63iJs3wo6RE
         GJ3QlvFt+RKQNkbJ3UyedpBTu/UuHhh3EgZ1agWpoJWL36PIZNAGaspCHfZCVFycCgUf
         D2cCaxVOgYQQLzqIfu+edsJpHoI8JOcJoduIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403946; x=1696008746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTtgeSpUdLuurLr/un8bnu1axQ+1dpOqA/3ccL3TFAo=;
        b=G9XvOSHL80aRkOiTDHBhShhqVFbaJ+Si1XGNgk+TL7khZR29PzsjWuFCp/3iCUZKHq
         8bhUQLzPd4fFQ6O9gEwN71n65UO/CCKwI75jrngMT9RMizMKwED+vFS45AqrwzMnomZH
         mFA/ckftx4SAL3g1jAeZ9vmj+4QDINwUORg/GVL7TLLNhOfnTmceNh1Q+Zb2Bx+V8j84
         Wpkn4nIZbnbEiDHdu/sM27942o9GNZ60Lm2LejXZ/31q9LF/n47PKJDGMQ+DWE8b4X1w
         tHlQTDIeUvyateYU5wxkNlZs791DJMHivby1Wjdt6/qzqduchB2D5MfKkCvWU/xKBOk0
         h/vw==
X-Gm-Message-State: AOJu0YxEGSoz+HSAzQVCKWqvzrGfgDMiTbdtG4Ooa7fLcrgeVgWz+B1I
	SgP3DTJ86EqAJisK1h9+f7Orfg==
X-Google-Smtp-Source: AGHT+IE4NKtjB8q0iCY5uRpFdVHfLGOGnUW9ndbQ3iwuIKZUl+ACrzobHns1ItGFQZS667ZYOrI2ZA==
X-Received: by 2002:a17:902:6944:b0:1bc:c82:9368 with SMTP id k4-20020a170902694400b001bc0c829368mr112509plt.32.1695403945964;
        Fri, 22 Sep 2023 10:32:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902864300b001b0358848b0sm3747353plt.161.2023.09.22.10.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:32:22 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Airlie <airlied@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	Emma Anholt <emma@anholt.net>,
	Evan Quan <evan.quan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	Xiaojian Du <Xiaojian.Du@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Kevin Wang <kevin1.wang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	John Harrison <john.c.harrison@Intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Ben Skeggs <bskeggs@redhat.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Zack Rusin <zackr@vmware.com>,
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	Melissa Wen <mwen@igalia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Le Ma <le.ma@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Yifan Zhang <yifan1.zhang@amd.com>,
	Prike Liang <Prike.Liang@amd.com>,
	Lang Yu <Lang.Yu@amd.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 7/9] drm/virtio: Annotate struct virtio_gpu_object_array with __counted_by
Date: Fri, 22 Sep 2023 10:32:12 -0700
Message-Id: <20230922173216.3823169-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=keescook@chromium.org;
 h=from:subject; bh=eZm0aznK0m8B2PZ9kKPoriymoURbDsQWuTqSiG5Zn6g=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+ecN7AHVyI0F/T2hAcEM09nm5XXW5LLfQTE
 HSHvLmbqbqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PngAKCRCJcvTf3G3A
 JmrOD/wOpyQVRHrGQGo8XfD5jMBVmYMEWa7mtPz8TQHyKwul0h4DAnDuY1syEElYvTvb0qCuTg6
 YHpqfYbVJonRUjUd83cqsdEqsNMRkx8ryd+FwIwDMcHFmp3kEWfg5s9zyJpQlhMbIA8qRhFRzp6
 1nctWnxSwK5Y+R6FATebIjhT9U2Y8CD6khRnkG9NQuimrbhgcl/f447wIiYiu5X7idIzuMwSDFR
 Prf1JJwDz4YkxahRTnX8WrJXhYUDJjWqyw7MOMkMW6ybVBIL8ie1WLAZlKfuNoq/ypItBU4eAMz
 +BDqWKau3tdzcpK42SAJNB9SVOIvsM8EHP5boshP1NmOAEdUKG8SXMJr6bbYAfFt/Zdk5ZmYfpJ
 Yxipt98I+ZRxsbNFS4Y+4kVDYW0QBySazXXvWa8U736thID88na3V/aHvwB4Ql0tKp5Mk3oaHjZ
 VIJkT0hMJ0c+tnjLvg6pHMeQM7yKNB+s0mGuL84RFj6OyWPATVyWvcrsQ/dAxuy53EitcBlWyzG
 OhHlG4pbiUAIcoN9Kju8k9tthCpSQohkyEr1pwg2o2OfnyfTD7GoFuTt85RlHxHFcx2PYl1nV2x
 FeRCY+2qIpNwX19xvQ8Lx3Vt8SeFDNnJWY5M6UFCEs1Kyk4337zXOTTH+xiGEYKfZpRPhfZZ+7Z CzpyiCN8tLdjdOg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct virtio_gpu_object_array.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 8513b671f871..96365a772f77 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -119,7 +119,7 @@ struct virtio_gpu_object_array {
 	struct ww_acquire_ctx ticket;
 	struct list_head next;
 	u32 nents, total;
-	struct drm_gem_object *objs[];
+	struct drm_gem_object *objs[] __counted_by(total);
 };
 
 struct virtio_gpu_vbuffer;
-- 
2.34.1

