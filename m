Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E171BB6AB
	for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214973; cv=none; b=Mn80LGxH5/TQzDXnVdheJZGrapdc5BoEPZOUnoH7vptbWDKATCPybCv3Yjfcg5LyIbmwHDsy6Qxoa0t5EN80AGXlsc1J0KekDXKTd3yotghquxTyvZnrbWpq/pErWjvqCDOPKGCItMh0wGa8TJhdRwAt5g7JfsdhYfBMuc2i1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214973; c=relaxed/simple;
	bh=P8sSvWEEzSTLJt0Sy3CkDaE+8o1jNAo9/MmMCZ53ijY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqbeWmEEiBz4od6qBIhTMn5cgir/TDaO5ZeZulfzwmfxjRMe2UdjJw9uBm9GgEezvR8xxIcqZJomNrwVE/0uIaTDgtcb3QkUNx5/nIXnrugduuEkB+tIqoPOaXTAnpti9rIfuMp/5aLc427puHw+NF4RI9+2C3EbzZ+54uIMFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=eqFRaqaL; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="eqFRaqaL"
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id oyIBsj840nNFGp1MqsnK8o; Fri, 13 Sep 2024 08:09:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id p1MpsUawdO7Crp1Mps21j3; Fri, 13 Sep 2024 08:09:23 +0000
X-Authority-Analysis: v=2.4 cv=Pco0hThd c=1 sm=1 tr=0 ts=66e3f333
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=rpUMG24A1zG+UrzXDtAMsg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=1NbDYHN2ElJTStc2awIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ioUqqHWbZA3ZxtqcF1IJZFQ0PDlv9LdpcpzewA1m3Os=; b=eqFRaqaLU7ofpW1I2KdGDkAT0G
	86CwVyJZZA0DQhQ3D+0MTRNIk+P7tQBxWOVf7gxioiPQLlK5yLBb8kn26pVn0oiEM7raxVXb9xLV/
	oJ2wtveKcWytzcKOn/qY4lwODhdOyyUSJujA9sAAj+NsbbdknhAslTaAnDrQeN7Y+yt+G2nfrCUBb
	xwbLo4YNFuGVeMU0PT4xtTEwLPSxT/ot2z7WgJYOJ5kmYn8Yzyja965S95psRvpIdaxfMmdto06SY
	UGduZDn/p6fXNtBAyIKdZ1QOgYMEU0EfY+bnDfEC67ssmTVMtTJut6sxvwEgYhvThnb093TPZBkKa
	AQRdd36g==;
Received: from [185.44.53.103] (port=38116 helo=[192.168.1.187])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sp1Mo-003kZT-0Q;
	Fri, 13 Sep 2024 03:09:22 -0500
Message-ID: <ef5a8e6d-cb97-4872-901c-cf4bbec23be6@embeddedor.com>
Date: Fri, 13 Sep 2024 10:09:17 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZsZLFS1CsHkKjw+C@elsanto>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZsZLFS1CsHkKjw+C@elsanto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.44.53.103
X-Source-L: No
X-Exim-ID: 1sp1Mo-003kZT-0Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.187]) [185.44.53.103]:38116
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN/DoTMu4mLwwGMoxGaCb48FtWqdItcucHbA62cU9HBnOl6hVhmGhlKbNSmeeHTZfuIJMKBtwHOOOb1sbXZOX3O6HmTNjGGDTtPpED5I970gI5oU3oQT
 eij77sgMIQ/gzgayWjDOLL1SwrOsxqLlEBNOdulj1Ebp9U3oFPGa/BUgdXq9DbcoqJCzCLomYYE1rzOzzOkEHcgz/ISBQKjLBZDI9jyIw3CHDa7q5pN7hCSN

Hi all,

Friendly ping: who can take this, please? 🙂

Thanks
-Gustavo

On 21/08/24 22:16, Gustavo A. R. Silva wrote:
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with this, fix the following warning:
> 
> drivers/gpu/drm/nouveau/dispnv50/disp.c:779:47: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/gpu/drm/nouveau/dispnv50/disp.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index eed579a6c858..ddddc69640be 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -774,11 +774,9 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
>   	struct drm_hdmi_info *hdmi = &nv_connector->base.display_info.hdmi;
>   	union hdmi_infoframe infoframe = { 0 };
>   	const u8 rekey = 56; /* binary driver, and tegra, constant */
> +	DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, 17);
> +	const u8 data_len = 17; /* same length as in DEFINE_RAW_FLEX above. */
>   	u32 max_ac_packet;
> -	struct {
> -		struct nvif_outp_infoframe_v0 infoframe;
> -		u8 data[17];
> -	} args = { 0 };
>   	int ret, size;
>   
>   	max_ac_packet  = mode->htotal - mode->hdisplay;
> @@ -815,29 +813,29 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
>   		return;
>   
>   	/* AVI InfoFrame. */
> -	args.infoframe.version = 0;
> -	args.infoframe.head = nv_crtc->index;
> +	args->version = 0;
> +	args->head = nv_crtc->index;
>   
>   	if (!drm_hdmi_avi_infoframe_from_display_mode(&infoframe.avi, &nv_connector->base, mode)) {
>   		drm_hdmi_avi_infoframe_quant_range(&infoframe.avi, &nv_connector->base, mode,
>   						   HDMI_QUANTIZATION_RANGE_FULL);
>   
> -		size = hdmi_infoframe_pack(&infoframe, args.data, ARRAY_SIZE(args.data));
> +		size = hdmi_infoframe_pack(&infoframe, args->data, data_len);
>   	} else {
>   		size = 0;
>   	}
>   
> -	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_AVI, &args.infoframe, size);
> +	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_AVI, args, size);
>   
>   	/* Vendor InfoFrame. */
> -	memset(&args.data, 0, sizeof(args.data));
> +	memset(args->data, 0, data_len);
>   	if (!drm_hdmi_vendor_infoframe_from_display_mode(&infoframe.vendor.hdmi,
>   							 &nv_connector->base, mode))
> -		size = hdmi_infoframe_pack(&infoframe, args.data, ARRAY_SIZE(args.data));
> +		size = hdmi_infoframe_pack(&infoframe, args->data, data_len);
>   	else
>   		size = 0;
>   
> -	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, &args.infoframe, size);
> +	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, args, size);
>   
>   	nv_encoder->hdmi.enabled = true;
>   }
