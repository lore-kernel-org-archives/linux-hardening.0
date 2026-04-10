Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8B3A641B
	for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840514; cv=none; b=Wun2b0HYkW5w7fzjHl3xocI5Hem+qna++g4rztM7uRCJ0JERVuoblZDOwhKdmdl1WgO5RKZ8DIv9Mm/Q/MT+w3EkjumeHQhjlqBrfI4LRl8cxpRaRU7CkPNCUqaATYlYJjKE/ezb/d9ezDSyA1uw+1xDf7XKTexqhJrRZLvY/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840514; c=relaxed/simple;
	bh=IGU6r6RgBHcOJQZIwjsV4tXNZc2Qsf/ggmtS5M8HXFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHadPoDnPHz/dm1UydFYjoPpRROs3rlq0Lz/6p1UnudNyUrzp3bxoUOszjl76cZqN10L3ObEkbGfHZ2L9sXQMP7BRwFgvSZSPaTOurKtbU2NGCHdNu4SPRinllYkGYtrV7cWfMUeHuQcpezKDRXTSCsYOoAyZlbIrVGhydF0u04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TMoDkyl7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NC9FKFjy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMoDkyl7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NC9FKFjy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AApPtv3743239
	for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 17:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bp/JyCTFtYQweJXfZZHfGdsxTk73Q69WkzJJd9yJDo8=; b=TMoDkyl7oeUMHSz1
	h4wbFV4nYnVGhfvzDmN4xUy6d0XMg8QC98zam32doQLoGBKcgqhlDgl2GGhxsAwD
	Xhtc0/Lxf0xf6G53bITxUHvJYoRwyAT/NjGQgPi1RxMVFBjKMVaNySXEOU4Ary16
	whCWw85DgOcGC39X74/lnJBWIlOuxiq7kLenyia2XyhsogfphGqWMJkkdL2HR9LM
	3s1mbFDwoIFjzh9Bv2CfVchktonmZinmvNQUZR+7aRBnXciYJvggaocDtWc0Wal1
	hNq2TtTgsEfTfLzAkagGORu7vD/v2zFFu3XEY6O2CxDzdXL0k7aaRg5EZknl4it0
	Ct6dIg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deytnh3bn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 17:01:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so2532015eec.0
        for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775840512; x=1776445312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bp/JyCTFtYQweJXfZZHfGdsxTk73Q69WkzJJd9yJDo8=;
        b=NC9FKFjyMY/Mr//XNwEGVCjFj6BlunKxWKWBRdGnfl7KXh8NEyLy0MIbfjAEHQTTmd
         F+Bt8cnD9AtPaMhQXr+MjQ81jDb3C9GbOOP8YDbyaMRzqoKJDiH2MMlo2fm8aXH706J9
         pSND++C6d4q3dvTUullyUViwR8BtPw1/+/BZCrBWNRF9FuHJZ96dV5ikiSrr/VdzQfqn
         t/KOJIxpUWh8T5wbHntHy2YQf/WaOHYOWfB1+PO4bCq+t57mfgU86e6WOpNMYCSGX92/
         qX7joX8L3vyA2KTnAOo7Ui4NEiDRdDPgUl80FEYaJavlk6funyMVERqWqcwRrLVuTrmc
         ouaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840512; x=1776445312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bp/JyCTFtYQweJXfZZHfGdsxTk73Q69WkzJJd9yJDo8=;
        b=HEIXLoEJwgKJukJJwfTEx0nEbmo954+eMgqhwF+VKbDWQYd4OiFydWZhf55K3usHVS
         CRYvRyu5Lf23YiggQui28O4yYrK3LKKwITc5nTtijuNZvAJA8WDlyE1BIIXdqLws8uRg
         p1ZTwFMt67FRv59yxNPM7bCpPnI3DQw6z3FVL88sQ+gKbi4KzwhZiuhK/nGhYzKWjElL
         UDawBDLa6GElqM0C135M6cx55zwvPfdifLQcLI19plmHSbcaJ+HAqHuKZUhE+S3OJY8A
         FuJTF+AVjAP+Ad7MJgpsZ1X3M5YSYQFx3XMD8EdMYLVB6E8uh5os9d3sl4KaLSLOzLDf
         Titw==
X-Forwarded-Encrypted: i=1; AJvYcCXaHZUhX8BPq9f2lhP25N+5hIMna9/yI1iSjbOB7G6RTez7scZ5qdevLR1w9Sa+VW7Glpvx8/iFGxcY05UFqpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMR/3kePkBavJdYl6/nmQ0icsMAbs3jCx60qbGpISPJCOnf+zS
	FYwLCxHxVHaFhBaKG7Ap1LCiNaKiUvtsOJ05UhzScxXVPgytF6+H4hhHpD1jXgOQrqeSSsG0Fcf
	1EhGsX2JJ8JcKJXURPG8cPEhGTQsGMQGAmdYwBNPURGQF53hz2erL6wLHaHsvkQKd01Si6Fc=
X-Gm-Gg: AeBDieviUilML/Sn5B/ZJ+pgKftRP2GxsubIwzwWeK4K1Be1s5cRie7Qg4lnChwPlrS
	/SL+mjQpSJ0Sx/0jz98FioaK9Ha4PDVKvFmC/hROc8ECOEq0syzp+CjdZBFVC2bz546m6d7C5Us
	p+YG8HOTqgKomWA4SnmwcNeAMiM5e+omhUAbZBQlGDZ5xdBTzqTX17feh7T1btl7++ga48OpyQY
	PX3aWyjp8eJAwA4R/uZGGZB9NVcO0jVL+SOEYdfb58BKRaIUDizuVT05aknGBiuUSSYOR88Xo7u
	lg/9CUIClllRsj1oHPIAKKUNVOJOZbr/9fNrkpRgF/kR3lV0YSdPZk0ze0FCvw4gpN5PtVASjYK
	/HcAc07pVNfm24pIZAjzH4LprXXKu2C3psbsUBcFbf/fX4qu99PjmVAumP84dbAeeZ1NDBt41rl
	I=
X-Received: by 2002:a05:7301:4089:b0:2cc:afce:bc01 with SMTP id 5a478bee46e88-2d589daf1b2mr2340770eec.29.1775840511772;
        Fri, 10 Apr 2026 10:01:51 -0700 (PDT)
X-Received: by 2002:a05:7301:4089:b0:2cc:afce:bc01 with SMTP id 5a478bee46e88-2d589daf1b2mr2340682eec.29.1775840509759;
        Fri, 10 Apr 2026 10:01:49 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm5778968eec.3.2026.04.10.10.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 10:01:49 -0700 (PDT)
Message-ID: <b772c81c-3628-45c5-ab11-a0737a94b812@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 11:01:47 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
To: Rosen Penev <rosenp@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM CLOUD AI (QAIC) DRIVER"
 <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260401220643.12802-1-rosenp@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260401220643.12802-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OKIbnPNn7r8AnbscTc7r0lnR_vBW4HDn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE1OCBTYWx0ZWRfX8dcQNkRZHmOQ
 Zls8FP/hb5iTGmlV1UdyAmH681DLur1XnRxAU9M+W67jCHHdwKnUQVg47KfsBJEtMSIKYGZ0Pvh
 8sJJ3oxDVZF0lriHYeXmHb8u3KifhKlVepv6mqH2Gn5FMzb4mJ1JglQt87bM97NNGdkwWwDQTv+
 8jq9c5uSxuPeMAE4ovWYN/vtCjq2dZvQD7bdgO4WM6zYudpJC3Ea4H/rQLLZGT53GcRv5ITXdSB
 yf+JczbWqZtQTJSxFAkHA0SqYJFpnQqqHn9+zKGcHSD0i/KlrwJJQiUTEPh0YkCqEm670qsl838
 Vlp8dr+4c28vrV0aXX3fydkJfZAGr8r2JzacrPtfijoS2Q7/5rrZaeI9458kr+zedyRoqn/2uxu
 AY7KV35sHCceCk3piw5gQEPKNfv/9jKUaAD1JtXxAEcBFkZ2K0isc3PetYKvNN0ACGGux+5hWAa
 bAvwKrNh0f5qZXCtZHQ==
X-Proofpoint-GUID: OKIbnPNn7r8AnbscTc7r0lnR_vBW4HDn
X-Authority-Analysis: v=2.4 cv=crGrVV4i c=1 sm=1 tr=0 ts=69d92d00 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=xkNXEimOluXcSHuVYG0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100158

For future reference, $SUBJECT should have a space between "PATCH" and 
the version. git format-patch will do it correctly for you if you use 
the -v option.

On 4/1/2026 4:06 PM, Rosen Penev wrote:
> Consolidate the two-element allocation into a single allocation using a
> flexible array member. This reduces memory fragmentation and simplifies
> the error path by eliminating the need to check for allocation failure
> between the two allocations.
> 
> Add __counted_by for runtime bounds checking.

This reword addresses my "why" comment on v1.  However I don't see that 
you responded to my question about how this was validated. I don't 
require a v3 of this patch, nor do I really want one. I want you to 
reply to this message and detail what validation you performed on this 
patch.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v2: use macro for number of elements. reword commit message.

Also for future reference, a blank line to separate the change log from 
the patch diff here makes the change log easier to find and read.

>   drivers/accel/qaic/qaic.h     | 4 ++--
>   drivers/accel/qaic/qaic_drv.c | 8 +++-----
>   2 files changed, 5 insertions(+), 7 deletions(-)
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
> index 63fb8c7b4abc..1dda8dfea5a4 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -43,6 +43,7 @@ MODULE_IMPORT_NS("DMA_BUF");
>   #define QAIC_DESC			"Qualcomm Cloud AI Accelerators"
>   #define CNTL_MAJOR			5
>   #define CNTL_MINOR			0
> +#define DBC_NUM				16
> 
>   struct qaic_device_config {
>   	/* Indicates the AIC family the device belongs to */
> @@ -405,15 +406,12 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
>   	struct drm_device *drm;
>   	int i, ret;
> 
> -	qdev = devm_kzalloc(dev, sizeof(*qdev), GFP_KERNEL);
> +	qdev = devm_kzalloc(dev, struct_size(qdev, dbc, DBC_NUM), GFP_KERNEL);
>   	if (!qdev)
>   		return NULL;
> 
> +	qdev->num_dbc = DBC_NUM;
>   	qdev->dev_state = QAIC_OFFLINE;
> -	qdev->num_dbc = 16;
> -	qdev->dbc = devm_kcalloc(dev, qdev->num_dbc, sizeof(*qdev->dbc), GFP_KERNEL);
> -	if (!qdev->dbc)
> -		return NULL;
> 
>   	qddev = devm_drm_dev_alloc(&pdev->dev, &qaic_accel_driver, struct qaic_drm_device, drm);
>   	if (IS_ERR(qddev))
> --
> 2.53.0
> 

