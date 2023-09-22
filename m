Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734AC45F62
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 19:00:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343392
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695409252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NE66f7DfP4/A2VOZXmvxuXHt1FmCuY2Q51yLIoHLwck=;
	b=VK9ia1C69p2AuLThkIIK0LKPkgnCxZHYupo7R9S74tkSAk8r6gwbVDQYYrsAM0Ip6iNFy9
	j4M8VDrWQznepxL1eNNSw8ofkdCPXkJuawhjH+UUt6dWoENcXeICIbyE5BfWbZ8nOwiciT
	z+uoTgfOxo+fBYy6496qiNDjRRGDQYM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-x3GwMVbwO0WGQPuNdp7z8A-1; Fri, 22 Sep 2023 15:00:51 -0400
X-MC-Unique: x3GwMVbwO0WGQPuNdp7z8A-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-65648d20aeeso24657196d6.1
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 12:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695409250; x=1696014050;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llC9/wUzzd4JVzDSD0PHMCO4lX+W74lZOeDntPKMIjc=;
        b=gg+lqLrHRfL+9wd2lKcXqpaizp/UiThoNrV3qQdr+sLUsu7mtDqO9Ve/1/9wXYKt8R
         jMbmmsSl5fnduleFkOFsT/ZrqUtwXtf4b3wKKcqPbhNyBdI6LyJ4tNoBlgSdVT+A+23/
         T4QtZ58la0UFZ0xI3Dv31v4jlLuPvi+X2xIUkZGCj/sFmbAK1EHdq1m+CBSu2blPpSPs
         SMRQ8WwGY+47Lh7UGuas3fcBO/5BYykTXmLc0hDSYhIh14YQ81VzA4MzxwzEBUyDdxdr
         lZLvGHoGU23lgRmEPTfkM17+LRyl3ZuNHZQJpAl2k83uUPqKs4GoiUFSGmegNvCqbMGB
         836w==
X-Gm-Message-State: AOJu0YziNk50NbC4jtNCRr+eY+F56vSF6PHWvM+/M7LIdtg+ygTi7L7r
	+92Qmp8Ubk2hImJrpjpQpEIMZ/6Ef9ZiU/FXXopZlMYLZ6eFK9N2UBQiRpDrKwmWspKO/w8Ec21
	O8UVenllvMvLD5dzd/WqLYJZtkIi5
X-Received: by 2002:a05:6214:1845:b0:655:d2c7:a9d1 with SMTP id d5-20020a056214184500b00655d2c7a9d1mr187735qvy.14.1695409250670;
        Fri, 22 Sep 2023 12:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcAhYi3agHEIh1mExaRpOkIAUDfxEWkbuUfbk0Y5Ex6ReRQkYaRYp/G33/F11gHisOBD3h3Q==
X-Received: by 2002:a05:6214:1845:b0:655:d2c7:a9d1 with SMTP id d5-20020a056214184500b00655d2c7a9d1mr187719qvy.14.1695409250417;
        Fri, 22 Sep 2023 12:00:50 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id w6-20020a0ce106000000b0064f50e2c551sm1671895qvk.1.2023.09.22.12.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:00:49 -0700 (PDT)
Message-ID: <1fc22ed54041660dfff5b7f3cc69708fd4ac0472.camel@redhat.com>
Subject: Re: [PATCH 5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with
 __counted_by
From: Lyude Paul <lyude@redhat.com>
To: Kees Cook <keescook@chromium.org>, David Airlie <airlied@gmail.com>
Cc: Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>, 
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Emma Anholt <emma@anholt.net>, Evan Quan
 <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Huang Rui
 <ray.huang@amd.com>, Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>,  Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Chris Wilson <chris@chris-wilson.co.uk>, John Harrison
 <john.c.harrison@Intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Bjorn Andersson <andersson@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>,  Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Zack Rusin
 <zackr@vmware.com>,  VMware Graphics Reviewers
 <linux-graphics-maintainer@vmware.com>, Melissa Wen <mwen@igalia.com>,
 Nathan Chancellor <nathan@kernel.org>,  Nick Desaulniers
 <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, Le Ma
 <le.ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>, Prike Liang <Prike.Liang@amd.com>, Lang Yu
 <Lang.Yu@amd.com>, Tejas Upadhyay <tejas.upadhyay@intel.com>, Nirmoy Das
 <nirmoy.das@intel.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>,  Kuogee Hsieh
 <quic_khsieh@quicinc.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,  intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org,  freedreno@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,  llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
Date: Fri, 22 Sep 2023 15:00:47 -0400
In-Reply-To: <20230922173216.3823169-5-keescook@chromium.org>
References: <20230922173110.work.084-kees@kernel.org>
	 <20230922173216.3823169-5-keescook@chromium.org>
Organization: Red Hat Inc.
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks!

On Fri, 2023-09-22 at 10:32 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>=20
> As found with Coccinelle[1], add __counted_by for struct nvkm_perfdom.
>=20
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>=20
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h b/drivers/gpu/=
drm/nouveau/nvkm/engine/pm/priv.h
> index 6ae25d3e7f45..c011227f7052 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
> @@ -82,7 +82,7 @@ struct nvkm_perfdom {
>  =09u8  mode;
>  =09u32 clk;
>  =09u16 signal_nr;
> -=09struct nvkm_perfsig signal[];
> +=09struct nvkm_perfsig signal[] __counted_by(signal_nr);
>  };
> =20
>  struct nvkm_funcdom {

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

