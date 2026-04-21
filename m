Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3C2459C6
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740002; cv=none; b=gigmGizOo2JHTyaQ1MZi4hDjnQPn3NFn9uvVo07RevbPpCr7I6Ve049JXKwpZ4hdsjf6+2WMk9p8qh/Cfz9xa+OLg7ZQwGVOI8rX+j5uqDjpYmHmD5de6HwglxufYeMB0/7FR8MgR+p0h8j0dUIEpKJhR6IYdPK+EL3gEfDFtx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740002; c=relaxed/simple;
	bh=4IjoQjwiFeLLeSO5t2hKnPbPnrdsdcns09X8bnj4R0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjRA9F55FnmAuTkn+5fw85JJFhhq0CvB0I6tQnd9/d8IJdWcqFpKpn8e4x1JB67xpDOFpLQ+mp+WdTHCDGqliR6vbINiiF9HSOt6zpcIGXfYsh/i6jY2lmak0BJV4CrFbh6ARvlDuMwDBVVOgntKMFx3nNkrl5k2/4S8Fn7432Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GXamZDbu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gtykg6yq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GXamZDbu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gtykg6yq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJ91S61598352
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 02:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nL9xUfvTkwQZncAFS6niHvBtOoZf0aD/RZbBCfCG6WA=; b=GXamZDbuUaHABGfK
	aJuurbG23e5ntre5qvoQEd+XkZ6jN1novvAz6fn9kGhVfdwgOt0fg/AndDyiLUC+
	EOjqyufcHc/iXz5ULKQXVelzdAgd7UfpZlqqs3A0KlLs8qOTGx8nJEdhRDegC8Ro
	L5KHd7GfTcnjB4vrSr0GvGDcCzDl5Rq2PFIHLEbr5I+sBy2y1Sq1yemu8dWKMVYl
	g0w2+sTkWrzdZG0KcspgI/d9J+eaqG2uynUVmSU9aU2hODtJlOLSKG6mB17vqUQt
	RNsOWiWgoCpedwSIozAu7y/19o7enEd8rPfW5xmqQbERM4xiisQ/StbjIBgOMTFj
	6DO4YA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfgnm44b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 02:53:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adef9d486bso34018525ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 19:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776739998; x=1777344798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nL9xUfvTkwQZncAFS6niHvBtOoZf0aD/RZbBCfCG6WA=;
        b=Gtykg6yq3LdnYNeifzQyijcQ+7lap2JkH/tF4Hs8BmDZ2LVTyGPX6feaS4mqmr3CwW
         b3cwkfkJjTHVqxdR5zXjBIP9x6SLGtAc/QSH31GgNFmTBZx81ngkBYDR2iXIht7exyOV
         udXmUF0DiHN8m/1DZQQ/co6VJ0Lemzgw8te1ZwIO862eS2nnAdbJLCd3RGWh0Dd9pkB4
         wiCVhGeulthz0JpmUYVFtSzOomfU5tA2UT+JZaQ5GR53oLaSnF8lgb9J1ChW81+ZKkPv
         +Su9wAhNxhXns1mSy+mv8RXctWoZIARrDy2zZ6U0c6MOOnqhRqz/0JXJVnCvESO3yUdp
         G/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776739998; x=1777344798;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL9xUfvTkwQZncAFS6niHvBtOoZf0aD/RZbBCfCG6WA=;
        b=DiwiOz5sZY3UJ4hGliJUS/Z8ZAPgaUIMxdiNtwvr5Y6f/c+AaYDcvPog2MDwVXlRWk
         TQitB6K6kUwMkNLG0I87LC4XYx+W5X184gOy8Z5xBYoE7FP0VnPIZ3bawBZayO72pkaw
         VfZuv4d2Hx79f7mGi7JQqYzpd4NhOvVMKeBrZHz7UO64GQ7/DbWufXFsoN6NBVsuWkX1
         G7LYLuS7doQaXVDDn5aEytG/pPea9cws8fyfzIMHhFW3JYFpCYTmgphgtvTo2nmn0OFP
         CkhqweYraNyZXnnqK2oIrg8013k/N1RUrKhfFpSbDZUgg7JxDPLw1Nq3vi8n4F6rfTf1
         GlzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9l6IbGZs9Pp8vUW8rjEzL7f5+tlEjedfLtE4dfomarKMmgGlfeNWU8VcEXmXAcPz8RMLRFNge+CBdlj3GSLps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk8P3in4n5f4nbnhr2P2daS7n2lmjZKR9byxaEGxaiw8loKM99
	JKEc0BhmaC0UjR/1gJspt3RHjQ2cHe3ri1WuQIqc6eBcfUlSY46iet8NVwhDw2xtYa4QuiKK4YY
	jwTFr6Uu11SS7k0Q+eaTlOXU5jUTs/yBkxCXDOLUfd5jJXYgOAOn3O1zPQCNmS7EnKNqvk0Q=
X-Gm-Gg: AeBDietQzaOTuHRuXy/uK8S+lq3MVEWXhzXa0/l2qTlX5UhLX39Cs4FbUa1/Z030bri
	ps18CXlxYuCsRj5jOCkHr3AHB3VPXE88dU7eU8z1Oz04wOkWgmy38VKKa0S2YTf4mdqkCnvRrXZ
	x1M2JpausGbu1y5VqhUSqRCwILWQpgNlS22fXK7XahGnuRafXFpJWe5g8eBLz9266HIzLCWiMWY
	CTiY+JSOaJhyuFbYHNre69Qp2HBguANfMSxVFA3nhzeP7HTVkz7Wg/FVTQ+9kgHcd03BZf//yky
	F+0L9KuZWMjFR4evBMJ36njIbgsSjbCS0nGSkflQgqf3cMmT+BlXimisPlxACEWe/RvdeuHP7sz
	Si/gXiJ1GRuVu28o3U5tIcQgYrIyCpcE2KoKty567gPfXe3+ocNPsrW1Wdi/yNlFYScrSMn7oOn
	sMblsxcss2ioKBJYodEHEE0DuwJU1/bw==
X-Received: by 2002:a17:902:6905:b0:2b2:49a7:a5bd with SMTP id d9443c01a7336-2b5f9e770c5mr113292135ad.1.1776739998396;
        Mon, 20 Apr 2026 19:53:18 -0700 (PDT)
X-Received: by 2002:a17:902:6905:b0:2b2:49a7:a5bd with SMTP id d9443c01a7336-2b5f9e770c5mr113291805ad.1.1776739997873;
        Mon, 20 Apr 2026 19:53:17 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa16e72sm117632635ad.19.2026.04.20.19.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 19:53:17 -0700 (PDT)
Message-ID: <a92cb332-b525-47f4-a529-a59080cb33dd@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 10:53:13 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATH12K WIRELESS DRIVER" <ath12k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260313001434.118010-1-rosenp@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260313001434.118010-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VwQntm-Yqupo1z9Q16c0eQrc_KBZdkTk
X-Proofpoint-GUID: VwQntm-Yqupo1z9Q16c0eQrc_KBZdkTk
X-Authority-Analysis: v=2.4 cv=TK11jVla c=1 sm=1 tr=0 ts=69e6e69f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Axv3upY4dNLjRVsui8cA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDAyNiBTYWx0ZWRfX0kBgC9tud+lR
 dr+7Zh7uQqveBWPYny+L1KAOOO4A5izoy4jKUgeJ9+tGaG0GOCt22vI/hLMO9+uXmno8g2Vt1Oi
 E+waOZfl+vzmw2qy3ZUd1VwMWLfKmmkFVSLHQIOZg23Wonj/hQaMLPwF+nXyNnfG6rwdRJpUoCE
 DD47SSEqRub25cm2lJxjSLyEXLyg/W/LI/3Hyno8PoDtiPd8FRsQU0VFOKWWJ4U0zmzUI/05Elo
 LxWuLNfWhZa3EYhEq4rswKXHGnH7R3VMTp4tIMS49GlgofFWfYWIgMXsGm8WGg+dp7dJtIMmthr
 fOWDEjE8T5Y62zR4zSbLzSRRLmX27e0II9J1W1kofzVoTRd0TU22vt1U0ZYoMDvzYJ5zIeoZ9jk
 9bkPY1iZo94P3KZg5eMZ2iUqhl3j9FZkO9NSF3xJaO5z/Ks/fqzM2HUCX+06ARLVn9jL4Uc295F
 AyybTbCtqrQWcO0DxLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_05,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210026



On 3/13/2026 8:14 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation as required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 29 +++++++--------------------
>  drivers/net/wireless/ath/ath12k/wmi.h |  2 +-
>  2 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 553ec28b6aaa..b7c43a64e37b 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5611,12 +5611,14 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
>  	if (ret)
>  		goto exit;
> 
> -	arg = kzalloc_obj(*arg);
> +	arg = kzalloc_flex(*arg, chan_list, n_channels);
>  	if (!arg) {
>  		ret = -ENOMEM;
>  		goto exit;
>  	}
> 
> +	arg->num_chan = n_channels;
> +
>  	ath12k_wmi_start_scan_init(ar, arg);
>  	arg->vdev_id = arvif->vdev_id;
>  	arg->scan_id = ATH12K_SCAN_ID;
> @@ -5638,18 +5640,8 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
>  		arg->scan_f_passive = 1;
>  	}
> 
> -	if (n_channels) {
> -		arg->num_chan = n_channels;
> -		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
> -					 GFP_KERNEL);
> -		if (!arg->chan_list) {
> -			ret = -ENOMEM;
> -			goto exit;
> -		}
> -
> -		for (i = 0; i < arg->num_chan; i++)
> -			arg->chan_list[i] = chan_list[i]->center_freq;
> -	}
> +	for (i = 0; i < arg->num_chan; i++)
> +		arg->chan_list[i] = chan_list[i]->center_freq;
> 
>  	ret = ath12k_start_scan(ar, arg);
>  	if (ret) {
> @@ -5674,7 +5666,6 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
> 
>  exit:
>  	if (arg) {
> -		kfree(arg->chan_list);
>  		kfree(arg->extraie.ptr);
>  		kfree(arg);
>  	}
> @@ -13735,19 +13726,13 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>  	scan_time_msec = hw->wiphy->max_remain_on_channel_duration * 2;
> 
>  	struct ath12k_wmi_scan_req_arg *arg __free(kfree) =
> -					kzalloc_obj(*arg);
> +					kzalloc_flex(*arg, chan_list, 1);
>  	if (!arg)
>  		return -ENOMEM;
> 
> -	ath12k_wmi_start_scan_init(ar, arg);
>  	arg->num_chan = 1;
> +	ath12k_wmi_start_scan_init(ar, arg);
> 
> -	u32 *chan_list __free(kfree) = kcalloc(arg->num_chan, sizeof(*chan_list),
> -					       GFP_KERNEL);
> -	if (!chan_list)
> -		return -ENOMEM;
> -
> -	arg->chan_list = chan_list;
>  	arg->vdev_id = arvif->vdev_id;
>  	arg->scan_id = ATH12K_SCAN_ID;
>  	arg->chan_list[0] = chan->center_freq;
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 0bf0a7941cd3..190e7a4a92d0 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3586,7 +3586,6 @@ struct ath12k_wmi_scan_req_arg {
>  	u32 num_bssid;
>  	u32 num_ssids;
>  	u32 n_probes;
> -	u32 *chan_list;
>  	u32 notify_scan_events;
>  	struct cfg80211_ssid ssid[WLAN_SCAN_MAX_NUM_SSID];
>  	struct ath12k_wmi_mac_addr_params bssid_list[WLAN_SCAN_MAX_NUM_BSSID];
> @@ -3595,6 +3594,7 @@ struct ath12k_wmi_scan_req_arg {
>  	u32 num_hint_bssid;
>  	struct ath12k_wmi_hint_short_ssid_arg hint_s_ssid[WLAN_SCAN_MAX_HINT_S_SSID];
>  	struct ath12k_wmi_hint_bssid_arg hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
> +	u32 chan_list[] __counted_by(num_chan);
>  };
> 
>  struct wmi_ssid_arg {
> --
> 2.53.0
> 
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

