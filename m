Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8003C6A8D2;
	Thu,  3 Oct 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980594; cv=none; b=bP2hoCEYhnb77As8TbS00lTzpShUyPqTEccrNjQ5uL6bku3zyli665Ghr7qSjrktnsIKBvw1EWBdeYTbrcPCD6wKTK6VLNtzzq+S4WsZKwGIPkCnz5fajONg10Ku3MdVQsMS2z/mCrQbRndZxHJNYlsNB78IEfmjUJnbFlqaAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980594; c=relaxed/simple;
	bh=dhihO2xV9w/h1fDGIWA6yLwQYla31KjxpiyBpYGT8Qw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kZKj63fmcCV4DB4qP9NT84CMQBNIXzlph0HnLvcS3vtz9+qkRnjWly+0z0KAH4n/c9l+u02fwtka3P9kvz1GFWxLsnYJlCx8NyQYQ8BUCUXTp/3aOtgESqQxRH6P7T9IRQI5q6JNLcUegCsNEkLCTiLajK2/d5kxAtUcnElmbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD1+5uvQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD1+5uvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15656C4CEC5;
	Thu,  3 Oct 2024 18:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727980594;
	bh=dhihO2xV9w/h1fDGIWA6yLwQYla31KjxpiyBpYGT8Qw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=JD1+5uvQfG262fgFaggrvoPxMbuldb7hr1gT7bYOX/4lZwUTtTYetZMGMINcFBgu1
	 hhY/O8y07jsuT2vYZ69hCBqJCOYFvQBxOyxnpyrPX3Dc74I0OQARZ7SPTHRjQUpBSp
	 fq7u8lFuX6pifcqjIm654Ij8b1KjHr0VEYPnd7fqPezDf0DvbTFJz3lPtz7W2Otu0E
	 OMsgfg0vRYBsidoODCHOscM8Es0vHBGsKjuWsVANZEpM4LDaO/f4KEI/N+MDj6ie6n
	 m2zk0izHjs3RfwxII3SMkIClkMQt88dednfGfk+FsfWEBiB6n6UgHMcmd6CGHhKlpc
	 av3O6mSLkLTIg==
Message-ID: <035ae74b-5df5-493f-9835-02c1c30ccfcc@kernel.org>
Date: Thu, 3 Oct 2024 20:36:30 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau: Avoid -Wflex-array-member-not-at-end
 warning
From: Danilo Krummrich <dakr@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZsZLFS1CsHkKjw+C@elsanto>
 <ef5a8e6d-cb97-4872-901c-cf4bbec23be6@embeddedor.com>
 <30530165-0ea9-4f02-9d8c-e8abc9eda5a7@kernel.org>
Content-Language: en-US
In-Reply-To: <30530165-0ea9-4f02-9d8c-e8abc9eda5a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/13/24 12:23 PM, Danilo Krummrich wrote:
> Hi,
> 
> On 9/13/24 10:09 AM, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> Friendly ping: who can take this, please? 🙂
> 
> Usually, that's me. But I thought you might want to send a v2 based on Kees'
> comments?

Do you plan to follow up on this? I'd prefer if we could get rid of the open-
coded "17". So, maybe just go with the define until we have something like
STACK_FLEX_COUNT()?

> 
> - Danilo
> 
>>
>> Thanks
>> -Gustavo
>>
>> On 21/08/24 22:16, Gustavo A. R. Silva wrote:
>>> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
>>> a flexible structure where the size of the flexible-array member
>>> is known at compile-time, and refactor the rest of the code,
>>> accordingly.
>>>
>>> So, with this, fix the following warning:
>>>
>>> drivers/gpu/drm/nouveau/dispnv50/disp.c:779:47: warning: structure containing 
>>> a flexible array member is not at the end of another structure [-Wflex-array- 
>>> member-not-at-end]
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>   drivers/gpu/drm/nouveau/dispnv50/disp.c | 20 +++++++++-----------
>>>   1 file changed, 9 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/ 
>>> nouveau/dispnv50/disp.c
>>> index eed579a6c858..ddddc69640be 100644
>>> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
>>> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
>>> @@ -774,11 +774,9 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct 
>>> nouveau_crtc *nv_crtc,
>>>       struct drm_hdmi_info *hdmi = &nv_connector->base.display_info.hdmi;
>>>       union hdmi_infoframe infoframe = { 0 };
>>>       const u8 rekey = 56; /* binary driver, and tegra, constant */
>>> +    DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, 17);
>>> +    const u8 data_len = 17; /* same length as in DEFINE_RAW_FLEX above. */
>>>       u32 max_ac_packet;
>>> -    struct {
>>> -        struct nvif_outp_infoframe_v0 infoframe;
>>> -        u8 data[17];
>>> -    } args = { 0 };
>>>       int ret, size;
>>>       max_ac_packet  = mode->htotal - mode->hdisplay;
>>> @@ -815,29 +813,29 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct 
>>> nouveau_crtc *nv_crtc,
>>>           return;
>>>       /* AVI InfoFrame. */
>>> -    args.infoframe.version = 0;
>>> -    args.infoframe.head = nv_crtc->index;
>>> +    args->version = 0;
>>> +    args->head = nv_crtc->index;
>>>       if (!drm_hdmi_avi_infoframe_from_display_mode(&infoframe.avi, 
>>> &nv_connector->base, mode)) {
>>>           drm_hdmi_avi_infoframe_quant_range(&infoframe.avi, &nv_connector- 
>>> >base, mode,
>>>                              HDMI_QUANTIZATION_RANGE_FULL);
>>> -        size = hdmi_infoframe_pack(&infoframe, args.data, 
>>> ARRAY_SIZE(args.data));
>>> +        size = hdmi_infoframe_pack(&infoframe, args->data, data_len);
>>>       } else {
>>>           size = 0;
>>>       }
>>> -    nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_AVI, 
>>> &args.infoframe, size);
>>> +    nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_AVI, args, 
>>> size);
>>>       /* Vendor InfoFrame. */
>>> -    memset(&args.data, 0, sizeof(args.data));
>>> +    memset(args->data, 0, data_len);
>>>       if (!drm_hdmi_vendor_infoframe_from_display_mode(&infoframe.vendor.hdmi,
>>>                                &nv_connector->base, mode))
>>> -        size = hdmi_infoframe_pack(&infoframe, args.data, 
>>> ARRAY_SIZE(args.data));
>>> +        size = hdmi_infoframe_pack(&infoframe, args->data, data_len);
>>>       else
>>>           size = 0;
>>> -    nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, 
>>> &args.infoframe, size);
>>> +    nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, args, 
>>> size);
>>>       nv_encoder->hdmi.enabled = true;
>>>   }
>>

