Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236381C244C;
	Fri, 13 Sep 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223027; cv=none; b=IDbxcPzSLYnUpNzTzn2p3/UyDTVkU38tvyktTnXhGuIZc7HGngXaaTJTkHWuMhGJl+KU0fPsSDxf/aZOk4i7tR/Ib6QrBW4aQPL7/6HFMID87gYaa9YJGq2pvEOMqHnx0BXJ85OxGnBrvwlG0SwZ0dUaTLwWIKNTdQ6iOIcrrrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223027; c=relaxed/simple;
	bh=x1MBeyP7N4yaRObxjhsKUbVfVi9XKlw7sC0IJuwAqfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spSbdekDl66jwzVnC5KakumedWsUCTxEOrldFtGAUTbd80wahKClIsQSAsNzV3GvkM4QwCYZZcq2CEIpKR5bpnKHtDi3D8JFj7zbwDaKRziB1sc1CstnDUZbKIrouvPgMO8If5YxY4Gxl83YVfmWSA4xlGqhk4qJ/rBCsyRjXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZigbP11U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZigbP11U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C7CC4CEC0;
	Fri, 13 Sep 2024 10:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726223026;
	bh=x1MBeyP7N4yaRObxjhsKUbVfVi9XKlw7sC0IJuwAqfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZigbP11UUROE9s0HakSjgNZ2KZDQq86pTtJSmidvc8Sx06hyeyJa8keckQd0fL9Zi
	 DKwTEnFkoOII3BOnz+WGR3NRW7BdeOskqiw4etGe41G5U1lLyZgrU31ceqmwmfA/EE
	 67akcNNE2NU0rYIl140iRSwTOY46yiTfnTe+ItMh9G73NzJBTOxXJD1RMnXimNBCw7
	 oNX/xwNLi/0T7pld54V+3bqPEcG58OV3r3katpYa/qzz6M6DT9gRXN70wm76IVPA9r
	 OSGZnHIwriNmm7yUCCdvPi4QKPF6+nxCWhaAfMhSagb/F6C10tFFenF4nTQb+lcpZg
	 t+/2c1gN0Wvog==
Message-ID: <30530165-0ea9-4f02-9d8c-e8abc9eda5a7@kernel.org>
Date: Fri, 13 Sep 2024 12:23:38 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZsZLFS1CsHkKjw+C@elsanto>
 <ef5a8e6d-cb97-4872-901c-cf4bbec23be6@embeddedor.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <ef5a8e6d-cb97-4872-901c-cf4bbec23be6@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 9/13/24 10:09 AM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please? 🙂

Usually, that's me. But I thought you might want to send a v2 based on Kees'
comments?

- Danilo

> 
> Thanks
> -Gustavo
> 
> On 21/08/24 22:16, Gustavo A. R. Silva wrote:
>> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
>> a flexible structure where the size of the flexible-array member
>> is known at compile-time, and refactor the rest of the code,
>> accordingly.
>>
>> So, with this, fix the following warning:
>>
>> drivers/gpu/drm/nouveau/dispnv50/disp.c:779:47: warning: structure containing 
>> a flexible array member is not at the end of another structure 
>> [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/gpu/drm/nouveau/dispnv50/disp.c | 20 +++++++++-----------
>>   1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c 
>> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> index eed579a6c858..ddddc69640be 100644
>> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> @@ -774,11 +774,9 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct 
>> nouveau_crtc *nv_crtc,
>>       struct drm_hdmi_info *hdmi = &nv_connector->base.display_info.hdmi;
>>       union hdmi_infoframe infoframe = { 0 };
>>       const u8 rekey = 56; /* binary driver, and tegra, constant */
>> +    DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, 17);
>> +    const u8 data_len = 17; /* same length as in DEFINE_RAW_FLEX above. */
>>       u32 max_ac_packet;
>> -    struct {
>> -        struct nvif_outp_infoframe_v0 infoframe;
>> -        u8 data[17];
>> -    } args = { 0 };
>>       int ret, size;
>>       max_ac_packet  = mode->htotal - mode->hdisplay;
>> @@ -815,29 +813,29 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct 
>> nouveau_crtc *nv_crtc,
>>           return;
>>       /* AVI InfoFrame. */
>> -    args.infoframe.version = 0;
>> -    args.infoframe.head = nv_crtc->index;
>> +    args->version = 0;
>> +    args->head = nv_crtc->index;
>>       if (!drm_hdmi_avi_infoframe_from_display_mode(&infoframe.avi, 
>> &nv_connector->base, mode)) {
>>           drm_hdmi_avi_infoframe_quant_range(&infoframe.avi, 
>> &nv_connector->base, mode,
>>                              HDMI_QUANTIZATION_RANGE_FULL);
>> -        size = hdmi_infoframe_pack(&infoframe, args.data, 
>> ARRAY_SIZE(args.data));
>> +        size = hdmi_infoframe_pack(&infoframe, args->data, data_len);
>>       } else {
>>           size = 0;
>>       }
>> -    nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_AVI, 
>> &args.infoframe, size);
>> +    nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_AVI, args, 
>> size);
>>       /* Vendor InfoFrame. */
>> -    memset(&args.data, 0, sizeof(args.data));
>> +    memset(args->data, 0, data_len);
>>       if (!drm_hdmi_vendor_infoframe_from_display_mode(&infoframe.vendor.hdmi,
>>                                &nv_connector->base, mode))
>> -        size = hdmi_infoframe_pack(&infoframe, args.data, 
>> ARRAY_SIZE(args.data));
>> +        size = hdmi_infoframe_pack(&infoframe, args->data, data_len);
>>       else
>>           size = 0;
>> -    nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, 
>> &args.infoframe, size);
>> +    nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, args, 
>> size);
>>       nv_encoder->hdmi.enabled = true;
>>   }
> 
