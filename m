Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76640234984
	for <linux-hardening@vger.kernel.org>; Fri, 20 Feb 2026 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771630579; cv=none; b=FPz6WeWqmngOR1V9Qm6Y0mf5/qDdsOU+yhhNLfWS12qO1QZsJtSHvTgmuVxQMZLxqTkAOOlxOvWk2ZM056vQelkSUdWgdLvlUe3KFk6xZ+ffRiX3VrDl5BiOLPvxF/oZDFPOBqTE+dbQSwn3Vve7tIB49EpOfxK8fBTQVF+wc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771630579; c=relaxed/simple;
	bh=Sy6oXzoaOmP445ImcelGg3uJV3WSYuEW5jJwrUXkC/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frxWlrBTDvrwuEklp4WYkkslfKFsCXg8dAwu2ysjbidBXyQ7uexu/XO7UySzUreXrq3OLLis23gPcsDgoVNI3FribB/yBQoNl9ESYcs7fVr8TDocUZyLNyFeOPfhDh9+0SHpTec5Qe3YVpWwlevqiwOodvDOaFkJ3z0C0oamqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdtxsZ/A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aAGynS+2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdtxsZ/A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aAGynS+2"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KG2n5S3154501
	for <linux-hardening@vger.kernel.org>; Fri, 20 Feb 2026 23:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8tydhh+6EmL3dAFMyH+Z+MIJDast/WxcYSEgk1cAR6c=; b=JdtxsZ/AA3+mxTq1
	rX2PZW4K+OILbGabe22w1LvF5sY0Y84/YyonHdJtau5p6oyjzn2wYsZPFr7wN+ia
	5WTewdXs1oveaLVxzDg61kuyjjGrcd3QyKtaRTrYPnJsuoftxS3neyJS+zRGK2qz
	eVacvN9h3cmIL7wvI3lB00Rz/LPxFOqhmwRArNb/V6CsAA+gDKalLBelTpmrCNAg
	/nQ06wKx7+zqYpU+0uVXtbf9ZdQdlSwnKZ2mplchIDX3TpUMTyizX9cTlhFjZkBd
	KJKMuG+BTCP+lZN9pDgpb2+q05LPWYzQpH0mSa5rgTnLpVvK06j4KQve3T+gzPEq
	wVFGhQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ceh7bjmd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 20 Feb 2026 23:36:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2baad797d0cso43807419eec.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Feb 2026 15:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771630574; x=1772235374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tydhh+6EmL3dAFMyH+Z+MIJDast/WxcYSEgk1cAR6c=;
        b=aAGynS+2ox/xnKNluy4SQ24fvANxoJ77qqAiMcmjjM60EuAyOprnHi0NhvNe3Fp+kR
         fZawLaAZTZt9URUL2mjEfVnq6U7YmpF2BFP56AjO0mozRLxRjJrZnG5VL5tXtWuB5NUI
         TZYLNtIuNEiYsWJmYdXAn8jcVYtYvXKnm+53NqK47cjdnBvHpPHkEY6NsJVDK1r0bFDx
         y/SUv1Ex34N/sL8CXw7wt39gigmAG6+QEZWGQrTETy/E3az4EF3cuPczzCVfEcqoONCQ
         ETvaivybwJYnjoIHy3MKwEofAFQqCBo8BOzD0ujyIk2A/PjAJcu8dLaMN4bqW35DWyvR
         P3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771630574; x=1772235374;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tydhh+6EmL3dAFMyH+Z+MIJDast/WxcYSEgk1cAR6c=;
        b=CNlQfw2kdhinFQ99dPgV+8gPWe9AA1ZRYhjvfM3m1ITG0sjYZem1yCUCIIGxU5kfMY
         sAUyjIbEeE+B26ssWIQRJpq/wdxxy8awtkCMvKvKRRc4B5OEjXP66fYWt8/GZ0id2ZVU
         akQKDJ2yJPm/aK0LZdkIgeRryS+Kji2kGANMOfHN77VXXbsBUXfxnc1bewbujokbw3US
         PnApD8mAkFbRtDq6cYiCweGnNILTgkMDjrvX2JSTFMVcz+i8KJXy108vokEQE6a0pRAX
         vb1Zm0/3seCZRa454qExBg7IgawHBpTRaad8MaxTsuVven5qvYgbW8WNcoMY2UZa/xbv
         Ebug==
X-Forwarded-Encrypted: i=1; AJvYcCVcZzir9WVRmA8TgTfney1PcvCg21YUO1uMjVZLydMmKpm++fdlsiWbPZRaLtj3jBbP+ZKeX6oyaJQFeSi6j3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3QErgaW1hn7h2p63E7EhjyR0zK9MKiBk4JiiBAi9AEXEClgU
	aTDWtEwoUmZIVOrC28fflPd00h2rcTDhQXqz3Juxr3waV8/FE2jJadFm1IkYPR0GFaqNbtHaZfB
	IkG+q5pDVPXsGsHVTh/2vesCaABpPtWtp0bd5yCVIE4zhHPgrYGp72Hh0lsT0v2SYgtxaEBw=
X-Gm-Gg: AZuq6aKN9JeNSMqrBaYHrx3kNK3hPx65oS0iRj5dwE5fwqKKJm/HVvO/X9ki0MitMRq
	Kale8fuP4nZVH/hvfFXikwaFx2ehNfZqiHdod50vxI7CO2AnjcaxdiiiK49i5L/jXL4G8t/ED/7
	EXL6pJi2zCjSRkme0TDZ1tXzfqOi5Y94hrRyrWmkNrj0EAauUeTVKwuG6S0JDzZd7kQdUE8fNPi
	v2Oe0vjVjQN7bDRB4pgVwv4FPD/ESB2tpFZeIjfN07PWhL1ceOGFBrKfl6LzZBFBXLbdFvPrAI6
	+C2WHADvg8xtGdlMbWLUj8aJ9O76n2uYOCrhZsmvB3x/EPuS8bN/5KNbnlcWl2MNOtalvSB3duk
	POzmG2AA8n90wcsow17If0fAUCDuyecCez37hitf7fum02CkdbIqVRDxu7OhXdW7e2gZ2i8I3IK
	g/dstYl81ykgkIRA==
X-Received: by 2002:a05:693c:2293:b0:2ba:8ae0:856f with SMTP id 5a478bee46e88-2bd7bb53936mr730850eec.15.1771630574133;
        Fri, 20 Feb 2026 15:36:14 -0800 (PST)
X-Received: by 2002:a05:693c:2293:b0:2ba:8ae0:856f with SMTP id 5a478bee46e88-2bd7bb53936mr730837eec.15.1771630573489;
        Fri, 20 Feb 2026 15:36:13 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af207d6sm964856c88.5.2026.02.20.15.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 15:36:12 -0800 (PST)
Message-ID: <c2060e50-0e36-422f-bfe3-44a81fb96c59@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 15:36:11 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: ath6kl: wmi: Avoid
 -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <aZP4RI-uN2001cBh@kspp>
 <d2a02b4c-5f69-4f5e-bc0e-428b64e99d36@oss.qualcomm.com>
 <6305fbc7-8210-4f4d-b719-30ba038611af@embeddedor.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6305fbc7-8210-4f4d-b719-30ba038611af@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Voguwu2n c=1 sm=1 tr=0 ts=6998efef cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Qanu7G-BKPL3DVzRuT4A:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: WAB5dKvrPWtbJSweCLk4aLxCzc6iou5v
X-Proofpoint-GUID: WAB5dKvrPWtbJSweCLk4aLxCzc6iou5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE5NSBTYWx0ZWRfX7lJvvPSFCCNq
 vjk/ADBL0jV1dtoNDvORMHuVIZqNK4d1gWOQXipTMQOGor+aRFmWPVHgstrJu/IS2Z8BhtBGtLl
 gwQvlPpsbcF/pcP/S+sV6llPaRAy2lU61Zgy3TAWollvVLcWJfbq0Zz8/p4KrUkWOl/+p97ntv+
 cuXnh505Ock56hWXgchh//nM3dqhhfgybsrXr/bne6itutH79rk5QGc79oE2KafC3iFrk3upwBc
 B/Ee+6r+BkYUKqKqTFLOI8LTL35Kskf9nkjzS1wqX/ivGqzHHIsZuHyhqgS263WZJo9eY1wkyEy
 GyeK7CkLV95XWohAuRnOUnhjQpp90iUSOj5QThW8BlkwqgvZH3zPxBXFu6KbIzR8zbY3oTIj4Ke
 FIceV+E0lAPuH2EPmmIm63LG8ukBl2BaiqS5pRTqiHjy1/cd0+bBlazdmWm8CLfZjvvC9jgVqsc
 8mUnU3oi/2lw/jiWeNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200195

On 2/18/2026 1:38 AM, Gustavo A. R. Silva wrote:
> 
>>> @@ -1652,7 +1656,7 @@ struct roam_ctrl_cmd {
>>>   	union {
>>>   		u8 bssid[ETH_ALEN]; /* WMI_FORCE_ROAM */
>>>   		u8 roam_mode; /* WMI_SET_ROAM_MODE */
>>> -		struct bss_bias_info bss; /* WMI_SET_HOST_BIAS */
>>> +		struct bss_bias_info_hdr bss; /* WMI_SET_HOST_BIAS */
>>>   		struct low_rssi_scan_params params; /* WMI_SET_LRSSI_SCAN_PARAMS
>>>   						     */
>>>   	} __packed info;
>>
>> That bss member appears to be completely unused
>> (bssid, roam_mode, and params are used)
>>
>> So IMO the better solution is to remove bss from the union.
>> And I think struct bss_bias and struct bss_bias_info can also be removed.
> 
> Even if they're not used, are you sure they aren't there simply	
> to define the memory layout of struct roam_ctrl_cmd?
> 
> As Kees commented[1], struct roam_ctrl_cmd appears to be a
> hardware interface... See below:
> 
> drivers/net/wireless/ath/ath6kl/wmi.c:
>   755 /*
>   756  * Mechanism to modify the roaming behavior in the firmware. The lower rssi
>   757  * at which the station has to roam can be passed with
>   758  * WMI_SET_LRSSI_SCAN_PARAMS. Subtract 96 from RSSI to get the signal level
>   759  * in dBm.
>   760  */
>   761 int ath6kl_wmi_set_roam_lrssi_cmd(struct wmi *wmi, u8 lrssi)
>   762 {
>   763         struct sk_buff *skb;
>   764         struct roam_ctrl_cmd *cmd;
>   765
>   766         skb = ath6kl_wmi_get_new_buf(sizeof(*cmd));
>   767         if (!skb)
>   768                 return -ENOMEM;
>   769
>   770         cmd = (struct roam_ctrl_cmd *) skb->data;
> ...
> }

yes, it defines a hardware interface. But note the 'info' is a union, and each
member of the union is there to support a specific value of roam_ctrl. And
since the WMI_SET_HOST_BIAS roam_ctrl is not used, the only important thing to
consider with your patch is that the location of the roam_ctrl field must not
change, and hence the size of union info must not change.

pahole of the original:
struct roam_ctrl_cmd {
	union {
		u8                 bssid[6];             /*     0     6 */
		u8                 roam_mode;            /*     0     1 */
		struct bss_bias_info bss;                /*     0     1 */
		struct low_rssi_scan_params params;      /*     0     8 */
	} info;                                          /*     0     8 */
	u8                         roam_ctrl;            /*     8     1 */

	/* size: 9, cachelines: 1, members: 2 */
	/* last cacheline: 9 bytes */
} __attribute__((__packed__));

pahole with struct bss removed:
struct roam_ctrl_cmd {
	union {
		u8                 bssid[6];             /*     0     6 */
		u8                 roam_mode;            /*     0     1 */
		struct low_rssi_scan_params params;      /*     0     8 */
	} info;                                          /*     0     8 */
	u8                         roam_ctrl;            /*     8     1 */

	/* size: 9, cachelines: 1, members: 2 */
	/* last cacheline: 9 bytes */
} __attribute__((__packed__));

So the size of the message and the location of roam_ctrl is unchanged.

/jeff
