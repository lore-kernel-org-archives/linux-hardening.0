Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470A42C0B
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:34:04 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1F2E7
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:34:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c328b53aeaso130498675ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696016042; x=1696620842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym+ucW6MHQZimVVr4/aWJAbaMhbjuFeNaLImS0cTOp0=;
        b=Ht4/tCNgN1L3tVISKcmwPVO9AoScXv+MedUTFwXVzmbds2hWBrAjSFNgM8T5fMCf8J
         AJ7KvjpUO2PR1iH4upbwCJy5A05lVCzlhUPVbNJD+B6t4pQs879bEEt+UG9XXGvItIYW
         hXrMwPqATE9uohsuicBuVcOutF3V032+1LT5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016042; x=1696620842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym+ucW6MHQZimVVr4/aWJAbaMhbjuFeNaLImS0cTOp0=;
        b=ZlawVgoT3UAYKmqY13EHtd0nWyOO+fdMxTVBG+jSGpHgRgrjxKeNtK+tlVMpF3Xm7+
         flOEHO/BrTCwGIwnsSJo3wR2pMCc8oJIyrqC6CRrkouIwJbA62fB9jsvC/b2ixWsinCV
         8v2Rz575f3o0KLYCaykaanQaafn1qrzZHPkjx4npL1A1BubnM6+zuL7OzmbKgDIs2pc8
         D0nAkgDa2jFNNDD4z8YO/UxxQgSnwZaXrSbT+tgAvSmGZfAP6EMuaSgWNllmQWDEj0fm
         qnQ3Znn1l/W36lxzIyW5FGGlUYjsRG/dguLEJY5JEUp/7lmMJxBrruPy+DPVqDYoIGtj
         Mw3A==
X-Gm-Message-State: AOJu0YysCbh1dvIjRIoUTe6+t+N4do/muhMjs2VRSf5I5v5fLVMp2U0e
	ebHhGr449p8UItwzEKWHzzeO7Q==
X-Google-Smtp-Source: AGHT+IGUGHi7dtq6VyAodryrcjje6E3uvOl68+dDAMdDOOXeHiwKUaYmLcNFewVq3SoThUPuXTt9vw==
X-Received: by 2002:a17:902:d2ce:b0:1c3:ed30:ce0a with SMTP id n14-20020a170902d2ce00b001c3ed30ce0amr6082275plc.19.1696016042107;
        Fri, 29 Sep 2023 12:34:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d50500b001b89a6164desm11405783plg.118.2023.09.29.12.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:34:01 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Airlie <airlied@gmail.com>,
	Kees Cook <keescook@chromium.org>
Cc: Emma Anholt <emma@anholt.net>,
	Evan Quan <evan.quan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
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
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
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
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Date: Fri, 29 Sep 2023 12:33:24 -0700
Message-Id: <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
> This is a batch of patches touching drm for preparing for the coming
> implementation by GCC and Clang of the __counted_by attribute. Flexible
> array members annotated with __counted_by can have their accesses
> bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).
> 
> As found with Coccinelle[1], add __counted_by to structs that would
> benefit from the annotation.
> 
> [...]

Since this got Acks, I figure I should carry it in my tree. Let me know
if this should go via drm instead.

Applied to for-next/hardening, thanks!

[1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with __counted_by
      https://git.kernel.org/kees/c/a6046ac659d6
[2/9] drm/amdgpu/discovery: Annotate struct ip_hw_instance with __counted_by
      https://git.kernel.org/kees/c/4df33089b46f
[3/9] drm/i915/selftests: Annotate struct perf_series with __counted_by
      https://git.kernel.org/kees/c/ffd3f823bdf6
[4/9] drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by
      https://git.kernel.org/kees/c/2de35a989b76
[5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with __counted_by
      https://git.kernel.org/kees/c/188aeb08bfaa
[6/9] drm/vc4: Annotate struct vc4_perfmon with __counted_by
      https://git.kernel.org/kees/c/59a54dc896c3
[7/9] drm/virtio: Annotate struct virtio_gpu_object_array with __counted_by
      https://git.kernel.org/kees/c/5cd476de33af
[8/9] drm/vmwgfx: Annotate struct vmw_surface_dirty with __counted_by
      https://git.kernel.org/kees/c/b426f2e5356a
[9/9] drm/v3d: Annotate struct v3d_perfmon with __counted_by
      https://git.kernel.org/kees/c/dc662fa1b0e4

Take care,

-- 
Kees Cook

