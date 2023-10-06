Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16FF43689
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ckLGhNPV"
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71ED12D
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:17:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-692eed30152so2163536b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623467; x=1697228267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A77BC7QX8Slsx+Ll7LU4L519A9TQl4V4ehtBrSUIzrM=;
        b=ckLGhNPVWd/ulrIPe3jfQ2NPXZ5eQalV+PIbFvURC8Tht9blWsgYmkRxjPcf1YYmPV
         hLDJRhfCeXE2xIjvGWIOpgauahjfj/K3LigI/k1Am9D3C0HugKDAtmjYjd8ZlwLgCyf8
         j+6SPq0cqEkZKZ4SVc7YNOmpQoTCcQnYFAp2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623467; x=1697228267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A77BC7QX8Slsx+Ll7LU4L519A9TQl4V4ehtBrSUIzrM=;
        b=s69J7HFBLgQ3hi3naE+gNzkITIH8ifDMF/2A9QpGlqFso1JkTATEbY1Q4Trj2zIY6S
         9F/aDoFgKjqqJHHmguVLoH9I/uP+KjhnsCkEjq0IgJi9GGlJ164/sjEgdd36M08EDWgl
         Dqf+LdtBIagaWi+tAT/7v11VW1GfF9FRU6M8Mz7ZE5BXgcNbc43Q6v4nU2YTaiLy9wiH
         QU6pqOEtre5a+SAyjCRgyDb8oW0R92aexbx5xrme9owbU82nqcXbus0bJYwHj+0zg0up
         +o1iAyPdQbTWb4djjIfHsZJrKN/u35v0iYWITD4feVzm0ZtuELFwXXkAQrNClFof7887
         QDqw==
X-Gm-Message-State: AOJu0YywfqiX43iLNvMVF+DXRihYxcmxZeGNfxHE5gy9xECrYPNsNNog
	QDHNxggpwDOI80LidXn93IOLfQ==
X-Google-Smtp-Source: AGHT+IGEI5no6IBRuxIIDAhkvTSvtsL8/uH21708qo7BPmv0WezMW5LyC1Lyp/b5nVHceMli3W0oSQ==
X-Received: by 2002:a05:6a21:3294:b0:16b:8572:5a4a with SMTP id yt20-20020a056a21329400b0016b85725a4amr3266606pzb.61.1696623467330;
        Fri, 06 Oct 2023 13:17:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a23-20020a656417000000b005898c8caee3sm1648955pgv.30.2023.10.06.13.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:46 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Harrison <John.C.Harrison@Intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Fei Yang <fei.yang@intel.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] drm/i915/guc: Annotate struct ct_incoming_msg with __counted_by
Date: Fri,  6 Oct 2023 13:17:45 -0700
Message-Id: <20231006201744.work.135-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706; i=keescook@chromium.org;
 h=from:subject:message-id; bh=hfOPKMbt1kpgmTXk+IkFUv+LIQHu3WxQ85BLA+j39zk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGtoRE75uVdefxFjupuMMe0I9OTzEzXxNkbpt
 Mqtn/fIxmuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBraAAKCRCJcvTf3G3A
 JsbYEACIjnXC26TRyjqe/0XWkVlFq8iUwQznZxL2nYr71KqzJo7xxRVqvbDairu1uyWkYlykJY1
 kzgJsioAawovDGi2WulfUyJJz+El41D1UlndyRYdC51Cd5QQBOyD3c8o9VvGFuESblrrl4NSvSy
 3m3RtEpfHAf2jD06tgBw+JDlLyNSUA9xbUf7CpCZwb6ii/JBNo6LwdbfC0s3PhT+DCjc1KEJBru
 f1D/ILZwWFEOzjiUQrRqlI3knZeHJNX/naWBjHRCQ06a3k03bxBwLrEOVUaJTEfouhXMQ/e0Vyw
 L8WPx4oAmc2jZktsESGFsciiAMduhLe1Pg+kNMFKeRhK7HZGoPkWBU6bTSdW81Za4g/eiZ/Wn06
 dnS24kWZENnfXtCkJhTUVO9gvpt+55FECMcTrpbC514WTeNhLxdEm+VCxucKdwyu5ESU82wsNDF
 XReLmc/Xq4yADXdU2p7jtMbNnGSd2LOploXFLd49VU8MSVuTbC+xMIXEga+cfVe3WGRzMLGqJGB
 cxKbEz8P7g+kp4k7wITnztl62lr3/mnTn5EYu2kkMXKPGIppa4h6rJ0KfCGu0vqMtNRmpCxO47K
 1v3sG/hPAcXC91EScYf5WstnOgdVKZvXShDQ0I7beJ6/+MpM4EBeY5CmZ85YUrxS5a+uafYPqms
 EE3Lf0b zByqJ28g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ct_incoming_msg.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
index 6e22af31513a..c33210ead1ef 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
@@ -96,7 +96,7 @@ struct ct_request {
 struct ct_incoming_msg {
 	struct list_head link;
 	u32 size;
-	u32 msg[];
+	u32 msg[] __counted_by(size);
 };
 
 enum { CTB_SEND = 0, CTB_RECV = 1 };
-- 
2.34.1

