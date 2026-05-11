Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4433242AB
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529714; cv=none; b=hzpBHVaCyYw6fzlEDPRnuYIpXGKZj72AnexQXH5AEQsXe+566mdk5zWm7Louv/vRvC3Y5TaPmkC+76e3iEDHzTlcWtcqWcM/mQ6OYfghnNJH6bFOUEa+dT6Tb4q7rTx+p9flu1PftOxCx0pS39quAfDFVK13Th3UZYxlhfIEIQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529714; c=relaxed/simple;
	bh=X3zTVQ62wREqjwSGXTXuWv8T/vG8auUCoFRMr2EQLOY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sqF1nPJprIoxtq+iz1q1eJ69kr5oYQMBACTY4ebXKgs8H1YuCxDA7Kw3H4ck1wKG1cfoFbiuKIgg0qvh/69priPETawdFRJ7JoxniToBbS14BNLVplR7+jwS16euhurxDmkEz88S72DBR7Ki+MbBQoTH7nHf+vdo01GxmZefnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Y00hQND3; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Y00hQND3"
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id MQnxwxxNR4RkpMWozwBXZ7; Mon, 11 May 2026 20:01:46 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id MWoswAMsDD6ICMWowwDpzu; Mon, 11 May 2026 20:01:42 +0000
X-Authority-Analysis: v=2.4 cv=DcUXqutW c=1 sm=1 tr=0 ts=6a0235a9
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=7T7KSl7uo7wA:10 a=c92rfblmAAAA:8
 a=FxjrvLIWRVXCnyOuGRoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+CdDmNnFmfg2uS5JE9AEtceT/tQMTQr1jrRL46Q1wJ4=; b=Y00hQND3Y+s7cEDANaZ21OcX+S
	MSG+ZZ0HeXaTVeHz075xpKAq/uODedbnGN+7hK8NkTeERJdzCn2me8Uv9orYQh9Er/jYCvAd0eRx5
	5OkXCz7u26aloUhVJQ9FcNiHI++jgEmL4OtuPWnROlzYRXdLj9AbO4ksigKtOfa1PtqLdgD9yQujn
	OcbxtXfXXet9Q/PkapmlOlkPmyUEbC+rGsv9iuwbndi3lkglG2B3Vy9TQo2wqDWyRfoC5G2uKT7VP
	lilPX3ayGCqC630o1bj3RmKIc+P5KmGRrxl49lcC/G1MrAt+zYc3stB961RC5fxjYU7B6HB3Zdbk6
	QRVGaIkA==;
Received: from [177.238.18.80] (port=57896 helo=[192.168.0.11])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wMWoq-00000002cy4-3k3i;
	Mon, 11 May 2026 15:01:37 -0500
Message-ID: <35a5a884-7c61-40e4-b675-681736bc033f@embeddedor.com>
Date: Mon, 11 May 2026 14:01:20 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/i915/gvt: Avoid -Wflex-array-member-not-at-end
 warning
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ae_4GkBsNl_0SYTm@kspp>
 <4d5f5949b34f7bba00ed570ad2098074aa0c05f5@intel.com>
 <2d713338-1eb5-4164-816a-6c0f91c8a9e4@embeddedor.com>
Content-Language: en-US
In-Reply-To: <2d713338-1eb5-4164-816a-6c0f91c8a9e4@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.80
X-Source-L: No
X-Exim-ID: 1wMWoq-00000002cy4-3k3i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.11]) [177.238.18.80]:57896
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfADNXUy42pV362uRRs8oI7xn6+0S8LU9UpbJdoPhMA5HEvgvXhNpVThZHu2aKYWmfFSEEcbVhwWSupso232BMNB8rGeBwUWE8uDBMnhC8BJu1n7zyD8+
 apzvU4Uw0a+OAvLZRrVJ4lmIO97ChyH4SOmzbyGc30w8Ea0vcvA9KAs1dtewGPsjHmhtZ1cfs5Bwb/BvC1OBrL2acLzVVmrgX3grT4jRUIIEbs3b9My8V0Ja

Hi all,

I wonder if you have any comments on this. :)

Thanks!
-Gustavo

>>> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
>>> index d6e76ba31d60..efe457c02788 100644
>>> --- a/drivers/gpu/drm/i915/gvt/opregion.c
>>> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
>>> @@ -122,17 +122,21 @@ struct vbt {
>>>       struct bdb_data_header general_features_header;
>>>       struct bdb_general_features general_features;
>>> -    struct bdb_data_header general_definitions_header;
>>> -    struct bdb_general_definitions general_definitions;
>>> -
>>> -    struct efp_child_device_config child0;
>>> -    struct efp_child_device_config child1;
>>> -    struct efp_child_device_config child2;
>>> -    struct efp_child_device_config child3;
>>> -
>>>       struct bdb_data_header driver_features_header;
>>>       struct bdb_driver_features driver_features;
>>> +
>>> +    struct bdb_data_header general_definitions_header;
>>> +
>>> +    /* Must be last as it ends in a flexible-array member. */
>>> +    TRAILING_OVERLAP(struct bdb_general_definitions, general_definitions, devices,
>>> +        struct efp_child_device_config child0;
>>> +        struct efp_child_device_config child1;
>>> +        struct efp_child_device_config child2;
>>> +        struct efp_child_device_config child3;
>>> +    );
>>
>> So this impacts the generation of a binary blob, parsed by the client OS
>> driver. In theory, the order of the BDB blocks shouldn't matter, but who
>> knows.
>>
>> Anyway, I'm more worried about inadvertent padding potentially being
>> introduced. struct vbt should have __packed attribute, which is missing,
>> but I also think the union and the struct within TRAILING_OVERLAP()
>> should also have __packed.
>>
>> Like, if struct efp_child_device_config gets extended by one byte,
>> what's going to happen with padding? It's __packed on its own, but IIUC
>> that doesn't automatically apply to the enclosing structs or unions.
> 
> We have __TRAILING_OVERLAP() to add attributes like __packed to the
> overlapping group of MEMBERS.
> 
> So, the patch would look as follows (including the addition of __packed to
> struct vbt):
> 
> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> index d6e76ba31d60..f4fabba56a1b 100644
> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> @@ -122,17 +122,21 @@ struct vbt {
>          struct bdb_data_header general_features_header;
>          struct bdb_general_features general_features;
> 
> -       struct bdb_data_header general_definitions_header;
> -       struct bdb_general_definitions general_definitions;
> -
> -       struct efp_child_device_config child0;
> -       struct efp_child_device_config child1;
> -       struct efp_child_device_config child2;
> -       struct efp_child_device_config child3;
> -
>          struct bdb_data_header driver_features_header;
>          struct bdb_driver_features driver_features;
> -};
> +
> +       struct bdb_data_header general_definitions_header;
> +
> +       /* Must be last as it ends in a flexible-array member. */
> +       __TRAILING_OVERLAP(struct bdb_general_definitions, general_definitions, devices, __packed,
> +               struct efp_child_device_config child0;
> +               struct efp_child_device_config child1;
> +               struct efp_child_device_config child2;
> +               struct efp_child_device_config child3;
> +       );
> +} __packed;
> +static_assert(offsetof(struct vbt, general_definitions.devices) ==
> +             offsetof(struct vbt, child0));
> 
> However, Sashiko says this[1]:
> 
> "Does moving these fields physically change the byte-for-byte layout and
> block sequence of the VBT exposed to the guest VM?
> struct vbt represents the exact layout of the synthetic VBT exposed to the
> guest VM via the OpRegion. In intel_vgpu_init_opregion(), the structure is
> directly copied to guest memory:
> drivers/gpu/drm/i915/gvt/opregion.c:intel_vgpu_init_opregion() {
>          ...
>          memcpy(buf + INTEL_GVT_OPREGION_VBT_OFFSET, &v, sizeof(struct vbt));
>          ...
> }"
> 
> If shuffling fields around actually causes any issues, I can use a different
> approach, like the one below (thanks to -fms-extensions):
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_vbt_defs.h b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> index 0dc13d080e8a..b238636e315e 100644
> --- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> +++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> @@ -568,7 +568,7 @@ struct child_device_config {
>          u32 edp_data_rate_override_reserved:20;                 /* 263+ */
>   } __packed;
> 
> -struct bdb_general_definitions {
> +struct bdb_general_definitions_hdr {
>          /* DDC GPIO */
>          u8 crt_ddc_gmbus_pin;
> 
> @@ -581,7 +581,10 @@ struct bdb_general_definitions {
>          /* boot device bits */
>          u8 boot_display[2];
>          u8 child_dev_size;
> +} __packed;
> 
> +struct bdb_general_definitions {
> +       struct bdb_general_definitions_hdr;
>          /*
>           * Device info:
>           * If TV is present, it'll be at devices[0].
> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> index d6e76ba31d60..3ebdc4c28c5b 100644
> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> @@ -123,7 +123,7 @@ struct vbt {
>          struct bdb_general_features general_features;
> 
>          struct bdb_data_header general_definitions_header;
> -       struct bdb_general_definitions general_definitions;
> +       struct bdb_general_definitions_hdr general_definitions;
> 
>          struct efp_child_device_config child0;
>          struct efp_child_device_config child1;
> @@ -132,7 +132,7 @@ struct vbt {
> 
>          struct bdb_data_header driver_features_header;
>          struct bdb_driver_features driver_features;
> -};
> +} __packed;
> 
>   static void virt_vbt_generation(struct vbt *v)
>   {
> 
> However, in this particular case, __TRAILING_OVERLAP() is more robust.
> 
> Thanks for the feedback!
> -Gustavo
> 
> [1] https://sashiko.dev/#/patchset/ae_4GkBsNl_0SYTm%40kspp

