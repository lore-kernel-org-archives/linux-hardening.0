Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841F224B05
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675296; cv=none; b=uyjbJ/y1mYK8V/0ycplV+cH5kksVPFOSfbzLYGkcjxCm776RUNhMaBpW1Gxd6P+aK2Do1vDBhZqOfXUDiF7Cu8m5N55vAxUFkdW2qq+QrVCD1TSPkYXMHiGvsSgINsCofRdz6GAzH+iTJU3fBYjgprfrAnmE1lESoZKr4VScKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675296; c=relaxed/simple;
	bh=AjVmgb5dpkXwkLAlM81RmTRbpQgON2OMo1Cl/Fp+PZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiCPs4sgYsXWrpOh4KrpQXgllNX2EZUj4Ci0hT9UvdTg4neP9USsczE/mZDFEY1FxUfXTihuBxF0olh+eQclpnfZ7CrgxYXt765oUTpwTyAJdqBh9F0az71vhOnxDvYONwCABqMlptHB584WdbYZIog+I2ZCyi0aSYlfpR96jmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZV3eTzf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KYH8LOpM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZV3eTzf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KYH8LOpM"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LMZnBE3171979
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=n5cdHVeRZQBU9Z5oQofdHpE5
	IuH2kEHktkm28d0TIgU=; b=CZV3eTzfGpBc+FjGpzetpbsvVQfA4jVGmlADzmk1
	ctAn+C/266n1P43t7lKy5rw1grG6wuwt1WnAEUK+yYdd5gkjUpPtgF7s8zSTdWIE
	J8yMczyVmOhFEU7lztnBaIlGB4s3XCUiubDteXFHFayqe5TesdwS2VT1zHeNCEcJ
	fqrZN27gUybCaRQWbbWImcU7OpAb6GsnLawP9hrvIZhBkDp9sBC061d2T1aZKGXx
	aqYVt25227Nl2tT1Vt1b1RUA2wX8RYvTY+v6nnEQaLk1DIi/9OD1IPpehHhnsaRW
	8u8GAN7o/GQJmTrEGsOnkmfMafRGxxoiCF7/sv1J/84c1A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsagu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:08:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21c01cf3so187804211cf.2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784675282; x=1785280082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n5cdHVeRZQBU9Z5oQofdHpE5IuH2kEHktkm28d0TIgU=;
        b=KYH8LOpMjqm1S5GJWHoMWSJ6QPMX2tEecX75M6calfPeY5o1CuADMRd3JlimIFdyO3
         OKWOh7yM/FknFMT9FuRwpsp0P4ZH62v+9xmB1AMriJNv0wwBEd81f4FuGZHfZkqjEadj
         BMqQtYGG5dw0B9Zfb/DXqS9nz2yJm92IkzHPmICEstaboQvnyr8kMomp/EHUzNXyaLma
         iAvk9abW9bkfh0rEHi7G+Bg/HnNnVeHCalsdhCuB34sFp3LeUpuZZtOQ9elJ4Zt19b5I
         Zgg4e0W6a4al3mRvvFAaj8H+7uU9QtYAG1CdgsHAQav7FY3UNEJSm3Xz3gd/CSN1Ksrd
         SGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675282; x=1785280082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5cdHVeRZQBU9Z5oQofdHpE5IuH2kEHktkm28d0TIgU=;
        b=VlIl70/QZNPEOyUwgEoFdoeS5jm1/v9wwe1DpnKe33l2QXhYTixqpHdF0H+n8oBLWY
         01ylzdoX7BBB/zeYDaj2Ev3imgQdAXtXe2PDD1EgDIrRcwrSKT0Z7RBJj/qyKnkAeV4E
         I/kpSTMScY2YX377VFuKDujDtmEUECLzx6vFqlVg+OvyzWGEqF5QOixBv9qVFIA5Lhyg
         2USxY3STQUloW+nGVaDuJ9LXHW++Cv/QSimkJ8cJfbxaQMKr9AegwdqpVQ1qyimf57gv
         WvQC91DauRR+KBcLhAeAz5U6fUb+VsaxTLa2thj4EMfgLzVf0FYAukiwjSNH4hyhYvBM
         FIgw==
X-Forwarded-Encrypted: i=1; AHgh+RpIOfDSCnNXg/7m6Nc2bzyJyQd6THwOK7Q1sax6oWY5EUJoVGD+sy/UsnfkIR/JS/GHeLYkW4s4eL4qP734F1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3vJP+3KvqxTbPzH/9jsXBo8vQdTGXhx7odG9KRBJMH4i6ei4
	PcxS2JLdQKcX37FL7Ng9NTy3WCp+zxkosAixgv0to0p8TotUWLVyrMg2EcHJWeLNUM2IqVav+aD
	GIC0op4SOms3pqwjKWL9kiSAL5ZVEopPv82ykIemGv1XE4fhMlXjyIUko4ERdWdLwcsUNiM8=
X-Gm-Gg: AfdE7cmPOluNZ9BYKWJdkBOacZDBJzBfZkRrRosHDky39kFIPptrMwohSVVUHomqwne
	kvfZAUT580QewmLAhkhl7fN3+msrY3To6bKhec/zPxxGqoYU3VQ+UDbTWYf9a06mm7onu8BQrfn
	KGkS8oVXu+8oeSzLw8eXJUsSsfnyvq0z0P1Hb7LHiY+S80KtjvK/6qKPpHVg5lxlCIoHpkNrVVd
	KaGuYJ9hbpA00vIwsPv5Rw6Y3xR2RjC10v/XmA65FyhgIrMpTf67FrrJu6RGpmF6MkiRbkRfB5N
	fwwlQPXaxlqbi2TO/h0ouVswNoihe5bci8vKR6vwZa7bVoeV55IaIDxW36uPhu8RaBw0IuTXjVd
	SU3IMrgdHdpDiwzjkYgvqYUaUBB4YklnIYtPuUaZFIZxWw9FUsuCCserZSVFoBAAGpKfkVYmNbB
	DzDxHD7+LOkuvlMg==
X-Received: by 2002:ac8:7f83:0:b0:51b:ef2c:7bf0 with SMTP id d75a77b69052e-5213dc987c4mr182725821cf.35.1784675282171;
        Tue, 21 Jul 2026 16:08:02 -0700 (PDT)
X-Received: by 2002:ac8:7f83:0:b0:51b:ef2c:7bf0 with SMTP id d75a77b69052e-5213dc987c4mr182725591cf.35.1784675281717;
        Tue, 21 Jul 2026 16:08:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9d302e3sm153944e87.51.2026.07.21.16.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:08:00 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:07:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v5 3/9] remoteproc: qcom: pas: add support for TMD
 thermal cooling devices
Message-ID: <vxmb3padun4hydx3g7r7gecpeawoslc7djpaaxjl3o5bq5n5ip@nf5djjaelfy3>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-3-99620e07f505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-b4-qmi-tmd-v5-3-99620e07f505@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: P_Cjf39h2NunyOjaYo26mYqSHWIFNYoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIzOCBTYWx0ZWRfX7mAOfb799ptp
 zXPVPEaTe5ACLlD67bZeIOmkm4vKAOzmKRaIzx9nXfg1oWSJMjQLdLVMNUd5sH4vN2r1n+3vM4p
 nGTjv867FYGS4b5UMXlqyDexhBc8xLeD0KDcFMDf+Fi4avK5LUAzDeR/Avutyk18URZv3ZweyXv
 gfgqQyx60aOPlYu0lPUHmBn6tN2/QOjkuh8mbi3kG6ejwsRBPLs06fe198jgzdFHfhF7j9VISzH
 wtFqV6bZM8dM4gavcvrRBV3gNx0eKG6GQNrr1JBQPNwX4ey/vVryFsLJPf9tVRYwv/xtCmsiFCq
 MgFrCe/2VPeTg4HA5tSJcCUFAVa4iMzcTfAwRKvWraAt5P2QgrBcwcBaxdzBfvposIgVI8ocyY7
 LKQ3Tzo9vPCvgXounGIH0TyQgxh4ryvlrfi8F8TkGGF9SN7WqjmN7XyiLAkFQHlhRm0+hN028CR
 lufYhDaGmJJaKfdR9Ng==
X-Proofpoint-GUID: P_Cjf39h2NunyOjaYo26mYqSHWIFNYoS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIzOCBTYWx0ZWRfX3jS10LV5ERcu
 +ex7k1d61eYOgXZt+jqmO09AwMRmtx9NOeEnJB5KeYbzk51CXol4jRRN2+OcE+rP9Ymp/Wx35hR
 SvVwI9Oxe3YuVfrch91MPELkAnpoAs0=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a5ffbd3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ggDtmrkCBDuQzhDCrNgA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210238

On Tue, Jul 21, 2026 at 11:59:00AM +0530, Gaurav Kohli wrote:
> Register Thermal Mitigation Devices (TMDs) for PAS-managed remote
> processors to enable thermal throttling through QMI.
> 
> This allows the thermal framework to request mitigation when remote
> subsystems such as modem and CDSP contribute to thermal pressure.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  drivers/remoteproc/Kconfig         |  1 +
>  drivers/remoteproc/qcom_q6v5_pas.c | 90 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 65befdbfa5f7..f7c02edf395f 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -229,6 +229,7 @@ config QCOM_Q6V5_PAS
>  	select QCOM_PIL_INFO
>  	select QCOM_MDT_LOADER
>  	select QCOM_Q6V5_COMMON
> +	select QCOM_QMI_TMD

Sashiko warned here about the missing NET dependencies.

>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
>  	select QCOM_PAS
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 25599d728208..dc5be2c030cf 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2016 Linaro Ltd
>   * Copyright (C) 2014 Sony Mobile Communications AB
>   * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
>  #include <linux/clk.h>
> @@ -26,8 +27,10 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> +#include <linux/soc/qcom/qmi_tmd.h>
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
> +#include <dt-bindings/thermal/qcom,qmi-tmd.h>
>  
>  #include "qcom_common.h"
>  #include "qcom_pil_info.h"
> @@ -38,6 +41,16 @@
>  
>  #define MAX_ASSIGN_COUNT 3
>  
> +/**
> + * struct tmd_name - TMD device name to cooling-device index mapping
> + * @name: TMD device name
> + * @id: Cooling-device index used as #cooling-cells cell 0 in DT
> + */
> +struct tmd_name {
> +	const char *name;
> +	int id;
> +};
> +
>  struct qcom_pas_data {
>  	int crash_reason_smem;
>  	const char *firmware_name;
> @@ -58,6 +71,10 @@ struct qcom_pas_data {
>  	int ssctl_id;
>  	unsigned int smem_host_id;
>  
> +	unsigned int tmd_instance_id;
> +	const struct tmd_name *tmd_name;
> +	int num_tmd;
> +
>  	int region_assign_idx;
>  	int region_assign_count;
>  	bool region_assign_shared;
> @@ -122,6 +139,8 @@ struct qcom_pas {
>  
>  	struct qcom_pas_context *pas_ctx;
>  	struct qcom_pas_context *dtb_pas_ctx;
> +
> +	struct qmi_tmd_client *tmd_inst;
>  };
>  
>  static void qcom_pas_segment_dump(struct rproc *rproc,
> @@ -798,6 +817,64 @@ static void qcom_pas_unassign_memory_region(struct qcom_pas *pas)
>  	}
>  }
>  
> +static int qcom_pas_setup_tmd(struct qcom_pas *pas, const struct qcom_pas_data *desc)
> +{
> +	struct qmi_tmd_client *tmd_inst;
> +	const struct tmd_name *tmd;
> +	const char **tmd_names;
> +	int i, ret;
> +
> +	if (!device_property_present(pas->dev, "#cooling-cells"))
> +		return 0;
> +
> +	if (!desc->tmd_name || desc->num_tmd == 0)
> +		return 0;
> +
> +	tmd_names = devm_kcalloc(pas->dev, desc->num_tmd,
> +				 sizeof(*tmd_names), GFP_KERNEL);
> +	if (!tmd_names)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < desc->num_tmd; i++) {
> +		tmd = &desc->tmd_name[i];
> +
> +		if (tmd->id < 0 || tmd->id >= desc->num_tmd) {

The < 0 check is totally redundant.

For the second check, currently the driver will set num_tmd to
ARRAY_SIZE(desc->tmds), which makes second part either redundant or
invalid. I assume that here you want to compare to some maximum TMD
number to be supported rather than a fixed ARRAY_SIZE().

> +			dev_err(pas->dev, "Invalid TMD id %d for '%s'\n",
> +				tmd->id, tmd->name);
> +			return -EINVAL;
> +		}
> +
> +		if (tmd_names[tmd->id]) {
> +			dev_err(pas->dev, "Duplicate TMD id %d for '%s'\n",
> +				tmd->id, tmd->name);
> +			return -EINVAL;
> +		}
> +
> +		tmd_names[tmd->id] = tmd->name;
> +	}
> +
> +	for (i = 0; i < desc->num_tmd; i++) {
> +		if (!tmd_names[i]) {
> +			dev_err(pas->dev, "Missing TMD mapping for id %d\n", i);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	tmd_inst = qmi_tmd_init(pas->dev, desc->tmd_instance_id, tmd_names,
> +				desc->num_tmd);

And this makes it even more strange. Can there be holes in the
tmd_names? Can platform omit some of the TMDs? Assumingly yes, this
is not correct (nor is devm_kcalloc).

> +	if (IS_ERR(tmd_inst)) {
> +		ret = PTR_ERR(tmd_inst);
> +		if (ret == -ENODEV)
> +			return 0;
> +
> +		return ret;
> +	}
> +
> +	pas->tmd_inst = tmd_inst;
> +
> +	return 0;
> +}
> +
>  static int qcom_pas_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_pas_data *desc;
> @@ -925,16 +1002,24 @@ static int qcom_pas_probe(struct platform_device *pdev)
>  	if (desc->early_boot)
>  		pas->rproc->state = RPROC_DETACHED;
>  
> -	ret = rproc_add(rproc);
> +	ret = qcom_pas_setup_tmd(pas, desc);
>  	if (ret)
>  		goto remove_ssr_sysmon;
>  
> +	ret = rproc_add(rproc);
> +	if (ret)
> +		goto remove_setup_tmd;
> +
>  	node = of_get_compatible_child(pdev->dev.of_node, "qcom,bam-dmux");
>  	pas->bam_dmux = of_platform_device_create(node, NULL, &pdev->dev);
>  	of_node_put(node);
>  
>  	return 0;
>  
> +remove_setup_tmd:
> +	if (pas->tmd_inst)
> +		qmi_tmd_exit(pas->tmd_inst);
> +
>  remove_ssr_sysmon:
>  	qcom_remove_ssr_subdev(rproc, &pas->ssr_subdev);
>  	qcom_remove_sysmon_subdev(pas->sysmon);
> @@ -960,6 +1045,9 @@ static void qcom_pas_remove(struct platform_device *pdev)
>  	if (pas->bam_dmux)
>  		of_platform_device_destroy(&pas->bam_dmux->dev, NULL);
>  
> +	if (pas->tmd_inst)
> +		qmi_tmd_exit(pas->tmd_inst);
> +
>  	rproc_del(pas->rproc);
>  
>  	qcom_q6v5_deinit(&pas->q6v5);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
