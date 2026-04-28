Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D42EDD7D
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368084; cv=none; b=tVKVFXhZqqS03oXdwhtSkTYv7MeHek4bFa9GNB7PjPsystFENkOb+l2DXsl+Vn5tNhVqwlGlAzTYENWZOUsupafwvORos9DHJT7XDMGJXgssJsAMMy7YpKkiebKQUeKmtPiNpP5PPN22ZIkfiY3m9xSCh7YfEJ0IQumG/T9fSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368084; c=relaxed/simple;
	bh=IcJ41p1S3Zzjw+o3gA1Mi9zZTLqegfsjHjcr7r1iJcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttOu9efTqq/4aMmyFZHPp2gwRl3ak9YMxMiVNAaBL+DfqwQtKvxCWQK4fNTL24HXuXtZSQwwTtIE1yCHUeDNkJkVUMOPzOyszrDQN2f9y3TUWH16Db3NoDVBwF9qOIC5SYDtZbNojn//FJ7IHOlXvhKBj5pJrRvNoXoiyOzbmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J1rHlRNe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YOd4b1cV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1rHlRNe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YOd4b1cV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S8JeE03123629
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 09:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uVa5aELi8oMy5IN5qMbJc9fv
	wjHh1VOUvgLucaocG9g=; b=J1rHlRNedvYMBPu+kQJFq8obDoBh6bHtsfLGahz2
	hlQdCu+A6u3y7mjNloWouF+t4ISvCbX70e/l5X26Ljg2HnbVteXVnmUdaj70LAwr
	Se5keSzn6OCCgB6kTKCD9qIvIHkO03HYe3XZFCyixRkDWuJsXVxeHgm9aT3NtzNN
	F9k59gi5dAEG//R2LTnCsJS+rxYudLoQgLQRrtgEkNzmE0fUyzlJ5d87WPw51qs8
	LHONOWUKvpSi3Cz+8TPT5HHrXEt22Nh/a6Bdr4yu4IjaazJ6ONe5swPbm4d13sx+
	RvQnHLtGk9d4RZtOgaZOHHVy6uWmbgG2RvD9ITkBdunESQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5qgmtf0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 09:21:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8a1accb970fso184183096d6.3
        for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 02:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777368081; x=1777972881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVa5aELi8oMy5IN5qMbJc9fvwjHh1VOUvgLucaocG9g=;
        b=YOd4b1cVwSsNK4+1sMkmiM5NJM+9VU0OlisGAe5kL61hrXZzkkHFKS9jUaFSAjQRf2
         LVukT1X7Koq0P6kAjxWZrnnslCGcz5+dYtkPEv/I8stq66KHeEzHOoi/brD4HPoReUx4
         AdzU8v4Ru8YRFofuSSaVUylzsm0i5qOLnMJpKFAX2pnUJtxvTyHMDVhii7wiGv7kna44
         vQrBnFONurN0icXXkY/f3m/Auia+96DcYfe1vvqobI+4l1t8+ZZvA/la57aJqi6z24Ou
         pAwa4SqViMDala8CdJj1yUpv79FaAsd2CeypeXRGtcqI9/uJYMOeFlxPmkwCl68TDsfT
         mF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368081; x=1777972881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVa5aELi8oMy5IN5qMbJc9fvwjHh1VOUvgLucaocG9g=;
        b=FRbaaSWGSlHlh7DUgt1GxOE1mPAea3rwbCzUtMS01f47RIE1iC9QbQ31MqS7VHOfUT
         xVsmZrJrKN5SL+eJuYF2frMomm9eJ4G/xjToEwx59NvzS7P4MuLkVlPSQf2eb1hKJPuP
         dyvV4AFpQIl+CoFbKXnxpOP2WmCUfmXd4FDB/U7+8wBxMO4dhpPVI9GhUGtpE6V8ulOa
         l9EYQBnh/9sW9egMft1tZbBsA33+OA5XILu0msC+P+IhbSi+pCPURg5/xVvigFCCtfLJ
         wGgxWZ8ToQEdSkNAlsTFSBzMiycb1j8rdD+ur8fCHaFrXKpaX+kqpS/5uGHrBD/RO68f
         Bbcg==
X-Forwarded-Encrypted: i=1; AFNElJ/0X3J1ijr3bAw88gF28TtrqIHxoznXIwJj6nUlYV2q5FF6jW2Kz7rFsMGGP8d02q+ArzNu73Tm0N1kvRc8qtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtohNKrq0osyeEWz8J0SqgBzNL2/IHJ7itkj0/7lrGMOC/1lrA
	P2VflVr9zPo2fTaGRNY6ZO0qvEDCe+MN0QEgyDiMnr+zkgOvfq4fL4jZo/ANa8EmH43VwK/wcmA
	20TIwSdKhu9cNXR63knK0XVTeqVITuaOwG65zkAyqZj2NSf8IX1kF2s1yad8FlB/7Ij+5fIU=
X-Gm-Gg: AeBDietJb5cm+P2mBlapSahXZ68hnpP+NsLenVdZRHxLt24xwXPZIG7MdkLNaJvQbKB
	RL7YorH3hAZOcluTxoR9SYo2H8MZ8FnaHthmKBW22bTWfpdg5lND+jAWYfkD9evt8hGfOkB3R3X
	PKbFPABdSgb8GeFrfLBly+WjYXCHNMT55vg/3WePUkzHOftcfYZWm9vqNSkfD0zlXcLbxsNh72B
	FTjanCpph4dXew6MzBRb87G42t5WU/bVJfZ/+nnhoS+ox69lOiZuEDmv4SDFyIKR96/peylVqBh
	jMrft2AqY3KqXzGa4bqhGtRdpmsK0usaWcy9AnoINdyftSi3hqUdeGTdwsHNw6hSQ7+QbN138tk
	5yyQRcGWrEbBMjhJ3wgNG1b6nUN7F2NA4OCXcFHL3tbj2JsR9pSy1WJ24WHBA9kl9zDpQdqcfKL
	TvNE354ItlRhoqJtTfKLgbatLBdX3BOBHe3Ut+b1NR4v2SvQ==
X-Received: by 2002:ac8:57cd:0:b0:50f:c117:1c52 with SMTP id d75a77b69052e-5100e0f6951mr26863531cf.4.1777368081351;
        Tue, 28 Apr 2026 02:21:21 -0700 (PDT)
X-Received: by 2002:ac8:57cd:0:b0:50f:c117:1c52 with SMTP id d75a77b69052e-5100e0f6951mr26863341cf.4.1777368080872;
        Tue, 28 Apr 2026 02:21:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a7462d5821sm470542e87.33.2026.04.28.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:21:19 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:21:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v11 08/11] tee: add Qualcomm TEE driver
Message-ID: <ljfhoo5o45m3t5fsqypg75c46qohvszd5azcqxyjdcr5unx7ob@vcgip4yzkmmn>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
 <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-8-520e867b3d74@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-8-520e867b3d74@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MiBTYWx0ZWRfX5cNFEimaZiKJ
 z5e3xnPhUSJg+QFZ1LbyI3B5+zpQJAJdAF6/Dv3lHD/1ClPtZycn7BbrAys3xebn2lgao3N8eIU
 Mnj8N/lMLi1vt/Iw4la9NB1i5L6rvo0lhgZMb9Ta97m/Sw4z39Iub6ClAcU0R08Gj11mWXCnBZP
 kyd6NdAFF765ozCFqfee4xqKHEZ0qRh67S9PhC9zyEsIbPvvmr0PANsWB3m56ks+NWdFZ+kCPI/
 x7HOMNX+ZI3OxZ0weQAPt4ko6nH6bJzNVqC5bQr1zXpa7RLHt3OMsVMbWHAMoOr3IjPK1Z1DYuy
 0VG8EOZxvmgdjAYH3ta8suB8aqVGdkFhKjsekJVy7VGjTEwfkO8IE046yKSoxlMm98dpY1rEApp
 VvnbCrRqnWgg7nCcMi3YPp1vBH2supPlBmYpvE4MqFmewGSI/1+wewWD17d4ePsUBnOa/h/FmMI
 vHojV87WHRE9WnoFTPQ==
X-Authority-Analysis: v=2.4 cv=V69NF+ni c=1 sm=1 tr=0 ts=69f07c12 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=yhmqyPtzb8d5NndqWuMA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1lzlReEqhxexW-2ueuiGUyKqv7Yc6EAB
X-Proofpoint-ORIG-GUID: 1lzlReEqhxexW-2ueuiGUyKqv7Yc6EAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280082

On Wed, Sep 10, 2025 at 08:41:21PM -0700, Amirreza Zarrabi wrote:
> Introduce qcomtee_object, which represents an object in both QTEE and
> the kernel. QTEE clients can invoke an instance of qcomtee_object to
> access QTEE services. If this invocation produces a new object in QTEE,
> an instance of qcomtee_object will be returned.
> 
> Similarly, QTEE can request services from by issuing a callback
> request, which invokes an instance of qcomtee_object.
> 
> Implement initial support for exporting qcomtee_object to userspace
> and QTEE, enabling the invocation of objects hosted in QTEE and userspace
> through the TEE subsystem.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  MAINTAINERS                          |   6 +
>  drivers/tee/Kconfig                  |   1 +
>  drivers/tee/Makefile                 |   1 +
>  drivers/tee/qcomtee/Kconfig          |  12 +
>  drivers/tee/qcomtee/Makefile         |   7 +
>  drivers/tee/qcomtee/async.c          | 182 +++++++
>  drivers/tee/qcomtee/call.c           | 813 +++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/core.c           | 906 +++++++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/qcomtee.h        | 143 ++++++
>  drivers/tee/qcomtee/qcomtee_msg.h    | 304 ++++++++++++
>  drivers/tee/qcomtee/qcomtee_object.h | 316 ++++++++++++
>  drivers/tee/qcomtee/shm.c            | 153 ++++++
>  drivers/tee/qcomtee/user_obj.c       | 692 ++++++++++++++++++++++++++
>  include/uapi/linux/tee.h             |   1 +
>  14 files changed, 3537 insertions(+)
> 
> +
> +static int
> +qcomtee_object_invoke_ctx_invoke(struct qcomtee_object_invoke_ctx *oic,
> +				 int *result, u64 *res_type)
> +{
> +	phys_addr_t out_msg_paddr;
> +	phys_addr_t in_msg_paddr;
> +	int ret;
> +	u64 res;
> +
> +	tee_shm_get_pa(oic->out_shm, 0, &out_msg_paddr);
> +	tee_shm_get_pa(oic->in_shm, 0, &in_msg_paddr);
> +	if (!(oic->flags & QCOMTEE_OIC_FLAG_BUSY))
> +		ret = qcom_scm_qtee_invoke_smc(in_msg_paddr, oic->in_msg.size,
> +					       out_msg_paddr, oic->out_msg.size,
> +					       &res, res_type);
> +	else
> +		ret = qcom_scm_qtee_callback_response(out_msg_paddr,
> +						      oic->out_msg.size,
> +						      &res, res_type);
> +
> +	if (ret)
> +		pr_err("QTEE returned with %d.\n", ret);
> +	else
> +		*result = (int)res;

After enablign QCOMTEE driver, I observe the following error during the
bootup on RB3 Gen2:

[    4.720777] qcomtee: QTEE returned with -22.
[    4.725251] qcomtee: QTEE version 0.0.0


> +
> +	return ret;
> +}
> +

-- 
With best wishes
Dmitry
