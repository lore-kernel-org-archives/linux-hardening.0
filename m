Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2064210ED
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 17:52:37 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D3124
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 10:52:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5db4925f9so48729005ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695664354; x=1696269154; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YKkjlOQ/GPkFrKX9bDbfTnpErQ+3hoiSxDUiC5xM1v4=;
        b=M3fRbwNKJs/vD2DbQRvOwnUx2tVgK38v4iSmjDxmw8vepMoxpGzAvG5zM5/YGSVBFm
         18wo93lzSHyfC8NkQRSAlkDoSifPfFJT/iqECR1NEX8JA/XkpZLsxbfAA1+v8GeHhaMf
         T9eoup+Jok6EoLs8xCCJgk9qeMKF1QGtOCTes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664354; x=1696269154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKkjlOQ/GPkFrKX9bDbfTnpErQ+3hoiSxDUiC5xM1v4=;
        b=c9nCakR58qDRK8+lt/qk6CbeGmB5w0L851mDgj4ROe4o3oR78TrqRCLJZheJdYnluB
         lQFXh/wJNcL5sIx8n4rVpvS6ZM1e0EJfXyGccRV6SGjeX93FPSzWlEjEA9Zk1UAUaQny
         urotyEbjoij9GqXhVTrqitrTA+5Htl9dyOxsfnrUwPOkNU56xRTuynXA/oekXImgAG1o
         8yhbuZF3xXHMYDY0Rpj2mNUfNc+y4OJapmeWnb4BGftZy+TEClB2a2p8J5Su3IDpGsdW
         wIt9OM+WCfg9/fE+8P/dmJe4Gos4KpN1nip0P0ZfoCm8k2PcWRXlJgkciRLrvlSJYkfr
         kpfA==
X-Gm-Message-State: AOJu0YyljOz09PA5RMsFdHi0IUE3PkkELQR3Iw0TOH/ng7MclXrtVYF5
	EkhutiRTXw0jqMvoVb6Xq8iXk09OuvoWteSM3Bg=
X-Google-Smtp-Source: AGHT+IGb2sjCfgiB4MDLQ4+6eqHIAz1MPyfkRmwtnYXAap4msCEkggCpsTKyt2Yxw0aBiRoszpn32Q==
X-Received: by 2002:a17:902:c94d:b0:1c6:e1d:8be0 with SMTP id i13-20020a170902c94d00b001c60e1d8be0mr424044pla.2.1695664354493;
        Mon, 25 Sep 2023 10:52:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b001bdc208ab82sm9138120ply.97.2023.09.25.10.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:52:33 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:52:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, David Airlie <airlied@gmail.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Emma Anholt <emma@anholt.net>, Tom Rix <trix@redhat.com>,
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	amd-gfx@lists.freedesktop.org,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Nathan Chancellor <nathan@kernel.org>,
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
	virtualization@lists.linux-foundation.org,
	linux-hardening@vger.kernel.org, Lijo Lazar <lijo.lazar@amd.com>,
	Yifan Zhang <yifan1.zhang@amd.com>, linux-arm-msm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, Kevin Wang <kevin1.wang@amd.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Melissa Wen <mwen@igalia.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Xiaojian Du <Xiaojian.Du@amd.com>, Le Ma <le.ma@amd.com>,
	freedreno@lists.freedesktop.org,
	Bjorn Andersson <andersson@kernel.org>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Nirmoy Das <nirmoy.das@intel.com>, Lang Yu <Lang.Yu@amd.com>,
	John Harrison <john.c.harrison@intel.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 1/9] drm/amd/pm: Annotate struct
 smu10_voltage_dependency_table with __counted_by
Message-ID: <202309251051.EE3ECE7B@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-1-keescook@chromium.org>
 <CADnq5_P2p3bmczci=pU+pG6f9+hqn=-xp1EynP2345CJZRW08w@mail.gmail.com>
 <2635922e-f52a-4e91-40c6-4f1358972786@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2635922e-f52a-4e91-40c6-4f1358972786@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 08:30:30AM +0200, Christian König wrote:
> Am 22.09.23 um 19:41 schrieb Alex Deucher:
> > On Fri, Sep 22, 2023 at 1:32 PM Kees Cook <keescook@chromium.org> wrote:
> > > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > > attribute. Flexible array members annotated with __counted_by can have
> > > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > > functions).
> > > 
> > > As found with Coccinelle[1], add __counted_by for struct smu10_voltage_dependency_table.
> > > 
> > > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> > > 
> > > Cc: Evan Quan <evan.quan@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: "Christian König" <christian.koenig@amd.com>
> > > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Xiaojian Du <Xiaojian.Du@amd.com>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: Kevin Wang <kevin1.wang@amd.com>
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Mhm, I'm not sure if this is a good idea. That is a structure filled in by
> the firmware, isn't it?
> 
> That would imply that we might need to byte swap count before it is
> checkable.

The script found this instance because of this:

static int smu10_get_clock_voltage_dependency_table(struct pp_hwmgr *hwmgr,
                        struct smu10_voltage_dependency_table **pptable,
                        uint32_t num_entry, const DpmClock_t *pclk_dependency_table)
{
        uint32_t i;
        struct smu10_voltage_dependency_table *ptable;

        ptable = kzalloc(struct_size(ptable, entries, num_entry), GFP_KERNEL);
        if (NULL == ptable)
                return -ENOMEM;

        ptable->count = num_entry;

So the implication is that it's native byte order... but you tell me! I
certainly don't want this annotation if it's going to break stuff. :)

-- 
Kees Cook
