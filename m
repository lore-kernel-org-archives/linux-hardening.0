Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135EC3FC5AF
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155755; cv=none; b=r6WcXI5RrEUB5oKQyy7kzuSJEZovJaG/RCxsSjjjV4hXqiXtnulv8cb9uZLVvRWPT+awkCVwK7HqMGTXO7f1nk4TuaFuGfAqMyeF8S6Lh64QRVl5a/JvCYcYLmZlKcX7iVjostZnlOgpqMWW5vpuZUm0CA8UF9s4HkWAkBjc6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155755; c=relaxed/simple;
	bh=lXEuzB3RYCL5buhFHGgoiK/09Sqr7HNhA5jgzs+/iac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/s3w18aBYTzXq+wXR9lneSQUR+i92MW6l9TmHyokYOxGQ2tG0Rb9nEjD2MeYraApu2zFf+jOc0BEiS8WrCe3h3lJkWj+cLH65hJdvS8Fpi/nsc+AWPQpgGX6fvKEn1fzMmkSWAUNV9RuzAIrX7pELhFG+MuKePd2tuQUjZL7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OvlEfZJa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bh4lseK4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvlEfZJa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bh4lseK4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAMC3s3427670
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 12:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=44rzlthw92Pyb3IiSzSQiDvH
	WraFwPuyNqv1IZJTnr0=; b=OvlEfZJa2Gb68W5vnOidmz+1rY7r3EwR1TsK6esL
	APGXdea8+9tVyHs8yQGHF79EJ9vB1o7oM5tkOQbg2VmmnAl4g2L4Hogu+o1Jq0pQ
	Hl5xDaNCJtnQAqTl9BQpU1p+JlYoPGBbeNABgvpqZErCs29WsCvuUmeor/oc774y
	pQl8Kr02kzLsQKIdnv/2FpP9MtpyWiVwdzAE+LE9Xsy2J2FngW47uTv/junf8/M3
	KWWbLvr9ssvqfhwGLZK9wtPcEb279z0UiEgMeBg3sj48POOil+FL6h1l8RtmuE2i
	8ePEY9kzaAlWC3Aaj0oDbw8IpORtKdSOidkjSr+wAaktKw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fnsxs2j9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 12:35:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1673734a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785155751; x=1785760551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=44rzlthw92Pyb3IiSzSQiDvHWraFwPuyNqv1IZJTnr0=;
        b=bh4lseK4jYZ2dQCO1Ox7MykYg9wQ4jymkGyHNOFWj3vYACejVn+d1v6nd4mM9IckGy
         e42pXnvsXueMP7/aSdEvlgS3Rrq7BM19W42L4a4B1y90jBEqAz/rtGU1CGqm3CrHjr1n
         5qhWpAQx8XEnsXbjIrKhK0yXU4jNgwrvC6/sqkibbEfZ1mILaQ6IgC1hAMW3m7s/J97s
         w3iUhytfUEGlyiXqfDFfafR5LDzJJ+1dZeR9vAygIxjxDyr28tEzeLRnc/3ktSN8sqff
         M/qlP6Yumi/MYW09qflgB5Jq+9B7xaKSA5DTfsmIKGQ15LloEeLcO8c/hf46CyyPrcw/
         6T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155751; x=1785760551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44rzlthw92Pyb3IiSzSQiDvHWraFwPuyNqv1IZJTnr0=;
        b=M4TDUIzLK6BpeK89znQ4BzMW4QVm1NCWY3H2P1HjJRggt43cvV2U5QDiLqGMs6IFxa
         HKHvnzRX+R5gMBnuGtthOLO5kf728WzpJut8/d2maxd5MWxL8AP8qWDp5LscaW8ytQjB
         2JAod/gJzakPc5wSllq1JN+G9q3YkDK5tgEAYwP6XQv7q7+4FUfC0GUkD8dliQgcZlFS
         Jmz9QiKPzdrT5ND6g9mPMwjdpbq087qseqofY2zt9Is3t6kwaKUG9UqMyj+53NYlK2z9
         nSbfTztOjjtuP4QcBDZmMgXvVtTM+O7kgaR0VbE9ZEMXt3iVOUyO6qheVokTkgP5VfLe
         5bCA==
X-Forwarded-Encrypted: i=1; AHgh+RpLY5QP93t6xGpzqSjjFpuB5kONc1IINt0EeweI6mXxtvIhlK6kZ2BRrnSVAIDdB06jawtURVM4eWNDNmeb5nI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rRuLICDFMmaUO5bQVYhUI6oQ2mRgDT+gQXL8YOFOepOgkBUU
	f3v87nqgO5CCpk+YJU47M6S+OLlXp9mAFszZl9ZVXaKTfmYDLrJtLI37VkfRms/aJE61iy+sdeX
	e9NhOOxTpiJz/FhHCkAADsmFg9C8B2Mew6V1e9b4epfVqWRAv3JKL5ZbmWs728jD8XHqUbX0=
X-Gm-Gg: AR+sD10Rw/yxDxr3Dt9dzN4RXXWLgtRvvY+5oj8W9s8CCCmH+9l11wlZTpOX0NZbUrq
	O8xuQDEJY3WNzdNibrnTmVAUGRMhKVA0FOUbfObQplC0K41XOL7PeYexC0QSftTpVL38qBSBXRz
	BVa7VhBSEX5EfVmMgkcxY5Vv6jJ0sNqUudEE79rM7JazSVIaaE/TmQRLWu5DxToHBsmlWqFZCeD
	055KRyjLLtyPgiIIaFqYJenaha36MBvmbUOi7CjY+AYw+Eoy+tu2HCNo+TlZKTwYOgXa4TfqGii
	Nq37zO8lAkBVX9+r+BNTQXz/+GChrwNSCO1z8h4hUhMY8XqFRYeyhfd0nm8hcoF61dNpdMiK5FN
	plxGkzBNCxg5FoOfa04cya/JKJgU=
X-Received: by 2002:a05:6a21:3990:b0:3c3:890f:6d75 with SMTP id adf61e73a8af0-3c67d9b4670mr7490791637.2.1785155750449;
        Mon, 27 Jul 2026 05:35:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:3990:b0:3c3:890f:6d75 with SMTP id adf61e73a8af0-3c67d9b4670mr7490750637.2.1785155749813;
        Mon, 27 Jul 2026 05:35:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5a04b2sm29439425eec.28.2026.07.27.05.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:35:49 -0700 (PDT)
Date: Mon, 27 Jul 2026 18:05:33 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@sandisk.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>,
        Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Jie Gan <jie.gan@oss.qualcomm.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] soc: qcom: smem: Use 'unsigned int' instead of
 'unsigned'
Message-ID: <20260727123533.hz53oknuy3xwzw5z@hu-mojha-hyd.qualcomm.com>
References: <20260727-topic-smem_dramc-v5-0-66188b3e338d@oss.qualcomm.com>
 <20260727-topic-smem_dramc-v5-1-66188b3e338d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-topic-smem_dramc-v5-1-66188b3e338d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEyMiBTYWx0ZWRfXxuTxtnC9aJTI
 8m56E4t2m59BhOlFUCDozSjxuR4g6D9tsffFd9nElRrjiQnZTP/VGQ9QcDJ3SfkK1Qa7c2X1aCA
 NgVFD8u2S208hfiwxhdZCDsG4+v3ESiVFISaG7nJJ63E7gssEUyEcMbdzECT+HAsdO5ItBnp6T/
 I5lMJmAlHGXv949aJjmVYX+8mPKJ2w47wxy6U56SCYJGq2bXOCzxzvzyX7qdkPJ9MpEls4NjqAa
 OhY8TA/KvqKfbOLRI1qIK2SWvH2lc6XmUkgmetdk3NQ4Zeputj6FDfn9JEpJ91kRKipxxsOdniS
 sGetDeVfVPEhKRYboPtvWU/cxPuaKApnEzSvHhgKnxvugCsWZfjrqZlDl4S2ff4LqesZBc4FyHa
 dSOEa0RveY96hrw6c/PRDbBUJklvp8DjzjlpltrqyDxZcHTadq/mKWQJ5vxSziJIIVPrQGtaoT/
 afX1R3E1qGhNOkyk7cQ==
X-Authority-Analysis: v=2.4 cv=EYr4hvmC c=1 sm=1 tr=0 ts=6a6750a7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=EZmpetop0t0RzpqVzL8A:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: ElclXwV_KoJls-JIpx_RGM0xa75n1l5s
X-Proofpoint-GUID: ElclXwV_KoJls-JIpx_RGM0xa75n1l5s
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEyMiBTYWx0ZWRfX2nnAVC/L8EoA
 0Ok0gwUkj4fXoeJo766OCgnvQULHDwmo5TtfAThLLwsc0gGyI1gJ3907AaR8tVNzF3i3l9smpLD
 fS07MoB5DA204eMvlfYJZ2SDeD3UzfI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270122

On Mon, Jul 27, 2026 at 11:59:27AM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> checkpatch.pl reports:
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Convert the SMEM driver to use the less ambiguous type instead.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

-- 
-Mukesh Ojha
