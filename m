Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7DE1D88A4
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628225; cv=none; b=Baks4ei8mfT1kaRd+TuOHdNagrly+a47Kk0xk8Et0815Od5iFhKr3rfkeNreMiIlpEP4PzdgyU8N+dNWGnEqEe3XXRykWMYwYcAf+AaDgiF2vTCi6FqnDTgXL5qbUKwJyOYIj4l5xQVs2xnmLl0sdG2mIGocoxApfNe8LEdwpVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628225; c=relaxed/simple;
	bh=SVdTkeVeyoLe/1KQceMwBisVnJtenJGNsKgIsNp7LRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7+sd8zwC02nSq/sIbDa/z+jXG/+EyMi4LysYeqxMl+UzNa6KMXtKK8Dhr31PD+KkN80RzhHLBISCzvvlytyR2FlLxW5FdOzlAsRlNvOacc0G08+IfqNyGwDPitc7R2meXH4kT4YlTEE+J66PxLA8SvfH9L2nwfCOtrMGOrCYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EhaMoWgP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=icrrug/Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EhaMoWgP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="icrrug/Q"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RFphct1487247
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 16:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h0uSEuoFInxVgrwB79dUUBt3ZPYXBustTfB6r5GqV4g=; b=EhaMoWgPsnhiqVsV
	Nd8oSZSoky4XsXx2YeRGcDZypaTTiinDsVBfXcuUhTn+zWujbfYDyryYb59/V2d1
	msvX6uzquKSoiKUM6grtzA/ptTlc9QLxhXJUBgbQFXAZl+Hgq5FXas41nEa6lB+d
	lD+j6uv00oS23F8x8E0uMeOCmZvewQfWQU2jXuJVmJvyulrZizOiXQw0zNZfS8Qe
	yEN1tmzAX85sBFUvmZRnNbmaEMHX8sLZ+4tGUnrrfBblFaxF2/Tm+f2Okt4JmeT5
	0gZr9PcmbNctyCJw5myhyQTEG0GlDvQFS5M4UmsbLcQjUtUNcvREvA7QOfQbPSvU
	N/dLig==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5vvv83f7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 16:17:03 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1279caef718so2262156c88.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774628222; x=1775233022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0uSEuoFInxVgrwB79dUUBt3ZPYXBustTfB6r5GqV4g=;
        b=icrrug/QV6WcjG8MOlphALEFcmOttNPIEp3xIkq7zz5chVeLRPKMrKoRIh7g6KxUQD
         PX9NayPAF0oiGYwQqE4YOWOydlVkEZqgGg6AGd0rDp+qR2x1ur6je+BjcmxXvTAwoue6
         ue8DEzMJfXaMYj439viYFENUMdk+/QxlpBcSJjJAVPjhFgY7F0rQkgC1jtdBiuDzBXMI
         W+KfHskW/7pmJy3oZo5LY/fgm41WAgZtud9KAVJ0totI+b77JR5ry7aCjUOo0qlBpcSP
         CQ+MCPB2DDHxQdIlxvLN6nmmYo3eEKbNGV2TNbRyFYVYv1WcEQ8SUl9T8AYNhgtj2v4F
         hHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774628222; x=1775233022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0uSEuoFInxVgrwB79dUUBt3ZPYXBustTfB6r5GqV4g=;
        b=kE/sjihepNw8fvpBrv1OGnFV1bzv0voQ4ocv4GQwb1oAXVxAakOTFmTkKStQmQiles
         8sZ06952dYtSpXBbee4JmUqpspAZ80h5F0UxKo6FfMyt+E27nP4dT0pgYFsThEgwl9CN
         ERdl7pL1BkMr0DlwXJrbBmqkL8enRvmqK8TgHiXHeSxcTJtWVJuEARs3PYdMKPmfH9Mo
         gIHj0KfROHC2hI3aYnHtgA4xQaZ9+vim/p+B+4A6TKixj1tCd8orGk+HgiugcHHx5PhK
         rVcWu1vfK9l+qtNv8AVF23I8Ao7XNO6quOK0hJr0N9LqL+tXhbAa+2X/+9IM9Us1h6X1
         DVZA==
X-Forwarded-Encrypted: i=1; AJvYcCVoFa+qV6yOoP53PHorYkIaTvR6Of6/TP8UamUi6ddbG60r0T78wcb2l2X6Jcp3FSlx1viJWah+2uavj4H4TMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcUlCu8o4iIbfP9stbw7pDH2UxO5otq+uGhOI2yKrjWMQEma5
	MIG6+nZa9K2bS5o8Sa9mGWpMwkC8cedWOxUrfT1N2cyNnar3T8Rnrf7jAOWW6yPHLJP8xNhMSAT
	pi2MyF/MfWdnVfd60JNo8+kwgofyH9mk1dnaPhle0Eyyq7AmRpUB9nTCi3oiSdrhPMjg+9f0=
X-Gm-Gg: ATEYQzxeevlhlgatobladLClqXfuVAFT/kcEoRiJdl0EBljB4AY8m6FIk+M6co6XT4f
	MnEyq2y8z6bKFpZGfalT5MEfe1pbQrDY3obytGBz1qWMy/SSwm3Z/hZ0EGtyef50VKGycEfkZbY
	NMymz5wT5L3QeebGy1MYNaszSGXJqvLCNDTSpkMd2LRBbJOr5ESBe3Ah+M+5eWO4utiy4pTOE5f
	HqEc2FvTOyniCfsJULrnEbsyRX86CxvIgSjDLoufJbBvvq3KSp/ZZ+35V97EOEeZswwBK6d09p6
	Ev+YsU7VkdOaZWE1OJfL2sH+/RFGIn5u4pB+KOg7Dno3gU1gjm4JEdlx7XJzhPw/S2H2zLLkgJ9
	bHow+7rE0mqXdJNfGQluJ/SwWkUdAWLWXWkh1x8l0LJM1e29DgpSQywruyl6Bo7b4BwMYdRCdX3
	I=
X-Received: by 2002:a05:7022:618a:b0:12a:6b99:1ad4 with SMTP id a92af1059eb24-12ab286cf5amr1634006c88.11.1774628222061;
        Fri, 27 Mar 2026 09:17:02 -0700 (PDT)
X-Received: by 2002:a05:7022:618a:b0:12a:6b99:1ad4 with SMTP id a92af1059eb24-12ab286cf5amr1633983c88.11.1774628221305;
        Fri, 27 Mar 2026 09:17:01 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa7624247sm8135794c88.11.2026.03.27.09.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 09:17:00 -0700 (PDT)
Message-ID: <5abe5ee7-f054-4e32-ad9a-c9b8f10bc423@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 10:16:59 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: kcalloc + kzalloc to kzalloc
To: Rosen Penev <rosenp@gmail.com>, linux-kernel@vger.kernel.org
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM CLOUD AI (QAIC) DRIVER" <linux-arm-msm@vger.kernel.org>,
        "open list:QUALCOMM CLOUD AI (QAIC) DRIVER"
 <dri-devel@lists.freedesktop.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260317003034.71618-1-rosenp@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260317003034.71618-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tXqXG6O3hw-cG_pOQNN4SWW41B3AENIQ
X-Proofpoint-GUID: tXqXG6O3hw-cG_pOQNN4SWW41B3AENIQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNiBTYWx0ZWRfXxyG6B0KUZzBn
 1UqwTY3DpE99rjyoM5n6hpm6Z2ts0OmBXYWGGA7y0bdxkEy4KKMtPaTBhu0Y4+iVMOfVdX40oYY
 k+K3wXHw8h+A5xlaDd/3sID2EHKaHBhnNwooFM+C0nrs86IDncCsyL7K5eEy+b1j+MNZvGciJ9s
 RAf758UioXPUb7DFdE7S9ozyESzD3jGNyg18FMdjmply29Z7oL3xyTzHHGg2ptT6+zK9EymCPcz
 vPY+Uwq2cOka1vhQqT/6tsYrl37NbeaIksa+1CPEdL3Ol7TVDL4MxsnrjuVSM3AnWM88qdEsOSW
 36jPeCMgbzfqBheMAG2uO7iNAV2dvqbeTMn9bDaB30EWagQBL9MKeyYI9uNnSEGGoDVQwLxdwcc
 Ig7eyXLLg9Hf0JK9Jsr5Q7NP7DmhlGNpIIJiNo7Gj5JITMYkoFOrJahNBsVGyL+rqmso7z/HyzA
 +J1pQoJI8EW2yv35W1w==
X-Authority-Analysis: v=2.4 cv=PL0COPqC c=1 sm=1 tr=0 ts=69c6ad7f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=H-3xqeJHN62Qb4ZhkN4A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270106

On 3/16/2026 6:30 PM, Rosen Penev wrote:
> Combine allocations by using a flexible array member.
> 
> Use __counted_by for extra runtime analysis. Move counting variable
> assignment as required by __counted_by.

This fails to answer "why".  This change is not justified in the commit 
text here.  Please see "Describe your changes" in submitting-patches.

Also would be helpful for you to mention how this was tested (although 
those details don't need to be in the commit text itself).  You are 
touching arguably the core structure of the driver and any mistakes will 
be devastating.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/accel/qaic/qaic.h     | 4 ++--
>   drivers/accel/qaic/qaic_drv.c | 7 ++-----
>   2 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
> index fa7a8155658c..e237020f6aa9 100644
> --- a/drivers/accel/qaic/qaic.h
> +++ b/drivers/accel/qaic/qaic.h
> @@ -152,8 +152,6 @@ struct qaic_device {
>   	struct list_head	cntl_xfer_list;
>   	/* Synchronizes MHI control device transactions and its xfer list */
>   	struct mutex		cntl_mutex;
> -	/* Array of DBC struct of this device */
> -	struct dma_bridge_chan	*dbc;
>   	/* Work queue for tasks related to MHI control device */
>   	struct workqueue_struct	*cntl_wq;
>   	/* Synchronizes all the users of device during cleanup */
> @@ -206,6 +204,8 @@ struct qaic_device {
>   	void			*ssr_mhi_buf;
>   	/* DBC which is under SSR. Sentinel U32_MAX would mean that no SSR in progress */
>   	u32			ssr_dbc;
> +	/* Array of DBC struct of this device */
> +	struct dma_bridge_chan	dbc[] __counted_by(num_dbc);
>   };
>   
>   struct qaic_drm_device {
> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 63fb8c7b4abc..ab428ecd26f5 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -405,15 +405,12 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
>   	struct drm_device *drm;
>   	int i, ret;
>   
> -	qdev = devm_kzalloc(dev, sizeof(*qdev), GFP_KERNEL);
> +	qdev = devm_kzalloc(dev, struct_size(qdev, dbc, 16), GFP_KERNEL);

I dislike the structure of this change.  16 is now in multiple places, 
and when it will change in the near future, its going to be harder to 
get the update right.  The existing code specifically assigns the value 
and uses the value from that assignment for that reason.

>   	if (!qdev)
>   		return NULL;
>   
> -	qdev->dev_state = QAIC_OFFLINE;
>   	qdev->num_dbc = 16;
> -	qdev->dbc = devm_kcalloc(dev, qdev->num_dbc, sizeof(*qdev->dbc), GFP_KERNEL);
> -	if (!qdev->dbc)
> -		return NULL;
> +	qdev->dev_state = QAIC_OFFLINE;
>   
>   	qddev = devm_drm_dev_alloc(&pdev->dev, &qaic_accel_driver, struct qaic_drm_device, drm);
>   	if (IS_ERR(qddev))

